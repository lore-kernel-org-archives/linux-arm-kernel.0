From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 24 Nov 2015 14:50:36 +0200
Subject: [PATCH] scsi: use sector_div instead of do_div
In-Reply-To: <24882658.08y4bWL6tn@wuerfel>
References: <24882658.08y4bWL6tn@wuerfel>
Message-ID: <56545D1C.6070509@dev.mellanox.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/2015 18:38, Arnd Bergmann wrote:
> do_div is the wrong way to divide a sector_t, as it is less
> efficient when sector_t is 32-bit wide. With the upcoming
> do_div optimizations, the kernel starts warning about this:
>
> drivers/scsi/scsi_debug.c: In function 'dif_store':
> include/asm-generic/div64.h:207:28: warning: comparison of distinct pointer types lacks a cast
>
> This changes the code to use sector_div instead, which always
> produces optimal code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sagi Grimberg <sagig@mellanox.com>
