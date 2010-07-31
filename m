From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 Jul 2010 11:37:55 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <2d92bd7e819dd81e2f64d358918711d3.squirrel@www.codeaurora.org>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007302359.08188.arnd@arndb.de>
	<2d92bd7e819dd81e2f64d358918711d3.squirrel@www.codeaurora.org>
Message-ID: <201007311137.55826.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 July 2010 00:58:00 stepanm at codeaurora.org wrote:
> > If you really need multiple domains across multiple IOMMUs, I'd suggest that
> > we first merge the APIs and then port your code to that, but as a first step
> > you could implement the standard dma-mapping.h API, which allows you to use
> > the IOMMUs in kernel space.
> 
> One of our uses cases actually does involve using domains pretty much as
> you had described them, though only on one of the IOMMUs. That is, the
> domain for that IOMMU basically abstracts its page table, and it is a
> legitimate thing to switch out page tables for the IOMMU on the fly. I
> guess the difference is that you described the domain as the set of
> mappings made on ALL the IOMMUs, whereas I had envisioned there being one
> (or more) domains for each IOMMU.

Can you be more specific on what kind of device would use multiple domains
in your case and how you intend to use them? Is this for some kind of DSP
interacting with user processes?

This seems to be a scenario that we haven't dealt with before (or perhaps
avoided intentionally), so if we need to make API changes, we should all
understand what we need them for. It's no problem to extend the API if you
have good reasons for using multiple domains, but I also want to make sure
that there isn't also a way to achieve the same or better result with the
current APIs.

	Arnd
