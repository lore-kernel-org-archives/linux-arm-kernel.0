From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:47:23 -0600
Subject: [PATCH v7 08/17] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
In-Reply-To: <1421247905-3749-9-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80B3B.8060303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> the former signals to the OS that the firmware is PSCI compliant.
> The latter selects the appropriate conduit for PSCI calls by
> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
> (SMC).
>
> FADT table contains such information in ACPI 5.1, FADT table was
> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
> use the flags in struct acpi_gbl_FADT for PSCI init.
>
> Since ACPI 5.1 doesn't support self defined PSCI function IDs,
> which means that only PSCI 0.2+ is supported in ACPI.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
