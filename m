From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Jul 2014 15:38:42 +0200
Subject: [PATCH 2/2] ARM: mvebu: add devtmpfs to mvebu_v5_defconfig
In-Reply-To: <1404375830-22169-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404375830-22169-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404375830-22169-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140703133842.GR20799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:23:50AM +0200, Thomas Petazzoni wrote:
> The devtmpfs filesystem is now widely used and generally needed to
> boot Linux systems. 42 ARM defconfigs have it enabled, so it makes
> sense to have it enabled as well in mvebu_v5_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

I have Debian sid on my boxes, and they is quite happy without
devtmpfs. Hence i've not proposed such a patch before.

	  Andrew


> ---
>  arch/arm/configs/mvebu_v5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 9f70f59..5df35e9 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -38,6 +38,8 @@ CONFIG_NET_PKTGEN=m
>  CONFIG_CFG80211=y
>  CONFIG_MAC80211=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
> -- 
> 2.0.0
> 
