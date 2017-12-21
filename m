From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 20 Dec 2017 17:38:43 -0800
Subject: [PATCH v2 0/9] soc: brcmstb: biuctrl updates for 64-bit chips
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <409b31a8-03ba-e371-b8a8-7975ef896fc8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/19/17 ? 11:22, Florian Fainelli a ?crit?:
> Hi all,
> 
> This patch series updates the Broadcom STB Bus Interface Unit controller to
> support newer chips such as 7260, 7268, 7271 and 7278. These chips require
> additional tuning in order to provide the expected bus throughput.
> 
> In the process, we need to re-organize the common.c file a little bit in order
> to extract the family and product identifiers a little earlier.
> 
> Finally, by moving the biuctrl initialization an early_initcall level, we can
> remove some code from the ARM-32bit machine descriptor file.
> 
> Provided that we are happy with these changes, I would route them through my
> drivers/next branch and a subsequent Broadcom ARM SoC pull request.
> 
> Thank you
> 
> Changes in v2:
> 
> - collect Rob's acked-by on the first patch
> - fixed the binding as suggested by Rob
> 
> Florian Fainelli (9):
>   dt-bindings: arm: Add entry for Broadcom Brahma-B53
>   dt-bindings: arm: brcmstb: Correct BIUCTRL node documentation
>   soc: brcmstb: Make CPU credit offset more parameterized
>   soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs
>   soc: brcmstb: biuctrl: Prepare for saving/restoring other registers
>   soc: brcmstb: biuctrl: Wire-up new registers
>   soc: brcmstb: biuctrl: Fine tune B53 MCP interface settings
>   soc: brcmstb: Split initialization
>   soc: brcmstb: biuctrl: Move to early_initcall

Series applied to drivers/next.
-- 
Florian
