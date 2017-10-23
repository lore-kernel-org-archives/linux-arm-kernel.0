From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Oct 2017 10:03:49 +0100
Subject: [PATCH 0/4] arm64: Changes to register and stack dumps
In-Reply-To: <f3e4cf91-6965-84e9-0e3a-39a1c24ab1ae@redhat.com>
References: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
 <f3e4cf91-6965-84e9-0e3a-39a1c24ab1ae@redhat.com>
Message-ID: <20171023090348.GA29937@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 03:53:50PM -0700, Laura Abbott wrote:
> On 10/19/2017 08:55 AM, Will Deacon wrote:
> > This handful of patches makes some significant changes to how we print
> > register/stack dumps and brings us inline with recent changes to x86.
> > The main changes are that we no longer print out the 'Exception stack:'
> > section and PC/LR values are resolved to a symbol+offset format where
> > possible.
> > 
> > Feedback welcome.
> > 
> 
> In very petty complaints, I can no longer just use the PC/LR with
> addr2line. Yes I can use gdb or one of the scripts but that's a
> few more steps when I'm doing debugging on my own. Like I said,
> very minor and overall this is good for both security and alignment.

Understood. scripts/faddr2line seems to do a reasonable job, but I agree
that it's a little annoying that you have to do some pointer arithmetic
if you want to e.g. locate disassembly in objdump. Setting KALLSYMS=n will
give you the addresses if you *really* want them.

> I ran this through several of the LKDTM tests and the backtraces
> looked fine. You're welcome to add
> 
> Tested-by: Laura Abbott <labbott@redhat.com>

Thanks, Laura.

Will
