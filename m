From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 9 Feb 2016 11:59:10 -0800
Subject: [PATCH] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <20160209195222.0882d7f7@arm.com>
References: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
 <20160209195222.0882d7f7@arm.com>
Message-ID: <56BA450E.50109@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2016 11:52 AM, Marc Zyngier wrote:
> On Tue,  9 Feb 2016 11:29:16 -0800
> David Daney <ddaney.cavm@gmail.com> wrote:
>
> Hi David,
>
>> From: Andrew Pinski <apinski@cavium.com>
>>
>> On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
>> instructions may cause the icache to become invalid if it contains
>> data for a non-current ASID.
>>
>> This patch implements the workaround (which flushes the local icache
>> when switching the mm) by using code patching.
>>
>> Signed-off-by: Andrew Pinski <apinski@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/arm64/Kconfig                  | 11 +++++++++++
>>   arch/arm64/include/asm/cpufeature.h |  3 ++-
>>   arch/arm64/kernel/cpu_errata.c      |  9 +++++++++
>>   arch/arm64/mm/proc.S                | 12 ++++++++++++
>>   4 files changed, 34 insertions(+), 1 deletion(-)
>
> It would be good to update Documentation/arm64/silicon-errata.txt to
> reflect the fact that there is a workaround available for this erratum.

Would you prefer a separate patch for that, or should I roll it into 
this one and resubmit?

David Daney


>
> Thanks,
>
> 	M.
>
