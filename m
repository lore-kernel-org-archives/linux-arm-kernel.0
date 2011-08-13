From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 13 Aug 2011 10:29 +0200
Subject: [PATCH 2/4] msm_serial: Add devicetree support
In-Reply-To: <1313190008-7551-3-git-send-email-davidb@codeaurora.org>
References: <1313190008-7551-1-git-send-email-davidb@codeaurora.org>
	<1313190008-7551-3-git-send-email-davidb@codeaurora.org>
Message-ID: <1434305.ibxmc6q715@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 August 2011 16:00:06 David Brown wrote:
> +Required properties:
> +- compatible :
> +       - "qcom,msm-uart"
> +- reg : offset and length of the register set for the device
> +       for the hsuart operating in compatible mode, there should be a
> +       second pair describing the gsbi registers.
> +- interrupts : should contain the uart interrupt.
> +
> +Example:
> +
> +       uart at 19c400000 {
> +               compatible = "qcom,msm-hsuart", "qcom,msm-uart";
> +               reg = <0x19c40000 0x1000">,
> +                     <0x19c00000 0x1000">;
> +               interrupts = <195>;
> +       };



> @@ -920,11 +928,17 @@ static int __devexit msm_serial_remove(struct platform_device *pdev)
>         return 0;
>  }
>  
> +static struct of_device_id msm_match_table[] = {
> +       { .compatible = "qcom,msm-hsuart-lite" },
> +       {}
> +};
> +

Hi David,

It looks like you changed the value for the "compatible" property in the
process of making the patch, but did not update all places.

Should it be qcom,msm-hsuart-lite or qcom,msm-hsuart?

	Arnd
