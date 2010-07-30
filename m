From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Jul 2010 21:20:10 +0100
Subject: [PATCH 9/9] [ARM] tegra: Add cpufreq support
In-Reply-To: <AANLkTi=jvQtCZ8=rsWDuLNpPLvKh54PdWvLDFZefZWDD@mail.gmail.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
	<1280449771-24043-10-git-send-email-ccross@google.com>
	<20100730131124.GA3117@isilmar-3.linta.de>
	<AANLkTi=jvQtCZ8=rsWDuLNpPLvKh54PdWvLDFZefZWDD@mail.gmail.com>
Message-ID: <20100730202010.GA22180@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 12:56:33PM -0700, Colin Cross wrote:
> On Fri, Jul 30, 2010 at 6:11 AM, Dominik Brodowski

> >> + ? ? ret = clk_set_rate_cansleep(cpu_clk, freqs.new * 1000);
> > "can sleep"? For how long?

> Adjusting the CPU clock may require changing the voltage through the
> regulator api, which locks a mutex, and eventually through I2C, which
> sleeps on I2C completion.

...although in some systems the I2C cost will be replaced with updating
a GPIO which is very much cheaper.
