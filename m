From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Sep 2015 16:28:48 +0200
Subject: [PATCH 1/5] ARM: dts: sun5i: Add PWM controller node for A13/A10s
In-Reply-To: <1442752251-20744-2-git-send-email-hdegoede@redhat.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <1442752251-20744-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150922142848.GC4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2015 at 08:30:47AM -0400, Hans de Goede wrote:
> The sun5i die has a PWM controller that is compatible to the one on the A20.
> Add a device node for it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 78b993a..5e036a4 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -543,6 +543,14 @@
>  			reg = <0x01c20c90 0x10>;
>  		};
>  
> +		pwm: pwm at 01c20e00 {
> +			compatible = "allwinner,sun7i-a20-pwm";

Is it? IIRC, it has a single channel, while the A20 has two.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/25c630ac/attachment.sig>
