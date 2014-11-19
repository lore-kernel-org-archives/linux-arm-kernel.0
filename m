From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Nov 2014 17:49:49 +0000
Subject: [PATCH v7 3/4] ARM: mediatek: Add sysirq in mt6589/mt8135/mt8127
 dtsi
In-Reply-To: <1416406451-4578-4-git-send-email-yingjoe.chen@mediatek.com>
 (Yingjoe Chen's message of "Wed, 19 Nov 2014 14:14:10 +0000")
References: <1416406451-4578-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416406451-4578-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <87d28jaxmq.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19 2014 at  2:14:10 pm GMT, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> Add sysirq settings for mt6589/mt8135/mt8127
> This also correct timer interrupt flag. The old setting works
> because boot loader already set polarity for timer interrupt.
> Without intpol support, the setting was not changed so gic
> can get the irq correctly.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  arch/arm/boot/dts/mt6589.dtsi | 14 ++++++++++++--
>  arch/arm/boot/dts/mt8127.dtsi | 14 ++++++++++++--
>  arch/arm/boot/dts/mt8135.dtsi | 14 ++++++++++++--
>  3 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
> index e3c7600..c91b2a9 100644
> --- a/arch/arm/boot/dts/mt6589.dtsi
> +++ b/arch/arm/boot/dts/mt6589.dtsi
> @@ -19,7 +19,7 @@
>  
>  / {
>  	compatible = "mediatek,mt6589";
> -	interrupt-parent = <&gic>;
> +	interrupt-parent = <&sysirq>;

This worries me a bit. Your sysirq cannot handle PPIs, and yet you make
it the top-level interrupt controller, without amending any PPI.

Does it mean you do not use *any* PPI? No per-cpu timer, nothing?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
