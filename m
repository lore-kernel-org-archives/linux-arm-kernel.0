From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Nov 2015 10:29:46 +0900
Subject: [PATCH v6 00/12] arm64: renesas: add sound support
In-Reply-To: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20151109012943.GF4832@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 06:33:10AM +0000, Kuninori Morimoto wrote:
> Hi,
> 
> these are v2 patches which add sound support to the r8a7795/Salvator-X.
> 
> These patches are an update of Simon's v5 patch-set
> 
> The main change to the patches themselves since Morimoto-san's v3 posting
> and v4 updates to that posting is to update to new CPG/MSSR bindings via
> Geert Uytterhoeven.
> 
> It doesn't include cs2000 support since it is not accepted yet.
> I will send additional patch if it was accepted.
> This patches doesn't include CTU/MIX support either,
> because it is too advanced feature at this point.
> 
> Base:
> 
> * "[PATCH v4 0/3] arm64: renesas: r8a7795: add I2C support"
>   This can be found in the topic/r8a7795-i2c-v4 branch of
>   my renesas tree on kernel.org.

Thanks.

In order to aid review I have made this patchset available in
the topic/r8a7795-sound-v6 branch of my renesas tree on kernel.org.
The topic/r8a7795-i2c-v4 branch is there too.

> Kuninori Morimoto (12):
>       arm64: renesas: r8a7795: add AUDIO_DMAC support
>       arm64: renesas: r8a7795: Sound SSI PIO support
>       arm64: renesas: r8a7795: Sound SSI DMA support
>       arm64: renesas: r8a7795: Sound SRC support
>       arm64: renesas: r8a7795: Sound DVC support
>       arm64: renesas: salvator-x: Sound SSI PIO support

The above patch seemed to have some fuzz. Please check that
I resolved that correctly.

>       arm64: renesas: salvator-x: Sound SSI DMA support
>       arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
>       arm64: renesas: salvator-x: Sound SRC support
>       arm64: renesas: salvator-x: Sound DVC support
>       arm64: defconfig: add Renesas R-Car DMAC driver support

The above patch did not apply cleanly. I have fixed that and also I
modified the patch to enable CONFIG_DMADEVICES as well as CONFIG_RCAR_DMAC.
Please check this e.g. using make savedefconfig.

>       arm64: defconfig: add Renesas sound and AK4613 support
> 
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  94 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 253 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   6 +++
>  3 files changed, 353 insertions(+)
> 
> -- 
> 2.1.4
> 
