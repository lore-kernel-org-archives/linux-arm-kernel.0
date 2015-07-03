From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 3 Jul 2015 13:16:35 +0800
Subject: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <1435880916-2153-2-git-send-email-al.stone@linaro.org>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <1435880916-2153-2-git-send-email-al.stone@linaro.org>
Message-ID: <55961AB3.70801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On 2015/7/3 7:48, Al Stone wrote:
> Add the __ACPI_FADT_SPEC_VERSION() helper macro to build a proper version
> number from a major and minor revision number.  Add also macros that use
> the helper to construct the current version from the values in the FADT
> (i.e., ACPI_FADT_SPEC_VERSION) and both the 5.1 and 6.0 versions.
>
> These macros are added in order to simplify retrieving and comparing ACPI
> specification version numbers, since this is becoming a more frequent need.
> In particular, there are some architectures that require at least a certain
> version of the spec, and there are differences in some structure sizes that
> have changed with recent versions but can only be tracked by spec version
> number.
>
> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)

If I understand correctly, will it be (and for next two patches as well):

0cff8dc0099f (ACPICA: ACPI 6.0: Add changes for MADT table.)?

FADT table update was not introduce any regressions for ARM64
I think.

Thanks
Hanjun
