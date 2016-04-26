From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 12:41:07 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7
In-Reply-To: <CAMuHMdWmGKa16BOoF=MJab5V_Ceb1yAbAf2yjFV7sSHxG6=GOQ@mail.gmail.com>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
 <7781705.p6jrBl2RnJ@wuerfel>
 <CAMuHMdWmGKa16BOoF=MJab5V_Ceb1yAbAf2yjFV7sSHxG6=GOQ@mail.gmail.com>
Message-ID: <5045792.GEWy4n0LSP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 10:32:39 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Tue, Apr 26, 2016 at 10:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 26 April 2016 09:30:45 Geert Uytterhoeven wrote:
> >> Commit 93fafa81cad3da9c ("Merge branches 'next/dt' and 'next/dt64' into
> >> for-next") accidentally re-added the line
> >>
> >>         clock-output-names = "can_clk";
> >>
> >> to arch/arm/boot/dts/r8a7791.dtsi, which was removed in commit
> >> f617604fe5d74b9c ("ARM: dts: r8a7791: Remove unnecessary
> >> clock-output-names properties") before.  It seems the same wrong
> >> conflict resolution was made before in commit ef3b08c6c0d85753 ("Merge
> >> branch 'fixes' into for-next").
> >>
> >> While this won't cause failures, can you please remove the offending
> >> line?
> >
> > I've merged renesas-fixes-for-v4.6 into next/dt now to resolve
> > the conflict there, otherwise Linus would have to do the same resolution
> > during the merge window.
> >
> > Thanks for letting us know. If you want to verify my new resolution,
> > please look at next/dt, which is the more important branch.
> 
> Thanks, but unfortunately your new merge resolution is incorrect, as it revived
> the line
> 
>         status = "disabled";
> 
> for the pcie_bus node.
> 

I've done the merge once more, noticed my mistake (vimdiff syntax
coloring was slightly misleading) and fixed it.

	Arnd
