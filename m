From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 31 Oct 2013 15:43:11 -0700
Subject: [PATCH] scripts/kallsyms: filter symbols not in kernel address
 space
In-Reply-To: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
References: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20131031154311.e65d16d79ba540ced736413b@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Oct 2013 23:48:59 +0800 Ming Lei <tom.leiming@gmail.com> wrote:

> This patch uses CONFIG_PAGE_OFFSET to filter symbols which
> are not in kernel address space because these symbols are
> generally for generating code purpose and can't be run at
> kernel mode, so we needn't keep them in /proc/kallsyms.
> 
> For example, on ARM there are some symbols which are
> linked in relocatable code section, then perf can't parse
> symbols any more from /proc/kallsyms, and this patch fixes
> the problem.

This is a non-back-compatible change and I'd like to see a much
stronger assurance that it is safe to merge and will not break any
existing application on the planet, please.

For a start, please describe with great precision what these excluded
symbols are (examples would help) and explain why no application will
conceivably have had any use for them.
