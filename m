From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 1 Aug 2015 11:26:38 +0200
Subject: [PATCH] ARM: dts: sun7i: Change cubietruck wifi enable pin to
 use mmc-pwrseq
In-Reply-To: <1438357312-17378-1-git-send-email-hdegoede@redhat.com>
References: <1438357312-17378-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150801092638.GW2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 05:41:52PM +0200, Hans de Goede wrote:
> The wifi-enable pin of the ap6210 module is not really a regulator,
> switch to the mmc-pwrseq framework for controlling it. This more
> accurately reflects how the hardware actually works.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index de3e195..0b2f914 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -88,15 +88,11 @@
>  		};
>  	};
>  
> -	reg_vmmc3: vmmc3 {
> -		compatible = "regulator-fixed";
> +	mmc3_pwrseq: mmc3_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vmmc3_pin_cubietruck>;

The pinctrl name shouldn't be called that way anymore.

Changed it to mmc3_pwrseq_pin_cubietruck, and applied the patch.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150801/e8beae06/attachment.sig>
