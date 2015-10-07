From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 11:00:01 +0100
Subject: [PATCH v5 0/5] ARM: sunxi: Add Reduced Serial Bus support
In-Reply-To: <1443700673-24312-1-git-send-email-wens@csie.org>
References: <1443700673-24312-1-git-send-email-wens@csie.org>
Message-ID: <20151007100001.GD2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 07:57:46PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is my fifth attempt at adding support for Allwinner's Reduced
> Serial Bus (RSB), which is used to communicate with PMICs and other
> peripherals on their newer SoCs, such as the A23/A33/A80.
> 
> RSB is a simplified two wire interface using push-pull outputs,
> supporting multiple slaves, address and data parity checks, and
> clock speeds up to 20 MHz. The bus only supports simple register
> read/writes, with possible register sizes of 8/16/32 bits. Access
> sizes not matching the slave device register sizes result in NACKs
> or errors. 32 bit registers in devices have yet to be seen.
> 
> v4 and later adds a platform driver for the RSB controller under
> drivers/soc/sunxi, which adds a custom driver type and bus type
> for slave drivers to use. Custom regmap support is also merged
> into the controller driver. Currently the driver only exports 2
> symbols: sunxi_rsb_driver_register() & __devm_regmap_init_sunxi_rsb().

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/1795f703/attachment.sig>
