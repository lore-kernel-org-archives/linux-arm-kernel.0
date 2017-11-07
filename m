From: ludovic.barre@st.com (Ludovic BARRE)
Date: Tue, 7 Nov 2017 14:06:44 +0100
Subject: [PATCH v3 0/9] irqchip: stm32: add stm32h7 support
In-Reply-To: <04d9d728-7f9f-6bc0-bb57-c7bb49817872@arm.com>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
 <04d9d728-7f9f-6bc0-bb57-c7bb49817872@arm.com>
Message-ID: <2f41fc16-6ed2-2d44-52e9-5461c86baf75@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Marc

normally, Alex take the last 3 ("ARM: dts")
commits in his branch, and will send in his pull request
Alex you confirm?

BR
Ludo

On 11/07/2017 12:23 PM, Marc Zyngier wrote:
> Hi Ludovic,
> 
> On 06/11/17 17:03, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This series adds:
>> -Management of multi-bank of external interrupts
>> stm32h7 has up to 96 inputs (3 banks of  32 inputs).
>> -Fix initial value after cold/hot boot (wakeup issue).
>>
>> Changes v3:
>> -remove chip.name and handler, already done by
>> irq_alloc_domain_generic_chips
>> -add Rob ack in dt-bindings commit
>>
>> Changes v2:
>> -Remove irq_mask and adds const on struct stm32_exti_bank
>> -Add wrapper functions pending and ack
>> -Replace BITS_PER_LONG by IRQS_PER_BANK
>> -Fill commit message on
>> "ARM: dts: stm32: add support of exti on stm32h743"
>> -Add system config bank for stm32h7
>>
>> Ludovic Barre (9):
>>    irqchip: stm32: select GENERIC_IRQ_CHIP
>>    irqchip: stm32: add multi-bank management
>>    dt-bindings: interrupt-controllers: add compatible string for stm32h7
>>    irqchip: stm32: add stm32h7 support
>>    irqchip: stm32: fix initial values
>>    irqchip: stm32: move the wakeup on interrupt mask
>>    ARM: dts: stm32: add exti support for stm32h743
>>    ARM: dts: stm32: add system config bank node for stm32h743
>>    ARM: dts: stm32: add support of exti on stm32h743 pinctrl
>>
>>   .../interrupt-controller/st,stm32-exti.txt         |   4 +-
>>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  24 +++
>>   arch/arm/boot/dts/stm32h743.dtsi                   |  13 ++
>>   drivers/irqchip/Kconfig                            |   1 +
>>   drivers/irqchip/irq-stm32-exti.c                   | 206 ++++++++++++++++-----
>>   5 files changed, 198 insertions(+), 50 deletions(-)
>>
> 
> I'm happy to take the first 6 patches through the irqchip tree. How
> about the last 3? I'd rather see them routed via armsoc if there is any
> risk of merge conflicts.
> 
> How do you want to proceed?
> 
> Thanks,
> 
> 	M.
> 
