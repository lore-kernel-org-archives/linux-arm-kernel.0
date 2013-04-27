From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Apr 2013 14:13:50 -0300
Subject: [PATCH] media: coda: Fix compile breakage
In-Reply-To: <201304271733.54301.arnd@arndb.de>
References: <1367039198-28639-1-git-send-email-shc_work@mail.ru>
 <201304271733.54301.arnd@arndb.de>
Message-ID: <CAOMZO5CYZoe9Z_eAWZ5Wit2o-+9hq3xWjHPF_ZLszN7bbDJrBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander/Arnd,

On Sat, Apr 27, 2013 at 12:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 27 April 2013, Alexander Shiyan wrote:
>> Patch adds GENERIC_ALLOCATOR, if "coda" is selected.
>>
>> drivers/built-in.o: In function `coda_remove':
>> :(.text+0x110634): undefined reference to `gen_pool_free'
>> drivers/built-in.o: In function `coda_probe':
>> :(.text+0x1107d4): undefined reference to `of_get_named_gen_pool'
>> :(.text+0x1108b8): undefined reference to `gen_pool_alloc'
>> :(.text+0x1108d0): undefined reference to `gen_pool_virt_to_phys'
>> :(.text+0x110918): undefined reference to `dev_get_gen_pool'
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> I noticed the problem as well, but haven't gotten around to create
> a patch. Thanks for taking care of this!

I fixed this issue in a different way:
https://patchwork.kernel.org/patch/2432841/

And Shawn has already queued it.
