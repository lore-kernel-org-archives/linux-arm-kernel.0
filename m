From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Jul 2015 14:33:27 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Marzen Board Removal for v4.3
In-Reply-To: <cover.1437726584.git.horms+renesas@verge.net.au>
References: <cover.1437726584.git.horms+renesas@verge.net.au>
Message-ID: <20150727123327.GF14224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 05:41:47PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC marzen board removal for v4.3.
> 
> This series removes legacy r8a7779 SoC and marzen board code.
> It does so in a way that does not introduce feature regressions
> when when booting the r8a7779/marzen board using shmobile_defconfig,
> which provides for booting using multiplatform, a scenario which previously
> used board code to provide some features including SMP.
> 
> Because of the above this series modifies SoC and DT files,
> and then removes code. And because of that it was not entirely clear to
> me which branch it should go into, so I have provided it in a stand-alone
> branch.
> 
> Unfortunately this branch has a number of minor conflicts with the "Renesas
> ARM Based SoC Cleanup for v4.3", tagged as renesas-cleanup-for-v4.3, which
> you have previously pulled.
> 
> A resolution to those conflicts can be found in the
> renesas-next-20150724-v4.2-rc1 tag of the renesas tree.
> 
> I would be happy to rebase these patches on top of renesas-cleanup-for-v4.3
> and resubmit a conflict-free pull request if you like.
> 
> On a more positive note, I believe this to well over 8000 lines of legacy
> code removed in this cycle :)

Organization is OK since the additions were small. If there were more
additions needed, doing the enablement one release and removing the
legacy code the release after would make more sense. But here that's fine.

The only thing I'd like to see different is to please send the defconfig
updates separately. They just take out no-longer-existent entries anyway, so
the series should do fine without them here.

So, please respin without the defconfig updates and provide them
separately, if you want to avoid bisectability problems just do them
next release.


-Olof
