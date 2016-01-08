From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 10:04:05 +0100
Subject: [PATCH v6 14/21] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1452209679-19445-15-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-15-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <4166007.lQt4DvC0e2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:32 Yury Norov wrote:
> +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> +                        unsigned long prot, unsigned long flags,
> +                        unsigned long fd, off_t off);
> +#define sys_mmap2                     sys_mmap
> 

Why do you need a separate declaration for sys_mmap here? There
is one in include/asm-generic/syscalls.h that should be visible
in this file.

	Arnd
