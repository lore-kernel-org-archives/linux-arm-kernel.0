From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sat, 16 Jun 2012 14:51:13 +0200
Subject: kernel fault in get_dump_page on at91
Message-ID: <4FDC8141.2030209@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

It seems generating a coredump on an at91rm9200 with kernels 3.4 and 3.5
causes an oops.

The function get_dump_page calls vivt_flush_cache_page which tests if
the current cpu belongs to mm_cpumask(vma->vm_mm), but vma->vm_mm is
NULL for the vector page.

Setting gate_vma.vm_mm to &init_mm seems to avoid the issue, but I am
not sure this is the right thing to do.

Regards.

-- 
                                                                Gilles.
