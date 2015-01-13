From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 13 Jan 2015 16:42:38 +0800
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
In-Reply-To: <9190510.INCMcmsads@wuerfel>
References: <54B48D5E.6050902@hisilicon.com> <9190510.INCMcmsads@wuerfel>
Message-ID: <54B4DA7E.2020602@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/1/13 16:33, Arnd Bergmann wrote:
> On Tuesday 13 January 2015 11:13:34 Wei Xu wrote:
>> There is 8MB SRAM in hip04.
>> Moving the bootwrapper into SRAM could avoid to worry about poking
>> holes into DRAM memory or allocation algorithms either.
>>
>> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
>> ---
>>  arch/arm/boot/dts/hip04.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
>> index 2388145..f0dfac7 100644
>> --- a/arch/arm/boot/dts/hip04.dtsi
>> +++ b/arch/arm/boot/dts/hip04.dtsi
>> @@ -22,7 +22,7 @@
>>  
>>         bootwrapper {
>>         compatible = "hisilicon,hip04-bootwrapper";
>> -       boot-method = <0x10c00000 0x10000>, <0xe0000100 0x1000>;
>> +       boot-method = <0xe00f0000 0x10000>, <0xe0000100 0x1000>;
>>         };

Hi Arnd,
 
> Is this backwards compatible with old firmware?

Sorry, it is not backwards compatible.
Another reason is that it could support opensuse 
more smoothly.

I have updated the firmware and uploaded it 
into Linaro Hisilicon git tree last month.
We will update the wiki on Linaro soon.

Do you think it is OK?
Thanks!

Best Regards,
Wei

> 
> 	Arnd
> 
> .
> 
