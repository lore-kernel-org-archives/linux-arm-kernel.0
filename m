From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 30 Mar 2010 00:41:24 +0100
Subject: [RFC 07/10] arm: allow passing an ELF64 header to elf_check_arch()
In-Reply-To: <01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100329234124.GF9876@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg wrote:
> This is needed to shut following compiler warning when CONFIG_PROC_VMCORE is
> enabled:
> 
> fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
> fs/proc/vmcore.c:500: warning: passing argument 1 of 'elf_check_arch' from
> incompatible pointer type
> 
> ELF32 and ELF64 headers have common fields of same size (namely e_ident and
> e_machine) which are checked in arm_elf_check_arch().

Wouldn't it be better to just disable the elf64 code entirely on
32-bit archs, saving about half of the code size in vmcore.c which
looks like it will never be called?

-- Jamie
