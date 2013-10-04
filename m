From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Oct 2013 16:37:42 +0100
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <524E8FBC.2080200@asianux.com>
References: <5247A3FC.9020508@asianux.com>
 <20130930161149.GI26036@mudshark.cambridge.arm.com>
 <524A2DE7.8040208@asianux.com>
 <20131001090119.GA17629@mudshark.cambridge.arm.com>
 <524ABA20.6060106@asianux.com>
 <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com> <524D416B.5090709@asianux.com>
 <20131003163200.GE7408@mudshark.cambridge.arm.com>
 <524E8FBC.2080200@asianux.com>
Message-ID: <20131004153742.GR24303@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 10:51:56AM +0100, Chen Gang wrote:
> On 10/04/2013 12:32 AM, Will Deacon wrote:
> > The problem with arm64 is that we're using *unsigned long* for 32-bit
> > clear_mask, which is definitely wrong because it's 64-bit (another patch to
> > fix this!).
> > 
> 
> At least, that is not a bug.

Sure it is. What if the adjacent 32-bit value was being accessed by another
CPU under a spinlock?

Will
