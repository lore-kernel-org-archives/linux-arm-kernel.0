From: timur@freescale.com (Timur Tabi)
Date: Mon, 5 Mar 2012 15:08:06 -0600
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305204456.GC3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305174232.GA3852@pengutronix.de>
 <CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
 <20120305204456.GC3224@opensource.wolfsonmicro.com>
Message-ID: <4F552B36.9020708@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:

> That would be *really* bad, simultaneous playback and record is very
> widely used.

Especially since I already have that working on PowerPC.  I went through
great lengths to get the device tree binding and the code working in this
regard.

> If the hardware has constraints on the sample rates the driver should be
> telling the application about this.  For the very common case where you
> need the same rate for playback and record there's framework support for
> doing this, the relevant driver just needs to set the symmetric_rates
> flag and the core will do everything.  

And my driver currently does this.  If the SSI is wired up in synchronous
mode, sample rate/size locking is enabled.

-- 
Timur Tabi
Linux kernel developer at Freescale
