From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 7 Jan 2015 09:14:19 +0100
Subject: [PATCH] ARM: shmobile: sh73a0 legacy: Set .control_parent for all
 irqpin instances
In-Reply-To: <4452252.suqURC1IYD@avalon>
References: <1420551550-27512-1-git-send-email-geert+renesas@glider.be>
 <4452252.suqURC1IYD@avalon>
Message-ID: <CAMuHMdWLdYY+xwK0_0Qv1DV0T=3H-dMDgON78a01OC+nj4ZGzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jan 6, 2015 at 3:14 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 06 January 2015 14:39:10 Geert Uytterhoeven wrote:
>> The sh73a0 INTC can't mask interrupts properly most likely due to a
>> hardware bug. Set the .control_parent flag to delegate masking to the
>> parent interrupt controller, like was already done for irqpin1.
>>
>> Without this, accessing the three-axis digital accelerometer ADXL345
>> on kzm9g through /dev/input/event1 causes an interrupt storm, which
>> requires a power-cycle to recover from.
>>
>> This was inspired by a patch for arch/arm/boot/dts/sh73a0.dtsi from
>> Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.
>
> This looks correct to me, but shouldn't we concentrate on getting rid of
> legacy code instead ?

Sure.

But this is a serious bug, which allows to crash the kernel from user space.
Worse, a simple reset is not sufficient to recover. You need to power-cycle
the board.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
