From: nm@ti.com (Nishanth Menon)
Date: Wed, 18 Sep 2013 08:02:32 -0500
Subject: [PATCH V2] ARM: dts: DRA7: provide arch-timer frequenecy parameter
In-Reply-To: <52398F87.6090108@ti.com>
References: <5238899D.60903@ti.com>
 <1379437288-10831-1-git-send-email-nm@ti.com> <52398F87.6090108@ti.com>
Message-ID: <5239A468.2070105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 06:33 AM, Sricharan R wrote:
> Hi,
> 
> On Tuesday 17 September 2013 10:31 PM, Nishanth Menon wrote:
>> CNTFREQ isn't pre-programmed on DRA7 just like O5, so provide the
>> timer frequency via DT. Without a valid value arch_timer_init results
>> in div0 crash.
>>
>> Cc: R Sricharan <r.sricharan@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Sourav Poddar <sourav.poddar@ti.com>
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Based on Benoit's for_3.13/dts branch. 
>> http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
>>
>> Crash log: http://pastebin.com/B2sDauS9
>>
>> V2: commit message update
>> V1: https://patchwork.kernel.org/patch/2903261/
>>
>>  arch/arm/boot/dts/dra7.dtsi |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index c98997b..71c2749 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -50,6 +50,7 @@
>>  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <6144000>;
>>  	};
>>  
>>  	gic: interrupt-controller at 48211000 {
> This is not the right way to pass the frequency. In fact, initially the frequency value was present
> when the dts was added, but had to revert it back based on the feedbacks. Please refer below.
>   
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg93832.html
> 
> 
> Also posted the below patch to fix this,
> 
>     http://marc.info/?l=linux-omap&m=137950345528918&w=2

Thanks for a better alternative. at least my boot tests indicate that
the patch works fine.


-- 
Regards,
Nishanth Menon
