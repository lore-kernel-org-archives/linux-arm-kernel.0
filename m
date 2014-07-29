From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 29 Jul 2014 12:19:16 +1000
Subject: [PATCH v4] arm64, ia64, ppc, s390, sh, tile, um, x86, mm:
 Remove default gate area
In-Reply-To: <6435254cc74d6e9172931f27be3854d522ad299b.1406232860.git.luto@amacapital.net>
References: <6435254cc74d6e9172931f27be3854d522ad299b.1406232860.git.luto@amacapital.net>
Message-ID: <1406600356.11977.4.camel@concordia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-07-24 at 13:56 -0700, Andy Lutomirski wrote:
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

Looks good to me. Booted and everything seems happy, I still have a vdso etc.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)

cheers
