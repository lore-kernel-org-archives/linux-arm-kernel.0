From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Fri, 21 Jul 2017 12:29:45 +0900
Subject: [lkp-robot] [include/linux/string.h] 6974f0c455:
 kernel_BUG_at_lib/string.c
In-Reply-To: <CA+55aFyeM9+1mQyyS8GN-b2JMVkdMxzyVG_8ajvHYm_W3XwV=w@mail.gmail.com>
References: <20170720014238.GH27396@yexl-desktop>
 <CA+55aFwuebKQ0-sAiRJWpMcaVJ8MjXvCg56DO5q8jMiPDXvc8A@mail.gmail.com>
 <20170721005140.ebf6d119bb30cc6cfe12ae61@kernel.org>
 <CA+55aFyeM9+1mQyyS8GN-b2JMVkdMxzyVG_8ajvHYm_W3XwV=w@mail.gmail.com>
Message-ID: <20170721122945.132d570c35f90c3abc011b08@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jul 2017 11:41:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jul 20, 2017 at 8:51 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Ok, I committed that patch as-is.
> 
> Other architectures may end up with the same issue, unless they really
> happen to have just a single instruction that fits in their
> kprobe_opcode_t type in their templates. But I didn't touch any of
> their (similar) code, since it will need testing.

Similar optprobe code are in arm and powerpc, arm does not support
FORTIFY_SOURCE (yet), and powerpc already fixed that same way.
So I'll make a same fix on arm before traped to the same issue.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
