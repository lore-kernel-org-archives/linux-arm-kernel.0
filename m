From: r65037@freescale.com (Zhu Richard-R65037)
Date: Wed, 13 Oct 2010 17:53:10 +0800
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <8762x6xx00.fsf@lechat.rtp-net.org>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de><87aamjxe00.fsf@lechat.rtp-net.org>
	<4CB56A88.2040101@eukrea.com><20101013082930.GA11286@pengutronix.de>
	<8762x6xx00.fsf@lechat.rtp-net.org>
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud:
The mechanism of the GPIO used as write protection pin is implemented ever, you can make a reference to the following suggestions.
The details pls refer to the [PATCH 3/6] mmc: sdhci: introduce private get_ro sent by wolfram.
and 
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/027269.html

The GPIO Card Detection solution maybe a little complex refer to the GPIO Write Protection,
 since the CD irq should be configured, and the poll Of card detection should be disabled at the same time.
So the sdhc-pltfm.c maybe should be changed too.

Hi Eric:
Can you add this GPIO WP mechanism into your serial patches?
I can't access the external git repos because of the firewall.:(.
The GPIO WP solution had been implemented in my patches before, the details pls refer to the URL listed above.

The codes are simple, maybe the definition of the platform data should be considered.



Best Regards
Richard Zhu



> -----Original Message-----
> From: Arnaud Patard [mailto:arnaud.patard at rtp-net.org]
> Sent: Wednesday, October 13, 2010 5:28 PM
> To: Wolfram Sang
> Cc: Eric B?nard; Zhu Richard-R65037; linux-mmc at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
> 
> Wolfram Sang <w.sang@pengutronix.de> writes:
> 
> Hi,
> 
> > On Wed, Oct 13, 2010 at 10:15:04AM +0200, Eric B?nard wrote:
> >
> >> >I've tried it on a efika mx (to2 version) and I've a problem with
> >> >the write-protect. It's on a GPIO and I don't see any way to
> >> >configure the esdhc-imx driver to use it. Any idea on how it should
> be done ?
> >> >
> >> it's actually not yet supported by the driver. There is a wp_gpio in
> >> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
> >> but it's not yet used by the driver.
> >
> > It's all prepared. I finally will have a look into it today.
> 
> oh, great. I was thinking about doing it but I'll wait for your patches
> then. I'm sure I need support for WP on GPIO but I may also need support
> for CD on GPIO so I'll be happy to test any patch you have.
> 
> 
> Thanks,
> Arnaud
