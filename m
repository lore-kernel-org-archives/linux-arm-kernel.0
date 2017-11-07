From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 7 Nov 2017 17:45:09 -0500
Subject: [PATCH 2/2] ARM: dts: NSP: Fix PPI interrupt types
In-Reply-To: <2f4dfba2-923a-840a-7dc9-5761380b28c5@gmail.com>
References: <20171107222812.17267-1-f.fainelli@gmail.com>
 <20171107222812.17267-3-f.fainelli@gmail.com>
 <2f4dfba2-923a-840a-7dc9-5761380b28c5@gmail.com>
Message-ID: <CAC3K-4psoDRRsTKvjJLs1PwJJ+zTm3c8QoUEuaCxY6HiMWDivA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 5:30 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/07/2017 02:28 PM, Florian Fainelli wrote:
>> Booting a kernel results in the kernel warning us about the following
>> PPI interrupts configuration:
>> [    0.105127] smp: Bringing up secondary CPUs ...
>> [    0.110545] GIC: PPI11 is secure or misconfigured
>> [    0.110551] GIC: PPI13 is secure or misconfigured
>>
>> Fix this by using the appropriate edge configuration for PPI11 and
>> PPI13, this is similar to what was fixed for Northstar (BCM5301X) in
>> commit 0e34079cd1f6 ("ARM: dts: BCM5301X: Correct GIC_PPI interrupt
>> flags").
>>
>> Fixes: 1a9d53cabaf4 ("ARM: dts: NSP: Add TWD Support to DT")
>
> this should have been Fixes: 7b2e987de207 ("ARM: NSP: add minimal
> Northstar Plus device tree"), I can fix that up while applying unless
> there are other comments.
>
>> Fixes: 1a9d53cabaf4 ("ARM: dts: NSP: Add TWD Support to DT")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jon Mason <jon.mason@broadcom.com>

>> ---
>>  arch/arm/boot/dts/bcm-nsp.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
>> index dff66974feed..d5f5e92e7488 100644
>> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
>> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
>> @@ -85,7 +85,7 @@
>>               timer at 20200 {
>>                       compatible = "arm,cortex-a9-global-timer";
>>                       reg = <0x20200 0x100>;
>> -                     interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
>>                       clocks = <&periph_clk>;
>>               };
>>
>> @@ -93,7 +93,7 @@
>>                       compatible = "arm,cortex-a9-twd-timer";
>>                       reg = <0x20600 0x20>;
>>                       interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
>> -                                               IRQ_TYPE_LEVEL_HIGH)>;
>> +                                               IRQ_TYPE_EDGE_RISING)>;
>>                       clocks = <&periph_clk>;
>>               };
>>
>>
>
>
> --
> Florian
