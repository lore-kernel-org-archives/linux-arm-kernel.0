From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 01 Aug 2016 10:54:07 +0200
Subject: [PATCH V3 2/5] dts/imx6q-b850v3: Configure IPU assignment order
In-Reply-To: <7e5985c0b25505eeaf50294ea04ed750c6c0f576.1469993472.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1469993472.git.peter.senna@collabora.com>
 <7e5985c0b25505eeaf50294ea04ed750c6c0f576.1469993472.git.peter.senna@collabora.com>
Message-ID: <1470041647.6640.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 31.07.2016, 21:55 +0200 schrieb Peter Senna Tschudin:
> As the IPU has combined limitations across multiple crtcs, and as that
> can't be communicated to userspace at the moment, reorder the crtcs to
> allow support to two Full-HD monitors by avoiding assigning two
> monitors to a single IPU.
> 
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>

NACK. This is a userspace issue. Changing the assignment order of the
CRTCs just shifts the failure to a userspace that want to use CRTC 0 and
2 now.

imx-drm just got atomic support and with the atomic check it should be
possible to inform userspace in a reasonable way about such issues.

Regards,
Lucas

> ---
> Unchanged from V2.
> 
> Changes from V1:
>  - New commit message
> 
>  arch/arm/boot/dts/imx6q-b850v3.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
> index 167f744..88a70de 100644
> --- a/arch/arm/boot/dts/imx6q-b850v3.dts
> +++ b/arch/arm/boot/dts/imx6q-b850v3.dts
> @@ -51,6 +51,11 @@
>  	chosen {
>  		stdout-path = &uart3;
>  	};
> +
> +	display-subsystem {
> +		compatible = "fsl,imx-display-subsystem";
> +		ports = <&ipu1_di0>, <&ipu2_di0>, <&ipu1_di1>, <&ipu2_di1>;
> +	};
>  };
>  
>  &clks {
