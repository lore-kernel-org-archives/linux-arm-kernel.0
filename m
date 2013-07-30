From: csd@broadcom.com (Christian Daudt)
Date: Tue, 30 Jul 2013 16:08:27 -0700
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X
 SoC with ARM CPU
In-Reply-To: <51F6A12C.30101@wwwdotorg.org>
References: <2043662.BcW19XTTMG@lenovo> <20130719020611.GA4941@glitch>
 <20130723185733.GB6811@ohporter.com>
 <CAGVrzcYnoN9NnJGvubS7=bVJDk37xSt4BimtvDWghe7OHEWALQ@mail.gmail.com>
 <20130724231106.GB29801@glitch>
 <CAGVrzcYudfgqs_eafje4BT2z2qE0kSJPx1B-xrq0WxtUkGxSFw@mail.gmail.com>
 <20130726000412.GH5022@linaro.org> <51F2F554.8030709@broadcom.com>
 <51F2F885.2040002@wwwdotorg.org>
 <20130729093000.GI3528@e106331-lin.cambridge.arm.com>
 <20130729132029.GI5022@ohporter.com> <51F6A12C.30101@wwwdotorg.org>
Message-ID: <51F8476B.3080508@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-29 10:06 AM, Stephen Warren wrote:
> On 07/29/2013 07:20 AM, Matt Porter wrote:
>> On Mon, Jul 29, 2013 at 10:30:00AM +0100, Mark Rutland wrote:
> ...
>>> I'd be happy to have "broadcom" for all *new* bindings, as it's already
>>> in some bindings alongside "bcm" and "brcm", and is certainly the
>>> clearest of the available options.
>>>
>>> However, given the strong feelings of many against breaking existing
>>> dts, we need to support the existing instances of "bcm" and "brcm" in
>> Whoa, how would existing dts break? At this instant in time, all the
>> bindings and dts are still in the kernel tree. A series to address this
>> make all bindings, drivers, and dts consistent in one shot.
> While there are some *.dts files in the kernel source tree, that is no
> guarantee that:
>
> a) People don't have custom *.dts files that are not in the kernel
> source tree, and hence can't be updated by Linux kernel patches.
>
> b) People actually replace their *.dtb when updating their zImage. Since
> DT is explicitly supposed to be an ABI, everything is explicitly
> supposed to work if they do only update their zImage and not their *.dtb.
>
In the interest of maintaining compatibility, we've discussed this 
internally @ Broadcom and we'll be standardizing on brcm vendor prefix 
going forward (at least the 2 teams represented in this thread...). 
Given that I am responsible for all of the current offending uses of 
"bcm," in dt bindings, and I can assure that switching them at this 
point causes no damage to the platforms (as the kernel tree being 
upstreamed is not yet being used internally), I'll follow up with a 
patch to switch these "bcm," uses into "brcm,".
  Going forward, our new drivers will switch to brcm, prior to being 
submitted upstream. With that, we can safely remove all vestiges of 
"bcm," dt prefix.

  Thanks,
    csd
