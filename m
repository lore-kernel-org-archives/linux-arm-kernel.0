From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Aug 2018 11:50:04 -0700
Subject: [GIT PULL] i.MX fixes for 4.19
In-Reply-To: <20180827091056.GN3850@dragon>
References: <20180827091056.GN3850@dragon>
Message-ID: <20180829185004.a2jvj3cdqujxllft@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 27, 2018 at 05:10:58PM +0800, Shawn Guo wrote:
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.19
> 
> for you to fetch changes up to b9543a2e39dc909e6b7ec901b6c7208d01d5c0dd:
> 
>   ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G (2018-08-27 15:05:48 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.19:
>  - i.MX display folks decided to switch MXS display driver from legacy
>    FB to DRM during 4.19 merge window.  It leads to a fallout on some
>    Freescale/NXP development boards with Seiko 43WVF1G panel, because
>    this DRM panel driver is not enabled in i.MX defconfig.  Here is
>    a series from Fabio to convert i.MX23/28 EVK DT to Seiko 43WVF1G
>    panel bindings and enable the panel driver in i.MX defconfig, so that
>    users can still get functional LCD on these boards by default.

This would have been nice to catch with -next, especially since it was found so
quickly after the merge window closed (that way we could have kept the period
of breakage much shorter).

>  - A fix from Leonard to revert incorrect legacy PCI irq mapping in
>    i.MX7 device tree, that was caused by document errors.


Merged this branch, thanks!


-Olof
