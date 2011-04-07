From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Apr 2011 23:04:07 +0100
Subject: howto set some kernel pages to readonly?
In-Reply-To: <201104072026.37303.pwaechtler@mac.com>
References: <201104072026.37303.pwaechtler@mac.com>
Message-ID: <20110407220407.GC17049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2011 at 08:26:36PM +0200, Peter W?chtler wrote:
> Hello Linux ARM developers,
> 
> on Linux x86 there is infrastructure to set rodata to, aeh, readonly. ;)
> 
> I also want to protect some pages to readonly  as a guard.
> So if some kernel code writes to the memory the kernel panics.
> 
> I tried the following without success:
> 
> And I have to admit that I don't understand all the macros for 
> manipulating the page table entries ;(
> Any clue what's wrong?

We don't map kernel space using pages, but section mappings which have a
granularity of 1MB.

That makes it difficult to set read-only status on just small areas of
memory because you'd have to ensure that the .rodata starts at a 1MB
boundary, and the following data also starts at a 1MB boundary - which
would be quite wasteful.
