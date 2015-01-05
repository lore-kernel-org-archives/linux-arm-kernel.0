From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Jan 2015 11:27:37 -0600
Subject: [PATCH V4] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
In-Reply-To: <1420475549-28492-1-git-send-email-nm@ti.com>
References: <1420475549-28492-1-git-send-email-nm@ti.com>
Message-ID: <20150105172737.GK19336@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 10:32:29AM -0600, Nishanth Menon wrote:
> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> a fan (such as AFB02505HHB) over J1 connector for various purposes.
> Provide device tree node to enable the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> V4: Change format of the speed-map used.
> V3: https://patchwork.kernel.org/patch/5562121/
> V2: https://patchwork.kernel.org/patch/5445111/
> V1: https://patchwork.kernel.org/patch/5444911/
> 
> Enable and disable can be controlled by (post the RPM, it finds
> closest match - even a 1 will do)
> 
> echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
> and
> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
> 
> Test log: http://slexy.org/view/s2T0ajh46z
> 
> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational

oh, perhaps add these as modules to omap2plus_defconfig ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/a348b300/attachment.sig>
