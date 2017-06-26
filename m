From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jun 2017 13:08:14 +0100
Subject: [PATCH 1/1] futex: remove duplicated code and fix UB
In-Reply-To: <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
References: <20170621115318.2781-1-jslaby@suse.cz>
 <alpine.DEB.2.20.1706230017520.2221@nanos>
 <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
Message-ID: <20170626120814.GF1691@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 02:02:31PM +0200, Jiri Slaby wrote:
> On 06/23/2017, 09:51 AM, Thomas Gleixner wrote:
> > On Wed, 21 Jun 2017, Jiri Slaby wrote:
> >> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> >> index f32b42e8725d..5bb2fd4674e7 100644
> >> --- a/arch/arm64/include/asm/futex.h
> >> +++ b/arch/arm64/include/asm/futex.h
> >> @@ -48,20 +48,10 @@ do {									\
> >>  } while (0)
> >>  
> >>  static inline int
> >> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > 
> > That unsigned int seems to be a change from the arm64 tree in next. It's
> > not upstream and it'll cause a (easy to resolve) conflict.
> 
> Ugh, I thought the arm64 is in upstream already. Note that this patch
> just takes what is in this arm64 fix and makes it effective for all
> architectures. So I will wait with v2 until it merges upstream.
> 
> So, Will, will you incorporate Thomas' comments into your arm64 fix?

I wasn't planning to (it's already queued and I think they're just cosmetic
changes). The easiest thing is probably for you to make the changes in the
generic version when you post v2.

Will
