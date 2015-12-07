From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 7 Dec 2015 17:48:05 +0200
Subject: [PATCH] fbdev: sis: enforce selection of at least one backend
In-Reply-To: <2902419.SMzMybotxA@wuerfel>
References: <2902419.SMzMybotxA@wuerfel>
Message-ID: <5665AA35.1040600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/11/15 16:33, Arnd Bergmann wrote:
> The sis framebuffer driver complains with a compile-time warning
> if neither the FB_SIS_300 nor FB_SIS_315 symbols are selected:
> 
> drivers/video/fbdev/sis/sis_main.c:61:2: warning: #warning Neither CONFIG_FB_SIS_300 nor CONFIG_FB_SIS_315 is se
> 
> This is reasonable because it doesn't work in that case, but it's
> also annoying for randconfig builds and is one of the most common
> warnings I'm seeing on ARM now.
> 
> This changes the Kconfig logic to prevent the silly configuration,
> by always selecting the FB_SIS_300 variant if the other one is
> not set.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Sorry for sending this twice, it looks like I forgot the fbdev list and
> Tomi as recipients the first time

Thanks, queued for 4.5.

 tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/b73370aa/attachment.sig>
