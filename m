From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Dec 2015 11:38:52 +0000
Subject: regmap-mmio and paged registers
In-Reply-To: <20151209222613.GI3515@piout.net>
References: <20151209214150.GH3515@piout.net>
 <20151209221036.GK5727@sirena.org.uk>
 <20151209222613.GI3515@piout.net>
Message-ID: <20151216113852.GG5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 11:26:13PM +0100, Alexandre Belloni wrote:
> On 09/12/2015 at 22:10:36 +0000, Mark Brown wrote :

> > Honestly looking at the register I'm not even convinced it is a paged
> > regmap, it looks more like a mailbox for communication with a
> > coprocessor than anything else (the fact that the selector is named PID,
> > the fact that the bitfields include CMD...).  Are you sure that it's a
> > good idea to represent this as a regmap at all?

> Yeah, I was probably not clear enough but the regmap actually covers the
> whole PMC range and include that particular register. We have to do that
> because this range is used by multiple drivers.

I don't see how that follows?  You can layer anything you like on top of
a regmap.

> This register, PMC_PCR is also used by multiple drivers so it is
> important to properly lock between the page selection and the following
> read or write.

regmaps aren't the only way of sharing access to something - like I say
there's the mailbox API too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/cb6cfecd/attachment.sig>
