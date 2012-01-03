From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:59:58 +0000
Subject: Git pull request: shmobile fix for the vmalloc series
In-Reply-To: <alpine.LFD.2.02.1201022323090.2907@xanadu.home>
References: <alpine.LFD.2.02.1201022323090.2907@xanadu.home>
Message-ID: <20120103095958.GJ2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 11:34:21PM -0500, Nicolas Pitre wrote:
> Russell, please pull the following into your devel-stable branch:
> 
> 	git://git.linaro.org/people/nico/linux vmalloc
> 
> This contains a patch from Magnus Damm fixing the oversized DMA area 
> issue on shmobile, and a revert of the temporary and noisy workaround 
> (which is already in your devel-stable branch) that was needed because 
> of that issue.

Is there much point?  shmobile shows no sign of fixing their #error for
the restart changes (and haven't responded to any of my emails) - I
think we should be thinking about removing this -clearly- unmaintained
set of platforms.

So, it currently looks like I'm going to be pushing a #error for them
in during the next merge window.  I'd much rather just delete the
unmaintained code to avoid adding those evil things.
