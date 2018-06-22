From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Fri, 22 Jun 2018 14:30:43 -0700
Subject: [PATCH] net: drivers/net: Convert random_ether_addr to
 eth_random_addr
In-Reply-To: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
References: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
Message-ID: <dc3e8b7272240b2650f5ed55a6e2954a765a96de.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-22 at 10:51 -0700, Joe Perches wrote:
> random_ether_addr is a #define for eth_random_addr which is
> generally preferred in kernel code by ~3:1
> 
> Convert the uses of random_ether_addr to enable removing the #define
> 
> Miscellanea:
> 
> o Convert &vfmac[0] to equivalent vfmac and avoid unnecessary line
> wrap
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For i40e change

> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c          | 5 ++---
>  drivers/net/ethernet/cortina/gemini.c                    | 2 +-
>  drivers/net/ethernet/hisilicon/hip04_eth.c               | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c              | 2 +-
>  drivers/net/ethernet/microchip/lan743x_main.c            | 2 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 2 +-
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c          | 2 +-
>  drivers/net/ethernet/sfc/ef10_sriov.c                    | 2 +-
>  drivers/net/ethernet/ti/cpsw.c                           | 2 +-
>  drivers/net/ethernet/ti/netcp_core.c                     | 4 ++--
>  drivers/net/ntb_netdev.c                                 | 2 +-
>  drivers/net/usb/lan78xx.c                                | 2 +-
>  drivers/net/wireless/ath/ath9k/hw.c                      | 2 +-
>  net/batman-adv/bridge_loop_avoidance.c                   | 2 +-
>  14 files changed, 16 insertions(+), 17 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180622/48cc24a3/attachment-0001.sig>
