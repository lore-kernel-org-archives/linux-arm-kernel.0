From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 7 Dec 2015 18:10:04 +0200
Subject: [PATCH] fbdev: auo_k190x: avoid unused function warnings
In-Reply-To: <3917686.rD8ezhD468@wuerfel>
References: <3917686.rD8ezhD468@wuerfel>
Message-ID: <5665AF5C.4060801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20/11/15 23:47, Arnd Bergmann wrote:
> The auo_k190x framebuffer driver encloses the power-management
> functions in #ifdef CONFIG_PM, but the auok190x_suspend/resume
> functions are only really used when CONFIG_PM_SLEEP is also
> set, as a frequent gcc warning shows:
> 
> drivers/video/fbdev/auo_k190x.c:859:12: warning: 'auok190x_suspend' defined but not used
> drivers/video/fbdev/auo_k190x.c:899:12: warning: 'auok190x_resume' defined but not used
> 
> This changes the driver to remove the #ifdef and instead mark
> the functions as __maybe_unused, which is a nicer anyway, as it
> provides build testing for all the code in all configurations
> and is harder to get wrong.

Applied for 4.5.

Btw, do you know if the linker will optimize the __maybe_unused funcs
away if they are not used? I presume so.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/976a5215/attachment.sig>
