From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Mar 2010 22:12:08 +0100
Subject: [RFC 07/10] arm: allow passing an ELF64 header to elf_check_arch()
In-Reply-To: <01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100329211208.GE28468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 12:26:33PM +0300, Mika Westerberg wrote:
> This is needed to shut following compiler warning when CONFIG_PROC_VMCORE is
> enabled:
> 
> fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
> fs/proc/vmcore.c:500: warning: passing argument 1 of 'elf_check_arch' from
> incompatible pointer type
> 
> ELF32 and ELF64 headers have common fields of same size (namely e_ident and
> e_machine) which are checked in arm_elf_check_arch().

A smaller patch:

-#define elf_check_arch elf_check_arch
+#define elf_check_arch(x) elf_check_arch((const struct elf32_hdr *)(x))
