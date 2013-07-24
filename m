From: csd@broadcom.com (Christian Daudt)
Date: Tue, 23 Jul 2013 17:10:52 -0700
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X
 SoC with ARM CPU
In-Reply-To: <20130723192203.GC6811@ohporter.com>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130723184907.GA6811@ohporter.com>
 <CAGVrzcbA72AYu6J3JXBirQQeTiDH9cJThdBdH=Q=gJtOnqz-AA@mail.gmail.com>
 <20130723192203.GC6811@ohporter.com>
Message-ID: <51EF1B8C.9020304@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-23 12:22 PM, Matt Porter wrote:
>>>> the bcm281x/kona family support code be merged and use "bcm" there, without
>>>> registering it. Besides, a simple rule of number here wins:
>>>>
>>>> git grep "brcm," * | wc -l
>>>> 63
>>>> git grep "bcm," * | wc -l
>>>> 25
>>>>
>>>> (as of Linux 3.11-rc1)
>>>>
>>>> So consistency we should get the bcm281x/kona DT bindings to rename their
>>>> vendor prefix as well.
>>> I believe getting this "right" is far more important than the difference
>>> in churn of a mere 38 instances of use of brcm. "Right" is two things:
>>> 1) it needs to be consistent 2) it should be what makes sense.
>> I agree, which is the reason why I would stick with the vendor prefix
>> and end the story there.
> It doesn't end there. An update to all the in process stuff has to
> happen, plus the upstream stuff. So in both cases there are changes to
> be made both upstream and with work-in-progress. The only difference is
> that I was suggesting an update to correct the prefix in
> vendor-prefixes.txt.
>
> However, if I'm the only one that cares enough to speak up for "bcm"
> I'll abandon that and submit the patch to adjust bcm281xx to be
> compliant with the current state of vendor-prefixes.txt. :)
>
bcm has been used internally but not consistently - about as 
consistently as brcm has been used in upstream :) Given that I've 
submitted most/all of the non-compliant code, I'll send a patch 
rectifying it and request internal team to switch to using brcm, for 
devicetree bindings, as atonement. If Matt doesn't beat me to it...

  Thanks,
    csd
