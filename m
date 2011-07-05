From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 21:45:32 +0800
Subject: [PATCH 00/15] Big pxa2[57]x_udc cleanup
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CAMPhdO8HfRFbxHTDdZ-ptZKA8d5b+txcVQRtpeH5A=404BacJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 9:08 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello colleagues,
>
> Please review the following patch serie. It's major task is removal of code
> and functionality duplication between pxa2[57]x_udc drivers and OTG
> transceivers subsystem.
>
> The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
>
> ?Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)
>
> are available in the git repository at:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/lumag/tosa-2.6.git misc/pxa-udc-cleanup
>
> Dmitry Eremin-Solenikov (15):
> ? ? ?ARM: pxa/balloon3: drop udc_is_connected
> ? ? ?ARM: pxa/mioa701: drop udc_is_connected
> ? ? ?ARM: pxa/stargate2: drop udc_is_connected
> ? ? ?ARM: pxa25x_udc: separate lubbock handling to lubbock-usb transceiver
> ? ? ?ARM: pxa/lubbock: switch to using lubbock_usb_xceiv transceiver
> ? ? ?pxa: drop handling of udc_is_connected
> ? ? ?pxa25x_udc: drop support for udc_command
> ? ? ?otg: add gpio_pullup OTG transceiver for devices with no VBUS sensing
> ? ? ?corgi: convert to use gpio-pullup
> ? ? ?poodle: convert to use gpio-pullup
> ? ? ?h5000: convert to use gpio-pullup
> ? ? ?gpio-vbus: support disabling D+ pullup on suspend
> ? ? ?mioa701: move gpio-pullup functionality to gpio-vbus
> ? ? ?gpio-pullup: support disabling D+ pullup on suspend
> ? ? ?pxa2[57]x_udc: drop gpio_pullup handling
>
> ?arch/arm/include/asm/mach/udc_pxa2xx.h | ? ?9 --
> ?arch/arm/mach-pxa/balloon3.c ? ? ? ? ? | ? ?7 -
> ?arch/arm/mach-pxa/colibri-pxa320.c ? ? | ? ?1 -
> ?arch/arm/mach-pxa/corgi.c ? ? ? ? ? ? ?| ? 14 ++-
> ?arch/arm/mach-pxa/devices.c ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/h5000.c ? ? ? ? ? ? ?| ? 14 ++-
> ?arch/arm/mach-pxa/lubbock.c ? ? ? ? ? ?| ? 17 +--
> ?arch/arm/mach-pxa/mioa701.c ? ? ? ? ? ?| ? 19 +--
> ?arch/arm/mach-pxa/poodle.c ? ? ? ? ? ? | ? 13 ++-
> ?arch/arm/mach-pxa/stargate2.c ? ? ? ? ?| ? ?6 -
> ?arch/arm/mach-pxa/vpac270.c ? ? ? ? ? ?| ? ?1 -
> ?drivers/usb/gadget/pxa25x_udc.c ? ? ? ?| ?132 ---------------------
> ?drivers/usb/gadget/pxa27x_udc.c ? ? ? ?| ? 27 +----
> ?drivers/usb/otg/Kconfig ? ? ? ? ? ? ? ?| ? 18 +++
> ?drivers/usb/otg/Makefile ? ? ? ? ? ? ? | ? ?2 +
> ?drivers/usb/otg/gpio_pullup.c ? ? ? ? ?| ?204 ++++++++++++++++++++++++++++++++
> ?drivers/usb/otg/gpio_vbus.c ? ? ? ? ? ?| ? 42 +++++++
> ?drivers/usb/otg/lubbock-usb.c ? ? ? ? ?| ?178 ++++++++++++++++++++++++++++
> ?include/linux/usb/gpio_vbus.h ? ? ? ? ?| ? ?1 +
> ?19 files changed, 493 insertions(+), 214 deletions(-)
> ?create mode 100644 drivers/usb/otg/gpio_pullup.c
> ?create mode 100644 drivers/usb/otg/lubbock-usb.c
>

Hi Dmitry,

The series looks good to me. It can be better re-ordered so that changes
to drivers/usb are the first part, and changes to arch/arm later?

Dropping the udc_is_connected() in each board file, I don't mind they
are in a same patch or separated.

Greg & Felipe,

Can you help merge the patches through the USB tree? Or if you can
give your Acks here. Thanks.

- eric

>
