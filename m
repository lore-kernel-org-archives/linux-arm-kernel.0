From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:16:54 +0200
Subject: [PATCH v2 00/18] ARM64: meson: DT cleanups
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <36c02d8a-d3e2-4330-f600-e49a1ba680e8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 05/13/2017 04:33 PM, Andreas F?rber wrote:
> Hello Kevin,
> 
> This series fixes several cosmetic issues, on top of your for-next branch.
> 
> Patches 3-6 rename a node, the rest should all be non-functional changes.

These are OK.

> 
> PLEASE STOP merging random new nodes at the bottom of DT files!
> Just like it's a convention to sort new nodes by unit address, it has been
> a convention to sort by-label nodes by their label. As discussed here and
> elsewhere, this helps avoid merge conflicts and makes nodes easy to find.
> I don't care whether we order A0 before A or after, but adding new HDMI
> or CVBS nodes at the very bottom is totally out of alphabetical order.
> Since my v1 you really should've known that...

It's not perfect, but now it's done, live with it, this has already been discussed.

Please try to refactor boards DTS with their parent reference design instead
like it was done with the P212 and what I did with the Wetek Hub and Play2.

> 
> Similarly, Khadas Vim shouldn't have been merged with the "bcrmf" typo.

Well, this is why we have 7 rc releases after the merge window...

> 
> Which proves my point that we need to fix these issues now so that they
> don't keep spreading (Broken Window Theory). New boards have not been
> checked for sort order, only boards already touched in v1.
> 
> Board and Makefile order affect my pending R-Box Pro patches.
> Node order affects Martin's pending Bluetooth patches among others.

Please order S905x after S905d, and we'll be OK.
> 
> Patches 7-9 (had and) have no dependency, please start applying.

I'll wait for Kevin's advice, but I'm against these since they are
only purely cosmetic and will break bisect and add unnecessary complexity
to handle further patches on these board.

> Thanks,
> Andreas

Thanks,
Neil
> 
> v1 -> v2:
> * Rebased (new nodes/properties added)
> * Chose a different name for the misnamed Wifi nodes (Rob)
> * Added patch to fix another new misnamed Wifi node
> * Dropped patch fixing a trailing white line error (resolved)
> * Tweaked subjects
> 
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Andreas F?rber (18):
>   dt-bindings: arm: amlogic: Reorder boards
>   arm64: dts: amlogic: Sort Makefile
>   arm64: dts: meson-gxbb-vega-s95: Fix Wifi node name
>   arm64: dts: meson-gxbb-p20x: Fix Wifi node name
>   arm64: dts: meson-gx-p23x-q20x: Fix Wifi node name
>   arm64: dts: meson-gxl-s905x-khadas-vim: Fix Wifi node name
>   arm64: dts: meson-gxm-nexbox-a1: Drop UART comment
>   arm64: dts: meson-gxl-s905x: Comment typo fix
>   arm64: dts: meson-gxbb-wetek-hub: Reference CVBS node by label
>   arm64: dts: meson-gxbb: Fix node order
>   arm64: dts: meson-gxbb-odroidc2: Fix node order
>   arm64: dts: meson-gxbb-vega-s95: Fix node order
>   arm64: dts: meson-gxbb-nexbox-a95x: Fix node order
>   arm64: dts: meson-gxbb-p20x: Fix node order
>   arm64: dts: meson-gxl: Fix node order
>   arm64: dts: meson-gxl-s905x-nexbox-a95x: Fix node order
>   arm64: dts: meson-gxm-nexbox-a1: Fix node order
>   arm64: dts: meson-gx-p23x-q20x: Fix node order
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt  |  20 ++-
>  arch/arm64/boot/dts/amlogic/Makefile               |   6 +-
>  .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  60 ++++----
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  52 +++----
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 108 ++++++-------
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  66 ++++----
>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  56 +++----
>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |   6 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 171 +++++++++++----------
>  .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |   2 +-
>  .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  52 +++----
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |   2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  72 ++++-----
>  .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  87 ++++++-----
>  14 files changed, 388 insertions(+), 372 deletions(-)
> 
