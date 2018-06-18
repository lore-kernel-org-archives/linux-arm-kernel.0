From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 18 Jun 2018 20:54:46 +0900
Subject: [PATCH 01/11] i2c: add helpers for locking the I2C segment
In-Reply-To: <b860025e-3d4b-f333-80b4-3831dd969757@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
 <20180618110502.cb5s24srp4frahm6@ninjato>
 <b860025e-3d4b-f333-80b4-3831dd969757@axentia.se>
Message-ID: <20180618115444.pgjmfntp767zuvmw@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
> > more readable and convenient than i2c_lock_bus() with the flag. I think
> > the flags have speaking names, too.
> > 
> > Is that an idea to remove these functions altogether and start using
> > i2c_lock_bus()?
> 
> That would be fine with me. I don't have a strong opinion and agree that
> both are readable enough...
> 
> It would make for a reduction of the number of lines so that's nice, but
> the macro in drivers/i2c/busses/i2c-gpio.c (patch 11) would not fit in
> the current \-width (or whatever you'd call that line of backslashes to
> the right in a multi-line macro).
> 
> Does anyone have a strong opinion?

I have a strong opinion on making i2c.h less bloated. And yes, less
number of lines is nice, too. I think that surely pays off the
whitespace exception.

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/045df151/attachment.sig>
