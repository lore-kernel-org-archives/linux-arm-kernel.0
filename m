From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Oct 2015 10:31:26 +0200
Subject: [PATCH v2 1/5] ARM: dts: sun6i: hummingbird: Fix VDD-CPU and
 VDD-GPU regulator names
In-Reply-To: <1444488540-11263-2-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-2-git-send-email-wens@csie.org>
Message-ID: <20151012083126.GX2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 10, 2015 at 10:48:56PM +0800, Chen-Yu Tsai wrote:
> The VDD-CPU and VDD-GPU regulators were incorrectly swapped.
> 
> Fixes: bab03561224ba ("ARM: dts: sun6i: hummingbird: Add AXP221 regulator
>        nodes")
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> index f9d9fc07bc63..e25d4924dbe7 100644
> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> @@ -191,18 +191,18 @@
>  				regulator-name = "vcc-3v0";
>  			};
>  
> -			vdd_cpu: dcdc2 {
> +			vdd_gpu: dcdc2 {
>  				regulator-always-on;
>  				regulator-min-microvolt = <700000>;
>  				regulator-max-microvolt = <1320000>;
> -				regulator-name = "vdd-cpu";
> +				regulator-name = "vdd-gpu";
>  			};

Do we need to leave the GPU regulator on ?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/38713a8a/attachment.sig>
