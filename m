From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 12 May 2017 08:57:33 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAGXu5j+EatK=DYONRkgovwLgytAnbG8jnAZaMSLckZFNVj3gig@mail.gmail.com>
References: <20170508075209.7aluvpwildw325rf@gmail.com>
 <1494256932.1167.1.camel@gmail.com>
 <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
 <20170509065619.wmqa6z6w3n6xpvrw@gmail.com>
 <20170509111007.GA14702@kroah.com>
 <CAJcbSZFswDWZoK-1UK+xkRMJ4ttSYbtH2Y5WD5_aPR-8ru6t8A@mail.gmail.com>
 <CAJcbSZEoRyewUtBHvqmNZL9FtT_q42Vmmd-EuC50x-ZRASiHHg@mail.gmail.com>
 <CA+55aFwvQfs_X+paQF6Luc0Rq+W3J2fKuHRou7=ANcquDdXdDA@mail.gmail.com>
 <20170512072802.5a686f23@mschwideX1>
 <CAGXu5j+EatK=DYONRkgovwLgytAnbG8jnAZaMSLckZFNVj3gig@mail.gmail.com>
Message-ID: <20170512065733.yukc7kqpgyhbtwjz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> > git commit b5a882fcf146c87cb6b67c6df353e1c042b8773d
> > "s390: restore address space when returning to user space".
> 
> If I'm understanding this, it won't catch corruption of addr_limit
> during fast-path syscalls, though (i.e. addr_limit changed without a
> call to set_fs()). :(

Nor does it, or the patch you propose, protect against against something 
corrupting task->mm pointer, or the task->*uid values, or any of the myriads of 
security relevant values stored in the task structure!

Making sure API (set_fs()) usage is bug-free and protecting against the effects of 
general data corruption are two unrelated things that should not mixed.

Thanks,

	Ingo
