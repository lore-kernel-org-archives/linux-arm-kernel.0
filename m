From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Oct 2011 08:35:47 +0100
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <4E9E0B71.9020708@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
Message-ID: <20111019073547.GR21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 04:27:45PM -0700, Tim Bird wrote:
> I'm about to submit a set of patches (really pretty small)
> to add 4K stack support to ARM (defaulted to 'N').
> 
> This has been kicking around in my Sony tree for a few years,
> and it's about time to mainline it.  The first patch is
> the actual 4KSTACKS patch.  See subsequent patches
> for tools to help with stack reduction to avoid the problems
> that apparently led to the removal of this feature on x86.

This isn't a good idea - if the feature has been abandoned on x86,
people aren't going to be soo concerned about the stack usage of
each function.  They're going to accept that there's more stack
space available, and we'll see code paths that start expecting that.

If we switch to 4K stacks, the problems of stack usage become ours.
Do we have the capacity to be able to address these issues as they
crop up?
