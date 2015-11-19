From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Nov 2015 21:21:06 +0100
Subject: [PATCH RESEND] arm: dts: berlin2q-marvell-dmp: remove broken-cd
 from eMMC node
In-Reply-To: <1447670617-7778-1-git-send-email-jszhang@marvell.com>
References: <1447670617-7778-1-git-send-email-jszhang@marvell.com>
Message-ID: <564E2F32.40202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.11.2015 11:43, Jisheng Zhang wrote:
> The eMMC is non-removable so is marked with the non-removable DT
> property to avoid having to redetect it after a suspend/resume.
> 
> But it also has the broken-cd property which is wrong since only
> one of the DT properties for card detection should be used
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to berlin64/dt.

Thanks!

> ---
>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index da28c97..cdcf89b 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -94,7 +94,6 @@
>  };
>  
>  &sdhci2 {
> -	broken-cd;
>  	bus-width = <8>;
>  	non-removable;
>  	status = "okay";
> 
