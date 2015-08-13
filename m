From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 13 Aug 2015 11:26:30 -0700
Subject: enabling libgcc for 64-bit divisions, was Re: PROBLEM: XFS on ARM
 corruption 'Structure needs cl
In-Reply-To: <20150813181841.10342.qmail@ns.horizon.com>
References: <CA+55aFwgaq3KkeXGQWxmVHsNVwJUWK3WssJ5_ADpQG4zTXjWPQ@mail.gmail.com>
 <20150813181841.10342.qmail@ns.horizon.com>
Message-ID: <CA+55aFw9-sN0nHn-ohdhSEt9i-mUjXN3fBj+dXLg56jgsOwgDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 11:18 AM, George Spelvin <linux@horizon.com> wrote:
>
> On x86, the case that msword >= divsor causes a divide exception
> (divide ba generalization of divide by zero), so it's tempting
> to do the same sort of "assume no trap and fix up in the handler"
> trick as <asm/uaccess.h>.

That would be horrible. One of the reasonably common cases of do_div()
is for printing out numbers. And they are often in the 4G+ range..

> One function that would cover a significant number of use cases
> (but not all, damn it) would be
>
> rem = do_mul_div(x, mul,_div)

Yes. That might be worth introducing. Not to replace do_div(), but as
a "32-bit only" interface to a somewhat common situation.

                Linus
