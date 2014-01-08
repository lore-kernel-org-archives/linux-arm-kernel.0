From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Jan 2014 16:21:39 +0100
Subject: [PATCH v5 3/4] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140108152139.GB15182@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 04:06:28PM +0100, Gregory CLEMENT wrote:
> The first variants of Armada XP SoCs (A0 stepping) have issues related
> to the i2c controller which prevent to use the offload mechanism and
> lead to a kernel hang during boot.
> 
> The commit introduces a new the compatible string
> marvell,mv78230-a0-i2c for the i2c controller. When this compatible
> string is used the driver disables the offload mechanism and the
> kernel no more hangs on these SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Cc: stable at vger.kernel.org
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 8be7e42aa4de..f424c0f89946 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -692,6 +692,10 @@ static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
>  	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
>  	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
>  	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
> +	{
> +		.compatible = "marvell,mv78230-a0-i2c",
> +		.data = &mv64xxx_i2c_regs_mv64xxx
> +	},

I think a oneliner entry like the entries above is easier to read, but
that is very minor...

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/5d478cfa/attachment.sig>
