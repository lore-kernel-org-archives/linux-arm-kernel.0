From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 9 Feb 2015 14:21:45 +0100
Subject: [PATCH] i2c: cadence: match return type of
 wait_for_completion_timeout
In-Reply-To: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
References: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150209132145.GD2491@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 08, 2015 at 07:55:55AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> ret is only used for wait_for_completion_timeout anyway the type is simply 
> changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Same as for the axxia driver: Please rename the variable because ret
being an int is kind of an idiom.

> ---
> 
> Patch was only compile tested with multi_v7_defconfig
> (implies CONFIG_I2C_CADENCE=y)
> 
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
> 
>  drivers/i2c/busses/i2c-cadence.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index 7d7a14c..5fbffe0 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -475,7 +475,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter *adap)
>  static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
>  		struct i2c_adapter *adap)
>  {
> -	int ret;
> +	unsigned long ret;
>  	u32 reg;
>  
>  	id->p_msg = msg;
> -- 
> 1.7.10.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150209/792c01bc/attachment.sig>
