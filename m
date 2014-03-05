From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 5 Mar 2014 21:06:25 +0530
Subject: [PATCH 1/1] ARM: EXYNOS: Map SYSRAM address through DT
In-Reply-To: <531725E9.5010307@saftware.de>
References: <1392876308-4748-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHz6wJPdC=DjgaiNOsPHY8k9zaB+p3-ahpwOOcPQtoWEHw@mail.gmail.com>
 <531725E9.5010307@saftware.de>
Message-ID: <CAK9yfHw2adag+J1B=te4QvTG-PMJzvbrMe7NwFZsUGJrJFjmSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2014 18:56, Andreas Oberritter <obi@saftware.de> wrote:
> On 05.03.2014 09:23, Sachin Kamat wrote:
>>> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>>> index d2e3f5f5916d..3ca3fb6aa5f4 100644
>>> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>>> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>>> @@ -28,6 +28,11 @@
>>>                 bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>>>         };
>>>
>>> +       sysram at 02020000 {
>                   ^
>>> +               compatible = "samsung,exynos4210-sysram";
>>> +               reg = <0x02025000 0x1000>;
>                           ^
>>> +       };
>>> +
>
> Shouldn't these two addresses match?

Ideally they should. However in this case, this particular board uses
older revision
of the SoC which has a different register address. I did not want to
create a compatible
string just for this (exceptional) case alone and hence did it this
way to override the reg. address.
Other option was not to have the register address in the node name.

 --
With warm regards,
Sachin
