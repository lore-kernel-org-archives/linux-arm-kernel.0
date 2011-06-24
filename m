From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 Jun 2011 09:32:27 -0400 (EDT)
Subject: [PATCH v3 00/40] ARM: mm: Add generic macros for declaring
	various CPU structs
In-Reply-To: <20110624101054.GA2342@arm.com>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106231721270.2142@xanadu.home>
	<20110624101054.GA2342@arm.com>
Message-ID: <alpine.LFD.2.00.1106240921500.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Jun 2011, Dave Martin wrote:

> On Thu, Jun 23, 2011 at 07:44:44PM -0400, Nicolas Pitre wrote:
> > On Thu, 23 Jun 2011, Dave Martin wrote:
> > 
> > >   - This series introduces a few lines slightly longer than 80
> > >     characters.  I don't think that splitting these lines will
> > >     do a lot to help readability, but this can be done if
> > >     people prefer.
> > 
> > Please don't.
> 
> You mean "don't split", right?  (Not "don't introduce"?)

Don't split if there is no obvious readability gain.  Human judgement is 
necessary here which can't be substituted by checkpatch.pl.

> > mohawk_flush_icache_all:
> > 	mov	r0, #0
> > 	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
> > 	mov	pc, lr
> > 
> > The "mov r0, #0" is probably unnecessary, but this is a common pattern.
> 
> Thanks, merged locally.
> 
> OK if I add your S-o-B to that patch?

Sure.

> > >   Subject: ARM: mm: cache-fa: Use the new processor struct macros
> > >   Subject: ARM: mm: cache-v3: Use the new processor struct macros
> > >   Subject: ARM: mm: cache-v4: Use the new processor struct macros
> > > [...]
> > 
> > Something is wrong in your Git setup.  You have a spurious "Subject: " 
> > prefix everywhere.
> > 
> > >   Subject: ARM: mm: proc-feroceon: Use the new processor struct macros
> 
> Hmmm, I had some scripts sqashing this down from a local 106-patch series.
> I guess my logic for pasting subject lines into the merged patches went
> wrong somewhere.  I was pretty much a zombie by that stage...

:-)

Alternatively, using 'git rebase -i' and its squash and or fold commands 
(which can be abbreviated to the first letter) is pretty handy.  Might 
save you the time to write the script in the first place.


Nicolas
