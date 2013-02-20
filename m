From: david.woodhouse@intel.com (Woodhouse, David)
Date: Wed, 20 Feb 2013 14:53:30 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
References: <20130129181046.GC25415@pd.tnic>
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
 <1361356696.13482.269.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200835380.6419@syhkavp.arg>
 <1361367842.13482.279.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
Message-ID: <1361372008.13482.280.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-02-20 at 09:06 -0500, Nicolas Pitre wrote:
> On Wed, 20 Feb 2013, Woodhouse, David wrote:
> 
> > On Wed, 2013-02-20 at 08:36 -0500, Nicolas Pitre wrote:
> > > You'll have the same issue wrt the above whether or not the source
> > > file is C or assembly.
> > 
> > Hm, true. I was thinking of the code itself (which is
> > position-independent anyway), rather than the flags in the object file.
> > 
> > So just ship a .S file and for the decompressor (if we need it at all)
> > rebuild it just the same as we do the *other* libgcc code like ashldi3.S
> > etc.
> 
> ... in which case there is no harm shipping a .c file and trivially 
> enforcing -O2, the rest being equal.

For today's compilers, unless the wind changes.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/89f55b17/attachment-0001.bin>
