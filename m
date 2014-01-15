From: robherring2@gmail.com (Rob Herring)
Date: Wed, 15 Jan 2014 09:26:56 -0600
Subject: [RFC 0/2] Early patches to get rid of meminfo
In-Reply-To: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
References: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAL_JsqKfePTDKaDguubLtutNVbfY6QNdi1EVRA2YkbqTGP9=Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 11:55 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> Hi,
>
> With the move away from bootmem and the convergence on memblock, it seems
> like meminfo should be deprecated as well to avoid duplication. This is
> a first pass attempt to just use memblock and not have meminfo integrated.
> There is still a major issue in terms of actually specifying mem at location
> on the command line but I wanted to send this out for some early feedback
> before putting any more effort into this. I've done basic boot testing on
> a simple DT target.

Nice. One thing I would like to see done in this area is ARM using the
default early_init_dt_add_memory_arch function. It currently doesn't
because of the dependency on meminfo.

Rob
