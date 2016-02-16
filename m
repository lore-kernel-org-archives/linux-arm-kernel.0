From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 16 Feb 2016 07:44:04 +0100
Subject: [PATCH v3 7/7] arm64: dts: r8a7795: Add CA53 L2 cache-controller
 node
In-Reply-To: <1455568715-20880-8-git-send-email-geert+renesas@glider.be>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
 <1455568715-20880-8-git-send-email-geert+renesas@glider.be>
Message-ID: <56C2C534.30704@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.02.2016 21:38, Geert Uytterhoeven wrote:
> Add a device node for the Cortex-A53 L2 cache-controller.
>
> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
> 32 KiB x 16 ways).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>    - Remaining part of "[PATCH v2 6/6] arm64: renesas: r8a7795: Add L2
>      cache-controller nodes".
> ---
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index c07f4e83b988ba42..c572527afec3403a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -72,6 +72,12 @@
>   		cache-level = <2>;
>   	};
>
> +	L2_CA53: cache-controller at 1 {
> +		compatible = "cache";
> +		cache-unified;
> +		cache-level = <2>;
> +	};
> +


As we don't have any CA53 in the device tree yet, and it was rejected to 
add it, I'd think that we don't want these unused entries at the moment.

I'd propose to add the CA53 entries, first. And then add their L2 cache 
entries.

Based on the outcome of the discussion for the CA57 we have to see if we 
want to add the unused cache-unified and cache-level, then, too.

Best regards

Dirk
