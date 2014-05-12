From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 12 May 2014 10:08:13 -0400 (EDT)
Subject: [PATCH v2 0/6] usb: host: Cleanup for ioremap'ing hcd memory
In-Reply-To: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1405121007410.1202-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 May 2014, Vivek Gautam wrote:

> Based on 'usb-next' branch of Greg's usb tree.
> 
> devm_ioremap_resource() API is advantageous over devm_ioremap()
> and should therefore be preferred to request any ioremap'ed address
> for hcd.
> 
> Changes from v1:
>  - Changed the way returned pointer is checked for error value
>    as pointed out in the review comment in the mailing list.
> 
> Vivek Gautam (6):
>   usb: host: ehci-exynos: Use devm_ioremap_resource instead of
>     devm_ioremap
>   usb: host: ehci-msm: Use devm_ioremap_resource instead of
>     devm_ioremap
>   usb: host: ehci-mv: Use devm_ioremap_resource instead of devm_ioremap
>   usb: host: ehci-spear: Use devm_ioremap_resource instead of
>     devm_ioremap
>   usb: host: ehci-tegra: Use devm_ioremap_resource instead of
>     devm_ioremap
>   usb: host: ohci-exynos: Use devm_ioremap_resource instead of
>     devm_ioremap
> 
>  drivers/usb/host/ehci-exynos.c |    7 +++----
>  drivers/usb/host/ehci-msm.c    |    7 +++----
>  drivers/usb/host/ehci-mv.c     |   16 ++++++----------
>  drivers/usb/host/ehci-spear.c  |   13 +++----------
>  drivers/usb/host/ehci-tegra.c  |    7 +++----
>  drivers/usb/host/ohci-exynos.c |    7 +++----
>  6 files changed, 21 insertions(+), 36 deletions(-)

For all six patches,

Acked-by: Alan Stern <stern@rowland.harvard.edu>
