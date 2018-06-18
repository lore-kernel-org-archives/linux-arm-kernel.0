From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 18 Jun 2018 20:05:03 +0900
Subject: [PATCH 01/11] i2c: add helpers for locking the I2C segment
In-Reply-To: <20180615101506.8012-2-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
Message-ID: <20180618110502.cb5s24srp4frahm6@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static inline void
> +i2c_lock_segment(struct i2c_adapter *adapter)
> +{
> +	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
> +}
> +
> +static inline int
> +i2c_trylock_segment(struct i2c_adapter *adapter)
> +{
> +	return i2c_trylock_bus(adapter, I2C_LOCK_SEGMENT);
> +}
> +
> +static inline void
> +i2c_unlock_segment(struct i2c_adapter *adapter)
> +{
> +	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
> +}

I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
more readable and convenient than i2c_lock_bus() with the flag. I think
the flags have speaking names, too.

Is that an idea to remove these functions altogether and start using
i2c_lock_bus()?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/b15be943/attachment.sig>
