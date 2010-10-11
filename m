From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 11 Oct 2010 17:14:53 +0800
Subject: [PATCH 01/14 v2] ARM: pxa: Introduce pxa[23]xx_map_io
In-Reply-To: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
References: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=Rh7HBue1w-i7VodkRw8JJBXhYnOghMLee7hGE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 8:20 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This patch introduces pxa2xx_map_io() and pxa3xx_map_io() to distinguish between
> PXA2xx and PXA3xx memory mapping.
>
> Also, fixup for platforms broken after introducing pxa2xx_map_io() and
> pxa3xx_map_io() is included.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> v2: Fix spitz.c containing code from patch 02/14. Thanks, Igor.
>
> ?arch/arm/mach-pxa/balloon3.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/capc7117.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/cm-x2xx.c ? ? ? ?| ? ?4 +-
> ?arch/arm/mach-pxa/cm-x300.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/colibri-pxa270.c | ? ?4 +-
> ?arch/arm/mach-pxa/colibri-pxa300.c | ? ?2 +-
> ?arch/arm/mach-pxa/colibri-pxa320.c | ? ?2 +-
> ?arch/arm/mach-pxa/corgi.c ? ? ? ? ?| ? ?6 ++--
> ?arch/arm/mach-pxa/csb726.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/em-x270.c ? ? ? ?| ? ?4 +-
> ?arch/arm/mach-pxa/eseries.c ? ? ? ?| ? 12 +++++-----
> ?arch/arm/mach-pxa/ezx.c ? ? ? ? ? ?| ? 12 +++++-----
> ?arch/arm/mach-pxa/generic.c ? ? ? ?| ? 37 ++++++++++++++++++++++++++++-------
> ?arch/arm/mach-pxa/generic.h ? ? ? ?| ? ?3 +-
> ?arch/arm/mach-pxa/gumstix.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/h5000.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/himalaya.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/hx4700.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/icontrol.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/idp.c ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/littleton.c ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/lpd270.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/lubbock.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/magician.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/mainstone.c ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/mioa701.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/mp900.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/palmld.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/palmt5.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/palmtc.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/palmte2.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/palmtreo.c ? ? ? | ? ?4 +-
> ?arch/arm/mach-pxa/palmtx.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/palmz72.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/pcm027.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/poodle.c ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/raumfeld.c ? ? ? | ? ?6 ++--
> ?arch/arm/mach-pxa/saar.c ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/spitz.c ? ? ? ? ?| ? ?7 +++--
> ?arch/arm/mach-pxa/stargate2.c ? ? ?| ? ?4 +-
> ?arch/arm/mach-pxa/tavorevb.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/tavorevb3.c ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/tosa.c ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/trizeps4.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/viper.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/vpac270.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/xcep.c ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/z2.c ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/zeus.c ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/zylonite.c ? ? ? | ? ?2 +-
> ?50 files changed, 101 insertions(+), 78 deletions(-)

Acked.
