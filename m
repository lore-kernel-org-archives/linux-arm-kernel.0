From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 11:40:47 -0400
Subject: [PATCH 00/10] clk: mvebu: restructure SoC clock drivers
In-Reply-To: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130528154047.GT31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Sebastian,

In order to avoid losing changes between this series and mvebu/pcie,
I've rebased this series on top of mvebu/pcie and incorporated the
correct conflict resolution into this series.  See below...

On Sat, May 11, 2013 at 03:08:00AM +0200, Sebastian Hesselbarth wrote:
> Marvell EBU SoCs share some common clock functions that register core
> clocks or clock gates from SoC specific data. These clock drivers are
> organized by function and over time the drivers filled up with #ifdefs
> to separate different SoC specific code.
> 
> This patch set first adds a new element to clock gate descriptors to
> allow to pass clk flags per clock gate. (Patch 1)
> 
> Then it restructures MVEBU clock drivers into common clock setup and
> SoC specific files and Kconfig options. The driver's init functions
> are also registered to get called with of_clk_init. (Patches 2, 3-6)
> 
> It then switches Dove, Kirkwood, and Armada 370/XP to make use of
> of_clk_init instead of mvebu_clocks_init. (Patches 7-9)
> 
> Finally, all obsolete files and Kconfig options are removed. (Patch 10)
> 
> It has been tested on CuBox (Dove) and Dockstar (Kirkwood) by me.
> Armada 370 and XP are compile tested only and should get their Tested-by
> from Thomas and Gregory, respectively.
> 
> @Mike: As this only touches MVEBU related code, I suggest to take it
> all through the corresponding ARM branch.
> 
> Sebastian Hesselbarth (10):
>   clk: mvebu: introduce per-clock-gate flags

I updated armada_370_gating_descr[] and armada_xp_gating_descr[] to
incorporate Thomas' pcie changes.

>   clk: mvebu: add common clock functions for core clk and clk gating
>   clk: mvebu: add Dove SoC-centric clock init
>   clk: mvebu: add Kirkwood SoC-centric clock init

>   clk: mvebu: add Armada 370 SoC-centric clock init
>   clk: mvebu: add Armada XP SoC-centric clock init

I then migrated the changes above to these two commits.

>   ARM: dove: move DT boards to SoC-centric clock init
>   ARM: kirkwood: move DT boards to SoC-centric clock init
>   ARM: mvebu: move DT boards to SoC-centric clock init

>   clk: mvebu: desintegrate obsolete file

Obviously, the diffstat changed slightly here.

I'm posting the revised version as replies to patches 1, 5 and 6. Please
let me know if I messed it up.  I'd like to send the PR for these
shortly.

thx,

Jason.
