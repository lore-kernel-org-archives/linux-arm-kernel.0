From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 29 Jul 2016 15:08:15 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <CAK7LNAS82QLZg40qjnkftES_Cd5AeyTAEdw3_Tms+8W6cK3QKw@mail.gmail.com>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <1469698980.12835.18.camel@pengutronix.de>
 <CAK7LNAS82QLZg40qjnkftES_Cd5AeyTAEdw3_Tms+8W6cK3QKw@mail.gmail.com>
Message-ID: <1469797695.3012.48.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Donnerstag, den 28.07.2016, 19:29 +0900 schrieb Masahiro Yamada:
[...]
> However, I think the following makes more sense:
> 
> 
> menuconfig RESET_CONTROLLER
>         bool "Reset Controller Support"
>         depends on (ARCH_HAS_RESET_CONTROLLER || COMPILE_TEST)
>         default y
>         help
>           Generic Reset Controller support.

That looks sensible to me. You'll only have to enable the reset
controller framework if either some enabled architecture has a reset
controller (in which case you want the driver for it to be activated by
default), or if you want to compile test some of the reset drivers.

regards
Philipp
