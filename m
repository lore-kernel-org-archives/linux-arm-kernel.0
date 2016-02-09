From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 9 Feb 2016 14:09:01 -0800
Subject: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
In-Reply-To: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
References: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20160209220901.GC28102@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 03:15:05PM +0530, Keerthy wrote:
> The thermal threholds for am57xx are different from that of dra7.
> Correcting the thresholds for the same.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Depends on: https://lkml.org/lkml/2016/2/8/90
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
> ===================================================================
> --- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.514959101 +0530
> +++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.510959168 +0530

Sorry, did not bother to check, but is this the only user of am57xx?

Apart from the above:

Acked-by: Eduardo Valentin <edubezval@gmail.com>


> @@ -825,3 +825,27 @@
>  		status = "okay";
>  	};
>  };
> +
> +&cpu_alert0 {
> +	temperature = <90000>; /* milliCelsius */
> +};
> +
> +&cpu_crit {
> +	temperature = <105000>; /* milliCelsius */
> +};
> +
> +&gpu_crit {
> +	temperature = <105000>; /* milliCelsius */
> +};
> +
> +&core_crit {
> +	temperature = <105000>; /* milliCelsius */
> +};
> +
> +&dspeve_crit {
> +	temperature = <105000>; /* milliCelsius */
> +};
> +
> +&iva_crit {
> +	temperature = <105000>; /* milliCelsius */
> +};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/e62133ba/attachment.sig>
