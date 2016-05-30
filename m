From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 May 2016 16:50:16 +0100
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
Message-ID: <20160530155016.GO29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
> On 30 May 2016 at 17:03, Mark Brown <broonie@kernel.org> wrote:

> > I really don't think it's worth caring too much about cases where the
> > DMA driver hasn't been compiled in, it's not like SPI is the only thing

> It's what the driver did to start with and it was requested to fall
> back to non-DMA in the case DMA is not available.

Why?  I really can't see any sensible use case for this that doesn't
have a better solution available.

> It's possible to add a parameter like require_dma which could be used
> to load the driver without dma if unset. If it was set by default then
> driver ordering is not important so long as dma driver is loaded
> eventually. Also an informative print that such parameter exists when
> probing the driver is deferred would be helpful. It would probably
> create quite a bit of log spam, however. The driver can be deferred
> several times during boot.

That seems fairly hacky, if we were going to do anything like that it
should be the other way around so that we default to trying to use
resources and even then it seems like something that should be handled
at a framework level rather than having random options in individual
drivers to ignore things.  Having things behave inconsistently between
different drivers is going to lead to a worse user experience and if
this is a good idea for one driver it seems like it'd be a good idea for
all of them.

But really 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/4ad69a21/attachment.sig>
