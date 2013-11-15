From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Nov 2013 14:29:22 +0900
Subject: [PATCH v2 3/3] ARM: shmobile: Koelsch: enable Ether in defconfig
In-Reply-To: <201311150223.40632.sergei.shtylyov@cogentembedded.com>
References: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
 <201311150223.40632.sergei.shtylyov@cogentembedded.com>
Message-ID: <20131115052919.GA16854@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 02:23:40AM +0300, Sergei Shtylyov wrote:
> Enable the Ether driver in 'koelsch_defconfig' along with DHCP autoconfiguration
> and NFS root.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks.

I think it is also appropriate to remove these too.
To be hones their inclusion appears to have been an error on my part.
And if nfsroot is being enabled it seems to be a good opportunity
to get rid of them.

CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="../../initramfs/out/rootfs.arm.cpio"
CONFIG_INITRAMFS_COMPRESSION_GZIP=y

> 
> ---
> Changes in version 2:
> - new patch in the series.
> 
>  arch/arm/configs/koelsch_defconfig |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> Index: renesas/arch/arm/configs/koelsch_defconfig
> ===================================================================
> --- renesas.orig/arch/arm/configs/koelsch_defconfig
> +++ renesas/arch/arm/configs/koelsch_defconfig
> @@ -29,7 +29,27 @@ CONFIG_VFP=y
>  CONFIG_NEON=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_PM_RUNTIME=y
> +CONFIG_NET=y
> +CONFIG_INET=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +CONFIG_NETDEVICES=y
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_CADENCE is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_CIRRUS is not set
> +# CONFIG_NET_VENDOR_FARADAY is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +CONFIG_SH_ETH=y
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
>  # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>  # CONFIG_INPUT_MOUSE is not set
>  # CONFIG_LEGACY_PTYS is not set
> @@ -49,6 +69,8 @@ CONFIG_LEDS_CLASS=y
>  CONFIG_TMPFS=y
>  CONFIG_CONFIGFS_FS=y
>  # CONFIG_MISC_FILESYSTEMS is not set
> +CONFIG_NFS_FS=y
> +CONFIG_ROOT_NFS=y
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_ARM_UNWIND is not set
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
