From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 21 Jan 2016 18:44:03 +0900
Subject: [PATCH] ARM: zx296702-ad1: remove deprecated supports-highspeed
In-Reply-To: <1453366905-3964-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453366905-3964-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <56A0A863.1010103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shaw.

On 01/21/2016 06:01 PM, Shawn Lin wrote:
> supports-highspeed property is deprecated for dw_mmc,
> this patch replace it with cap-sd-highspeed and cap-mmc-highspeed.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/zx296702-ad1.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
> index 081f980..bfbcd805d 100644
> --- a/arch/arm/boot/dts/zx296702-ad1.dts
> +++ b/arch/arm/boot/dts/zx296702-ad1.dts
> @@ -19,7 +19,8 @@
>  
>  &mmc0 {
>  	num-slots = <1>;
> -	supports-highspeed;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
>  	non-removable;
>  	disable-wp;
>  	status = "okay";

I saw the below codes..

slot at 0 {
	reg = <0>;
	bus-width = <4>;
};

Slot is also deprecated.. You can change those..

Best Regards,
Jaehoon Chung

> @@ -32,7 +33,8 @@
>  
>  &mmc1 {
>  	num-slots = <1>;
> -	supports-highspeed;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
>  	non-removable;
>  	disable-wp;
>  	status = "okay";
> 
