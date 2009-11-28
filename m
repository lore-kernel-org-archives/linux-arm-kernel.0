From: timur@freescale.com (Timur Tabi)
Date: Sat, 28 Nov 2009 13:53:30 -0600
Subject: [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <20091123121055.GE30179@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
	<20091123121055.GE30179@pengutronix.de>
Message-ID: <4B117FBA.601@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> Mainly because I wasn't aware of the fact that the fsl driver is the
> same:(

So "fsl-ssi.c" was not a clue? :-)

>
> I'm currently looking if and how the code can be merged. I don't know if
> it's worth it though since the common code doesn't seem to be very big.

That's probably because my driver only supports I2S and yours supports AC97. 
Please, DMA is different.  I wasn't really expecting you to be able to re-use 
my driver, but I figured you could at least re-use the macros I've defined in 
fsl-ssi.h

> There will have to be some changes in the fsl-ssi driver. For example I
> need the irq handler for my fiq handler which means that the fsl-ssi
> driver is not allowed to request the irq for it's statistic.

That shouldn't be a problem, since the statistics never show anything useful 
anyway.

> The other
> thing is the hardware accesses as we do not have in_be*, out_be* and
> setbits/clrbits. Of course all these things are doable and shouldn't be
> a showstopper.

These should be defined in the arch/arm header files anyway.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
