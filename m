From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 10 Oct 2018 11:30:16 +1100
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
In-Reply-To: <bd3d0472-1bd7-52ed-b9f6-b5edae8c8b6d@gmail.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
 <20181005050627.GL32578@linaro.org>
 <bd3d0472-1bd7-52ed-b9f6-b5edae8c8b6d@gmail.com>
Message-ID: <20181010003016.GH7004@umbus.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 11:02:29AM -0700, Frank Rowand wrote:
> On 10/04/18 22:06, AKASHI, Takahiro wrote:
[snip]
> >>>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> >>>> +                                               u64 addr, u64 size)
> >>>> +{
> >>>> +       int addr_cells, size_cells;
> >>
> >> unsigned
> > 
> > fdt_[address|size]_cell() returns an int.
> 
> I stand corrected.  They take advantage of the fact that valid values
> are in the range 0..4 and return a negative value for error.

I'm not sure if the spec formally defines that these values will fit
in a positive 'int'.  But if addresses are 8GiB each, you're going to
have much bigger problems putting it in a device tree than this
function.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/6840e7e7/attachment.sig>
