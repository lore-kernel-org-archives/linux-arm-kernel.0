From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:40:14 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.13
In-Reply-To: <7ho9tqbgsv.fsf@baylibre.com>
References: <7ho9tqbgsv.fsf@baylibre.com>
Message-ID: <20170619034014.GR30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 14, 2017 at 10:49:36AM -0700, Kevin Hilman wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64
> 
> for you to fetch changes up to 27f87bd2900b1a95d9c8e25deeb9768cf3fdcc4e:
> 
>   ARM64: dts: meson-gxl-s905x-p212: Add HDMI and CVBS nodes (2017-06-09 11:38:22 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 64-bit DT changes for v4.13
> - cleanup/reorganize alphabetically to better avoid conflicts
> - add HDMI and CVBS nodes for multiple boards
> - new pinctrl pins: SPI, HDMI CEC
> - SCPI: fix thermal sensor reporting
> 
> New board support
> - NanoPi K2 (GXBB)
> - R-Box Pro (GXM)

Merged, thanks!

> 
> ----------------------------------------------------------------
> Andreas F??rber (23):
>       dt-bindings: arm: amlogic: Reorder boards
>       arm64: dts: amlogic: Sort Makefile
>       arm64: dts: meson-gxbb-vega-s95: Fix Wifi node name
>       arm64: dts: meson-gxbb-p20x: Fix Wifi node name
>       arm64: dts: meson-gx-p23x-q20x: Fix Wifi node name
>       arm64: dts: meson-gxl-s905x-khadas-vim: Fix Wifi node name
>       arm64: dts: meson-gxm-nexbox-a1: Drop UART comment
>       arm64: dts: meson-gxl-s905x: Comment typo fix
>       arm64: dts: meson-gxbb-wetek-hub: Reference CVBS node by label
>       arm64: dts: meson-gxbb: Fix node order
>       arm64: dts: meson-gxbb-odroidc2: Fix node order
>       arm64: dts: meson-gxbb-vega-s95: Fix node order
>       arm64: dts: meson-gxbb-nexbox-a95x: Fix node order
>       arm64: dts: meson-gxbb-p20x: Fix node order
>       arm64: dts: meson-gxl: Fix node order
>       arm64: dts: meson-gxl-s905x-nexbox-a95x: Fix node order
>       arm64: dts: meson-gxm-nexbox-a1: Fix node order
>       arm64: dts: meson-gx-p23x-q20x: Fix node order

Small nit: Most of these could probably have been squashed into a few
patches, being able to bisect them individually isn't likely to be useful.

>       dt-bindings: Add Kingnovel vendor prefix
>       dt-bindings: arm: amlogic: Add R-Box Pro
>       arm64: dts: meson-gxm: Add R-Box Pro
>       dt-bindings: arm: amlogic: Add NanoPi K2
>       arm64: dts: amlogic: Add NanoPi K2
> 
> Carlo Caione (1):
>       ARM64: dts: meson-gx: Fix sensors reporting from SCP
> 
> Neil Armstrong (12):
>       ARM64: dts: meson-gxl: Fix pinctrl periphs gpio-ranges
>       ARM64: dts: Fix GXL periphs pinctrl pull-enable register base
>       ARM64: dts: Fix GXBB periphs pinctrl pull-enable register base
>       ARM64: dts: meson-gxbb: Add CEC pins nodes
>       ARM64: dts: meson-gxl: Add CEC pins nodes
>       ARM64: dts: meson-gxl: Add Ethernet PHY LEDS pins nodes
>       ARM64: dts: meson-gxbb: Add SPI pinctrl nodes
>       ARM64: dts: meson-gxl: Add SPI pinctrl nodes
>       ARM64: dts: meson-gxbb-wetek-play2: Add HDMI and CVBS Nodes
>       ARM64: dts: meson-gxl-s905d-p230: Add HDMI nodes
>       ARM64: dts: meson-gxl-s905x-khadas-vim: Add HDMI nodes
>       ARM64: dts: meson-gxl-s905x-p212: Add HDMI and CVBS nodes

Same for some of these, but it's just a few.


-Olof
