From: davem@davemloft.net (David Miller)
Date: Fri, 11 Apr 2014 14:19:11 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CA+55aFwPR1XLRKiYya5wwxwbdnA_qiB4fZPL0i7+L4mpmzk5qA@mail.gmail.com>
References: <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140411.140213.521479030434404328.davem@davemloft.net>
 <CA+55aFwPR1XLRKiYya5wwxwbdnA_qiB4fZPL0i7+L4mpmzk5qA@mail.gmail.com>
Message-ID: <20140411.141911.2103972187575537634.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Apr 2014 11:11:33 -0700

> And quite frankly, using the "vma->vm_flags" sounds potentially
> *incorrect* to me, since it really isn't about the vma. If you change
> a page through a non-executable vma, you'd want to flush the icache
> entry for that page mapped in a totally different vma. So I really get
> the feeling that passing in "vma" is actively *wrong*. The vma
> interface really makes little to no sense.
> 
> Hmm?

The vm_flags check is about "could it have gotten into the I-cache
via this VMA".

If the VMA protections change, we'd do a flush of some sort during
that change.
