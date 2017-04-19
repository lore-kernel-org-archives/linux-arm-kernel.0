From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:45:52 -0700
Subject: [GIT PULL] Allwinner H5 DT changes for 4.12
In-Reply-To: <20170406093748.7xybeycxnqj5frow@lukather>
References: <20170406093748.7xybeycxnqj5frow@lukather>
Message-ID: <20170419124552.GT17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 11:37:48AM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Here is a serie of patches a bit unusual for the next merge window.
> 
> Allwinner released a new SoC, the H5, that is basically an H3 with
> arm64 CPU cores (A53 instead of A7).
> 
> In order to support it properly, we've created a common DTSI, and
> built on top. Since that DTSI is spread across arm and arm64, it took
> a bit of rework (all the patches in that PR until commit da89e1d5cbaf
> ("ARM: sunxi: h3/h5: add usb_otg and OHCI/EHCI for usbc0 on H3/H5"))
> that is shared with the PR I just sent with the H3-only patches.
> 
> The patches on top of that commit are H5-specific commits (new boards,
> new features) and should be merged through your arm64 DT branch.
> 
> Thanks,
> Maxime
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-h5-for-4.12
> 
> for you to fetch changes up to d7bb5b966174fee6e4b0085124b75787a5d81b8a:
> 
>   ARM: sunxi: h3/h5: switch apb0-related clocks to r_ccu (2017-04-04 17:45:24 +0200)
> 
> ----------------------------------------------------------------
> Allwinner H5 DT changes for 4.12
> 
> H5 patches for 4.12, which are mostly related to reworking the H3 DTSI to
> be usable on the arm64 H5 DTSI, that shares almost everything with the H3
> but the CPU cores.
> 
> We then have patches to support the H5 boards on top.
> 
> ----------------------------------------------------------------
> Andre Przywara (3):
>       arm: sun8i: h3: split Allwinner H3 .dtsi
>       arm64: allwinner: h5: add Allwinner H5 .dtsi
>       arm64: allwinner: h5: add support for the Orange Pi PC 2 board
> 
> Icenowy Zheng (6):
>       arm: sun8i: h3: drop skeleton.dtsi inclusion in H3 DTSI
>       arm: sun8i: h3: drop pinctrl-a10.h inclusion for H3 DTSI
>       arm: sun8i: h3: correct the GIC compatible in H3 to gic-400
>       ARM: sunxi: h3/h5: add usb_otg and OHCI/EHCI for usbc0 on H3/H5
>       arm64: allwinner: h5: enable USB OTG on Orange Pi PC 2 board
>       ARM: sunxi: h3/h5: switch apb0-related clocks to r_ccu
> 
>  arch/arm/boot/dts/sun8i-h3.dtsi                    | 602 ++-------------------
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 601 ++++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 188 +++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 124 +++++
>  arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
>  6 files changed, 955 insertions(+), 562 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
>  create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi

So, I really don't like these symlinks. We had some discussions here:

https://marc.info/?m=147547436324674&w=2

Given my lack of attention on this, it's obviously way late in the release
cycle to ask you to respin so I'll merge this branch as-is right now.

What I'll do though, is that I'll apply that patch that sets up those
symlinks here, and may I ask that you revisit right after -rc1 with
a pull request that moves over to that model? I.e. the arm64 dts
would then include <arm/sunxi-h3-h5.dtsi> instead.


-Olof
