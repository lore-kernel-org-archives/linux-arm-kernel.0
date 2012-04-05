From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 5 Apr 2012 10:59:55 +0200
Subject: [PATCH 2/9] ARM: OMAP2+: SmartReflex: move the driver specific
 macros in include/linux/power
In-Reply-To: <4F7D4165.2060101@codeaurora.org>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-3-git-send-email-j-pihet@ti.com>
 <4F7C9C89.9080605@codeaurora.org> <4F7CA3E1.2050809@ti.com>
 <4F7D4165.2060101@codeaurora.org>
Message-ID: <CAORVsuVt5uj5NAsqsce+7f=xMXC9-nck5cPUCOEC8QP3VkxYyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Apr 5, 2012 at 8:53 AM, Trilok Soni <tsoni@codeaurora.org> wrote:
> Hi Benoit,
>
>
>>
>> The main motivation is that it's a driver and thus does not have
>> anything to do inside mach-omap2.
>
>
> Right, I understood that. mach-omap2 is not suitable for full fledged
> drivers.

The initial motivation is to provide a generic framework for this type
of drivers, by cleaning up the current OMAP code and by providing as
much generic code as possible.

Cf. the patch sets I submitted before this very one:
- the SR code clean-up [1], which is needed to make the code ready for
the integration of new features,
- the SR class support [2], which is needed for new SR classes to be
implemented.

>From the maintainer point of view it made more sense to move the code
before cleaning it up and so it should happen before [1] and [2].
The result is that [1] and [2] will need to be rebased when the move
is accepted and merged in.

[1] http://marc.info/?l=linux-omap&m=133055488908132&w=2
[2] http://marc.info/?l=linux-omap&m=133163445926544&w=2

>>
>> Where will you put that otherwise?
>
>
> Couple of suggestions:
>
> drivers/platform/omap/avs?
> drivers/misc/omap/avs?
>
> I prefer first one.
Those paths are for OMAP specific code and not for a generic framework.

>>
>> IIRC, David Brownell was referring to the rule of three for such case.
>> Meaning that it worth having a generic fmwk when at least three
>> different drivers are doing the same kind of things.

Do OMAP v1 and OMAP v2 implementations count as 2 drivers? ;-)
More seriously, the OMAP code for SmartReflex is far from complete in
mainline. There is a plan to provide the following features:
- OMAP v1 IP,
- OMAP v2 IP,
- class 1.5,
- class 3,
- class 3.5,
- and more support for the upcoming chipsets.

Also I am sure that other vendors could step in and have their
platform specific code converted to the new fwk as well.

>
>
> Yes, I remember that rule, but that's not stopping us to create a fwk, may
> be others will rise once they see the framework and contribute
> if their h/w architecture requirements are not addressed?
>

Thanks,
Jean

>
> ---Trilok Soni
>
> --
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
