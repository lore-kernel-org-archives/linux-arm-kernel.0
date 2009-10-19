From: skuribay@pobox.com (Shinya Kuribayashi)
Date: Mon, 19 Oct 2009 10:23:42 +0900
Subject: [RFC] i2c-designware patches
In-Reply-To: <20091014190248.GE11789@tarshish>
References: <4AD3E974.8080200@necel.com> <20091014190248.GE11789@tarshish>
Message-ID: <4ADBBF9E.1070801@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Baruch Siach wrote:
> Your contribution to the implementation of transactions that are longer than 
> the hardware buffers is very important. I wrote this code as a theoretical 
> exercise, as I never had access to an i2c slave which requires long 
> transactions. So I'm not surprised to find out that this code was broken.

Aa far as looking through the source code, I know that it's broken
without giving it a try with real DW I2C hardware ;-), but that'
not a big problem.

As said in the covermail, your initial work, namely i2c_dw_xfer(),
i2c_dw_xfer_msg(), and i2c_dw_read() is well-designed, this _is_
very important.  That makes further enhancements of DW I2C
transactions much easier, and makes me decide to post the patches.

> For all these patches except no. 7 (Set a clock name to DesignWare I2C clock 
> source) and no. 16 (Add I2C_FUNC_SMBUS_* bits) you have my
> 
> Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks, will do.

I added more 4-5 patches fixing transmit abort handling, and misc
updates all over the patchset (typos, comments, better logics).
They will come up, hopefully, next week.

  Shinya
