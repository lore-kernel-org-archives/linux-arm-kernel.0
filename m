From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 22 Aug 2017 16:35:34 +0100
Subject: [PATCH v6 6/6] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20170822121722.0000712c@huawei.com>
References: <1503338109-32540-1-git-send-email-suzuki.poulose@arm.com>
 <1503338109-32540-7-git-send-email-suzuki.poulose@arm.com>
 <20170822121722.0000712c@huawei.com>
Message-ID: <f59706eb-8702-7557-10a7-27535aa5f91c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/17 12:17, Jonathan Cameron wrote:
> On Mon, 21 Aug 2017 18:55:09 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
>> The DSU integrates one or more cores with an L3 memory system, control
>> logic, and external interfaces to form a multicore cluster. The PMU
>> allows counting the various events related to L3, SCU etc, along with
>> providing a cycle counter.
>>
>> The PMU can be accessed via system registers, which are common
>> to the cores in the same cluster. The PMU registers follow the
>> semantics of the ARMv8 PMU, mostly, with the exception that
>> the counters record the cluster wide events.
>>
>> This driver is mostly based on the ARMv8 and CCI PMU drivers.
>> The driver only supports ARM64 at the moment. It can be extended
>> to support ARM32 by providing register accessors like we do in
>> arch/arm64/include/arm_dsu_pmu.h.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Hi Suzuki,
>
> Was just reading this again out of curiosity and picked up on a couple of
> really trivial things.  Nothing that should slow down a merge, but if you happen
> to be doing a v6...
>
> Driver looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan,

Thanks for taking a look. I will fix those issues.

Suzuki
