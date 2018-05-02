From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 2 May 2018 14:54:58 +0200
Subject: [PATCH 1/3] mmc: sunxi: add support for the MMC controller on H6
In-Reply-To: <20180426140728.43155-2-icenowy@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-2-icenowy@aosc.io>
Message-ID: <CAPDyKFr1CRS7W5gYntbo_KhkvoCB00xzfF4jyUOmtkG1z2g2xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2018 at 16:07, Icenowy Zheng <icenowy@aosc.io> wrote:
> The new Allwinner H6 SoC have 3 MMC controllers. The first and second
> ones are similar to the ones on A64, but the third one adds EMCE
> (Embedded Crypto Engine) support which does hardware transparent crypto
> on the eMMC.
>
> As we still do not have support for EMCE, and the support of it is
> disabled by defualt, we just duplicate the A64 mmc configurations and
> change the compatible string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  2 ++

DT doc changes in separate patches please!

>  drivers/mmc/host/sunxi-mmc.c                        | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>

Kind regards
Uffe
