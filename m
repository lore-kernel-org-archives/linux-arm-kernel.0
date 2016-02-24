From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Feb 2016 17:22:57 +0100
Subject: [PATCH 1/2] ARM: mxs_defconfig: Cleanup mxs_defconfig
In-Reply-To: <1456326291-20618-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456326291-20618-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <5137278.2zPjnDRSyU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 February 2016 16:04:50 Michael Grzeschik wrote:
> @@ -144,7 +144,6 @@ CONFIG_PWM_MXS=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT2_FS_XATTR=y
>  CONFIG_EXT3_FS=y
> -CONFIG_EXT4_FS=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_FSCACHE=m
>  CONFIG_FSCACHE_STATS=y
> @@ -178,7 +177,6 @@ CONFIG_PROVE_LOCKING=y
> 

EXT3_FS is deprecated and only there to select EXT4_FS. Please drop
the other one instead. While we are there, you could also drop EXT2_FS,
as that is now handled by EXT4_FS as well.

	Arnd
