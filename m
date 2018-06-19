From: peda@axentia.se (Peter Rosin)
Date: Tue, 19 Jun 2018 23:29:51 +0200
Subject: [PATCH 01/11] i2c: add helpers for locking the I2C segment
In-Reply-To: <20180618115444.pgjmfntp767zuvmw@ninjato>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
 <20180618110502.cb5s24srp4frahm6@ninjato>
 <b860025e-3d4b-f333-80b4-3831dd969757@axentia.se>
 <20180618115444.pgjmfntp767zuvmw@ninjato>
Message-ID: <4a721b58-d718-68c0-cca5-23b5b21ef100@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-06-18 13:54, Wolfram Sang wrote:
> 
>>> I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
>>> more readable and convenient than i2c_lock_bus() with the flag. I think
>>> the flags have speaking names, too.
>>>
>>> Is that an idea to remove these functions altogether and start using
>>> i2c_lock_bus()?
>>
>> That would be fine with me. I don't have a strong opinion and agree that
>> both are readable enough...
>>
>> It would make for a reduction of the number of lines so that's nice, but
>> the macro in drivers/i2c/busses/i2c-gpio.c (patch 11) would not fit in
>> the current \-width (or whatever you'd call that line of backslashes to
>> the right in a multi-line macro).
>>
>> Does anyone have a strong opinion?
> 
> I have a strong opinion on making i2c.h less bloated. And yes, less
> number of lines is nice, too. I think that surely pays off the
> whitespace exception.

Ok, I have rebased onto v4.18-rc1, killed the i2c-tegra hunk and converted
i2c_lock_root(foo) over to i2c_lock_bus(foo, I2C_LOCK_ROOT_ADAPTER) and
i2c_lock_segment(foo) over to i2c_lock_bus(foo, I2C_LOCK_SEGMENT). And I
of course killed a bunch of locking helpers in i2c.h.

I doing build tests now, will post a v2 in the morning.

Cheers,
Peter
