From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 21:29:26 -0500
Subject: [PATCH v2 15/20] arm: kirkwood: topkick: the Topkick platform
 uses a 88F6282 SoC
In-Reply-To: <1356101359-6054-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1356101359-6054-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130110022926.GH5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 03:49:14PM +0100, Thomas Petazzoni wrote:
> The Topkick board uses a 88F6282 SoC, so the Device Tree Source
> describing the Topkick should inherit from kirkwood-6282.dtsi, which
> allows to take advantage of pin muxing capabilities.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes since v1:
>  * This patch is new in v2
> ---
>  arch/arm/boot/dts/kirkwood-topkick.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
> index c0de5a7..8f4a5b8 100644
> --- a/arch/arm/boot/dts/kirkwood-topkick.dts
> +++ b/arch/arm/boot/dts/kirkwood-topkick.dts
> @@ -1,6 +1,7 @@
>  /dts-v1/;
>  
>  /include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6282.dtsi"

Hmmm, shouldn't the cooresponding MPP.._GPIO and kirkwood_mpp_conf() be
removed as well?

thx,

Jason.

>  
>  / {
>  	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
