From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 04 Feb 2015 14:29:34 -0600
Subject: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54D2812E.9060804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2015 06:45 AM, Hanjun Guo wrote:
> Hi,
>
> This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, there are
> some updates since v7:

All 21 patches:

Tested-by: Timur Tabi <timur@codeaurora.org>

I no longer need to use "acpi=force", so that's nice.

>
>   - Add two more documantation to explain why we need ACPI in ARM64 servers

"documentation"


>     by Grant, and recommendations and prohibitions on the use of the numerous
>     ACPI tables and objects by Al Stone.
>
>   - Add two patches which is need to map acpi tables after acpi_gbl_permanent_mmap
>     is set
>
>   - Add another patch "dt / chosen: Add linux,uefi-stub-generated-dtb property"
>     to address that if firmware providing no dtb, we can try ACPI configuration data
>     even if no "acpi=force" is passed in early parameters. (I think ACPI for XEN and
>     kexec need consider sperately as disscussed, correct me if I'm wrong).

"need to be considered separately", "discussed"

>
>   - Add CC in the patch to the subsystem maintainers and modify the subject
>     of the patch to explicitly show the subsystem touched by this patch set,
>     please help us to review and ack them if they make sense, thanks.
>
>   - Add Tested-by from Qualcomm and Redhat;
>
>   - Make ACPI depends on PCI suggested by Catalin;
>
>   - Clean up SMP init function as Lorenzo suggested, remove physical
>     CPU hot-plug code in the patch;
>
>   - Address some comments from Marc and explicitly state that will
>     implment statcked irqdomain and GIC init framework when GICv3 and

"implement", "stacked"


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
