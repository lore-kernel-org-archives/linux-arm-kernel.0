From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 24 Jun 2011 14:54:33 +0100
Subject: [PATCH v3 00/40] ARM: mm: Add generic macros for declaring
	various CPU structs
In-Reply-To: <alpine.LFD.2.00.1106240921500.2142@xanadu.home>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106231721270.2142@xanadu.home>
	<20110624101054.GA2342@arm.com>
	<alpine.LFD.2.00.1106240921500.2142@xanadu.home>
Message-ID: <20110624135433.GB2342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 09:32:27AM -0400, Nicolas Pitre wrote:

[...]

> Don't split if there is no obvious readability gain.  Human judgement is 
> necessary here which can't be substituted by checkpatch.pl.

That's what I thought; just wanted to check I'd understood correctly.

> 
> > > mohawk_flush_icache_all:
> > > 	mov	r0, #0
> > > 	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
> > > 	mov	pc, lr
> > > 
> > > The "mov r0, #0" is probably unnecessary, but this is a common pattern.
> > 
> > Thanks, merged locally.
> > 
> > OK if I add your S-o-B to that patch?

Done.  Thanks for the code.

[...]

> Alternatively, using 'git rebase -i' and its squash and or fold commands 
> (which can be abbreviated to the first letter) is pretty handy.  Might 
> save you the time to write the script in the first place.

I have just been "educated" on this point by someone else too -- autosquash
would have suited my purposes exactly in this case ... I'll definitely
do that next time.  Always good to learn something new :)


The above fixes have been applied and pushed to the branch referenced
below.

This should get merged via Will's tree for the next merge window,
providing that Russell is happy and nobody else objects.

Cheers
---Dave

The changes since commit 56299378726d5f2ba8d3c8cbbd13cb280ba45e4f:

  Linux 3.0-rc4 (2011-06-20 20:25:46 -0700)

are available in the git repository at:
  git://git.linaro.org/people/dmart/linux-2.6-arm.git arm/proc-macros
