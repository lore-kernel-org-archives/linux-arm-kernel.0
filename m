From: sourav.poddar@ti.com (sourav)
Date: Wed, 9 Jul 2014 15:37:00 +0530
Subject: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
In-Reply-To: <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
 <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
Message-ID: <53BD1444.6080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 09 July 2014 12:10 AM, Sebastian Andrzej Siewior wrote:
> The core complains that the number 343 is too large. The older code has
> here 124. This avoids the warning, the driver hasn't been tested.
>
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>
> ---
>   arch/arm/boot/dts/dra7.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index daf7d36..1529bca 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -821,7 +821,7 @@
>   			clocks =<&qspi_gfclk_div>;
>   			clock-names = "fck";
>   			num-cs =<4>;
> -			interrupts =<0 343 0x4>;
> +			interrupts =<0 124 0x4>;
>   			status = "disabled";
>   		};
>

The number is correct and is complaining just because the crossbar stuff 
is not
put in. I had already posted a patch[1] to remove interrupt binding as 
of now.

Hence, NAK for this patch.

[1]: https://patchwork.kernel.org/patch/4364341/
