From: peda@axentia.se (Peter Rosin)
Date: Mon, 18 Jun 2018 13:32:47 +0200
Subject: [PATCH 01/11] i2c: add helpers for locking the I2C segment
In-Reply-To: <20180618110502.cb5s24srp4frahm6@ninjato>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
 <20180618110502.cb5s24srp4frahm6@ninjato>
Message-ID: <b860025e-3d4b-f333-80b4-3831dd969757@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-06-18 13:05, Wolfram Sang wrote:
> 
>> +static inline void
>> +i2c_lock_segment(struct i2c_adapter *adapter)
>> +{
>> +	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
>> +}
>> +
>> +static inline int
>> +i2c_trylock_segment(struct i2c_adapter *adapter)
>> +{
>> +	return i2c_trylock_bus(adapter, I2C_LOCK_SEGMENT);
>> +}
>> +
>> +static inline void
>> +i2c_unlock_segment(struct i2c_adapter *adapter)
>> +{
>> +	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
>> +}
> 
> I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
> more readable and convenient than i2c_lock_bus() with the flag. I think
> the flags have speaking names, too.
> 
> Is that an idea to remove these functions altogether and start using
> i2c_lock_bus()?

That would be fine with me. I don't have a strong opinion and agree that
both are readable enough...

It would make for a reduction of the number of lines so that's nice, but
the macro in drivers/i2c/busses/i2c-gpio.c (patch 11) would not fit in
the current \-width (or whatever you'd call that line of backslashes to
the right in a multi-line macro).

Does anyone have a strong opinion?

Cheers,
Peter
