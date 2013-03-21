From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 21 Mar 2013 09:39:20 +0100
Subject: [PATCH] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <514A63EE.7000707@tabi.org>
References: <20130319170322.27828.7691.stgit@localhost>
 <514A63EE.7000707@tabi.org>
Message-ID: <514AC738.6050900@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/13 02:35, Timur Tabi wrote:
> Martin Fuzzey wrote:
>> +If a clock is provided, clock-frequency is optional
>> +
>> +If no clock is provided clock-frequency is required (this represents 
>> the codec
>> +being clocked by an external signal not present in the clock tree)
>> +
>> +If both a clock and clock-frequency are provided the clock's rate 
>> will be set.
>> +
>> +
>>   Example:
>>
>>   codec: sgtl5000 at 0a {
>>       compatible = "fsl,sgtl5000";
>>       reg = <0x0a>;
>> +    clock-frequency = <20000000>;
>> +    clocks = <&clks 162>; /* cko1 */
>
> The code looks okay, but I'm not sure this example is right.  The 
> binding says that clock-frequency is optional if 'clocks' is provided, 
> but here you list both.  You should probably have two examples.
>
Hello and thank you for your review.

No the example is correct.

With this patch and that DT example the frequency of clock 162 will be 
_set_ to 20MHz

If clock-frequency is omitted the binding is still correct (hence the 
optional) but the frequency of clock 162 would not be modified.

In the documentation I wrote "If both a clock and clock-frequency are 
provided the clock's rate will be set. " maybe this is not clear enough?

Regards,

Martin
