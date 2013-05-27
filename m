From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 28 May 2013 07:48:04 +1000
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
In-Reply-To: <20130527.131857.945196320286011406.davem@davemloft.net>
References: <1369647565.3557.28.camel@pasglop> <51A33447.80305@gmail.com>
 <1369655404.3557.33.camel@pasglop>
 <20130527.131857.945196320286011406.davem@davemloft.net>
Message-ID: <1369691284.3557.34.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-27 at 13:18 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 27 May 2013 21:50:04 +1000
> 
> > It would be handy to be able to just do something like
> > 
> >       of_set_property(node, name, ptr, len);
> > 
> > However, that wouldn't help much with the allocation/leak problem,
> > though at least it would be easier to use. It could also *try* to re-use
> > the current allocation if the new content is of smaller or equal size.
> 
> And this is so much better of an interface because it allows the
> OF implementation to decide how to deal with memory allocation
> and freeing.

Absolutely, I'm not arguing that point.

Cheers,
Ben.
