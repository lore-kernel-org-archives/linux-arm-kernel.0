From: syin@broadcom.com (Sherman Yin)
Date: Fri, 13 Dec 2013 17:16:00 -0800
Subject: [PATCH v3 4/6] pinctrl: Add pinctrl binding for Broadcom Capri
 SoCs
In-Reply-To: <CACRpkdY7s+eUFkg0AsaN5B9-1y_mTJ29Y-D9CkRG2GQ3JshP+w@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>	<1386787041-6035-1-git-send-email-syin@broadcom.com>	<1386787041-6035-5-git-send-email-syin@broadcom.com>
 <CACRpkdY7s+eUFkg0AsaN5B9-1y_mTJ29Y-D9CkRG2GQ3JshP+w@mail.gmail.com>
Message-ID: <52ABB150.1030702@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-12 12:37 PM, Linus Walleij wrote:
> On Wed, Dec 11, 2013 at 7:37 PM, Sherman Yin <syin@broadcom.com> wrote:
>
>> Adds pinctrl driver devicetree binding for Broadcom Capri (BCM281xx) SoCs.
>>
>> Signed-off-by: Sherman Yin <syin@broadcom.com>
>> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>> ---
>> v3: Use generic pin config properties instead of brcm-specific ones.  Clarified
>>      pin types (standard, i2c, hdmi).
>> v2: Use hyphens instead of underscore in DT property names.
>
> Overall this is very nice!

Thanks!

>> +- bias-pull-up:                        Integer. Pull up strength in Ohm:
>> +                                       1: 1.2 kOhm
>> +                                       2: 1.8 kOhm
>> +                                       3: 720 Ohm
>> +                                       4: 2.7 kOhm
>> +                                       5: 831 Ohm
>> +                                       6: 1.08 kOhm
>> +                                       7: 568 Ohm
>
> Please do not use these custom enumerators 1 thru 7.
> Instead say that the argument is given in ohms, so for
> example:
>
> bias-pull-up = <12000>;
>
> Then translate this into the proper enumerator in your
> driver instead.

Ok.  The 3 bits in this enumeration correspond to enabling the 3 pull up 
Rs (1.2k, 1.8k, 2.7k) in parallel, so the enum kind of make sense. But 
sure I can change it to actual ohms and will error out in the driver if 
specified value is not one of the 7.

> No full example provided in the binding! This needs to
> be there for understanding.

Ok Will add some examples.

Thanks,
Sherman
