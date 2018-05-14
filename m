From: joe@perches.com (Joe Perches)
Date: Mon, 14 May 2018 09:11:57 -0700
Subject: [PATCH 00/21] i2c: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Message-ID: <c83bb5ddf36b419c4c01e20384c7b532c9a48cd4.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-05-14 at 16:53 +0200, Peter Rosin wrote:
> Hi!
> 
> The nice little inline i2c_8bit_addr_from_msg is not getting
> enough use. This series improves the situation and drops a
> bunch of lines in the process.

Perhaps the inline should test for I2C_M_REV_DIR_ADDR
as there is at least one use like

-               addr = msg->addr << 1;
-               if (flags & I2C_M_RD)
-                       addr |= 1;
+               addr = i2c_8bit_addr_from_msg(msg);
                if (flags & I2C_M_REV_DIR_ADDR)
                        addr ^= 1;

which look odd

Do any of these changes now no longer need
the temporary flags variable?
