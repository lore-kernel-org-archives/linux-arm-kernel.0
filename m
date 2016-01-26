From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 26 Jan 2016 15:45:23 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160126232921.GY4503@linux.vnet.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
 <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
 <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
 <20160126232921.GY4503@linux.vnet.ibm.com>
Message-ID: <CA+55aFyD94yaA1QzXgfeO18T-czY3TVUi5n6r-9jOUObDeR-zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 3:29 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> No trailing data-dependent read, so agreed, no smp_read_barrier_depends()
> needed.  That said, I believe that we should encourage rcu_dereference*()
> or lockless_dereference() instead of READ_ONCE() for documentation
> reasons, though.

I agree that that is likely the right thing to do in pretty much all situations.

In theory, there might be performance situations where we'd want to
actively avoid the smp_read_barrier_depends() inherent in those, but
considering that it's only a performance issue on alpha, and we
probably have all of two or three people using Linux on alpha, it's a
pretty theoretical performance worry.

                  Linus
