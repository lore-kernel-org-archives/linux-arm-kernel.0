From: horms@verge.net.au (Simon Horman)
Date: Fri, 4 Nov 2016 10:02:23 +0100
Subject: [PATCH v2] ARM: DTS: r8a7794: alt: Fix PFC names for DU
In-Reply-To: <1478201686-25488-1-git-send-email-jacopo@jmondi.org>
References: <1478180574-15464-1-git-send-email-jacopo@jmondi.org>
 <1478201686-25488-1-git-send-email-jacopo@jmondi.org>
Message-ID: <20161104090223.GA4801@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 03, 2016 at 08:34:46PM +0100, Jacopo Mondi wrote:
> Update the PFC pin groups and function names of DU interface for
> r8a7794 ALT board.
> 
> The currently specified pin groups and function names prevented PFC and
> DU interfaces from being correctly configured:
> 
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> sh-pfc e6060000.pin-controller: function 'du' not supported
> sh-pfc e6060000.pin-controller: invalid function du in map table
> rcar-du: probe of feb00000.display failed with error -22
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
> 
> v1->v2:
>     - s/PCF/PFC/ in commit message according to Sergei Shtylyov's comment
> 
> Patch applied against Simon Horman's renesas/master branch.
> The PCF pin groups and function renaming was introduced by commit 56ed4bb9 and
> DTS for ALT board has never been update accordingly.
> Tested displaying frames on VGA interface: the rcar-du driver loads correctly.

Thanks for noticing this.

There is no need to repost to update the subject, but for reference I would
prefer the prefix to be "ARM: dts: alt:". Assuming there are no other
changes I can fix that up when queuing up this change.

I am wondering if this should be queued up as a fix for v4.9 and in turn
v4.8-stable. Or if it should just be queued up for v4.10.

In the case of the former I'd advocate adding the following tag
(again no need to repost just to update this):

Fixes: 56ed4bb984ac ("pinctrl: sh-pfc: r8a7794: Add DU pin groups")

>  arch/arm/boot/dts/r8a7794-alt.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> index 8d1b35a..9d65fb3 100644
> --- a/arch/arm/boot/dts/r8a7794-alt.dts
> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> @@ -165,8 +165,8 @@
>  	pinctrl-names = "default";
>  
>  	du_pins: du {
> -		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_dotclkout0";
> -		function = "du";
> +		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_clk0_out";
> +		function = "du1";
>  	};
>  
>  	scif2_pins: scif2 {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
