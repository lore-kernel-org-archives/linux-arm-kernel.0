From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 26 Sep 2016 14:47:27 +0900
Subject: [PATCH] ARM: uniphier: select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1474368275.4030.45.camel@pengutronix.de>
References: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
 <1474356608.4030.7.camel@pengutronix.de>
 <CAK7LNASDYjUjUoUEstFygA1GOboVgDTNKak8Zkpcj_B3XbK-1w@mail.gmail.com>
 <1474368275.4030.45.camel@pengutronix.de>
Message-ID: <CAK7LNAQcBZ+0ZePN9sFdp-u=3VFq+f=SfGiq6W_w5Buwewue-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,


2016-09-20 19:44 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Dienstag, den 20.09.2016, 17:47 +0900 schrieb Masahiro Yamada:
>> Hi Philipp,
>>
>>
>> 2016-09-20 16:30 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> > Hi Masahiro,
>> >
>> > Am Dienstag, den 20.09.2016, 13:43 +0900 schrieb Masahiro Yamada:
>> >> The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
>> >> merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.
>> >>
>> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >> ---
>> >>
>> >> Philipp,
>> >>
>> >> IIRC, you mentioned that you were planning to consolidate the double
>> >> gurad by CONFIG_RESET_CONTROLLER and CONFIG_ARCH_HAS_RESET_CONTROLLER.
>> >>
>> >> I have not seen it in the ML, so I am sending this.
>> >>
>> >> Please let me know if you have some updates.
>> >
>> > I had started to doodle a bit, see
>> >
>> >     git fetch git://git.pengutronix.de/git/pza/linux.git refs/heads/reset/kconfig
>> >
>> > but I haven't found time for cleanup and testing.
>>
>>
>> OK, I will merge this patch for now.
>>
>>
>>
>> BTW, I did not understand some of your commits under way.
>>
>>
>> commit 7fe911f9c83737449565db03bebf953d3d94bbbf
>> Author: Philipp Zabel <p.zabel@pengutronix.de>
>> Date:   Tue Aug 9 11:18:51 2016 +0200
>>
>>     dmaengine: sunx6i: do not depend on reset controller framework
>>
>>     The reset controller framework provides inline function stubs if
>>     disabled.
>>
>>     Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>>
>>
>>
>>
>> As far as I see from drivers/dma/sun6i-dma.c,
>> the reset control is mandatory for this driver.
>>
>> Why are you removing the dependency?
>>
>>
>> Don't you care if it works on run-time
>> as long as it can build?
>
> I have not thought about this too hard, it's just there because the
> reset framework is not a build dependency (anymore). Some patches were
> necessary to remove dependency loops, but I think this one could just be
> dropped.


I have not taken a close look at it, but
if "dependency loops" is the reason for the change,
please mention it in the git-log.

I do not think we should remove the "depends on"
only for the reason "inline function stubs are already provided".



-- 
Best Regards
Masahiro Yamada
