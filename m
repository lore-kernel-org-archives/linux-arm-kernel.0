From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 16:15:08 +0800
Subject: [RFC PATCH] ARM: dts: imx: replace underscore with hyphen in
 aliases name
In-Reply-To: <20180504085248.532c8a47@karo-electronics.de>
References: <1525399128-11587-1-git-send-email-shawnguo@kernel.org>
 <20180504085248.532c8a47@karo-electronics.de>
Message-ID: <20180504081506.GZ3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 08:52:48AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Fri,  4 May 2018 09:58:48 +0800 Shawn Guo wrote:
> > It replaces underscore with hyphen in aliases name to fix DTC
> > alias_paths warning below, which is seen with various i.MX board dts
> > files when W=1 switch is on.
> > 
> >  Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> > 
> > Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> > Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > ---
> > Hi Lothar, Gary,
> > 
> > Per my search on kernel code, this change will not break anything on
> > kernel support.  But I'm not really sure about the case of bootloaders
> > running on the boards.  That's why I'm sending it as RFC.
> > 
> > We really want i.MX to be the first-class citizen in the community.
> > After a few cycles efforts on cleaning up DTC warnings, this alias_paths
> > warning is the last one we see with i.MX dts files.  We really want to
> > get rid of it and make i.MX dts be DTC warning free.
> > 
> > So please comment whether we can merge this patch.
> > 
> This breaks our U-Boot which searches for the alias names with '_'.
> But I think it's not worth keeping the old names alive, since the
> problem can easily be fixed by adding the old alias name to the FDT
> on affected boards from within U-Boot, if necessary.
> 
> Alternatively we could add a:
> 	reg_can_xcvr = "reg-can-xcvr";
> [...]
> so that the respective aliases can be resolved using both names for a
> while.

Appreciate it.

> 
> So:
> Acked-By: Lothar Wa?mann <LW@KARO-electronics.de>

Thanks, Lothar.

Shawn
