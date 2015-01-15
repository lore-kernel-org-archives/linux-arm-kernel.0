From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:47:03 -0600
Subject: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision
 is less than 5.1
In-Reply-To: <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80B27.2050605@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> FADT Major.Minor version was introduced in ACPI 5.1, it is the same
> as ACPI version.
>
> In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
> MADT table for GIC and SMP init, without those updates, we can not
> get the MPIDR for SMP init, and GICv2/3 related init information, so
> we can't boot arm64 ACPI properly with table versions predating 5.1.
>
> If firmware provides ACPI tables with ACPI version less than 5.1,
> OS will be messed up with those information and have no way to init
> smp and GIC, so disable ACPI if we get an FADT table with version
> less that 5.1.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
