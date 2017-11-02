From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 11:09:26 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1711020011400.21665@knanqh.ubzr>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <nycvar.YSQ.7.76.1711020011400.21665@knanqh.ubzr>
Message-ID: <20171102110925.GV9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 12:16:54AM -0400, Nicolas Pitre wrote:
> On Wed, 1 Nov 2017, Nicolas Pitre wrote:
> 
> > Well... I don't know what happened with Chris' testing either.
> > 
> > I *thought* I build tested it, but my .config had 
> > CONFIG_DEBUG_SEMIHOSTING=y.
> 
> Here's the fixed patch. I won't submit it to the patch system before we 
> understand how the previous one worked for Chris.

As we have seen, there's risk involved with merging apparently tested
fixes, and it can result in major build breakage.

Today is the last linux-next fetch before the potential opening of the
merge window on Sunday.  I'd prefer not to merge anything in the next
four days, but instead let things settle ready for that.

Most of last night's builds for my autobuilder failed due to this
problem (I didn't have a chance to regenerate that tree after kernelci
reported the problem), so I'm going to have to wait until tonight's
builds to see how things are - and that's starting to leave precious
little available time before the merge window.  I don't run the
builder during the day as it eats around six hours of time.

So, in short, my tree is now closed in expectation of 4.14 on Sunday.

However, if you want me to remove "8705/1: early_printk: use printascii()
rather than printch()" I can do that, but only if you tell me before
4pm UTC today.

If we get 4.14-rc8 instead, I'll re-open for a few days for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
