From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sat, 21 Jul 2012 15:18:35 +0200
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with
 VIVT caches
In-Reply-To: <5009C26B.6080901@xenomai.org>
References: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
 <20120719122814.GE29153@mudshark.cambridge.arm.com>
 <5009C26B.6080901@xenomai.org>
Message-ID: <500AAC2B.5060300@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2012 10:41 PM, Gilles Chanteperdrix wrote:
> Being 0 or 1 whether we want to flush the vector page (I believe we do
> not want to flush it, but am not sure).

Actually, I believe we want to flush the vector page, at least on
systems with VIVT cache: on systems with VIVT cache, the vector page is
writeable in kernel mode, so may have been modified, and the address
used by elf_core_dump is not the vectors address, but the address in the
kernel direct-mapped RAM region where the vector page was allocated, so
there is a cache aliasing issue.

-- 
                                                                Gilles.
