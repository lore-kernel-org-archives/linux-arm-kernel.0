From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Apr 2015 16:07:57 +0100
Subject: [PATCH] ARM: alignment: Use is_wide_instruction() to check wide
 instruction
In-Reply-To: <1428936444.7514.66.camel@mtksdaap41>
References: <1428674741-5409-1-git-send-email-yingjoe.chen@mediatek.com>
 <20150413124832.GA15504@e103592.cambridge.arm.com>
 <1428936444.7514.66.camel@mtksdaap41>
Message-ID: <20150413150757.GB15504@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 10:47:24PM +0800, Yingjoe Chen wrote:
> On Mon, 2015-04-13 at 13:48 +0100, Dave Martin wrote:
> > On Fri, Apr 10, 2015 at 10:05:41PM +0800, Yingjoe Chen wrote:
> > > 
> > > I first notice the comment is incorrect, then I realize there's another
> > > macro which do exactly the same thing.
> > > Tested with hand written userspace program with a few wide instructions
> > > to make sure this still work as expect.
> > > 
> > > 8<-------------------------------------------------
> > > do_alignment() is using locally added IS_T32() macro to check if an
> > > instruction is a Thumb-2 32 bit instruction. The macro
> > > is_wide_instruction() is doing the same thing, with slightly faster
> > > implementation.
> > > Change to use is_wide_instruction() in do_alignment() and remove
> > > IS_T32().
> > 
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > The existing code is correct, but the comment is indeed wrong.
> > Consolidating this with one of the other existing macros makes sense.
> > 
> > 
> > !__opcode_is_thumb16() could also be used here (or is_wide_instruction()
> > redefined in terms of it), but that's not essential.
> 
> Hi Dave,
> 
> Thanks for your review.
> 
> I did notice there are __opcode_is_thumb16/32. They need to handle
> 32bits instruction instead of 16bits only for is_wide_instruction, so I
> think using same implementation for them is a different story.
> 
> Joe.C

No worries.  It can be tidied up some more later if someone finds a good
reason for it.

Cheers
---Dave
