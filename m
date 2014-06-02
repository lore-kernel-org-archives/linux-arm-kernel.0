From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 2 Jun 2014 19:14:28 +0200
Subject: [PATCH v3 1/6] i2c: s3c2410: Handle i2c sys_cfg register in i2c
 driver
In-Reply-To: <1399706419-13976-2-git-send-email-pankaj.dubey@samsung.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706419-13976-1-git-send-email-pankaj.dubey@samsung.com>
 <1399706419-13976-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140602171428.GK2654@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 10, 2014 at 04:20:14PM +0900, Pankaj Dubey wrote:
> Let's handle i2c interrupt re-configuration in i2c driver. This will
> help us in removing some soc specific checks from machine files.
> Since only Exynos5250, and Exynos5420 need to do this, added syscon
> based phandle to i2c device nodes of respective SoC DT files.
> Also handle saving and restoring of SYS_I2C_CFG register during
> suspend and resume of i2c driver. This will help in removing soc
> specific check from mach-exynos/pm.c.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> CC: Wolfram Sang <wsa@the-dreams.de>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: devicetree at vger.kernel.org
> CC: linux-doc at vger.kernel.org
> CC: linux-i2c at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Shall this go via i2c-tree? Looks to me like it should go with the rest
of the series? Patch is mostly okay (only reviewed the code, not the
bindings), one nit:

> +	regmap_update_bits(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, BIT(id), val);

Hardcode the '0' and drop using 'val'?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/40aacffb/attachment.sig>
