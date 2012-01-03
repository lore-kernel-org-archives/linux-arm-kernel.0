From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 15:32:03 +0000
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
In-Reply-To: <2101657.NNXDtBpq3c@myhost>
References: <1325065882.1584.153.camel@skywanderer.emcraft.com>
 <20120103110337.GM2914@n2100.arm.linux.org.uk> <2101657.NNXDtBpq3c@myhost>
Message-ID: <20120103153203.GV2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 03:21:03PM +0400, Alexander Potashev wrote:
> Hi Russell,
> 
> On 3 ?????? 2012 11:03:37 Russell King - ARM Linux wrote:
> > I notice that you sent me a very similar email on 24th December, which I
> > haven't responded to yet: given that it's the Christmas period, and
> > people take holidays, I think you're being a little hasty over your
> > resending.
> 
> The reason why I have re-sent the message to the mailing list was that I 
> feeled like this discussion should be public, not just that I was bored 
> waiting for the response.
> 
> Anyway, sorry for the noise.
> 
> > In any case, yes, I can change it.  However, as has already been
> > pointed out, we're moving over to using device tree as the primary form
> > of platform differentiation.  With device tree, machine type numbers
> > are completely meaningless (and aren't actually used by the kernel.)
> 
> Thanks in advance for fixing the entry!
> 
> > While I will fix the entry, I suspect that Arnd will now refuse to
> > merge any new SoC support for mainline which is not using the device
> > tree.
> 
> Linux kernel development in our company is still based on the 2.6.33 version 
> of the kernel. Most of our code is not going to be sent upstream. We will 
> probably think about FDT when upgrading to a newer version of the kernel.

I think it may help your case to point out that this is a uclinux platform,
being Cortex M4 based, rather than a mmu-ful platform.  While much of the
DT progress has been focused on mmu-ful platforms, much of this should just
work for DT with uclinux.

However, I suspect there may be issues such as how to provide the kernel
with a DT blob which would need to be addressed which would make this
non-trivial.

There's also the issue whether DT on uclinux makes sense as these
platforms are normally highly focussed and highly embedded (and it
really doesn't make that much sense to have a single kernel image
running on all.)
