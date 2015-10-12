From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 12 Oct 2015 10:39:05 +0800
Subject: [PATCH v5 0/7] arm64: berlin: add pinctrl support
In-Reply-To: <20151010223636.GH2842@kwain>
References: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
 <20151010223636.GH2842@kwain>
Message-ID: <20151012103905.4ff69c90@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Oct 2015 00:36:36 +0200
Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Hi Jisheng,
> 
> Please keep Acked-by tags when you submit a new version of a series.

Got it. I dunno this before, will take care in the future.

Thanks a lot for your review,
Jisheng

> 
> Thanks,
> 
> Antoine
> 
> On Fri, Oct 09, 2015 at 07:56:43PM +0800, Jisheng Zhang wrote:
> > This series adds support for Marvell berlin4ct pin-controller, allowing
> > to configure the pin muxing from the device tree.
> > 
> > Since v4:
> >  - drop ARCH_BERLIN dependency for it has been met
> >  - drop COMPILE_TEST dependency but make berlin pinctrl driver visible
> >    if COMPILE_TEST=y, and let this change be a seperate commit.
> > 
> > Since v3:
> >  - fix stupid build error: I missed local changes to berlin-bg4ct.c
> > 
> > Since v2:
> >  - introduce new berlin_pinctrl_probe_regmap() to avoid duplicated code
> >  - renaming such as s/urt/uart etc. but keep the group name as URT* to keep
> >    consistent with HW/ASIC
> > 
> > Since v1:
> >  - use generic name for pin functions
> >  - a new commit to add pinmux for uart0
> >  - correct pinctrl usage in dts
> > 
> > 
> > Jisheng Zhang (7):
> >   pinctrl: berlin: introduce berlin_pinctrl_probe_regmap()
> >   pinctrl: berlin: Make berlin pinctrl driver visible if COMPILE_TEST=y
> >   pinctrl: berlin: add the berlin4ct pinctrl driver
> >   arm64: berlin: add the pinctrl dependency for Marvell Berlin SoCs
> >   pinctrl: dt-binding: document berlin4ct SoC pinctrl
> >   arm64: dts: berlin4ct: add the pinctrl node
> >   arm64: dts: berlin4ct: add default pinmux for uart0
> > 
> >  .../devicetree/bindings/pinctrl/berlin,pinctrl.txt |   5 +-
> >  arch/arm64/Kconfig.platforms                       |   1 +
> >  arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  22 +
> >  drivers/pinctrl/berlin/Kconfig                     |   7 +-
> >  drivers/pinctrl/berlin/Makefile                    |   1 +
> >  drivers/pinctrl/berlin/berlin-bg4ct.c              | 503 +++++++++++++++++++++
> >  drivers/pinctrl/berlin/berlin.c                    |  26 +-
> >  drivers/pinctrl/berlin/berlin.h                    |   4 +
> >  8 files changed, 558 insertions(+), 11 deletions(-)
> >  create mode 100644 drivers/pinctrl/berlin/berlin-bg4ct.c
> > 
> > -- 
> > 2.6.1
> > 
> 
