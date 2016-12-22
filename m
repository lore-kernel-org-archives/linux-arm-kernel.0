From: schwab@suse.de (Andreas Schwab)
Date: Thu, 22 Dec 2016 23:12:32 +0100
Subject: [PATCH] mm: pmd dirty emulation in page fault handler
In-Reply-To: <20161222145203.GA18970@bbox> (Minchan Kim's message of "Thu, 22
 Dec 2016 23:52:03 +0900")
References: <1482364101-16204-1-git-send-email-minchan@kernel.org>
 <20161222081713.GA32480@node.shutemov.name>
 <20161222145203.GA18970@bbox>
Message-ID: <8737hftxyn.fsf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dez 22 2016, Minchan Kim <minchan@kernel.org> wrote:

> From b3ec95c0df91ad113525968a4a6b53030fd0b48d Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Thu, 22 Dec 2016 23:43:49 +0900
> Subject: [PATCH v2] mm: pmd dirty emulation in page fault handler
>
> Andreas reported [1] made a test in jemalloc hang in THP mode in arm64.
> http://lkml.kernel.org/r/mvmmvfy37g1.fsf at hawking.suse.de
>
> The problem is page fault handler supports only accessed flag emulation
> for THP page of SW-dirty/accessed architecture.
>
> This patch enables dirty-bit emulation for those architectures.
> Without it, MADV_FREE makes application hang by repeated fault forever.
>
> [1] b8d3c4c3009d, mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called

Successfully tested a backport to 4.9.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
