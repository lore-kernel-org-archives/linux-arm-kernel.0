From: treding@nvidia.com (Thierry Reding)
Date: Fri, 21 Aug 2015 15:16:33 +0200
Subject: [PATCH v3 0/14] Add Analogix Core Display Port Driver
In-Reply-To: <8384E112-E1F4-4CD3-85BF-A2A25989783F@gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <105A0032-83A0-4B75-AE94-258F12451670@gmail.com>
 <55D6F6F8.70504@rock-chips.com>
 <8384E112-E1F4-4CD3-85BF-A2A25989783F@gmail.com>
Message-ID: <20150821131631.GC22118@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 08:24:16PM +0900, Jingoo Han wrote:
> On 2015. 8. 21., at PM 7:01, Yakir Yang <ykk@rock-chips.com> wrote:
> > 
> > Hi Jingoo,
> > 
> >> ? 2015/8/21 16:20, Jingoo Han ??:
> >>> On 2015. 8. 19., at PM 11:48, Yakir Yang <ykk@rock-chips.com> wrote:
> >> 
> >> .....
> >> 
> >>> .../bindings/video/analogix_dp-rockchip.txt        |   83 ++
> >>> .../devicetree/bindings/video/exynos_dp.txt        |   51 +-
> >>> arch/arm/boot/dts/exynos5250-arndale.dts           |   10 +-
> >>> arch/arm/boot/dts/exynos5250-smdk5250.dts          |   10 +-
> >>> arch/arm/boot/dts/exynos5250-snow.dts              |   12 +-
> >>> arch/arm/boot/dts/exynos5250-spring.dts            |   12 +-
> >>> arch/arm/boot/dts/exynos5420-peach-pit.dts         |   12 +-
> >>> arch/arm/boot/dts/exynos5420-smdk5420.dts          |   10 +-
> >>> arch/arm/boot/dts/exynos5800-peach-pi.dts          |   12 +-
> >>> drivers/gpu/drm/bridge/Kconfig                     |    5 +
> >>> drivers/gpu/drm/bridge/Makefile                    |    1 +
> >>> drivers/gpu/drm/bridge/analogix_dp_core.c          | 1382 +++++++++++++++++++
> >>> drivers/gpu/drm/bridge/analogix_dp_core.h          |  286 ++++
> >>> drivers/gpu/drm/bridge/analogix_dp_reg.c           | 1294 ++++++++++++++++++
> >>> .../exynos_dp_reg.h => bridge/analogix_dp_reg.h}   |  270 ++--
> >>> drivers/gpu/drm/exynos/Kconfig                     |    5 +-
> >>> drivers/gpu/drm/exynos/Makefile                    |    2 +-
> >>> drivers/gpu/drm/exynos/analogix_dp-exynos.c        |  347 +++++
> >> Would you change this file name to "exynos_dp.c"?
> > 
> > Sorry, I don't think so  ;(
> > 
> > I think IP_name+Soc_name would be better in this re-use case.
> 
> So? Is there the naming rule such as "IP_name+SoC_name"?
> 
> > Beside I see
> > there are lots of driver named with this format in kernel, such as dw_hdmi & dw_mmc
> 
> Please look at other dw cases.
> For example, look at dw_pcie.
> 
> drivers/pci/host/
> pcie-designware.c
> pci-spear13xx.c
> pci-exynos.c
> 
> In this case, pci-spear13xx.c and pci-exynos.c do not use "IP_name+SoC_name", even though these are dw IPs.
> 
> Also, naming consistency is more important.
> Now, Exynos DRM files are using "exynos_drm_" prefix.
> 
> drivers/gpu/drm/exynos/
> exynos_drm_buf.c
> exynos_drm_core.c
> ....
> 
> However, "analogix_dp-exynos.c" looks very inconsistent.
> 
> If there is no strict naming rule, please use "exynos_dp.c"
> or "exynos_drm_dp.c". 

Exynos DRM maintainers get to pick their filenames, so Yakir, please
rename as Jingoo suggested.

Even if you didn't the first thing that would go into the Exynos DRM
driver tree after this is merged is a rename patch anyway.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150821/542c4e0f/attachment.sig>
