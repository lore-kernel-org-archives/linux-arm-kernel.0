From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Oct 2015 11:58:25 +0000
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call
 into nop
In-Reply-To: <20151028041619.4e44491a@grimm.local.home>
References: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
 <20151028041619.4e44491a@grimm.local.home>
Message-ID: <20151028115825.GB29512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 04:16:19AM -0400, Steven Rostedt wrote:
> On Wed, 28 Oct 2015 16:04:05 +0800
> Li Bin <huawei.libin@huawei.com> wrote:
> 
> > By now, the recordmcount only records the function that in
> > following sections:
> > .text/.ref.text/.sched.text/.spinlock.text/.irqentry.text/
> > .kprobes.text/.text.unlikely
> > 
> > For the function that not in these sections, the call mcount
> > will be in place and not be replaced when kernel boot up. And
> > it will bring performance overhead, such as do_mem_abort (in
> > .exception.text section). This patch make the call mcount to
> > nop for this case in recordmcount.
> 
> I can take this in my tree with an Ack from the ARM64 maintainers.

Looks like it does what it says on the tin:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
