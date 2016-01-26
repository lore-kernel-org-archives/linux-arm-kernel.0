From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 27 Jan 2016 09:38:05 +1100
Subject: Fwd: [robh:dt/next 2/2] fdt_ro.c:undefined reference to `strnlen'
In-Reply-To: <alpine.LFD.2.20.1601261636510.19789@knanqh.ubzr>
References: <201601270337.wm7hjDwR%fengguang.wu@intel.com>
 <CAL_JsqJ2C=OQa5ntYH3MLQ87+=ELHAtgFpg5QNQpQ0-RgzQeiw@mail.gmail.com>
 <alpine.LFD.2.20.1601261636510.19789@knanqh.ubzr>
Message-ID: <20160126223805.GE16692@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 04:52:18PM -0500, Nicolas Pitre wrote:
> On Tue, 26 Jan 2016, Rob Herring wrote:
> 
> > With the latest dtc I've imported to the kernel, there is a new
> > dependency on strnlen. This is giving the ARM decompressor an error. I
> > have a couple of ideas on how to fix it:
> > 
> > - Move string related functions in dtc to separate file
> > - Add lib/string.c to the decompressor build
> > - Build the decompressor with function-sections to discard the string
> > related functions and avoid the linker error. Also, there's probably a
> > bit of other unused code that would get dropped. function-sections
> > doesn't work for the kernel in general, but may for the decompressor.
> > Nico may know.
> 
> Use of function-sections turns out to be more involved than I wish. And 
> we've put many special restrictions on the decompressor already. And 
> linking dtc (only part of it actually) into the decompressor is only for 
> legacy stuff and I'd prefer we don't spend too much time on legacy 
> stuff.  Yadda yadda.
> 
> So instead I'd simply paste a simple implementation of strnlen into 
> arch/arm/boot/compressed/string.c and be done with it.  The one in 
> lib/string.c looks dead simple for what it's worth.

I think that would be my preferred option too.

> 
> > - Don't update dtc and take the rest of the day off.
> 
> That is always an option.  Does it really need to be updated?  ;-)
> 
> 
> Nicolas

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/52124933/attachment.sig>
