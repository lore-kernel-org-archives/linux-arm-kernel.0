From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:45:03 -0600
Subject: [PATCH v7 02/17] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <1421247905-3749-3-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80AAF.7030107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
>
> As we want to get ACPI tables to parse and then use the information
> for system initialization, we should get the RSDP (Root System
> Description Pointer) first, it then locates Extended Root Description
> Table (XSDT) which contains all the 64-bit physical address that
> pointer to other boot-time tables.
>
> Introduce acpi.c and its related head file in this patch to provide
> fundamental needs of extern variables and functions for ACPI core,
> and then get boot-time tables as needed.
>    - asm/acenv.h for arch specific ACPICA environments and
>      implementation, It is needed unconditionally by ACPI core;
>    - asm/acpi.h for arch specific variables and functions needed by
>      ACPI driver core;
>    - acpi.c for ARM64 related ACPI implementation for ACPI driver
>      core;
>
> acpi_boot_table_init() is introduced to get RSDP and boot-time tables,
> it will be called in setup_arch() before paging_init(), so we should
> use eary_memremap() mechanism here to get the RSDP and all the table
> pointers.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
