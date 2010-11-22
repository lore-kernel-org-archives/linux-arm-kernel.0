From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 23:44:27 +0000
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional
	branches in head.S for Thumb-2.
In-Reply-To: <alpine.LFD.2.00.1011221512460.9313@xanadu.home>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-9-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011221346170.9313@xanadu.home>
	<20101122191719.GO31227@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011221512460.9313@xanadu.home>
Message-ID: <20101122234427.GP31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 03:24:11PM -0500, Nicolas Pitre wrote:
> On Mon, 22 Nov 2010, Russell King - ARM Linux wrote:
> > No, you're not thinking right.  It was _intentional_ that __error_p
> > ended up in a different section to __init.  With CPU hotplug, as it
> > is called from the hotplug CPU initialization path, it needs to be
> > available for that path to call.
> 
> Well... agreed for the hotplug CPU case.  The section selection is good 
> as it is for that.
> 
> However I doubt this was intentional when commit 75d90832d5 was created, 
> which is when the actual section move took place.

Well, T2 is not something I particularly test for.  There's already too
many combinations to test as it is.
