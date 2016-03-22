From: ashok.sekar@broadcom.com (Ashok Sekar)
Date: Tue, 22 Mar 2016 21:01:55 +0530
Subject: [PATCH 1/5] arm64/perf: Changed events naming convention for
 uniformity
In-Reply-To: <20160322094732.GB31126@arm.com>
References: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
 <1458133309-17045-2-git-send-email-ashoks@broadcom.com>
 <20160322094732.GB31126@arm.com>
Message-ID: <CANK38rZypVwh7F=CD6KMs8GqNMy_geejYHVphjW26Jpd=YRe5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Mar 22, 2016 at 3:17 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ashok,
>
> On Wed, Mar 16, 2016 at 06:01:45AM -0700, Ashok Kumar wrote:
>> Changed events name to the format _L1/2/3I/D_CACHE/TLB_.
>> For e.g. moved ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL to
>> ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL in line with the already
>> existing definitions like ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB.
>>
>> Added _ACCESS keyword to some of the definitions
>> (ARMV8_PMUV3_PERFCTR_L1D_TLB, ARMV8_PMUV3_PERFCTR_L1I_TLB, etc)
>> in line with the already existing definitions like
>> ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS for clarity.
>>
>> Corrected typo L21 to L2I in ARMV8_PMUV3_PERFCTR_L21_TLB_REFILL,
>> ARMV8_PMUV3_PERFCTR_L21_TLB
>
> I don't mind renaming these events, but could we have them matching the
> names in the ARM ARM, please? For example:
>
>> -#define ARMV8_PMUV3_PERFCTR_L1D_TLB                          0x25
>> -#define ARMV8_PMUV3_PERFCTR_L1I_TLB                          0x26
>> -#define ARMV8_PMUV3_PERFCTR_L2I_CACHE                                0x27
>> +#define ARMV8_PMUV3_PERFCTR_L1D_TLB_ACCESS                   0x25
>> +#define ARMV8_PMUV3_PERFCTR_L1I_TLB_ACCESS                   0x26
>> +#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_ACCESS                 0x27
>
> These really are called "L1D_TLB, L1I_TLB and L2I_CACHE" without the
> "_ACCESS" suffix.
Sure, I will post a v2 as per ARM ARM. I just added it for verbosity.

Thanks,
Ashok
>
> Will
