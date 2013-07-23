From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 23 Jul 2013 19:56:26 +0100
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC with
 ARM CPU
In-Reply-To: <20130723184907.GA6811@ohporter.com>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130723184907.GA6811@ohporter.com>
Message-ID: <CAGVrzcbA72AYu6J3JXBirQQeTiDH9cJThdBdH=Q=gJtOnqz-AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/23 Matt Porter <matt.porter@linaro.org>:
> On Wed, Jul 17, 2013 at 12:08:30AM +0100, Florian Fainelli wrote:
>> Hello,
>>
>> Le mardi 16 juillet 2013 11:14:36 Matt Porter a ?crit :
>> > > + compatible = "brcm,bcm5301x";
>> >
>> > Ok, this was nagging at me before I went on my very long vacation. I see
>> > the "brcm" vendor prefix as a real consistency problem. I noticed on the
>> > bcm281xx/kona family, we have been using "bcm" which is not logged in
>> > vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
>> > already established use of "brcm" before any of the bcm281xx support
>> > came in. Ideally, the vendor prefix should change to "bcm" since every
>> > reference in the family names is BCM. However, if others want the least
>> > amount of churn in making this consistent, we might have to go with
>> > "brcm" across the board.
>>
>> I would like to keep "brcm" here because that is what has been defined as a
>> vendor prefix, and is used beyond the scope of the ARM Linux kernel support
>> even within Broadcom. Maybe it was an oversight, or rather a mistake to let
>
> [Update: I thought some more about this and investigated why Broadcom started
>  using "bcm" and changed my mind]
>
> Can you provide a cite?

Well, I can tell you that this is what my group is using for its
vendor prefix in DT because this is the one that was allocated in
vendor-prefixes.txt. This is also what the upstream BCM63xx DSL SoC is
using even though that port is still WIP, so could be subject to
changing.

> I can tell you that within Broadcom they have
> been moving to get rid of it. That is why you see all this Broadcom
> originated code using "bcm" because it actually matches their part
> number prefix. As further evidence of the preference for "bcm", feel free to
> look through the entire public catalog of parts at
> http://www.broadcom.com/products/ and note that they all have BCM as the part
> prefix...this carries over into all driver references to the parts as well
> including everything in the wireless world.

If you want to add more confusion, because there is,
drivers/staging/bcm which stands for Beceem has been later acquired by
Broadcom, eventually turning this 3 letter word into something
"consistent" from a Broadcom point of view. As far as I am concerned,
I would just stick with the allocated vendor prefix and replace "bcm"
with "brcm" because the allocated one is the authoritative one.

>
>> the bcm281x/kona family support code be merged and use "bcm" there, without
>> registering it. Besides, a simple rule of number here wins:
>>
>> git grep "brcm," * | wc -l
>> 63
>> git grep "bcm," * | wc -l
>> 25
>>
>> (as of Linux 3.11-rc1)
>>
>> So consistency we should get the bcm281x/kona DT bindings to rename their
>> vendor prefix as well.
>
> I believe getting this "right" is far more important than the difference
> in churn of a mere 38 instances of use of brcm. "Right" is two things:
> 1) it needs to be consistent 2) it should be what makes sense.

I agree, which is the reason why I would stick with the vendor prefix
and end the story there.
--
Florian
