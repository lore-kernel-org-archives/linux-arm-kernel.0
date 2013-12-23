From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 23 Dec 2013 22:34:13 +0100
Subject: [PATCH 5/7] ARM: dts: Complete data for isp iommu
In-Reply-To: <52B88B1A.40506@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-6-git-send-email-florian.vaussard@epfl.ch>
 <52B88B1A.40506@ti.com>
Message-ID: <52B8AC55.70205@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On 12/23/2013 08:12 PM, Anna, Suman wrote:
> Hi Florian,
> 
> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>> Add missing information required to probe the iommu for the camera
>> subsystem.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   arch/arm/boot/dts/omap3.dtsi | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>> index daabf99..610d084 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -371,11 +371,13 @@
>>               dma-names = "tx", "rx";
>>           };
>>
>> -        mmu_isp: mmu at 480bd400 {
>> +        mmu_isp: mmu_isp at 480bd400 {
> 
> Any reason for switching the name to mmu_isp?
> 

The name of the hwmod is "mmu_isp". This was not working otherwise,
but I cannot tell you for sure why without getting back at my office.

>>               compatible = "ti,omap3-mmu-isp";
>>               ti,hwmods = "mmu_isp";
>>               reg = <0x480bd400 0x80>;
>>               interrupts = <8>;
> 
> As I was testing the series, I found that this interrupt number is
> wrong. The interrupt number should be 24, you can fix it in this patch.
> I will post couple of patches to correct the interrupt numbers for
> couple of other occurrences.
> 

Really? Oh yes, this is CAM_IRQ0, thus M_IRQ_24. Nice catch.

Regards,

Florian
