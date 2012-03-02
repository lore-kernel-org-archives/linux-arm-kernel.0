From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 09:48:11 +0000
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <20120302071939.A1BE83E2D8A@localhost>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
 <20120302071939.A1BE83E2D8A@localhost>
Message-ID: <201203020948.12235.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Grant Likely wrote:
> > --- a/arch/arm/mach-kirkwood/common.c
> > +++ b/arch/arm/mach-kirkwood/common.c
> > @@ -163,7 +163,7 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
> >  /*****************************************************************************
> >   * SoC RTC
> >   ****************************************************************************/
> > -void __init kirkwood_rtc_init(void)
> > +static void __init kirkwood_rtc_init(void)
> 
> This undoes the code changed in the previous patch.  If you reorder the patches then
> this change goes away in both.
> 

That would break bisection because you end up with two rtc devices after this
patch without first moving out the kirkwood_rtc_init into board-dt.c

	Arnd
