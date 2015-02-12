From: rric@kernel.org (Robert Richter)
Date: Thu, 12 Feb 2015 11:02:35 +0100
Subject: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150212100235.GA30412@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.02.15 20:45:28, Hanjun Guo wrote:
> This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, there are
> some updates since v7:
> 
>  - Add two more documantation to explain why we need ACPI in ARM64 servers
>    by Grant, and recommendations and prohibitions on the use of the numerous
>    ACPI tables and objects by Al Stone.
> 
>  - Add two patches which is need to map acpi tables after acpi_gbl_permanent_mmap
>    is set
> 
>  - Add another patch "dt / chosen: Add linux,uefi-stub-generated-dtb property"
>    to address that if firmware providing no dtb, we can try ACPI configuration data
>    even if no "acpi=force" is passed in early parameters. (I think ACPI for XEN and
>    kexec need consider sperately as disscussed, correct me if I'm wrong).
> 
>  - Add CC in the patch to the subsystem maintainers and modify the subject
>    of the patch to explicitly show the subsystem touched by this patch set,
>    please help us to review and ack them if they make sense, thanks.
> 
>  - Add Tested-by from Qualcomm and Redhat;
> 
>  - Make ACPI depends on PCI suggested by Catalin;
> 
>  - Clean up SMP init function as Lorenzo suggested, remove physical
>    CPU hot-plug code in the patch;
> 
>  - Address some comments from Marc and explicitly state that will
>    implment statcked irqdomain and GIC init framework when GICv3 and
>    ITS, GICv2m are implemented;
> 
>  - Rebased on top of 3.19-rc7.

Patches tested on Cavium ThunderX. For the whole series:

 Tested-by: Robert Richter <rrichter@cavium.com>
 Acked-by: Robert Richter <rrichter@cavium.com>

Please apply.

Thanks,

-Robert
