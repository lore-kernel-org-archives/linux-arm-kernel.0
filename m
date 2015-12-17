From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 Dec 2015 20:40:17 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <7947081.psvz6dklxq@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <13702087.6o87OAVdIx@wuerfel> <20151217120157.GC3958@katana>
 <7947081.psvz6dklxq@wuerfel>
Message-ID: <20151217194016.GD1530@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > My conclusion for now is:
> > 
> > There needs something to be done surely, but currently I don't have the
> > bandwidth to do it or even play around with it. I am not fully happy
> > with your patches as well because __maybe_unused has some kind of "last
> > resort" feeling to me.
> 
> I generally like __maybe_unused, but it's a matter of personal preference.
> We could avoid the __maybe_unused if the reg_slave/unreg_slave callback
> pointers are always available in struct i2c_algorithm.

Yes, I was thinking in this direction, looking at how PM does it. Needs
some playing around, though.

> Just for reference, see below for my combined patch, in case you decide
> to use that at a later point.

Thanks a lot!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151217/1d5dfb0a/attachment.sig>
