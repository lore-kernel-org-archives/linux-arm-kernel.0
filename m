From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Jun 2016 15:11:06 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Ethernet Switch drivers
In-Reply-To: <1466026874-11971-1-git-send-email-andrew@lunn.ch>
References: <1466026874-11971-1-git-send-email-andrew@lunn.ch>
Message-ID: <5761D27A.4040706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 02:41 PM, Andrew Lunn wrote:
> Kernelci now has two boards with Ethernet switches supported by DSA.
> Enable DSA and the switch drivers so we get some boot testing.

So this is going to create some conflicts with this commit which would
be submitted for 4.8:

https://github.com/Broadcom/stblinux/commit/0fa28995465cf9f9465a1ff69e8dfff17f9734ea

So let's take yours and I will rework mine to just include the BCMGENET
and SYSTEMPORT drivers inclusion.

> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/multi_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8f857564657f..b45ac256b491 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -157,6 +157,8 @@ CONFIG_INET6_IPCOMP=m
>  CONFIG_IPV6_MIP6=m
>  CONFIG_IPV6_TUNNEL=m
>  CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_DSA=y
> +CONFIG_NET_SWITCHDEV=y
>  CONFIG_CAN=y
>  CONFIG_CAN_RAW=y
>  CONFIG_CAN_BCM=y
> @@ -222,6 +224,8 @@ CONFIG_SATA_RCAR=y
>  CONFIG_NETDEVICES=y
>  CONFIG_VIRTIO_NET=y
>  CONFIG_HIX5HD2_GMAC=y
> +CONFIG_NET_DSA_MV88E6XXX=y
> +CONFIG_NET_DSA_BCM_SF2=y
>  CONFIG_SUN4I_EMAC=y
>  CONFIG_MACB=y
>  CONFIG_NET_CALXEDA_XGMAC=y
> 


-- 
Florian
