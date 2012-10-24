From: josh.coombs@gmail.com (Josh Coombs)
Date: Wed, 24 Oct 2012 11:29:08 -0400
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAMW5UfaHZE2VB5Ug-5hT_29U8zfO_qZh9T=9QBbx0xv7D+OeOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, are there any required kernel config changes to go along with
this?  I didn't see any updates to the default configs in the patches
so I want to make sure I'm testing with the right options enabled.

Josh C

On Wed, Oct 24, 2012 at 10:53 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> This patchset converts all DT kirkwood boards to using pinctrl.
>
> This patchset depends on an earlier patchset to allow the mvebu
> pinctrl driver and gpio driver to be built for kirkwood.
>
> Only the TS219 conversion has been tested on hardware. The remaining
> are compile tested. Before merging upstream, it would be good if the
> others could be tested on hardware.
>
> This series along with the dependents can be found in:
>
> git://github.com/lunn/linux.git v3.7-rc2-pinctrl
>
> Andrew Lunn (9):
>   ARM: Kirkwood: Convert TS219 to pinctrl.
>   ARM: Kirkwood: Convert iConnect to pinctrl.
>   ARM: Kirkwood: Convert dnskw to pinctrl
>   ARM: Kirkwood: Convert dockstar to pinctrl.
>   ARM: Kirkwood: Convert dreamplug to pinctrl.
>   ARM: Kirkwood: Convert GoFlex Net to pinctrl.
>   ARM: Kirkwood: Convert ib62x0 to pinctrl.
>   ARM: Kirkwood: Convert lsxl boards to pinctrl.
>   ARM: Kirkwood: Convert IX2-200 to pinctrl.
>
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi         |  136 +++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dockstar.dts       |   21 ++++
>  arch/arm/boot/dts/kirkwood-dreamplug.dts      |   26 +++++
>  arch/arm/boot/dts/kirkwood-goflexnet.dts      |   57 +++++++++++
>  arch/arm/boot/dts/kirkwood-ib62x0.dts         |   41 ++++++++
>  arch/arm/boot/dts/kirkwood-iconnect.dts       |   52 ++++++++++
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   90 ++++++++++++++++
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi          |   67 ++++++++++++
>  arch/arm/boot/dts/kirkwood-ts219-6281.dts     |   56 ++++++++++
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts     |   56 ++++++++++
>  arch/arm/mach-kirkwood/board-dnskw.c          |   37 -------
>  arch/arm/mach-kirkwood/board-dockstar.c       |   10 --
>  arch/arm/mach-kirkwood/board-dreamplug.c      |   14 ---
>  arch/arm/mach-kirkwood/board-goflexnet.c      |   18 ----
>  arch/arm/mach-kirkwood/board-ib62x0.c         |   21 ----
>  arch/arm/mach-kirkwood/board-iconnect.c       |   17 ----
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   24 -----
>  arch/arm/mach-kirkwood/board-lsxl.c           |   19 ----
>  arch/arm/mach-kirkwood/board-ts219.c          |   25 -----
>  19 files changed, 602 insertions(+), 185 deletions(-)
>
> --
> 1.7.10.4
>
