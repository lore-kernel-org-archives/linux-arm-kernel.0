From: cjb@laptop.org (Chris Ball)
Date: Mon, 16 Jul 2012 00:23:11 -0400
Subject: [PATCH v3 5/6] mmc: dw_mmc: add device tree support
In-Reply-To: <1342097668-25243-6-git-send-email-thomas.abraham@linaro.org>
 (Thomas Abraham's message of "Thu, 12 Jul 2012 18:24:27 +0530")
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
 <1342097668-25243-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <87liikjpw0.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 12 2012, Thomas Abraham wrote:
> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> new file mode 100644
> index 0000000..3acd6c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> @@ -0,0 +1,108 @@
> +* Synopsis Designware Mobile Storage Host Controller
> +
> +The Synopsis designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following
> +	- snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
> +
> +* reg: physical base address of the dw-mshc controller and size of its memory
> +  region.
> +
> +* interrupts: interrupt specifier for the controller. The format and value of
> +  the interrupt specifier depends on the interrupt parent for the controller.

Please instead add:

This file documents differences between the core properties described
by mmc.txt and the properties used by the dw_mmc driver.

mmc.txt already describes compatible, reg, interrupts, bus-width,
cd-gpios, and wp-gpios, so you don't need to describe those again.

> +	cnt = sizeof(of_quriks) / sizeof(struct dw_mci_of_quirks);
> +	for (idx = 0; idx < cnt; idx++)
> +		if (of_get_property(np, of_quriks[idx].quirk, NULL))
> +			pdata->quirks |= of_quriks[idx].id;

of_quirks, not of_quriks.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
