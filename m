From: drew.richardson@arm.com (Drew Richardson)
Date: Thu, 6 Aug 2015 10:08:03 -0700
Subject: [PATCH] ARM: Mark ret_fast_syscall as a function
In-Reply-To: <1436877957-18127-1-git-send-email-drew.richardson@arm.com>
References: <1436877957-18127-1-git-send-email-drew.richardson@arm.com>
Message-ID: <20150806170758.GA26691@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 01:45:57PM +0100, Drew Richardson wrote:
> ret_fast_syscall runs when user space makes a syscall. However it
> needs to be marked as such so the ELF information is correct. Before
> it was:
> 
>    101: 8000f300     0 NOTYPE  LOCAL  DEFAULT    2 ret_fast_syscall
> 
> But with this change it correctly shows as:
> 
>    101: 8000f300    96 FUNC    LOCAL  DEFAULT    2 ret_fast_syscall
> 
> I see this function when using perf to unwind call stacks from kernel
> space to user space. Without this change I would need to add some
> special case logic when using the vmlinux ELF information.
> 
> Signed-off-by: Drew Richardson <drew.richardson@arm.com>

I haven't heard any further comments on this, did this get merged and
I just didn't notice? Or did I forget to add someone?

Thanks,

Drew
