From: davem@davemloft.net (David Miller)
Date: Tue, 13 Jan 2015 16:56:57 -0500 (EST)
Subject: [PATCH] rocker: fix harmless warning on 32-bit machines
In-Reply-To: <4047824.AYNhYQQ6UI@wuerfel>
References: <4047824.AYNhYQQ6UI@wuerfel>
Message-ID: <20150113.165657.1171408376100942920.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Jan 2015 15:23:52 +0100

> The rocker driver tries to assign a pointer to a 64-bit integer
> and then back to a pointer. This is safe on all architectures,
> but causes a compiler warning when pointers are shorter than
> 64-bit:
> 
> rocker/rocker.c: In function 'rocker_desc_cookie_ptr_get':
> rocker/rocker.c:809:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   return (void *) desc_info->desc->cookie;
>          ^
> 
> This adds another cast to uintptr_t to tell the compiler
> that it's safe.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next, thanks.
