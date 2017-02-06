From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Feb 2017 15:14:00 -0800
Subject: [PATCH 4/4] clk: mvebu: Expand mv98dx3236-core-clock support
In-Reply-To: <20170203034012.29399-5-chris.packham@alliedtelesis.co.nz>
References: <20170203034012.29399-1-chris.packham@alliedtelesis.co.nz>
 <20170203034012.29399-5-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170206231400.GM25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03, Chris Packham wrote:
> The initial implementation in commit e120c17a70e5 ("clk: mvebu: support
> for 98DX3236 SoC") hardcoded a fixed value for the main PLL frequency.
> Port code from the Marvell supplied Linux kernel to support different
> PLL frequencies and provide clock gating support.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   7 +
>  .../bindings/clock/mvebu-gated-clock.txt           |  11 ++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |  14 +-
>  drivers/clk/mvebu/Makefile                         |   2 +-
>  drivers/clk/mvebu/armada-xp.c                      |  13 --
>  drivers/clk/mvebu/mv98dx3236.c                     | 144 +++++++++++++++++++++

This mixes dts and clk driver changes. Any chance it can be split
up and just have the clk part go through clk tree? Otherwise, I
can ack this if you want to take it all through arm-soc?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
