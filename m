From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Apr 2010 14:35:26 +0300
Subject: [PATCH] i2c-s3c2410: Enable i2c clock only on xfer
In-Reply-To: <20100420093936.GE6684@trinity.fluff.org>
References: <201004172342.43440.anarsoul@gmail.com>
	<20100420093936.GE6684@trinity.fluff.org>
Message-ID: <201004201435.32697.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 20 ?????? 2010 12:39:36 ????? Ben Dooks ???????:
> On Sat, Apr 17, 2010 at 11:42:32PM +0300, Vasily Khoruzhick wrote:
> > I don't see any reason to keep i2c clock enabled all the time when i2c
> > bus driver is loaded, and even more: it prevents me to disable uda1380
> > codec power - uda1380 doesn't respond on i2c xfers if its power was
> > disabled during i2c clock is enabled.
> 
> Weird. The SCL line should only be clocked when the block is generating
> transfers.

Yeah, it should be so, but there's a fact - codec doesn't respond on i2c after 
its power off/power on sequence without this patch, and it responds with 
patch.
I suppose I can monitor SDA/SCL state via reading GPE15/GPE14 pin status, I'll 
investigate on it a bit more...

> It is probably worth moving the clk_enable() outside the loop to avoid
> calling it each time we try an transfer.

Ok.

> I'm not sure, but I think the clock should also be enabled when reading
> or writing registers. I'd be happier to see a patch where the setup
> functions also ensure that the clock is enabled.

Ok

Regards,
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100420/b0067cbd/attachment.sig>
