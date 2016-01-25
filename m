From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 25 Jan 2016 19:09:12 +0800
Subject: [PATCH v3 00/12] mmc: use sdhci_pltfm_init for private
 allocation and clean up
In-Reply-To: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
References: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160125190912.001ee172@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

On Wed, 6 Jan 2016 18:31:31 +0800 Jisheng Zhang wrote:

> These patches are to complete the TODOs in Commit 0e748234293f ("mmc:
> sdhci: Add size for caller in init+register"), I.E:
> 
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete

What do you think about this series? Do I need to rebase on 4.5-rc1 then send
a v4? Any suggestions are appreciated.

Thanks in advance,
Jisheng

> 
> Since v2:
>  - based on mmc next tree and remove all priv usage introduced in newly
>    commits in this tree
>  - don't break two lines if sdhci_pltfm_init() call could be put into
>    one line. Thank Ludovic Desroches.
> 
> Since v1:
>  - add new patch03 to factorise sdhci_msm_pdata outisde of sdhci_msm_host.
>    This is to fix drivers/mmc/host/sdhci-msm.c:440:32: warning: 'msm_host'
>    is used uninitialized in this function [-Wuninitialized]
>  - Add Arnd's Ack for all patches except patch3 which is new in v2
> 
> 
> Jisheng Zhang (12):
>   mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of sdhci_msm_host
>   mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-st: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
>   mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
>   mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host
> 
>  drivers/mmc/host/sdhci-bcm2835.c   | 14 +++-----------
>  drivers/mmc/host/sdhci-esdhc-imx.c | 38 +++++++++++++++++---------------------
>  drivers/mmc/host/sdhci-msm.c       | 23 ++++++++++-------------
>  drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++---------------
>  drivers/mmc/host/sdhci-of-at91.c   | 24 +++++++++---------------
>  drivers/mmc/host/sdhci-of-esdhc.c  | 19 +++++++++----------
>  drivers/mmc/host/sdhci-pltfm.h     |  1 -
>  drivers/mmc/host/sdhci-pxav2.c     |  1 -
>  drivers/mmc/host/sdhci-pxav3.c     | 20 ++++++++------------
>  drivers/mmc/host/sdhci-st.c        | 35 +++++++++++++++++------------------
>  drivers/mmc/host/sdhci-tegra.c     | 21 +++++++--------------
>  11 files changed, 90 insertions(+), 131 deletions(-)
> 
