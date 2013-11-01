From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 1 Nov 2013 10:10:37 +0800
Subject: [PATCH] scripts/kallsyms: filter symbols not in kernel address
 space
In-Reply-To: <20131031154311.e65d16d79ba540ced736413b@linux-foundation.org>
References: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
 <20131031154311.e65d16d79ba540ced736413b@linux-foundation.org>
Message-ID: <CACVXFVMJmQJd0cFaZcmZZvFpUQUmTPJRj87QBVr0kbgZxjq8dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Thanks for your comment.

On Fri, Nov 1, 2013 at 6:43 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> For a start, please describe with great precision what these excluded
> symbols are (examples would help) and explain why no application will
> conceivably have had any use for them.

Looks Russell has given the example symbols already, and all these
symbols should be only for generating code, and they won't be run by
kernel since kernel can't run code which isn't in kernel virtual address
space, so there is no reason for application to use these symbols.

Actually, there is already report on the problem, see below link:

http://www.gossamer-threads.com/lists/linux/kernel/1808193?page=last

> OK.  Do you recall which patch that was?  And is it the case that this
> patch excludes only the symbols which that patch accidentally added?

This patch excludes all kernel symbols(non-module symbols) which
aren't in kernel virtual address space, I think it is reasonable and correct.


Thanks,
-- 
Ming Lei
