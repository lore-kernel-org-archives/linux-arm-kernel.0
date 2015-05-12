From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Tue, 12 May 2015 14:13:20 +0200
Subject: [PATCH 2/6] ARM: Zynq: DT: Enable xadc node in zynq-parallella.dts
In-Reply-To: <1431037945-40360-2-git-send-email-xander.huff@ni.com>
References: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
 <1431037945-40360-2-git-send-email-xander.huff@ni.com>
Message-ID: <5551EE60.40601@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.05.2015 um 00:32 schrieb Xander Huff:
> Now that zynq-7000 disables xadc by default, enable in zynq-parallella
> to retain existing behavior.
> 
> Signed-off-by: Xander Huff <xander.huff@ni.com>
> ---
>  arch/arm/boot/dts/zynq-parallella.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> index 1745712..b1a1f7a 100644
> --- a/arch/arm/boot/dts/zynq-parallella.dts
> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> @@ -32,6 +32,12 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
>  		linux,stdout-path = "/amba/serial at e0001000";
>  	};
> +
> +	amba {
> +		adc: adc at f8007100 {
> +			status = "okay";
> +		};
> +	};

You've already discarded this patchset, but please note for the future
that the desired style would've been the one you see below, i.e.

>  };

&adc {
	status = "okay";
};

Regards,
Andreas

>  
>  &clkc {
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
