From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Jun 2016 08:08:12 -0500
Subject: [PATCH v6] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
In-Reply-To: <1466080858-29565-1-git-send-email-zhengxing@rock-chips.com>
References: <1466080858-29565-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20160620130812.GA24614@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 08:40:58PM +0800, Xing Zheng wrote:
> Because we need to support the multiple codecs (MAX98357A/RT5514/DA7219)
> on the RK3399 GRU boards, this patch can help us to support these codecs.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v6:
> - remove enable/disable dapm pins, and to switch codecs via user space
> - fix "Speaker" dapm route for max98357a
> - add SND_JACK_LINEOUT flag for da7219 jack detection
> 
> Changes in v5:
> - fix the build warning for missing I2C/CLKDEV_LOOKUP dependency
> 
> Changes in v4:
> - the compatible name needs to be based on a single reference design,
>   and the name of the board is called "GRU"
> - use one i2sX card "rockchip,cpu = <&i2s0>" instead of array that is
>   based on GRU
> - rename DOC to rockchip,rk3399-gru-sound.txt
> - rename compatible to rockchip,rk3399-gru-sound
> - rename source code to rk3399_gru_sound.c
> 
> Changes in v3:
> - rename DOC to rockchip,rk3399-max98357a-rt5514-da7219.txt
> - rename compatible to rockchip,rk3399-max98357a-rt5514-da7219
> - rename source code to rk3399_max98357a_rt5514_da7219.c
> 
> Changes in v2:
> - use the FS 256 to set mclks of the max98357a and rt5514 danamically
> - add more sample rate for da7219
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   15 +

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/rockchip/Kconfig                         |   11 +
>  sound/soc/rockchip/Makefile                        |    2 +
>  sound/soc/rockchip/rk3399_gru_sound.c              |  322 ++++++++++++++++++++
>  4 files changed, 350 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
>  create mode 100644 sound/soc/rockchip/rk3399_gru_sound.c
