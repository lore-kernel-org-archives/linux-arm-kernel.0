From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Thu, 5 Nov 2009 23:27:29 +0200
Subject: [PATCH] Allow platforms to control which PXA uarts are registered
In-Reply-To: <20091105141337.GB21681@n2100.arm.linux.org.uk>
References: <20091105141337.GB21681@n2100.arm.linux.org.uk>
Message-ID: <f870da180911051327hc687c1oe8c76fb487e340ba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 4:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> For some platforms, it is inappropriate to register all PXA UARTs.
> In some cases, the UARTs may not be used, and in others we may want
> to avoid registering the UARTs to allow other drivers (eg, FICP) to
> make use of the UART.
>
> In addition, a while back there was a request to be able to pass
> platform data to the UART driver.
>
> This patch enables all of this by providing functions platforms can
> call to register each individual UART.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>
> Note: this patch needs verification that those platforms missing
> a call to pxa_set_hwuart_info() really don't use the HWUART - I
> think I got it right based upon which are PXA255 based platforms.
>
> ?arch/arm/mach-pxa/balloon3.c ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/cm-x2xx.c ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/cm-x300.c ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/colibri-pxa270.c | ? ?3 +++
> ?arch/arm/mach-pxa/colibri-pxa300.c | ? ?4 ++++
> ?arch/arm/mach-pxa/colibri-pxa320.c | ? ?4 ++++
> ?arch/arm/mach-pxa/corgi.c ? ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/csb726.c ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/devices.c ? ? ? ?| ? 26 +++++++++++++++++++++++++-
> ?arch/arm/mach-pxa/e330.c ? ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/e350.c ? ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/e400.c ? ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/e740.c ? ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/e750.c ? ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/e800.c ? ? ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/em-x270.c ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/ezx.c ? ? ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-pxa/generic.h ? ? ? ?| ? ?5 +++++
> ?arch/arm/mach-pxa/gumstix.c ? ? ? ?| ? ?5 +++++
> ?arch/arm/mach-pxa/h5000.c ? ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-pxa/himalaya.c ? ? ? | ? ?3 +++
> ?arch/arm/mach-pxa/hx4700.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/idp.c ? ? ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-pxa/imote2.c ? ? ? ? | ? ?6 +++++-
> ?arch/arm/mach-pxa/littleton.c ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/lpd270.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/lubbock.c ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/magician.c ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/mainstone.c ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/mioa701.c ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-pxa/mp900.c ? ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-pxa/palmld.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/palmt5.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/palmtc.c ? ? ? ? | ? ?5 +++++
> ?arch/arm/mach-pxa/palmte2.c ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/palmtx.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/palmz72.c ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/pcm027.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/poodle.c ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/pxa25x.c ? ? ? ? | ? ?7 +------
> ?arch/arm/mach-pxa/pxa27x.c ? ? ? ? | ? ?3 ---
> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? | ? ?3 ---
> ?arch/arm/mach-pxa/saar.c ? ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/spitz.c ? ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/stargate2.c ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/tavorevb.c ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/tosa.c ? ? ? ? ? | ? ?5 +++++
> ?arch/arm/mach-pxa/treo680.c ? ? ? ?| ? ?5 +++++
> ?arch/arm/mach-pxa/trizeps4.c ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/viper.c ? ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-pxa/xcep.c ? ? ? ? ? | ? ?5 +++++
> ?arch/arm/mach-pxa/zylonite.c ? ? ? | ? ?4 ++++
> ?52 files changed, 211 insertions(+), 14 deletions(-)

For cm-x2xx, cm-x300 and em-x270
Acked-by: Mike Rapoport <mike@compulab.co.il>
