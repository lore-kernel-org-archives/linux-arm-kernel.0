From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 09:45:42 -0500
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20160601144542.GA3835@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 09:02:22PM +0800, Xing Zheng wrote:
> There are multi codec devices on the RK3399 platform, we can use
> this patch support and control these codecs.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
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
>  .../rockchip,rk3399-max98357a-rt5514-da7219.txt    |   15 +
>  sound/soc/rockchip/Kconfig                         |   11 +
>  sound/soc/rockchip/Makefile                        |    2 +
>  .../soc/rockchip/rk3399_max98357a_rt5514_da7219.c  |  333 ++++++++++++++++++++
>  4 files changed, 361 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399-max98357a-rt5514-da7219.txt
>  create mode 100644 sound/soc/rockchip/rk3399_max98357a_rt5514_da7219.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-max98357a-rt5514-da7219.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-max98357a-rt5514-da7219.txt
> new file mode 100644
> index 0000000..3ae603e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-max98357a-rt5514-da7219.txt
> @@ -0,0 +1,15 @@
> +ROCKCHIP with MAX98357A/RT5514/DA7219 codecs
> +
> +Required properties:
> +- compatible: "rockchip,rk3399-max98357a-rt5514-da7219"

I'm still not very clear on the naming convention thoughout this. This 
doesn't seem like a pattern we want to repeat (<chip>-<codec>-<codec>).

Rob
