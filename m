From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 11 Nov 2013 21:22:24 +0100
Subject: [PATCH] ARM: mvebu: Add RN104 SATA LEDs driven via NXP PCA9554
 I2C to GPIO muxer
In-Reply-To: <8738n2hfci.fsf@natisbad.org>
References: <877gchmggw.fsf@natisbad.org> <527ECC4C.8080207@gmail.com>
 <8738n2hfci.fsf@natisbad.org>
Message-ID: <52813C80.70800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 09:07 PM, Arnaud Ebalard wrote:
> Hi Sebastian,
>
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:
>
>>> @@ -154,6 +161,30 @@
>>>    			gpios = <&gpio2 0 1>;    /* GPIO 64 Active Low */
>>>    			linux,default-trigger = "keep";
>>>    		};
>>> +
>>> +		sata1_led {
>>> +			label = "rn104:blue:sata1";
>>> +			gpios = <&pca9554 0 1>;  /* Active Low */
>>
>> Same comment as for ReadyNAS 2120 patch:
>>
>> #include <dt-bindings/gpio/gpio.h> and use GPIO_ACTIVE_HIGH/LOW.
>
> Unlike RN2120 .dts for which I was able to change all the high/low
> values for macros in a single move, if I do the changes here for this
> specific patch, the .dts file for the RN104 will contain both values and
> macros.
>
> What about the following options?:
>
>   - send a preliminary patch to change all the values for macros in RN104
>     .dts file once -rc1 is here and then resubmit the PCA9554 patch with
>     macros?
>   - have the patch applied as is and then convert the whole RN104 .dts w/
>     another patch.

I'd say, respin this with gpio.h and go for a round of cleanup later.

> Anyway, once RN2120 is accepted, I intend to spend some time doing some
> housekeeping on other readynas .dts file based on the comments you made
> recently (macros, reg, addressing, phy info, etc), and also some minor
> points (whitespaces).

Great!

Sebastian
