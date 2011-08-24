From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 12:13:28 +0100
Subject: [PATCH v4 2/8] ARM: kexec: ensure new kernel is entered in ARM
	state
In-Reply-To: <alpine.LFD.2.00.1108232126550.20358@xanadu.home>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<1314136012-20533-3-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232126550.20358@xanadu.home>
Message-ID: <20110824111327.GI32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 02:28:12AM +0100, Nicolas Pitre wrote:
> On Tue, 23 Aug 2011, Will Deacon wrote:
> 
> > Commit 540b5738 ("ARM: 6999/1: head, zImage: Always Enter the kernel in
> > ARM state") mandates that the kernel should be entered in ARM state.
> > 
> > If a Thumb-2 kernel kexecs a new kernel image, we need to ensure that
> > we change state when branching to the new code. This patch replaces a
> > mov pc, lr with a bx lr so that we transition to ARM state if need be.
> 
> This will break kexec support on ARMv4 targets.  No idea if any ARMv4 
> target uses kexec though.

It's easy enough to sort out though, so I may as well fix the code in case
anybody wants to try kexec on ARMv4!

Thanks,

Will
