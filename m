From: carlo@caione.org (Carlo Caione)
Date: Fri, 26 Feb 2016 18:40:11 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <2709755.YfRKeiaS4S@wuerfel>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <2692251.6GoexVJEYt@wuerfel>
 <CAOQ7t2Y2B8hfGim9UegUZsurQM0+Df0K0_DjsQ0r8+qMjUSBEw@mail.gmail.com>
 <2709755.YfRKeiaS4S@wuerfel>
Message-ID: <CAOQ7t2b4N+uxkR7_aiiVWzr=DEFjz5BeAEfXiK+YgQZxzF31nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 6:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 February 2016 17:43:54 Carlo Caione wrote:

[cut]

>> AFAICT (I'm not the driver author) there is no a really strict reason
>> to have one single driver accessing registers on both buses. Of course
>> the driver has to be changed a bit.
>> Are you suggesting to have two different drivers with two different compatibles?
>
> Just an idea, but yes: if the register layout is different, then they
> would also need different compatible strings.

The meson pin controller driver basically defines the register layout
in the DTS: http://lxr.free-electrons.com/source/arch/arm/boot/dts/meson8.dtsi
#L102 and #L111, so yes, we have a different layouts.

> This is mostly a question of how the hardware design really looks:
> are these two separate pin controllers that each are responsible for
> a clear subset of the pins?

Exactly. All the GPIOAO_XX pins are managed by the pin controller on the AO bus.
At this point I guess it is needed to rework a bit the pinctrl driver
to address this problem switching to two drivers with different
compatibles for the two buses.

Thanks,

-- 
Carlo Caione
