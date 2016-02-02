From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 14:13:47 +0100
Subject: [PATCH 03/14] clk: sunxi: add bus gates for A83T
In-Reply-To: <1454203266-4450-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-4-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160202131347.GP4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:55AM +0800, Vishnu Patekar wrote:
> A83T has similar bus gates that of H3, including single gating register has
> different clock parent.
> 
> As per H3 and A83T datasheet, usbhost is under AHB2.
> 
> However,below shows allwinner source code assignment:
> bits: 26 (ehci0), 27 (ehci1), 29 (ohci0) => AHB1 for A83T.
> bits: 26 (ehci0), 27 (ehci1) => AHB1 for H3
> bits  29, 30, 31(ohci0,1,2) => AHB2 for H3.
> 
> until, this confusion is cleared keep it H3 way.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
>  drivers/clk/sunxi/clk-sun8i-bus-gates.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 7f19ef5..4514d77 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -59,6 +59,7 @@ Required properties:
>  	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
>  	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
>  	"allwinner,sun8i-h3-bus-gates-clk" - for the bus gates on H3
> +	"allwinner,sun8i-a83t-bus-gates-clk" - for the bus gates on A83T

Please order them alphabetically next time.

Applied with the fix, and the Acked-bys

thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/8a695ffe/attachment.sig>
