From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 16:00:08 +0100
Subject: [PATCH 0/5] ARM: Kirkwood: Use fixed regulators
In-Reply-To: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
References: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121117150008.GB13479@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks

Forgot to mention, these patches apply on top of the gpio-poweroff
patches, which has been ACKed by the appropriate maintainer.

	Andrew

On Sat, Nov 17, 2012 at 03:46:09PM +0100, Andrew Lunn wrote:
> A few Kirkwood boards use a GPIO line to enable power to subsystems,
> eg USB or SATA devices. Use the regulator framework to control these
> GPIO lines, and describe them in DT rather than C code in the board
> files.
> 
> Posted before as part of the bigger patchset.
> 
> Andrew Lunn (5):
>   ARM: Kirkwood: Enable regulator and fixed regulators.
>   ARM: Kirkwood: Convert DNSKW to use regulators
>   ARM: Kirkwood: Convert Dockstar to use regulators
>   ARM: Kirkwood: Convert GoFlexNet to use regulators
>   ARM: Kirkwood: Convert LSXL to use regulators
> 
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi    |   29 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dockstar.dts  |   17 +++++++++++++++++
>  arch/arm/boot/dts/kirkwood-goflexnet.dts |   17 +++++++++++++++++
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi     |   29 +++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig           |    3 ++-
>  arch/arm/mach-kirkwood/board-dnskw.c     |    4 ----
>  arch/arm/mach-kirkwood/board-dockstar.c  |    4 ----
>  arch/arm/mach-kirkwood/board-goflexnet.c |    4 ----
>  arch/arm/mach-kirkwood/board-lsxl.c      |    8 --------
>  9 files changed, 94 insertions(+), 21 deletions(-)
> 
> -- 
> 1.7.10.4
> 
