From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 05 Mar 2015 10:56:20 +1100
Subject: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
In-Reply-To: <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-5-git-send-email-keescook@chromium.org>
 <1425442601.9084.9.camel@ellerman.id.au>
 <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
Message-ID: <1425513380.32154.13.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-04 at 13:13 -0800, Kees Cook wrote:
> 
> I had a question in the powerpc-specific change that may have gone unnoticed:
> 
> Can mmap ASLR be safely enabled in the legacy mmap case here? Other archs
> use "mm->mmap_base = TASK_UNMAPPED_BASE + random_factor".
> 
> Separate from this series, do you happen to know if this improvement
> can be made, or if the legacy mmap on powerpc can't handle this?

Yeah I saw that. The short answer is I'm not sure.

I assume we have that distinction for some good reason, but whether we still
need it I don't know. I'll dig a bit and see if anyone can remember the details.

cheers
