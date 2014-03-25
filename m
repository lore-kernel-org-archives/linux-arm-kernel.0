From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 Mar 2014 10:07:00 +0100
Subject: [PATCH v3] i2c: new bus driver for efm32
In-Reply-To: <20140324170131.GB7524@katana>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
Message-ID: <20140325090700.GL23076@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> And checkpatch said:
> 
> WARNING: braces {} are not necessary for any arm of this statement
> #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> +		if (cur_msg->flags & I2C_M_RD) {
> ...
hmm the whole block reads:

        case REG_STATE_STATE_DATA:
                if (cur_msg->flags & I2C_M_RD) {
                        efm32_i2c_recv_next_byte(ddata);
                } else {
                        /* wait for Ack or Nack of slave */
                }
                break;

so just removing the braces does the wrong thing. Is this a false
positive checkpatch warning? Andy? Joe?

I can make it:

		if (cur_msg->flags & I2C_M_RD)
			efm32_i2c_recv_next_byte(ddata);
		/* in the write case wait for Ack or Nack of slave */

but I consider the version above more readable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
