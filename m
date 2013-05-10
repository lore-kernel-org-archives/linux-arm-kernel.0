From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 May 2013 09:40:00 +0100
Subject: [PATCH v2] ARM v6/v7 cmpxchg64 shouldn't clear upper 32 bits of
 the old/new value
In-Reply-To: <20130508165500.GH20820@mudshark.cambridge.arm.com>
References: <20130508143004.GA20820@mudshark.cambridge.arm.com>
 <1368025614-17820-1-git-send-email-jaccon.bastiaansen@gmail.com>
 <20130508165500.GH20820@mudshark.cambridge.arm.com>
Message-ID: <20130510084000.GA10492@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaccon,

On Wed, May 08, 2013 at 05:55:00PM +0100, Will Deacon wrote:
> On Wed, May 08, 2013 at 04:06:54PM +0100, Jaccon Bastiaansen wrote:
> > The implementation of cmpxchg64() for the ARM v6 and v7 architecture
> > casts parameter 2 and 3 (the old and new 64bit values) to an unsigned
> > long before calling the atomic_cmpxchg64() function. This clears
> > the top 32 bits of the old and new values, resulting in the wrong
> > values being compare-exchanged.
> > 
> > This bug is introduced by commit 3e0f5a15f500 (ARM: 7404/1: cmpxchg64: use atomic64
> 
> Best to line-wrap this at 76 chars.
> 
> > and local64 routines for cmpxchg64)
> > 
> > Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> 
> Please add the following above your S-o-B:
> 
>   Cc: <stable@vger.kernel.org>
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Then below your S-o-B, add:
> 
>   KernelVersion: 3.9
> 
> and send the patch to patches at arm.linux.org.uk

Did you manage to do this? I can't see anything pending or queued in rmk's
tree...

Cheers,

Will
