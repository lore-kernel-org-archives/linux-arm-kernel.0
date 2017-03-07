From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Mar 2017 18:10:12 +0100
Subject: [PATCH v2 0/6] Updates for Marvell Switch SoCs
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Thu, 16 Feb 2017 21:50:34 +1300")
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87bmtdovwr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On jeu., f?vr. 16 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Shortly after I posted my last series I got access to a more recent
> Marvell SDK which had some device tree support for the switch SoCs I'd
> been wanting. It was still based on an older kernel but it was a huge
> improvement over what came before.
>
> Patch 1/6 is a typo I noticed after my initial series was applied.
>
> Patch 2/6 is a bit of a cleanup. I did initially struggle with how to
> access individual parts of the DFX block as well as retaining a handle on
> the entire thing for the switch driver to use.
>
> Patch 3/6 is a re-jig of the dtsi files which is needed by 5/6. This is
> required because I need to use the coreclk label on a different node. It
> also means I don't have to disable nodes for blocks that only exist on
> the Armada-XP.
>
> Patch 4/6, 5/6 are split from the previous versions.
>
> Patch 6/6 is the device tree portion of a change already in clk-next.


I applied patches 2, 3 and 6 on mvebu/dt with the acked-by from Rob when
he gave it.

Patch 1 is already part of 4.11-rc1.

For patch 4 and 5 I understand that either we don't need it or it should
be a updated version so I skipped them.

Thanks,

Gregory

>
> Chris Packham (6):
>   ARM: dts: Fix typo in armada-xp-98dx4251
>     Changes in v2
>     - new
>     Changes in v3:
>     - none
>   ARM: dts: armada-xp-98dx3236: combine dfx server nodes
>     Changes in v2:
>     - none
>     Changes in v3:
>     - none
>   ARM: dts: Use armada-370-xp as a base for armada-xp-98dx3236
>     Changes in v2:
>     - Update root compatible strings in armada-xp-98dx3336.dtsi,
>       armada-xp-98dx4251.dtsi, armada-xp-db-dxbc2.dts and
>       armada-xp-db-xc3-24g4xg.dts
>     Changes in v3:
>     - none
>   ARM: dts: mvebu: Add binding for mv98dx3236-soc-id
>     Changes in v3:
>     - new, split from driver
>   ARM: mvebu: Add driver for mv98dx3236-soc-id
>     Changes in v2:
>     - none
>     Changes in v3:
>     - split from dts changes
>   ARM: dts: mvebu: Move mv98dx3236 clock bindings
>     Changes in v2:
>     - New. Split out from "clk: mvebu: Expand mv98dx3236-core-clock support"
>     Changes in v3:
>     - Clarify why the old location was wrong (but worked).
>
>
>  .../bindings/arm/marvell/mv98dx3236-soc-id.txt     |  14 ++
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   7 +
>  .../bindings/clock/mvebu-gated-clock.txt           |  11 ++
>  .../devicetree/bindings/net/marvell,prestera.txt   |  13 +-
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 213 ++++++++++++++++-----
>  arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |   2 +-
>  arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |   2 +-
>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   2 +-
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   2 +-
>  arch/arm/mach-mvebu/mvebu-soc-id.c                 |  43 ++++-
>  10 files changed, 242 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
>
> -- 
> 2.11.0.24.ge6920cf

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
