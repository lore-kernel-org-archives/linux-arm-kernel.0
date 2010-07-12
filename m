From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jul 2010 22:31:16 +0200
Subject: ARM defconfig files
In-Reply-To: <20100712185029.GB14425@pengutronix.de>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
Message-ID: <201007122231.16283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 July 2010 20:50:29 Uwe Kleine-K?nig wrote:
> 
> [1] The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> 
>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/defconfig/reduced-v2.6.35-rc1

BTW, looking at the most common entries in there, I think we might at some
point want to change some of the defaults in the respective Kconfig files.
Right now an empty defconfig would result in a configuration without
file system, networking or modules:

sort arch/arm/configs/* | uniq -c | sort -n | tail -n 30
    114 CONFIG_BLK_DEV_RAM=y
    116 CONFIG_BLK_DEV_INITRD=y
    116 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
    117 CONFIG_NFS_FS=y
    118 CONFIG_MTD_CHAR=y
    119 CONFIG_INOTIFY=y
    122 # CONFIG_BLK_DEV_BSG is not set
    122 CONFIG_IP_PNP=y
    123 # CONFIG_IPV6 is not set
    123 CONFIG_MTD_BLOCK=y
    125 CONFIG_FPE_NWFPE=y
    127 CONFIG_NET_ETHERNET=y
    128 CONFIG_LOG_BUF_SHIFT=14
    128 CONFIG_MTD=y
    131 CONFIG_PACKET=y
    132 # CONFIG_INPUT_MOUSE is not set
    133 CONFIG_DEBUG_KERNEL=y
    134 CONFIG_EXT2_FS=y
    138 CONFIG_MODULE_UNLOAD=y
    139 CONFIG_TMPFS=y
    142 CONFIG_NETDEVICES=y
    147 CONFIG_ZBOOT_ROM_BSS=0x0
    147 CONFIG_ZBOOT_ROM_TEXT=0x0
    151 CONFIG_INET=y
    151 CONFIG_UNIX=y
    153 CONFIG_NET=y
    156 # CONFIG_VGA_CONSOLE is not set
    158 CONFIG_MODULES=y
    164 CONFIG_SYSVIPC=y
    174 CONFIG_EXPERIMENTAL=y

Also, some of the defconfigs contain stuff that arguably does not belong
into a defconfig and could be removed in the next merge window, e.g.

ezx_defconfig:CONFIG_LOCALVERSION="-ezx200910312315"
pnx4008_defconfig:CONFIG_DECNET=m
at572d940hfek_defconfig:CONFIG_SGI_PARTITION=y

	Arnd
