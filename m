From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 26 Feb 2018 21:06:39 +0100
Subject: [PATCH] i2c-stm32f4: remove redundant initialization of pointer
 reg
In-Reply-To: <20180116174404.19464-1-colin.king@canonical.com>
References: <20180116174404.19464-1-colin.king@canonical.com>
Message-ID: <20180226200639.tfll2y4efepm2sos@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 05:44:04PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer reg is assigned a value that is never read, it is later
> overwritten with a new value, hence the redundant initialization can
> be removed.
> 
> Cleans up clang warning:
> drivers/i2c/busses/i2c-stm32f4.c:352:16: warning: Value stored to 'reg'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Maxime? Alexandre? Are you OK with this patch?

> ---
>  drivers/i2c/busses/i2c-stm32f4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
> index 47c8d00de53f..ba600d77a3f8 100644
> --- a/drivers/i2c/busses/i2c-stm32f4.c
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -349,7 +349,7 @@ static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
>  static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
>  {
>  	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> -	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> +	void __iomem *reg;
>  
>  	stm32f4_i2c_disable_irq(i2c_dev);
>  
> -- 
> 2.15.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/0d7e201c/attachment.sig>
