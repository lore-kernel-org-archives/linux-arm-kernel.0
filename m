From: kapilh@broadcom.com (Kapil Hali)
Date: Sat, 5 Dec 2015 17:26:08 +0530
Subject: [PATCH v5 2/5] ARM: BCM: Clean up SMP support for Broadcom Kona
In-Reply-To: <56621CA3.3090903@gmail.com>
References: <1449260611-24417-1-git-send-email-kapilh@broadcom.com>
 <1449260611-24417-3-git-send-email-kapilh@broadcom.com>
 <56621CA3.3090903@gmail.com>
Message-ID: <5662D0D8.1020004@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 12/5/2015 4:37 AM, Florian Fainelli wrote:
> On 04/12/15 12:23, Kapil Hali wrote:
>> These changes cleans up SMP implementaion for Broadcom's
>> Kona SoC which are required for handling SMP for iProc
>> family of SoCs at a single place for BCM NSP and BCM Kona.
>>
>> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
>> ---
>>  arch/arm/boot/dts/bcm11351.dtsi |  2 +-
>>  arch/arm/boot/dts/bcm21664.dtsi |  2 +-
>>  arch/arm/mach-bcm/kona_smp.c    | 82 +++++++++++++++++++++++++++--------------
>>  3 files changed, 56 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>> index 2ddaa51..3dc7a8c 100644
>> --- a/arch/arm/boot/dts/bcm11351.dtsi
>> +++ b/arch/arm/boot/dts/bcm11351.dtsi
>> @@ -31,7 +31,6 @@
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>>  		enable-method = "brcm,bcm11351-cpu-method";
>> -		secondary-boot-reg = <0x3500417c>;
> 
> I would expect the 'enable-method' to be moved as well to be consistent
> with what you are adding for NSP later on.
> 
Right, it is updated in the new patch set.
>>  
>>  		cpu0: cpu at 0 {
>>  			device_type = "cpu";
>> @@ -42,6 +41,7 @@
>>  		cpu1: cpu at 1 {
>>  			device_type = "cpu";
>>  			compatible = "arm,cortex-a9";
>> +			secondary-boot-reg = <0x3500417c>;
>>  			reg = <1>;
>>  		};
Thanks,
Kapil
