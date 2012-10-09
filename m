From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 08 Oct 2012 22:18:24 -0400 (EDT)
Subject: Single zImage and A15/LPAE
In-Reply-To: <50735B75.8070109@wwwdotorg.org>
References: <50735B75.8070109@wwwdotorg.org>
Message-ID: <alpine.LFD.2.02.1210082201470.16518@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2012, Stephen Warren wrote:

> I'm curious what the single-zImage story is for Cortex A15 CPUs with
> LPAE extensions; IIRC, LPAE entails a different page table format and so
> isn't going to co-exist in the same zImage as non-LPAE

LPAE vs non LPAE is an even more invasive change than ARMv6+ vs pre 
ARMv6 support.  So no, I don't think we'll ever support LPAE and non 
LPAE configs in the same kernel binary.

> (although doesn't x86 support that now; I though separate 
> LPAE/non-LPAE kernels went away there?)

I don't think so.  At least Ubuntu apparently still carries a PAE and 
non PAE kernel packages.  Fedora doesn't, probably because they decided 
not to support non PAE capable machines anymore.  We certainly cannot 
make this choice on ARM yet.

> Presumably though, the intent is to be able to disable LPAE in Kconfig,
> and create a single zImage with both A9 and A15 support, or to enable
> LPAE and only support A15 with LPAE, and which you'd choose to do simply
> depends on whether you care about LPAE based on how much RAM the boards
> you want to support have (or perhaps also what physical address your
> peripherals are at)?

Yes.


Nicolas
