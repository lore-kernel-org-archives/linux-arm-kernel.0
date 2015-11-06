From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Nov 2015 10:23:39 -0600
Subject: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
In-Reply-To: <1446826430-3705-1-git-send-email-sre@kernel.org>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
Message-ID: <87a8qryu44.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Sebastian Reichel <sre@kernel.org> writes:
> This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> which breaks the omap3 device tree build due to a wrong reference.
>
> I accidently queued this change via the power supply subsystem while
> telling Marek at the same time, that it should go through Tony's tree.
> Following that I did miss Stephen's messages about the build failure in
> linux-next and since he switched to merging an older snapshot nobody
> else noticed the problem in my tree. I didn't notice myself, since I
> did not build any device tree files assuming none have changed by me.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reported-by: Felipe Balbi <balbi@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/twl4030.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 482b7aa37808..36ae9160b558 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -22,8 +22,6 @@
>  	charger: bci {
>  		compatible = "ti,twl4030-bci";
>  		interrupts = <9>, <2>;
> -		io-channels = <&twl4030_madc 11>;
> -		io-channel-name = "vac";
>  		bci3v1-supply = <&vusb3v1>;
>  	};
>  
> -- 
> 2.6.2
>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/a62fabc5/attachment.sig>
