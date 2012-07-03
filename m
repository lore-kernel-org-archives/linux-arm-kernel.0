From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 03 Jul 2012 09:20:29 +0200
Subject: [PATCH v4] mm: cma: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <1331120259-30780-1-git-send-email-Barry.Song@csr.com>
References: <1331120259-30780-1-git-send-email-Barry.Song@csr.com>
Message-ID: <03e601cd58ec$5b8177b0$12846710$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, March 07, 2012 12:38 PM Barry Song wrote:

> From: Barry Song <Baohua.Song@csr.com>
> 
> Any write request to /dev/cma_test will let the module to allocate memory from
> CMA, for example:
> 
> 1st time
> $ echo 1024 > /dev/cma_test
> will require cma_test to request 1MB(1024KB)
> 2nd time
> $ echo 2048 > /dev/cma_test
> will require cma_test to request 2MB(2048KB)
> 
> Any read request to /dev/cma_test will let the module to free the 1st valid
> memory from CMA, for example:
> 
> 1st time
> $ cat /dev/cma_test
> will require cma_test to free the 1MB allocated in the first write request
> 2nd time
> $ cat /dev/cma_test
> will require cma_test to free the 2MB allocated in the second write request
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  tools/cma/Makefile   |   13 +++++
>  tools/cma/cma_test.c |  140 ++++++++++++++++++++++++++++++++++++++++++++++++++

I'm sorry for such a long delay in processing this patch, but I wanted first to be sure
that the core CMA code gets into mainline, then I got busy with other dma-mapping 
related stuff. 

IMHO the right place for such code is in drivers/misc instead of tools/cma. 

This patch contains a kernel module source code so it should be put with other kernel
modules. tools/ directory is aimed to contain user space code useful for developing and
testing Linux kernel.

Make sure that you also add Greg Kroah-Hartman <gregkh@linuxfoundation.org> on CC:,
he maintains misc drivers.

> (snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
