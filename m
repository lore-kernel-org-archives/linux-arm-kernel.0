From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Aug 2014 08:53:00 -0300
Subject: [PATCH] ARM: imx6: add pci config space as platform resource
In-Reply-To: <1407409120-23635-1-git-send-email-l.stach@pengutronix.de>
References: <1407409120-23635-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAOMZO5Daf2+UcQKLkyiZeM7Zs9nd-ektO_f7n_3K-bw0GgPM8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 7, 2014 at 7:58 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Fixes "imx6q-pcie 1ffc000.pcie: missing *config* reg space"
> error exposed by new versions of the designware pcie driver.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ce0599134a69..6b5da2a98aaf 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -133,7 +133,9 @@
>
>                 pcie: pcie at 0x01000000 {
>                         compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
> -                       reg = <0x01ffc000 0x4000>; /* DBI */
> +                       reg = <0x01ffc000 0x04000>,
> +                             <0x01f00000 0x80000>;
> +                       reg-names = "dbi", "config";


Please update Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt as well.
