From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 3 Jun 2014 15:28:09 +0200
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
In-Reply-To: <538DC873.8000809@redhat.com>
References: <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
 <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
 <5385AF94.90004@redhat.com>
 <CAPDyKFpd1mPi1pqTxx=uNG+MsprCngZN-WFnNQrB_1+WuA0faA@mail.gmail.com>
 <538DAC58.90001@redhat.com>
 <CAPDyKFr67c0NfL6+_0mejz2rSjwCLXhhGVqXpicerM1ZwRMNmg@mail.gmail.com>
 <538DC873.8000809@redhat.com>
Message-ID: <CAPDyKFqi0-Fa0rZAvCO0GukNTrMy9R1io8bLYr_KEceRRFb+-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]

>>
>> Why do we need to put the sdio functions devices in DT?
>
> To define sdio function specific non probable info, such as oob irqs,
> also see the "mmc: Add SDIO function devicetree subnode parsing" patch-set
> of which I send v3 this morning.

Yes, of course - makes sense.

[snip]

>>>> I see these important things that follow if we decide to use runtime
>>>> PM to trigger the power up/off sequence.
>>>> 1) In cases of !CONFIG_PM_RUNTIME, it means the "powerup driver" once
>>>> probed, will keep it's resources enabled forever.
>>>
>>> Ack.
>>
>> So, the consequence is that for CONFIG_PM_SLEEP systems not using
>> CONFIG_PM_RUNTIME - we don't have a good solution.
>>
>> Is that acceptable?
>
> IMHO yes, if people want maximum power savings they should use
> CONFIG_PM_RUNTIME. And since this is all for yet to be added
> systems / configs I would expect CONFIG_PM_RUNTIME to be supported
> there just fine.

That's a valid point, but on the other hand, "old" systems could
benefit from this "feature" as well, were runtime PM might not be that
interesting.

Kind regards
Uffe
