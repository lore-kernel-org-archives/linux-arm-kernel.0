From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 15 Jul 2014 07:47:26 -0700
Subject: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
In-Reply-To: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
Message-ID: <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> The core mm code will provide a default gate area based on
> FIXADDR_USER_START and FIXADDR_USER_END if
> !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
>
> This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
> 64-bit UML, and x86_32 have their own code just to disable it.  arm,
> 32-bit UML, and x86_64 have gate areas, but they have their own
> implementations.
>
> This gets rid of the default and moves the code into ia64.
>
> This should save some code on architectures without a gate area: it's
> now possible to inline the gate_area functions in the default case.

Can one of you pull this somewhere?  Otherwise I can put it somewhere
stable and ask for -next inclusion, but that seems like overkill for a
single patch.

--Andy
