From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 3 Jun 2015 15:31:56 +0200
Subject: [PATCH 0/2] get pinctrl more flexible for per pin muxing
 controllers
In-Reply-To: <1430729776-27797-1-git-send-email-ludovic.desroches@atmel.com>
References: <1430729776-27797-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <556F01CC.8020305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/05/2015 10:56, Ludovic Desroches a ?crit :
> Hi,
> 
> The way pins, groups and functions are tied is too constraining for some
> controllers. It concerns mainly the ones we don't care about groups and
> functions, each pin can be muxed to any functions.
> The goal of these two patches is too remove some of the constraints.
> 
> I have added the prototype of a pin controller and device tree to show the
> way I want to use these changes. I couldn't test it on boards using generic
> pinconf so I am not sure that I don't break something...
> 
> 
> Ludovic Desroches (4):
>   pinctrl: change function behavior for per pin muxing controllers
>   pinctrl: introduce complex pin description

Linus,

Ludovic sent this series nearly one month ago. It was posted after a RFC
series on the same topic two months ago. As we don't see any comment on
neither of them we assume that it's okay to include them.

So, is it possible for you to merge these 2 patches in
pinmux/pinconf-generic? The driver making use of this work, which was
marked a "PROTO" in the series sent by Ludovic, is being finalized and
sent: it would be good to have it working early.

Best regards,


>   pinctrl: rough draft for a future controller
>   ARM: at91/dt: proto dt
> 
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/at91-sama5d4ek_proto.dts | 243 ++++++++++
>  arch/arm/boot/dts/sama5d4_proto-pinfunc.h  | 463 +++++++++++++++++++
>  arch/arm/boot/dts/sama5d4_proto.dtsi       | 716 +++++++++++++++++++++++++++++
>  drivers/pinctrl/Kconfig                    |  10 +
>  drivers/pinctrl/Makefile                   |   1 +
>  drivers/pinctrl/pinconf-generic.c          |  44 +-
>  drivers/pinctrl/pinctrl-at91-pio4.c        | 625 +++++++++++++++++++++++++
>  drivers/pinctrl/pinmux.c                   |  58 +--
>  include/linux/pinctrl/pinctrl.h            |   6 +
>  include/linux/pinctrl/pinmux.h             |   3 +
>  11 files changed, 2134 insertions(+), 36 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d4ek_proto.dts
>  create mode 100644 arch/arm/boot/dts/sama5d4_proto-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/sama5d4_proto.dtsi
>  create mode 100644 drivers/pinctrl/pinctrl-at91-pio4.c
> 


-- 
Nicolas Ferre
