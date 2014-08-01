From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 1 Aug 2014 18:06:52 +0800
Subject: [Query] How to pass reboot arguments to secure firmware with PSCI spec
Message-ID: <20140801180652.72e722be@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin and Will,

I noticed that the following commit implement reboot via. PSCI SYSTEM_RESET
function. So my question is how to handle the reboot arguments? 


> static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> {
>       invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);

How to pass cmd to secure firmware?

> }

Thanks in advance,
Jisheng

commit e71246a23acbc89e9cb4ebf1558d60e65733479f
Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Date:   Thu Apr 17 14:38:41 2014 -0400

    PSCI: Add initial support for PSCIv0.2 functions
    
    The PSCIv0.2 spec defines standard values of function IDs
    and introduces a few new functions. Detect version of PSCI
    and appropriately select the right PSCI functions.
    
    Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Acked-by: Catalin Marinas <catalin.marinas@arm.com>
