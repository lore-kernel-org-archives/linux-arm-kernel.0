From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 7 Jul 2011 13:50:14 +0800
Subject: [GIT PULL] pxa: patches for v3.1
In-Reply-To: <201107061857.51896.arnd@arndb.de>
References: <CAMPhdO-Xy69r5P-GZivUjsho81k1b_m_mAYM2hxtBt2X3W=42A@mail.gmail.com>
	<201107061857.51896.arnd@arndb.de>
Message-ID: <CAMPhdO_Qe7dQaNu7OT3-07NdLxpbsV4SzJi3EuTdH0KC5Yp8VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2011 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 05 July 2011, Eric Miao wrote:
>> The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
>
> Hi Eric,
>
> You are mixing very different kinds of patches here, I'd much prefer to
> get separate pull requests for them by category. Looking at the changelogs, it
> seems that there should be three of these:
>
> Bug fixes:
>> Jonathan Cameron (2):
>> ? ? ? pcmcia: pxa2xx/vpac270: free gpios on exist rather than requesting
>> Daniel Mack (1):
>> ? ? ? ARM: pxa/raumfeld: fix device name for codec ak4104
>> Sven Neumann (2):
>> ? ? ? ARM: pxa/raumfeld: adapt to upcoming hardware change
>> ? ? ? ARM: pxa/raumfeld: display initialisation fixes
>> Linus Walleij (1):
>> ? ? ? ARM: pxa: fix gpio_to_chip() clash with gpiolib namespace
>
> Cleanups:
>> Jonathan Cameron (2):
>> ? ? ? pcmcia: pxa2xx/trizeps4: remove unnecessary ifdefs
>> Dmitry Eremin-Solenikov (1):
>> ? ? ? ARM: scoop: drop pcmcia_init callback
>> Philipp Zabel (4):
>> ? ? ? ARM: pxa/magician: fix MAGICIAN_EGPIO_BASE, align with NR_BUILTIN_GPIO
>> ? ? ? ARM: pxa/magician: use gpio arrays for backlight and global gpios
>> ? ? ? ARM: pxa/hx4700: use gpio arrays for global gpios
>> ? ? ? ARM: pxa/mioa701: use gpio arrays for global and gsm gpios
>> Igor Grinberg (4):
>> ? ? ? ARM: pxa/cm-x300: fix V3020 RTC functionality
>> ? ? ? ARM: pxa/cm-x300: GPIO cleanup
>> ? ? ? ARM: pxa/cm-x300: minor style cleanup
>> ? ? ? ARM: pxa/cm-x300: update cm_x300_defconfig
>> Eric Miao (7):
>> ? ? ? ARM: pxa: enable AUTO_ZRELADDR
>> ? ? ? ARM: pxa: add common header file for pxa3xx
>> ? ? ? ARM: pxa: move declarations from generic.h to <soc>.h
>> ? ? ? ARM: pxa/saarb: make use of pxa3xx_map_io()
>
> Features:
>> Haojian Zhuang (2):
>> ? ? ? ARM: mmp/dkb: enable max7312 gpio expander
>> Tanmay Upadhyay (3):
>> ? ? ? ARM: pxa168: Add support for UART3
>> ? ? ? ARM: pxa168: Add support for Ethernet
>> ? ? ? ARM: pxa168: Add board support for gplugD
>> Vasily Khoruzhick (1):
>> ? ? ? ARM: pxa/z2: add poweroff function
>> Haojian Zhuang (2):
>> ? ? ? ARM: pxa: add clk_set_rate()
>> Eric Miao (7):
>> ? ? ? ARM: pxa: avoid accessing interrupt registers directly
>> ? ? ? ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
>> ? ? ? ARM: pxa: enable MULTI_IRQ_HANDLER for all boards
>
> Can you split up the series roughly along these lines and send me
> new pull requests? I'd like to be able to mix and match these with
> stuff for the other SoCs where it makes sense, when I send a pull
> request to Linus. That way, if there is too much pushback on new features,
> we can still get all the cleanups and bug fixes in, and don't end up with
> some platforms getting lucky because they are sent first, while the others
> are too much and don't get anything in.

That makes sense. Some of the fixes are applicable to v3.0, which I'll
check to move them over.

And so do you want me to send 3 separate git pull requests? I'm actually
thinking of using two 'trivial' (fixes+cleanup) + 'devel' (new features).


>
> Obviously I hope to get everything merged, but if a pull request looks
> like the one you sent me, I'd rather not take it at all. The individual
> patches all look good to me though, no objection there.
>
> ? ? ? ?Arnd
>
