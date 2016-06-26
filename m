From: broonie@kernel.org (Mark Brown)
Date: Sun, 26 Jun 2016 13:48:43 +0100
Subject: [PATCH 1/5] spi: do not fail if the CS line is not connected
In-Reply-To: <20160619060902.GB424@jack.zhora.eu>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
 <20160617113622.GA10760@jack.zhora.eu>
 <20160617122803.GN26099@sirena.org.uk>
 <20160619060902.GB424@jack.zhora.eu>
Message-ID: <20160626124843.GP28202@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2016 at 03:09:02PM +0900, Andi Shyti wrote:

> > > This is true, but there are cases where the CS is not connected
> > > and this case needs to be treated separately to allow the device
> > > to work.

> > In what way?  It is just as easy for a device with no physical chip
> > select to have a logical chip select of 0 that it does nothing with as
> > it is for that device to handle any other number.

> That is indeed my case: the s3c64xx doesn't send anything, unless
> I manually enable CS (from the next patches I need to write '0'
> in the CS register). But I need smoething to tell to the
> device that the CS line is not connected, for example a flag in
> the DTS.

I'm sorry but I just don't understand what you're saying here.  You are
saying that there is no chip select but you need to enable the chip
select?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160626/58e72133/attachment.sig>
