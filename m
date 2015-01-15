From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Thu, 15 Jan 2015 15:33:00 -0600
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B8320C.5090201@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/14/2015 9:04 AM, Hanjun Guo wrote:
> Hi,
>
> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
>
> updates from v6:
>    - Rebased on top of 3.19-rc4, add Mack Salter's patch to use
>      the early_ioremap after paging_init() for ACPI table mappings;
>
>    - Two patches about converting apic_id to phys_id to make it arch
>      agnostic were already merged into RC4 by Rafael.
>
>    - Split patch "Parse FADT table to get PSCI flags for PSCI init"
>      into two as Lorenzo's suggestion, also fix typo and lack of __init
>      for psci_0_2_set_functions() which is spotted by Lorenzo.
>
>    - Add Tested-by from Yijing Wang.
>
> previous version is here:
> v6: https://lkml.org/lkml/2015/1/4/40
>
> 1. Why we need ACPI on ARM64?
>
>    - Grant already posted a blog about this, and stated clearly
>      why we need ACPI on ARM64:
>
>      http://www.secretlab.ca/archives/151
>
>
> 2. What we need to do before the arm64 ACPI core patches
>     could be merged into the kernel?
>
>    - Al Stone posted a TODO list and updates v2 for the
>      progress we made:
>      http://www.spinics.net/lists/arm-kernel/msg390069.html
>
>    - so from the progress we can see that we already finished
>      most of the items, and _OSI we got a plan to fix it, RFC
>      patch is on the way.
>
>
> This patch set was tested on FVP by Fuwei, and booted ok as expected.
> (No functional change since last version)
>
> Thanks
> Hanjun
>

The V7 patch series has also been re-tested on AMD Seattle server 
platform along with the "Introduce ACPI support for ahci_platform 
driver" patch series here (https://lkml.org/lkml/2015/1/5/662).

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Thanks,

Suravee
