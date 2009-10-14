From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Oct 2009 21:02:48 +0200
Subject: [RFC] i2c-designware patches
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <20091014190248.GE11789@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shinya,

On Tue, Oct 13, 2009 at 11:44:04AM +0900, Shinya Kuribayashi wrote:
> Here're various improvements / bug-fixing patches for DW I2C driver.
> I'm working with v2.6.27-based kernel, but they must work fine with the
> latest mainline kernel.
> 
> It's stil in RFC, and I'm working with it for some time.  Any comments
> or suggestions are highly appreciated.  Then I'll respin and give it a
> test, thanks.
> 
> Baruch, I'd say the base driver is in good shape enogh, so I'm having
> a fun with modifing the driver.  Thanks for the initial work.
> 
> P.S. ARM and MIPS lists are Cc:ed as I believe there must be potential
> users of this driver.
> 
> 
> Shinya Kuribayashi (16):
>      i2c-designware: Consolidate to use 32-bit word accesses
>      i2c-designware: Don't use the IC_CLR_INTR register to clear interrupts
>      i2c-designware: Use platform_get_irq helper
>      i2c-designware: i2c_dw_read: Take "struct dw_i2c_dev" pointer
>      i2c-designware: i2c_dw_xfer_msg: Take "struct dw_i2c_dev" pointer
>      i2c-designware: Remove an useless local variable "num"
>      i2c-designware: Set a clock name to DesignWare I2C clock source
>      i2c-designware: Improve _HCNT/_LCNT calculation
>      i2c-designware: i2c_dw_xfer_msg: Fix an i2c_msg search bug
>      i2c-designware: Do dw_i2c_pump_msg's jobs in the interrutp handler
>      i2c-designware: Set Tx/Rx FIFO threshold levels
>      i2c-designware: Divide i2c_dw_xfer_msg into two functions
>      i2c-designware: i2c_dw_xfer_msg: Introduce a local "buf" pointer
>      i2c-designware: Deferred FIFO-data-counting variables initialization
>      i2c-designware: i2c_dw_xfer_msg: Mark as completed on an error
>      i2c-designware: Add I2C_FUNC_SMBUS_* bits

Great job.

Your contribution to the implementation of transactions that are longer than 
the hardware buffers is very important. I wrote this code as a theoretical 
exercise, as I never had access to an i2c slave which requires long 
transactions. So I'm not surprised to find out that this code was broken.

For all these patches except no. 7 (Set a clock name to DesignWare I2C clock 
source) and no. 16 (Add I2C_FUNC_SMBUS_* bits) you have my

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
