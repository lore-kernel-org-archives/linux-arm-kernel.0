From: Claudiu.Beznea@microchip.com (Claudiu Beznea)
Date: Mon, 22 Jan 2018 10:54:07 +0200
Subject: [PATCH v2 10/16] pwm: Add PWM modes
In-Reply-To: <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
 <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
Message-ID: <c5aeb8df-6aa8-cde4-9305-08777cac2f45@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20.01.2018 00:34, Rob Herring wrote:
> On Fri, Jan 12, 2018 at 04:22:57PM +0200, Claudiu Beznea wrote:
>> Define a macros for PWM modes to be used by device tree sources.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  include/dt-bindings/pwm/pwm.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
>> index ab9a077e3c7d..b8617431f8ec 100644
>> --- a/include/dt-bindings/pwm/pwm.h
>> +++ b/include/dt-bindings/pwm/pwm.h
>> @@ -12,4 +12,7 @@
>>  
>>  #define PWM_POLARITY_INVERTED			(1 << 0)
>>  
>> +#define PWM_DTMODE_NORMAL			(1 << 0)
> 
> Bit 0 is already taken. I think you mean (0 << 1)?
I wanted to have the PWM modes in a new cell, so that the pwms binding to be
something like:
pwms=<pwm-controller pwm-channel pwm-period pwm-flags pwm-mode>

If you think it is mode feasible to also include PWM mode in the cell for 
PWM flags, please let me know.

> 
> Personally, I'd just drop this define. A define for a 0 value makes more 
> sense when each state is equally used (like active high or low), but if 
> 0 is the more common case, then I don't the need for a define.
I want it to have these defines like bit defines:
PWM_DTMODE_NORMAL=0x1
PWM_DTMODE_COMPLEMENTARY=0x2
PWM_DTMODE_PUSH_PULL=0x4

Thank you,
Claudiu Beznea

> 
>> +#define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
>> +
>>  #endif
>> -- 
>> 2.7.4
>>
> 
