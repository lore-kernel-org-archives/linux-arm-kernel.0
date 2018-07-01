From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 1 Jul 2018 20:09:33 +0200
Subject: [PATCH] ARM: dts: armada-38x: use the new thermal binding
In-Reply-To: <20180701153213.6mo3zf3pre4icd4m@tarshish>
References: <bc62b7ec60e502afb7de69c1b060cd49fc6545f7.1530458089.git.baruch@tkos.co.il>
 <20180701153213.6mo3zf3pre4icd4m@tarshish>
Message-ID: <94c2d9ab-6695-b551-c77e-a144a5462bb1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 01.07.2018 um 17:32 schrieb Baruch Siach:
> Hi Marvell maintainers,
> 
> I forgot to Cc the list.
> 
> On Sun, Jul 01, 2018 at 06:14:49PM +0300, Baruch Siach wrote:
>> Commit 2f28e4c24b10e (thermal: armada: Clarify control registers
>> accesses) introduced the new thermal binding. The new biding extends the

"binding" (2nd occurrence)

>> seconds registers field size to 8. Switch to the new binding to fix

"second", "registers'"?

Regards,
Andreas

>> thermal reading values. Without this change the fix to errata #132698
>> introduced in commit 8c0b888f661 (thermal: armada: Change sensors trim
>> default value) is not effective.
>>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
>> index 18edc9bc7927..929459c42760 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>> @@ -547,7 +547,7 @@
>>  
>>  			thermal: thermal at e8078 {
>>  				compatible = "marvell,armada380-thermal";
>> -				reg = <0xe4078 0x4>, <0xe4074 0x4>;
>> +				reg = <0xe4078 0x4>, <0xe4070 0x8>;
>>  				status = "okay";
>>  			};
> 
> baruch
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
