From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Oct 2012 10:18:29 +0100
Subject: [PATCH] [ARM] Use AT() in the linker script to create correct
 program headers
In-Reply-To: <20121009173706.GE4124@obsidianresearch.com>
References: <20120930232116.GC30637@obsidianresearch.com>
 <20121001153952.GB2100@linaro.org>
 <20121001160639.GA31620@obsidianresearch.com>
 <20121005084500.GI4625@n2100.arm.linux.org.uk>
 <20121008102413.GC2302@linaro.org>
 <20121009173706.GE4124@obsidianresearch.com>
Message-ID: <20121010091829.GA2131@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 11:37:06AM -0600, Jason Gunthorpe wrote:
> On Mon, Oct 08, 2012 at 11:24:13AM +0100, Dave Martin wrote:
> 
> > Partly this came from some side speculation about whether we could do
> > things like privileged read-only permissions on newer CPUs, for preventing
> > unintended or undesired writes to the kernel's code or read-only data.
> 
> Some other arches page protect the kernel, but that tends to be at
> odds with the desire to use huge pages for the kernel mapping, and
> independent of the load headers..

This wasn't so much about that headers themselves as about fragmentation
of the page permissions which makes it difficult to map everything using
huge pages / sections.  But as you say, there are conflicting concerns
here, and it seems not to be a priority.

Privileged write-protect is nice to have if non-disruptive, but not
essential.

Cheers
---Dave
