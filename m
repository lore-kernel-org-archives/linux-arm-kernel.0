From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Nov 2014 16:14:15 -0800
Subject: [GIT PULL] Broadcom STB GISB bus driver for 3.19
In-Reply-To: <1417218722-29944-1-git-send-email-f.fainelli@gmail.com>
References: <1417218722-29944-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <54790FD7.9060509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/11/2014 15:52, Florian Fainelli a ?crit :
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/brcm/linux.git tags/arm-soc/for-3.19/brcmstb-drivers
> 
> for you to fetch changes up to 7938c2c819d7ec0e1f7d6b97acbd19c344139eb7:
> 
>   bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties (2014-11-28 15:44:44 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains the following changes to the Broadcom GISB bus
> arbiter from Kevin Cernekee:
> 
> - Extend brcmstb GISB bus driver to work on MIPS (currently ARM-only) and support
>   65nm and 40nm MIPS-based chips such as: BCM7038, BCM7400 and BCM7435
> 
> - Extend brcmstb GISB bus driver to work on BE systems (currently LE-only).
> 
> ----------------------------------------------------------------
> Kevin Cernekee (5):
>       bus: brcmstb_gisb: Make the driver buildable on MIPS
>       bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
>       bus: brcmstb_gisb: Look up register offsets in a table
>       bus: brcmstb_gisb: Add register offset tables for older chips
>       bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties

This patch depends on of_device_is_big_endian() which I thought would
make it through 3.19 via Grant's tree, I will resubmit this pull request
without the last patch until of_device_is_big_endian() has made it to
the tree.

Thanks

> 
>  .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   6 +-
>  drivers/bus/Kconfig                                |   2 +-
>  drivers/bus/brcmstb_gisb.c                         | 127 ++++++++++++++++++---
>  3 files changed, 114 insertions(+), 21 deletions(-)
> 
