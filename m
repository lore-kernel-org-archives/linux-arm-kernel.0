From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Fri, 30 Jun 2017 07:19:24 +0000
Subject: [PATCH] staging: fsl-dpaa2/eth: Remove dead code
In-Reply-To: <20170629162546.10372-1-ruxandra.radulescu@nxp.com>
References: <20170629162546.10372-1-ruxandra.radulescu@nxp.com>
Message-ID: <DB5PR04MB1240A5870E15A372E3FEE3FBEAD30@DB5PR04MB1240.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ioana Radulescu [mailto:ruxandra.radulescu at nxp.com]
> Sent: Thursday, June 29, 2017 7:26 PM
> To: gregkh at linuxfoundation.org
> Cc: devel at driverdev.osuosl.org; linux-kernel at vger.kernel.org;
> agraf at suse.de; arnd at arndb.de; linux-arm-kernel at lists.infradead.org; Bogdan
> Purcareata <bogdan.purcareata@nxp.com>; stuyoder at gmail.com; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>
> Subject: [PATCH] staging: fsl-dpaa2/eth: Remove dead code
> 
> All possible values of the switch statement are explicitly
> handled, so there's no need to have a default branch.
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Acked-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>

> ---
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> index 5312edc26f01..031179ab3a22 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> @@ -217,8 +217,6 @@ static void dpaa2_eth_get_ethtool_stats(struct
> net_device *net_dev,
>  		case 2:
>  			num_cnt = sizeof(dpni_stats.page_2) / sizeof(u64);
>  			break;
> -		default:
> -			break;
>  		}
>  		for (k = 0; k < num_cnt; k++)
>  			*(data + i++) = dpni_stats.raw.counter[k];
> --
> 2.11.0
