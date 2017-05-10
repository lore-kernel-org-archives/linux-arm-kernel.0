From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 10 May 2017 14:48:36 -0700
Subject: [PATCH v2 net-next 03/12] drivers: net: xgene: Use rgmii mdio mac
 access
In-Reply-To: <1494449110-23785-4-git-send-email-isubramanian@apm.com>
References: <1494449110-23785-1-git-send-email-isubramanian@apm.com>
 <1494449110-23785-4-git-send-email-isubramanian@apm.com>
Message-ID: <4be54921-2d46-1675-9f39-894c7caf3807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2017 01:45 PM, Iyappan Subramanian wrote:
> From: Quan Nguyen <qnguyen@apm.com>
> 
> This patch switches to use rgmii mdio mac access routines if available,
> as they share the same HW.
> 
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> ---
>  drivers/net/ethernet/apm/xgene/xgene_enet_hw.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
> index 2050c58..47c5b75 100644
> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
> @@ -277,6 +277,13 @@ void xgene_enet_wr_mac(struct xgene_enet_pdata *pdata, u32 wr_addr, u32 wr_data)
>  	u8 wait = 10;
>  	u32 done;
>  
> +	if (pdata->mdio_driver && ndev->phydev &&
> +	    pdata->phy_mode == PHY_INTERFACE_MODE_RGMII) {

To be on the safe side you should check all 4 values of
PHY_INTERFACE_MODE_RGMII, not just this one.
-- 
Florian
