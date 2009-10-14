From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Oct 2009 20:53:27 +0200
Subject: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
In-Reply-To: <4AD3EBDD.50105@necel.com>
References: <4AD3E974.8080200@necel.com>
 <4AD3EBDD.50105@necel.com>
Message-ID: <20091014185327.GD11789@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shinya,

On Tue, Oct 13, 2009 at 11:54:21AM +0900, Shinya Kuribayashi wrote:
> This will ease our testing a bit with i2c-tools.  Note that DW I2C core
> doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave-
> addressing-only I2C transactions.

Is this supposed to be applied to mainline?

baruch

> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
> ---
> drivers/i2c/busses/i2c-designware.c |    9 ++++++++-
> 1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index 6f85e28..80c8b8a 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -529,7 +529,14 @@ done:
> 
> static u32 i2c_dw_func(struct i2c_adapter *adap)
> {
> -	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> +	return	I2C_FUNC_I2C |
> +		I2C_FUNC_10BIT_ADDR |
> +		I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_BLOCK_DATA |
> +		I2C_FUNC_SMBUS_I2C_BLOCK |
> +		I2C_FUNC_SMBUS_I2C_BLOCK_2;
> }
> 
> static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
> -- 
> 1.6.5
> 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
