From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 15:10:57 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTikdxSQD+9UY70PtCPMgnrovx-dWjrrPJ0AZyG4X@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
	<201010091311.26335.arnd@arndb.de>
	<AANLkTikdxSQD+9UY70PtCPMgnrovx-dWjrrPJ0AZyG4X@mail.gmail.com>
Message-ID: <AANLkTi=37SCuwwze4KS_yOdmi8bvJP_OexHaYLw-AXfJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 9, 2010 at 2:43 PM, Dave Airlie <airlied@gmail.com> wrote:
>> The few drivers that may be hit by this are typically in drivers/staging
>> exactly because issues like this have not been fixed yet.
>>
>> We should probably just fix the non-staging drivers that are hit by
>> this now and declare the issue done.
>>
>> When you say that "many drivers broken", can you list the ones you know
>> about? It would probably help resolve this the right way.
>
> I'm guessing some closed source graphics drivers for ARM do all kinds
> of wrong crap, and Nokia use them a lot, and nobody wants to tell the
> closed vendors to change their drivers because it costs money.

You are over simplifying things.

 1) The code is open[1]
 2) the decision comes from TI, Nokia can only do so much before shipping
 3) I know many people in Nokia have pushed very hard, and cleaned up
the driver a lot themselves
 4) There are other companies, Intel is using SGX too

Anyway, there are other examples, like tidspbridge, which Nokia has
spent a lot of time cleaning up, and TI made a great effort to push
into staging. And others already in mainline, like
sh_mobile_ceu_camera.

[1] http://meego.gitorious.org/meego-os-base/kernel-source/trees/master/patches

-- 
Felipe Contreras
