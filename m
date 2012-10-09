From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 20:41:03 -0600
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <19574322.MHE4gIJg5N@flexo>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com> <19574322.MHE4gIJg5N@flexo>
Message-ID: <50738EBF.2060905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 05:50 AM, Florian Fainelli wrote:
> Hi Domenico,
> 
> On Sunday 07 October 2012 03:53:01 Domenico Andreoli wrote:
>> From: Domenico Andreoli <domenico.andreoli@linux.com>
>>
>> BCM476x's minimal infrastructure, Kernel's great reuse.
>>
>> Look mom, no include/mach directory!

>> Index: b/arch/arm/boot/dts/bcm476x.dtsi
>> ===================================================================
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm476x.dtsi
>> @@ -0,0 +1,31 @@
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	compatible = "brcm,bcm476x";
>> +	model = "Broadcom BCM476x";
>> +
>> +	chosen {
>> +		bootargs = "earlyprintk";
>> +	};
>> +
>> +	amba {
> 
> I would rather explicitely mention that the peripheral base address is at 0
> so something like this:
> 
> amba at 0 {
> 
> to make it clear that the peripherals declared as leaf nodes of this one are
> at a relative address.
> 
>> +		compatible = "arm,amba-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;

You should only put a unit address ("@0") in the node name if there's a
matching reg property and the unit address is needed to make the node
name unique. Neither condition applies in this case.
