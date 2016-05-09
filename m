From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 9 May 2016 15:04:17 +0100
Subject: [PATCH] [for 4.7] arm-ccn: Enable building as module
In-Reply-To: <5729C2CC.7030806@arm.com>
References: <1461855901-23794-1-git-send-email-suzuki.poulose@arm.com>
 <5729C2CC.7030806@arm.com>
Message-ID: <573098E1.5050007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/16 10:37, Suzuki K Poulose wrote:
> On 28/04/16 16:05, Suzuki K Poulose wrote:
>> arm-ccn driver uses irq_set_affinity, which is not exported and
>> hence cannot be built as a module, eventhough we have all the
>> bits ready. This patch makes use of the exported helper
>> irq_set_affinity_hint() instead. Also, the __free_irq expects
>> the affinity_hint to be NULL when we free the irq. So set the
>> affinity_hint to NULL at clean up.
>>
>> Now that we can build it as a module, update the Kconfig to
>> reflect the change.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Acked-by: Pawel Moll <pawel.moll@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Hi,
> 
> Could you please pull this for 4.7 ?

Gentle ping...

Suzuki
