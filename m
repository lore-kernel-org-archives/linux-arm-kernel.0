From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 14 Apr 2015 13:19:34 +0200
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <1428963047-23666-3-git-send-email-arun.ramamurthy@broadcom.com>
References: <1428963047-23666-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1428963047-23666-3-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <20150414111934.GA27836@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 03:10:46PM -0700, Arun Ramamurthy wrote:
> Getting phys by index instead of phy names so that we do
> not have to create a naming scheme when multiple phys
> are present
> 
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  drivers/usb/host/Kconfig         |  1 +
>  drivers/usb/host/ehci-platform.c | 70 ++++++++++++++--------------------------
>  2 files changed, 26 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 5ad60e4..563f22d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -284,6 +284,7 @@ config USB_EHCI_ATH79
>  
>  config USB_EHCI_HCD_PLATFORM
>  	tristate "Generic EHCI driver for a platform device"
> +	select GENERIC_PHY

Configs should never select if at all possible.
