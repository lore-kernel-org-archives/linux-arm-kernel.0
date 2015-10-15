From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Oct 2015 09:16:42 +0200
Subject: [PATCH v6 0/5] Add DT support for netxbig LEDs
In-Reply-To: <56178C49.4070704@samsung.com> (Jacek Anaszewski's message of
 "Fri, 09 Oct 2015 11:43:37 +0200")
References: <1443301358-2131-1-git-send-email-simon.guinot@sequanux.org>
 <56178C49.4070704@samsung.com>
Message-ID: <87mvvk38kl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacek,
 
 On ven., oct. 09 2015, Jacek Anaszewski <j.anaszewski@samsung.com> wrote:

> On 09/26/2015 11:02 PM, Simon Guinot wrote:
>> Hello,

[..]
>>
>> Simon Guinot (5):
>>    leds: netxbig: add device tree binding
>>    ARM: Kirkwood: add LED DT entries for netxbig boards
>>    ARM: mvebu: remove static LED setup for netxbig boards
>>    leds: netxbig: convert to use the devm_ functions
>>    leds: netxbig: set led_classdev max_brightness
>>
>>   .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
>>   .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++
>>   arch/arm/boot/dts/kirkwood-net5big.dts             |  60 ++++
>>   arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  80 +++++
>>   arch/arm/mach-mvebu/Kconfig                        |   7 -
>>   arch/arm/mach-mvebu/Makefile                       |   1 -
>>   arch/arm/mach-mvebu/board.h                        |  21 --
>>   arch/arm/mach-mvebu/kirkwood.c                     |   4 -
>>   arch/arm/mach-mvebu/netxbig.c                      | 191 ------------
>>   drivers/leds/leds-netxbig.c                        | 336 ++++++++++++++++-----
>>   include/dt-bindings/leds/leds-netxbig.h            |  18 ++
>>   .../linux/platform_data/leds-kirkwood-netxbig.h    |   1 +
>>   12 files changed, 531 insertions(+), 302 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
>>   delete mode 100644 arch/arm/mach-mvebu/board.h
>>   delete mode 100644 arch/arm/mach-mvebu/netxbig.c
>>   create mode 100644 include/dt-bindings/leds/leds-netxbig.h
>>
>
> Since no comment regarding DT bindings has appeared for a long time,
> I decided to merge the patch set without DT maintainer's ack, thanks.

it is a good news that this series will be finally merged. However did
you also take the patches "ARM: Kirkwood: add LED DT entries for netxbig
boards" and "ARM: mvebu: remove static LED setup for netxbig boards" ?

Thanks,

Gregory

>
> -- 
> Best Regards,
> Jacek Anaszewski

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
