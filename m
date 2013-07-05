From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Fri, 5 Jul 2013 09:39:03 +0000
Subject: [PATCH v4] tty: serial: add Freescale lpuart driver support
In-Reply-To: <20130705091449.GA20040@S2101-09.ap.freescale.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
 <20130705091449.GA20040@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851E5AFC@039-SN1MPN1-005.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Friday, July 05, 2013 5:15 PM
>To: Lu Jingchang-B35083
>Cc: linux-serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>gregkh at linuxfoundation.org; s.hauer at pengutronix.de
>Subject: Re: [PATCH v4] tty: serial: add Freescale lpuart driver support

>> +	/* restore CR2 */
>> +	writeb(old_cr2, sport->port.membase + UARTCR2);
>
>I just noticed that you dropped this CR2 restore since v5 of the patch.
>I have a patch enabling low-level debug support for Vybrid.  It works with
>v4 of your patch but has problem with the v5.  The console stops working
>as below.
>
>Serial: IMX driver
>serial: Freescale lpuart driver
>40028000.serial: ttyLP1 at MMIO 0x40028000 (irq = 94) is a FSL_LPUART
>console [ttyLP1] enabled, bootconsole disabled
>
>If I have above CR2 restore code added back.  The low-level debug support
>will just work fine with console.
>
>Is it an accident you removed the code?
[Lu Jingchang-B35083] 
I explicitly removed the cr2 restore code on cleaning up the redundant code, and find it work well on normal operation.
Low level debug is not supported on Vybrid so I didn't notice that problem.
Will you fixing it? Or I submit a fix on it?
Thanks.



Best Regards,
Jingchang 
