From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 25 Aug 2016 16:31:27 +0900
Subject: [PATCH 09/10] reset: zynq: add driver Kconfig option
In-Reply-To: <1472109786.3032.21.camel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-9-git-send-email-p.zabel@pengutronix.de>
 <CAK7LNATr0WDx0aMXEJMxrDY6WxBtqis-DkZiOjGnrjM8zqYi-A@mail.gmail.com>
 <CAK7LNASJ0gQ-_4H3+=deNAXYVSWkek4sH2uUrTkyxGH5R7i1Xw@mail.gmail.com>
 <1472109786.3032.21.camel@pengutronix.de>
Message-ID: <CAK7LNASfDx_DkedVs0Y8FKrD2DJEG9cqty6kbLTy_YYusEg1iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-25 16:23 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Donnerstag, den 25.08.2016, 10:08 +0900 schrieb Masahiro Yamada:
>> 2016-08-25 2:48 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> > 2016-08-24 22:29 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> >> Visible only if COMPILE_TEST is enabled, this allows to include the
>> >> driver in build tests.
>> >>
>> >> Cc: Moritz Fischer <moritz.fischer@ettus.com>
>> >> Cc: Michal Simek <michal.simek@xilinx.com>
>> >> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> >> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> >> ---
>> >>  drivers/reset/Kconfig  | 6 ++++++
>> >>  drivers/reset/Makefile | 2 +-
>> >>  2 files changed, 7 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> >> index 17030e2..86b49a2 100644
>> >> --- a/drivers/reset/Kconfig
>> >> +++ b/drivers/reset/Kconfig
>> >> @@ -67,6 +67,12 @@ config RESET_SUNXI
>> >>         help
>> >>           This enables the reset driver for Allwinner SoCs.
>> >>
>> >> +config RESET_ZYNQ
>> >> +       bool "ZYNQ Reset Driver" if COMPILE_TEST
>> >> +       default ARCH_ZYNQ
>> >> +       help
>> >> +         This enables the reset driver for Xilinx Zynq FPGAs.
>> >> +
>> >
>> > Please move this below RESET_UNIPHIER
>> > as I assume you are sorting Kconfig entries alphabetically.
>
> Yes, that was my intention.
>
>> > Otherwise,
>> >
>> > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >
>>
>>
>>
>>
>> >> +         This enables the reset driver for Xilinx Zynq FPGAs.
>>
>>
>> One more thing, I thought this statement is not precise
>> because Zynq is not only an FPGA,
>> but ARM SoC + FPGA.
>>
>> Please consider to reword
>>
>> "This enables the reset driver for Xilinx Zynq SoC"
>
> I'll change it to SoCs, thanks.

Maybe singular?   As far as I know, Zynq-7000 is the only SoC
of the Zynq family.
I am not sure if Xilinx has plan to add more lineups to 32bit SoCs.



-- 
Best Regards
Masahiro Yamada
