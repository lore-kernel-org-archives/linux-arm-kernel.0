From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 29 Dec 2016 17:02:40 -0600
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161229224335.13531-2-cov@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
Message-ID: <1dfdc578-e0f8-1320-d223-c9c55e70ca93@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2016 04:43 PM, Christopher Covington wrote:
> -| Implementor    | Component       | Erratum ID      | Kconfig                 |
> -+----------------+-----------------+-----------------+-------------------------+
> -| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319    |
> -| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319    |
> -| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069    |
> -| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472    |
> -| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719    |
> -| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419    |
> -| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
> -| ARM            | Cortex-A57      | #852523         | N/A                     |
> -| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
> -| ARM            | Cortex-A72      | #853709         | N/A                     |
> -| ARM            | MMU-500         | #841119,#826419 | N/A                     |
> -|                |                 |                 |                         |
> -| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
> -| Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144    |
> -| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
> -| Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
> -| Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
> -|                |                 |                 |                         |
> -| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
> +| Implementor   | Component       | Erratum ID      | Kconfig                  |
> ++---------------+-----------------+-----------------+--------------------------+
> +| ARM           | Cortex-A53      | #826319         | ARM64_ERRATUM_826319     |
> +| ARM           | Cortex-A53      | #827319         | ARM64_ERRATUM_827319     |
> +| ARM           | Cortex-A53      | #824069         | ARM64_ERRATUM_824069     |
> +| ARM           | Cortex-A53      | #819472         | ARM64_ERRATUM_819472     |
> +| ARM           | Cortex-A53      | #845719         | ARM64_ERRATUM_845719     |
> +| ARM           | Cortex-A53      | #843419         | ARM64_ERRATUM_843419     |
> +| ARM           | Cortex-A57      | #832075         | ARM64_ERRATUM_832075     |
> +| ARM           | Cortex-A57      | #852523         | N/A                      |
> +| ARM           | Cortex-A57      | #834220         | ARM64_ERRATUM_834220     |
> +| ARM           | Cortex-A72      | #853709         | N/A                      |
> +| ARM           | MMU-500         | #841119,#826419 | N/A                      |
> +|               |                 |                 |                          |
> +| Cavium        | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375     |
> +| Cavium        | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144     |
> +| Cavium        | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154     |
> +| Cavium        | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456     |
> +| Cavium        | ThunderX SMMUv2 | #27704          | N/A                      |
> +|               |                 |                 |                          |
> +| Freescale/NXP | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585      |
> +| Qualcomm      | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003 |

Looks like you've made an unrelated whitespace change that affected the entire table,
not just the line you're adding.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
