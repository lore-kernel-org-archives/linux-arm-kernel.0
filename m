From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 18 Aug 2015 17:36:18 +0530
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <1439886500.31432.4.camel@pengutronix.de>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com>
 <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
 <20150814215617.GA7557@n2100.arm.linux.org.uk>
 <55D25C64.3090107@ti.com> <55D2A1DD.9000007@oracle.com>
 <20150818081334.GK7557@n2100.arm.linux.org.uk>
 <1439886500.31432.4.camel@pengutronix.de>
Message-ID: <20150818120618.GA4294@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

On Tue, Aug 18, 2015 at 10:28:20AM +0200, Lucas Stach wrote:
> Am Dienstag, den 18.08.2015, 09:13 +0100 schrieb Russell King - ARM
> Linux:

> > It seems to be pointing towards something in the boot loader...
> > 
> > Normally, uboot will hook itself into the vectors to report errors, but
> > I wonder whether uboot enables asynchronous aborts while it's running.
> > Don't forget to make sure that the aborts are disabled again prior to
> > calling the kernel.
> > 
> At least one of the Marvell platforms has the same issue with the
> bootloader (I think it is some downstream U-Boot) leaving an imprecise
> abort hanging around as a nice present for Linux to crash on.

If you have a JTAG, maybe you can manually set CPSR.A bit (equivalent
of Lucas's patch) at bootloader/kernel entry and conclude who is the
culprit or maybe even localize it better.

This method did help in rootcausing issue in one of the SoC that showed
the same behaviour.

Regards
Afzal
