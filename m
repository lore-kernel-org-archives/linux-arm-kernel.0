From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 05 Feb 2015 17:48:37 +0800
Subject: [PATCH v8 11/21] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
In-Reply-To: <20150204164328.GF22035@red-moon>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-12-git-send-email-hanjun.guo@linaro.org>
 <20150204164328.GF22035@red-moon>
Message-ID: <54D33C75.8030405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?05? 00:43, Lorenzo Pieralisi wrote:
> On Mon, Feb 02, 2015 at 12:45:39PM +0000, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
>> the former signals to the OS that the firmware is PSCI compliant.
>> The latter selects the appropriate conduit for PSCI calls by
>> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
>> (SMC).
>>
>> FADT table contains such information in ACPI 5.1, FADT table was
>> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
>> use the flags in struct acpi_gbl_FADT for PSCI init.
>
> So you do rely on a global FADT being available, if you use it for PSCI
> detection you can use it for ACPI revision detection too, right ?

Yes, I think so.

>
> Point is, either we should not use the global FADT table, or we use
> it consistently, or there is something I am unaware of that prevents
> you from using in some code paths and I would like to understand
> why.

global FADT table is initialized when parsing the tables from RSDP in
ACPICA core, and it should be work on ARM64 too.

Thanks
Hanjun
