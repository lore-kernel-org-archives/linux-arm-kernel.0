From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 17:28:15 +0530
Subject: [PATCH 1/2] ARM: dts: dra7-evm: increase QSPI SPL partition size
In-Reply-To: <20170117232743.GA7403@atomide.com>
References: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
 <1484311234-21978-2-git-send-email-ravibabu@ti.com>
 <20170113181239.GC2630@atomide.com>
 <6C6B28D4DC342643927BEAFCE8707BF6C0A8C367@DBDE04.ent.ti.com>
 <20170117232743.GA7403@atomide.com>
Message-ID: <b586537d-49b6-50a6-ae60-11faf25b26f9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 18 January 2017 04:57 AM, Tony Lindgren wrote:
> * B, Ravi <ravibabu@ti.com> [170117 00:15]:
>> Hi Tony
>>
>>> * Ravi Babu <ravibabu@ti.com> [170113 04:41]:
>>>> The SPL size for DRA74x platform has increased and is now more than 
>>>> 64KB. Increase QSPI SPL partition size to 256KB for DRA74x EVM.
>>>>
>>>> QSPI partition numbering changes because of this.
>>
>>> And this will break the existing partitions potentially..
>>> See what was discussed on the list few days ago in thread "[PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition table".
>>
>>> It's best to have these left empty or as they originally were and let u-boot configure the partitions.
>>
>> Agree with you. For dra7xx platform the SPL size has been increased to 256KB and hence the existing QSPI SPL partition in kernel (64K size) will break when latest mainline u-boot is used. 
>> Here only SPL partition has been changed and other partition & size is NOT changed and kept intact. I feel it will not break the existing partitions for dra7xx platform.
> 
> What about the renumbering of partitions in your patch?

Thats true, partitions will get renumbered. But mtd numbering can change
depending on probe order of devices anyway. So usespace which uses
hardcoded mtd partition numbers is pretty fragile already, I guess.

> 
> Probably just best to make the partition information empty in the
> kernel as discussed.

Given that existing dtbs already have the partition information, wont
this be treated as a regression for someone upgrading to new kernel?

Going forward, is the preference that new boards shall not have
partition information in DT?

Thanks,
Sekhar
