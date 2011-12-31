From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Dec 2011 04:15:02 +0100
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is not
 MX23
In-Reply-To: <4EFE7236.10609@freescale.com>
References: <1325233646-3343-1-git-send-email-b32955@freescale.com>
 <20111230143658.GA9141@pengutronix.de> <4EFE7236.10609@freescale.com>
Message-ID: <201112310415.02867.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> 
> > On Fri, Dec 30, 2011 at 04:27:26PM +0800, Huang Shijie wrote:
> >> In MX28, if we do not reset the BCH module. The BCH module may
> >> becomes unstable when the board reboots for several thousands times.
> > 
> > Do you have more details when and why this happens? What happens on MX23
> > then?
> 
> In one customer's 3G router which uses the MX28:
> [0] NAND boot mode, mount the UBIFS in the NAND partition.
> [1] We used the gpmi_reset_block(r->bch_regs, true) to init the BCH module.
> [2] The board will automatically reboot again after it booted by NAND
> boot mode.
> [3] After reboot more then thousands times(cost nearly one day), the BCH
> mode became UNSTABLE,
> the data read out was not right, so the system could not mount the UBIFS.
> 
> After we use gpmi_reset_block(r->bch_regs, false) to init the BCH
> module, the bug never happens.
> 
> 
> 
> The gpmi_reset_block() was coded to avoid the NAND boot bug in MX23. So
> MX23 does not have the bug.
> 
> >> Signed-off-by: Huang Shijie <b32955@freescale.com>
> > 
> > Is this Bug 2847 from the errata? Should be mentioned in the commit
> > message and
> 
> Yes, this is the bug 2847 from the mx23's errata.
> 
> I will add some comments to it.
> 
> Best Regards
> Huang Shijie
> 
> > comments of the patch if so.
> > 
> > Regards,
> > 
> >    Wolfram

Ah, so you confirmed it's a problem with the silicon. Good
