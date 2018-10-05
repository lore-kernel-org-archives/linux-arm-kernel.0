From: david@gibson.dropbear.id.au (David Gibson)
Date: Fri, 5 Oct 2018 15:09:59 +1000
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
In-Reply-To: <20181005050627.GL32578@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
 <20181005050627.GL32578@linaro.org>
Message-ID: <20181005050959.GP7004@umbus.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 02:06:29PM +0900, AKASHI, Takahiro wrote:
[snip]
> > >> +{
> > >> +       return (strlen(prop_name) + 1) +
> > >> +               sizeof(struct fdt_property) +
> > >> +               FDT_TAGALIGN(len);
> > > 
> > > Looks like you are using this to calculate how much space you need to
> > > allocate in addition to the current DTB for a couple of new or
> > > replaced properties. I'm not sure that this calculation is completely
> > > accurate. And it is strange there doesn't seem to be any libfdt
> > > function for this already. It would be simpler to just add some fixed
> > > additional amount.
> > > 
> > > Maybe David G has comments on this?
> 
> I'm not quit sure why it's not that accurate, but as I said in a reply to
> David's comment, I will take your suggestion.

I think it is accurate, but it is not robust.  It might not be
accurate if we ever make further tweaks to the libfdt format.  libfdt
is supposed to abstract those changes away, but if you make
assumptions like this, you break that abstraction.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/2cdcd3fd/attachment.sig>
