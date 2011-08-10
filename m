From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2011 16:31:37 +0200
Subject: [PATCH 2/3 v2] RFC: arm/kirkwood: add dreamplug support.
In-Reply-To: <6b9e805f5765939fc844d5a9cd02ad141aa6af00.1312906908.git.jason@lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
	<6b9e805f5765939fc844d5a9cd02ad141aa6af00.1312906908.git.jason@lakedaemon.net>
Message-ID: <201108101631.38293.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 August 2011, Jason Cooper wrote:
> Copied guruplug-setup.c and did s/guruplug/dreamplug/g.  Then, switched
> to SPI based NOR flash.  LED pins are correct.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/mach-kirkwood/Kconfig           |    6 ++
>  arch/arm/mach-kirkwood/Makefile          |    1 +
>  arch/arm/mach-kirkwood/dreamplug-setup.c |  144 ++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-kirkwood/dreamplug-setup.c

Hi Jason,

If the boards are reasonably similar, the way to go using the device tree
is to have separate dts files but share a single board file that uses the
device tree to figure out the differences.

For the on-chip components, you can even share most of the device tree
contents with an include directive.

In the actual board file, do not list any platform devices, but make
sure that the contents of the device tree file describe the devices
completely. Try to avoid any dependencies on the specific board name
(other than the initial match entry) but instead describe the
differences accurately.

	Arnd
