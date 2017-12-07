From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Dec 2017 15:00:18 -0200
Subject: [PATCH] ARM: dts: imx6: RDU2: correct RTC compatible
In-Reply-To: <20171207150923.25024-1-l.stach@pengutronix.de>
References: <20171207150923.25024-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5D+-WWuq2VXY-C=0KMBuxR=ZAPdLFQo+crLbLA31=qr4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

+ Rob and device tree list

On Thu, Dec 7, 2017 at 1:09 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The RTC is manufactured by Maxim. This is a cosmetic fix, as Linux
> doesn't match the vendor string for i2c devices.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index eef737bd52d9..6bef9a98678e 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -581,7 +581,7 @@
>         };
>
>         ds1341: rtc at 68 {
> -               compatible = "dallas,ds1341";
> +               compatible = "maxim,ds1341";

Dallas has been acquired by Maxim and
Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
mentions "dallas,ds1341", so better keep the existing notation.

Regards,

Fabio Estevam
