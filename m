From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 10:23:46 +0100
Subject: [PATCH v2 09/10] arm64,ia64,ppc,s390,sh,tile,um,x86,mm: Remove
 default gate area
In-Reply-To: <e1656ab2adfd1891f62610abe3e85ad992ee0cbf.1404164803.git.luto@amacapital.net>
References: <cover.1404164803.git.luto@amacapital.net>
 <e1656ab2adfd1891f62610abe3e85ad992ee0cbf.1404164803.git.luto@amacapital.net>
Message-ID: <20140701092345.GH28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:53:20PM +0100, Andy Lutomirski wrote:
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

For the arm64 bit:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
