From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 Aug 2016 09:47:58 +0100
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
Message-ID: <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yoma,

On 18/08/16 03:07, yoma sophian wrote:
> hi Sudeep
>
>> Correct. What's the cpu enable method on your platform ? Is it PSCI  ?
> No, the enable method is "spin-table"
>

Generally spin-table is used for the initial bring up. If one is
interested in full power management support on a platform, PSCI is the
recommended standard on ARM64.

>> If yes, does you PSCI implementation support SYSTEM_SUSPEND ? If
>> yes, it should work. Check your PSCI implementation otherwise.
>
> if so, there are 2 things make me curious: a. I trace
> arch/arm64/kernel/psci.c even arch/arm64/*, but I sill cannot find
> where it create global suspend method table with suspend_set_ops. #
> grep -rnw 'suspend_set_ops' ../linux-4.1/arch/arm64/ #

drivers/firmware/psci.c

> except arch/xxx folder, there are
> ../linux-4.1/drivers/macintosh/via-pmu.c:2276:
> suspend_set_ops(&pmu_pm_ops); ../linux-4.1/drivers/acpi/sleep.c:666:
> suspend_set_ops(old_suspend_ordering ? Does that mean aarch64
> register suspend_set_ops by apci flow when adopt PSCI
> implementation?
>
Not yet, but may choose that from ACPI boot.


> b. in arm64, if some platform has its own suspend flow,  couldn't it
> adopts arm/match-xxx to register its own global suspend method?
>

No, PSCI is highly recommended.

-- 
Regards,
Sudeep
