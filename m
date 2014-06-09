From: pratyush.anand@st.com (Pratyush Anand)
Date: Mon, 9 Jun 2014 09:19:03 +0530
Subject: [PATCH 1/4] phy: Add provision for calibrating phy.
In-Reply-To: <1402056736-12674-2-git-send-email-gautam.vivek@samsung.com>
References: <1402056736-12674-1-git-send-email-gautam.vivek@samsung.com>
 <1402056736-12674-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20140609034902.GA2625@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 08:12:12PM +0800, Vivek Gautam wrote:
> Some PHY controllers may need to calibrate certain
> PHY settings after initialization of the controller and
> sometimes even after initializing the PHY-consumer too.
> Add support for the same in order to let consumers do so in need.
> 
> Signed-off-by: vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/phy/phy-core.c  |   36 ++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy.h |    7 +++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 74d4346..92d31a3 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -376,6 +376,42 @@ int phy_power_off(struct phy *phy)
>  EXPORT_SYMBOL_GPL(phy_power_off);
>  
>  /**
> + * phy_calibrate - calibrate a phy post initialization
> + * @phy: Pointer to 'phy' from consumer
> + *
> + * For certain PHYs, it may be needed to calibrate few phy parameters
> + * post initialization. The need to calibrate may arise after the

For USB you may need to calibrate phy after each new connection. If
so, why not to use already existing struct usb_phy's notify_connect.

        pratyush
