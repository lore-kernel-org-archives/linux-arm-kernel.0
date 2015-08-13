From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 13 Aug 2015 09:28:35 -0700
Subject: enabling libgcc for 64-bit divisions, was Re: PROBLEM: XFS on ARM
 corruption 'Structure needs cl
In-Reply-To: <20150813061109.29409.qmail@ns.horizon.com>
References: <20150813061109.29409.qmail@ns.horizon.com>
Message-ID: <CA+55aFwgaq3KkeXGQWxmVHsNVwJUWK3WssJ5_ADpQG4zTXjWPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 11:11 PM, George Spelvin <linux@horizon.com> wrote:
>
> Agreed.  But some x86 code I'm working on now, I have a *lot* of
> asm("divl") calls because even do_div isn't great for 64/32->32 division.

Yeah.

I'm not convinced that "64/32->32" is all that generic, though.  If
the dividend in 64-bit, there's no fundamental type-based guarantee
that things will fit.

So your case is rather special, and depends (intimately) on knowing
the actual ranges and how they interact.

That's not a generic situation like "do_div()".

                  Linus
