From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jul 2016 16:37:31 +0200
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <4818149.nzRaU7vJQE@amdc1976>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <2773873.Jjn1O47GXr@wuerfel> <4818149.nzRaU7vJQE@amdc1976>
Message-ID: <4264651.gPKphdYuCx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> 
> On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > (no IDE host drivers are selected in this config so there is no
> > > valid reason to enable IDE subsystem itself).
> > > 
> > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > 
> > I think the series makes a lot of sense. I have checked your assertions
> > in the changelogs and found no flaws in your logic, so I think we should
> > take them all through arm-soc unless there are other concerns.
> 
> Thank you.
> 
> Should I resend everything or just patches that were not reposted yet
> (the ones that were marked as RFT initially and got no feedback)?

I'd be fine with just getting a pull request with all the patches that
had no negative feedback and that were not already applied (if any).

> > Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
> > how you determined that they need it?
> 
> The only such defconfig is davinci_all_defconfig which uses
> palm_bk3710 host driver (CONFIG_BLK_DEV_PALMCHIP_BK3710).
> 
> > I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
> > have no libata replacement, are there any others like that, or are
> > they all platforms that should in theory work with libata but need
> > testing?
> 
> All platforms except ARCH_ACORN, ARCH_DAVINCI & ARCH_RPC should work
> with libata.

Adding Sekhar and Kevin for DaVinci: At first sight, palm_bk3710 looks
fairly straightforward (meaning someone has to do a few day's work)
to convert into a libata driver.

As this is on on-chip controller that is part of a dm644x and dm646x,
it should also not be hard to test (as long as someone can find
a hard drive to plug in).

	Arnd
