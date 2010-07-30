From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Jul 2010 22:14:58 +0100
Subject: [PATCH 9/9] [ARM] tegra: Add cpufreq support
In-Reply-To: <AANLkTinzmQRrudecEkaNm5+k_j3ATh+bB_1ZmFDWkYy0@mail.gmail.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
	<1280449771-24043-10-git-send-email-ccross@google.com>
	<20100730131124.GA3117@isilmar-3.linta.de>
	<AANLkTi=jvQtCZ8=rsWDuLNpPLvKh54PdWvLDFZefZWDD@mail.gmail.com>
	<20100730202010.GA22180@sirena.org.uk>
	<AANLkTinzmQRrudecEkaNm5+k_j3ATh+bB_1ZmFDWkYy0@mail.gmail.com>
Message-ID: <20100730211457.GB22180@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 01:33:08PM -0700, Colin Cross wrote:
> On Fri, Jul 30, 2010 at 1:20 PM, Mark Brown

> > ...although in some systems the I2C cost will be replaced with updating
> > a GPIO which is very much cheaper.

> Yes, but even on a GPIO regulator, the regulator api will lock a mutex
> and possibly schedule.

Yup, the schedule will depend on how long it takes to charge the cap on
the output in the case of the GPIO regulator.  The point being that the
delay you'll encounter is wildly variable depending on hardware setup.
