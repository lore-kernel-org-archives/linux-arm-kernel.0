From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 15 Nov 2011 11:16:51 -0800
Subject: [PATCH v1] dts: tegra-ventana: use proper root instead of /dev/ram
In-Reply-To: <1321338087-3662-1-git-send-email-vwadekar@nvidia.com>
References: <1321338087-3662-1-git-send-email-vwadekar@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740805E1B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Varun Wadekar wrote at Monday, November 14, 2011 11:21 PM:
> From: Pritesh Raithatha <praithatha@nvidia.com>
> 
> The root file system on ventana resides on /dev/mmcblk0p1.

Well, that's entirely up to however the user set up their system, although
I admit mmcblk0p1 is likely to be the common case; I certainly carry
basically this patch locally for many boards.

> Update the dts file to use the proper root instead of /dev/ram.
> 
> Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Varun Wadekar <vwadekar@nvidia.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

Of course, perhaps an even better solution is to just remove /chosen from
all the board .dts files, and stop using CONFIG_APPENDED_DTB since U-boot
supports FDT, and will update the cmdline with whatever the user chose.
Still, I think this is probably OK for now.

-- 
nvpublic
