From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 31 Oct 2016 22:22:54 +0200
Subject: [PATCH v2 4/5] ARM: dts: da850-lcdk: enable mstpri and ddrctl
 nodes
In-Reply-To: <1477925138-23457-5-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <12222113.L5elJM2tqN@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

Thank you for the patch.

On Monday 31 Oct 2016 15:45:37 Bartosz Golaszewski wrote:
> Enable the MSTPRI configuration and DDR2/mDDR memory controller
> nodes on da850-lcdk. This is needed in order to adjust the memory
> throughput constraints for better tilcdc support.

Is there a reason not to enable these unconditionally in da850.dtsi (or rather 
not disabling them) instead of handling it per board ?

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts
> b/arch/arm/boot/dts/da850-lcdk.dts index 4747629..b39796e 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -243,3 +243,11 @@
>  		};
>  	};
>  };
> +
> +&mstpri {
> +	status = "okay";
> +};
> +
> +&ddrctl {
> +	status = "okay";
> +};

-- 
Regards,

Laurent Pinchart
