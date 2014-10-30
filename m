From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 11:10:20 +0100
Subject: [PATCH 2/3] dt-bindings: Add Reset Controller for MediaTek SoC
In-Reply-To: <1414638733-10080-3-git-send-email-flora.fu@mediatek.com>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
 <1414638733-10080-3-git-send-email-flora.fu@mediatek.com>
Message-ID: <2323181.epJX0Uxj7x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 October 2014 11:12:12 flora.fu at mediatek.com wrote:
> +
> +example:
> +       infrarst: reset-controller at 10001030 {
> +               #reset-cells = <1>;
> +               compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
> +               mediatek,syscon-reset = <&infracfg 0x30 0x8>;
> +       };

I think you need to change the 'unit-address' now, i.e. the @10001030
value above no longer matches any reg property. You could just
remove that part.

> +Specifying reset lines connected to IP modules
> +==============================================
> +
> +The reset controller(mtk-reset) manages various reset sources. Those device nodes should
> +specify the reset line on the rstc in their resets property, containing a phandle to the
> +rstc device node and a RESET_INDEX specifying which module to reset, as described in 
> +reset.txt.
> +
> +For MediaTek SoC, RESET_INDEX is reset bit defined in INFRACFG or PERICFG registers.
> +
> +example:
> +pwrap: pwrap at 1000f000 {
> +       compatible = "mediatek,mt8135-pwrap";
> +       reg = <0 0x1000f000 0 0x1000>,
> +               <0 0x11017000 0 0x1000>;
> +       reg-names = "pwrap-base",
> +               "pwrap-bridge-base";
> +       resets = <&infrarst 7>, <&perirst 34>;
> +       reset-names = "infrarst", "perirst";
> +       };
> +};
> 

You have an extraneous '};' here.

	Arnd
