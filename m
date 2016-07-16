From: fmh6jj@gmail.com (Frank Mori Hess)
Date: Sat, 16 Jul 2016 17:51:49 -0400
Subject: bug in error message
Message-ID: <CAJz5OpfCWc2=kD8bwthizCEMau2DjMScoNkCER_FGFQkADbhrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a bug in arch/arm/mm/dma-mapping.c where it prints a number
in an error message in hex when it should be decimal:

pr_err("DMA: failed to allocate %zx KiB pool for atomic coherent allocation\n",
        atomic_pool_size / 1024);

patch (literally one character) here:

https://github.com/fmhess/linux/commit/dce53a26afe31c63b88bc5b5c75b41ec86579291

-- 
Frank
