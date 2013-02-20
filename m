From: david.woodhouse@intel.com (Woodhouse, David)
Date: Wed, 20 Feb 2013 10:38:18 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
References: <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
 <20130201011712.GF23505@n2100.arm.linux.org.uk>
 <1359703995.23531.6.camel@shinybook.infradead.org>
 <20130205210436.670c62e26d2121330e87af35@freescale.com>
 <1360141322.6066.4.camel@shinybook.infradead.org>
 <20130206191905.ac8eb6743e69425f30888704@freescale.com>
 <20130207181315.GM17833@n2100.arm.linux.org.uk>
 <1360344301.6066.263.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081503430.6300@xanadu.home>
 <1360363233.6066.283.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081745500.6300@xanadu.home>
 <20130208191208.2ef3d78bda71aa7b44d00d7b@freescale.com>
 <alpine.LFD.2.02.1302082102380.6300@xanadu.home>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
 <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
Message-ID: <1361356696.13482.269.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-19 at 22:17 -0500, Nicolas Pitre wrote:
> 
> > +$(obj)/bswapsdi2.o: $(obj)/../../../../arch/$(SRCARCH)/lib/bswapsdi2.o
> > +     $(call cmd,shipped)
> > +
> 
> I don't think you can get away with this.  The decompressor code is 
> compiled with -fpic and the main kernel is not.  Most toolchains do mark 
> object files with some flags to prevent the link of incompatible objects 
> together (normally pic and non pic objects are not compatible even if in 
> this very simple case that would not matter).  Maybe you are able to 
> link zImage successfully simply because no references to __bswap* needed 
> to be resolved and therefore the linker didn't need to search/include 
> that object?

This, and the issue with -Os vs. -O2, make me inclined to suggest that
we should just provide an asm version of these functions instead of
using the compiler.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6242 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/7c864f83/attachment-0001.bin>
