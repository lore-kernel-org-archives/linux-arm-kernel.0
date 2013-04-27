From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Apr 2013 17:33:54 +0200
Subject: [PATCH] media: coda: Fix compile breakage
In-Reply-To: <1367039198-28639-1-git-send-email-shc_work@mail.ru>
References: <1367039198-28639-1-git-send-email-shc_work@mail.ru>
Message-ID: <201304271733.54301.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 April 2013, Alexander Shiyan wrote:
> Patch adds GENERIC_ALLOCATOR, if "coda" is selected.
> 
> drivers/built-in.o: In function `coda_remove':
> :(.text+0x110634): undefined reference to `gen_pool_free'
> drivers/built-in.o: In function `coda_probe':
> :(.text+0x1107d4): undefined reference to `of_get_named_gen_pool'
> :(.text+0x1108b8): undefined reference to `gen_pool_alloc'
> :(.text+0x1108d0): undefined reference to `gen_pool_virt_to_phys'
> :(.text+0x110918): undefined reference to `dev_get_gen_pool'
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I noticed the problem as well, but haven't gotten around to create
a patch. Thanks for taking care of this!

	Arnd
