From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 18:27:06 +0200
Subject: [PATCHv16 0/9] Contiguous Memory Allocator
In-Reply-To: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201110071827.06366.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 October 2011, Marek Szyprowski wrote:
> Once again I decided to post an updated version of the Contiguous Memory
> Allocator patches.
> 
> This version provides mainly a bugfix for a very rare issue that might
> have changed migration type of the CMA page blocks resulting in dropping
> CMA features from the affected page block and causing memory allocation
> to fail. Also the issue reported by Dave Hansen has been fixed.
> 
> This version also introduces basic support for x86 architecture, what
> allows wide testing on KVM/QEMU emulators and all common x86 boxes. I
> hope this will result in wider testing, comments and easier merging to
> mainline.

Hi Marek,

I think we need to finally get this into linux-next now, to get some
broader testing. Having the x86 patch definitely helps here becauses
it potentially exposes the code to many more testers.

IMHO it would be good to merge the entire series into 3.2, since
the ARM portion fixes an important bug (double mapping of memory
ranges with conflicting attributes) that we've lived with for far
too long, but it really depends on how everyone sees the risk
for regressions here. If something breaks in unfixable ways before
the 3.2 release, we can always revert the patches and have another
try later.

It's also not clear how we should merge it. Ideally the first bunch
would go through linux-mm, and the architecture specific patches
through the respective architecture trees, but there is an obvious
inderdependency between these sets.

Russell, Andrew, are you both comfortable with putting the entire
set into linux-mm to solve this? Do you see this as 3.2 or rather
as 3.3 material?

	Arnd
