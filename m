From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Mon, 01 Jun 2015 11:21:19 +0200
Subject: [PATCH v2] arm/arm64: KVM: Properly account for guest CPU time
In-Reply-To: <20150601090817.GA18722@cbox>
References: <1432838950-28774-1-git-send-email-christoffer.dall@linaro.org>
 <556C0E22.9090401@de.ibm.com> <20150601090817.GA18722@cbox>
Message-ID: <556C240F.5070501@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.06.2015 um 11:08 schrieb Christoffer Dall:

>>>
>>> Second, looking at the ppc and mips code, they seem to also call
>>> kvm_guest_exit() before enabling interrupts, so I don't understand how
>>> guest CPU time accounting works on those architectures.
>>
>> Not an expert here, but I assume mips has the same logic as arm so if your
>> patch is right for arm its probably also for mips.
>>
>> powerpc looks similar to what s390 does (not using the tick, instead it uses
>> a hw-timer) so this should be fine.
>>
> I wonder if we can simply enable HAVE_VIRT_CPU_ACCOUNTING_GEN and get
> this for free which would avoid the need for this patch?

Asssuming that HAVE_VIRT_CPU_ACCOUNTING_GEN behaves similar to 
HAVE_VIRT_CPU_ACCOUNTING on s390/power in respect to not rely on ticks
- yes it might work out. Can you give it a try?

Christian
