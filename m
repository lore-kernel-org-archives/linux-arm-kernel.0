From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Sep 2016 13:18:31 +0200
Subject: next build: 143 builds: 2 failed, 141 passed, 2 errors,
 2 warnings (next-20160909)
In-Reply-To: <57d26402.eeb8c20a.ba0e2.8bbb@mx.google.com>
References: <57d26402.eeb8c20a.ba0e2.8bbb@mx.google.com>
Message-ID: <2582793.W17ckCts1B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 9, 2016 12:25:54 AM CEST kernelci. org bot wrote:
> next build: 143 builds: 2 failed, 141 passed, 2 errors, 2 warnings (next-20160909)

This is pretty good, here is what's left:

> rpc_defconfig (arm) ? FAIL, 1 error, 0 warnings, 0 section mismatches
> 
> Errors:
>     fs/fat/dir.c:758:424: internal compiler error: Segmentation fault

Could we please update the gcc build on kernelci.org from "Linaro GCC 5.3-2016.02"
to the following version (Linaro GCC 5.3-2016.05) or later?

> allmodconfig (arm64) ? FAIL, 1 error, 0 warnings, 0 section mismatches
> 
> Errors:
>     ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!

Currently under discussion, no patch yet.

> Warnings summary:
> 
>       2  lib/raid6/recov_avx512.c:387:2: warning: #warning "your version of binutils lacks AVX512 support" [-Wcpp]

This is for the x86 native binutils, which may be a bit trickier to
update. Apparently the minimum assembler version required for this is
from binutils-2.25, released Jan 13, 2015.

	Arnd
