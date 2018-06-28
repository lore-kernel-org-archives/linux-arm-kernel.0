From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Jun 2018 10:35:51 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Fix reg for usbh1phy
In-Reply-To: <20180628043713.14425-1-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5DqkfotddSRbibD0UE2R=QZMef2-4Gr3LaeGT=Fq9qMyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Thu, Jun 28, 2018 at 1:37 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> There's already a USB PHY with reg of zero on that bus - usbphy0, used
> by usbotg (included from imx51.dtsi). Move usbh1phy to @1 avoid
> address collision.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index b8ca73d3d379..541c6e67ad1a 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -175,9 +175,9 @@
>                 #size-cells = <0>;
>                 compatible = "simple-bus";
>
> -               usbh1phy: usbh1phy at 0 {
> +               usbh1phy: usbh1phy at 1 {
>                         compatible = "usb-nop-xceiv";
> -                       reg = <0>;
> +                       reg = <1>;

We don't really need the 'reg' property here.

I have sent a previous fix for this on an attempt to fix dtc warnings
with W=1,  so let me send a v2 based on the feedback I got previously:
https://patchwork.kernel.org/patch/10399085/

Thanks
