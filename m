From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Jul 2013 10:05:03 +0200
Subject: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130716080503.GA3125@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mon, Jul 15, 2013 at 04:24:36PM +0200, Gregory CLEMENT wrote:
> The I2C Transaction Generator offloads CPU from managing I2C
> transfer step by step.
> 
> This feature is currently only available on Armada XP, so usage of
> this mechanism is activated through device tree.
> 
> Based on the work of Piotr Ziecik and rewrote to use the new way of
> handling multiples i2c messages.
> 
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 207 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 196 insertions(+), 11 deletions(-)

[...]

> +	/*
> +	 * For controllers embedded in new SoCs activate the
> +	 * Transaction Generator support.
> +	 */
> +	if (of_device_is_compatible(np, "marvell,mv78230-i2c"))
> +		drv_data->offload_enabled = true;
> +

Do you have a reason for not adding it to the match table? I mean, you
will introduce a new compatible here, but if that compatible is used
alone, won't probe the driver? That doesn't seem very right to me.

Also, you should probably add it to the bindings documentation.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/512ddec5/attachment.sig>
