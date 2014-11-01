From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 19:40:59 -0400
Subject: [PATCH 0/4] Support for DLINK DIR665
In-Reply-To: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
Message-ID: <20141101234059.GM3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 11:13:29PM +0100, Andrew Lunn wrote:
> The DLINK is a wireless access point using a Kirkwood processor
> and a Marvell TopDog wifi chipset.
> 
> The base device tree file was provided by Claudio Leite. I've
> performed a few cleanups, added dsa support for the in build switch,
> and extended the defconfigs for regression testing.
> 
> Andrew Lunn (3):
>   ARM: Kirkwood: DIR665: Instantiate Distributed Switch Architecture
>   ARM: mvebu: Add DLINK DIR665 options to mvebu_v5_defconfig
>   ARM: config: Add DLINK DIR665 options to multi_v5_defconfig
> 
> Claudio Leite (1):
>   ARM: Kirkwood: Add support for DLink DIR665
> 
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/kirkwood-dir665.dts | 278 ++++++++++++++++++++++++++++++++++
>  arch/arm/configs/multi_v5_defconfig   |   2 +
>  arch/arm/configs/mvebu_v5_defconfig   |   2 +
>  4 files changed, 283 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-dir665.dts

Applied patches 1 and 2 with a small comment tweak to mvebu/dt.

Applied patches 3 and 4 to mvebu/defconfig since we are the only active
modifiers of multi_v5_defconfig, so I don't foresee huge conflicts there
like we get with multi_v7_defconfig.

thx,

Jason.
