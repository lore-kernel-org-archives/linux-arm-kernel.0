From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Feb 2013 16:57:34 -0500 (EST)
Subject: [PATCH 12/17] ARM: fix magic for bootloader in BE8
In-Reply-To: <511943CD.6010305@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-13-git-send-email-ben.dooks@codethink.co.uk>
 <alpine.LFD.2.02.1302082304410.6300@xanadu.home>
 <511943CD.6010305@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1302121654080.1242@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Feb 2013, Ben Dooks wrote:

> On 09/02/13 04:06, Nicolas Pitre wrote:
> > On Fri, 8 Feb 2013, Ben Dooks wrote:
> > 
> > > If the boot-loader is running little endian and the kernel is compiled
> > > big endian then it will not verify the magic number of the front of the
> > > kernel.
> > > 
> > > Note, do we need to also reverse the two values after the magic, or are
> > > they used later on in the kernel decompressor?
> > 
> > Those value instances are not used by the code.  So for consistency they
> > would have to be reversed, yes.  Given those are variable and determined
> > by the linker, I don't know how you could manage it.
> 
> By breaking it down into parts I think...
> 
> I think this patch should be re-worked depending on the outcome of
> re-doing the whole ATAG endian configuration so that these are in
> the same endian-ness as we expect the ATAGs to be in.

I don't think this is related to ATAGS at all.

Those values are making a header for bootloaders to use in identifying 
an ARM Linux zImage binary.  If you want to boot from a LE environment, 
the header must look like if this is a LE kernel.


Nicolas
