From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 27 Sep 2016 11:22:14 +0300
Subject: [PATCH] simplefb: Disable and release clocks and regulators in
 destroy callback
In-Reply-To: <20160907090919.27187-1-wens@csie.org>
References: <20160907090919.27187-1-wens@csie.org>
Message-ID: <4f60733b-9ec0-ff8a-638e-50d06a2a9de2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/16 12:09, Chen-Yu Tsai wrote:
> simplefb gets unregister when a proper framebuffer driver comes in and
> kicks it out. However the claimed clocks and regulators stay enabled
> as they are only released in the platform device remove function, which
> in theory would never get called.
> 
> Move the clock/regulator cleanup into the framebuffer destroy callback,
> which gets called as part of the framebuffer unregister process.
> 
> Note this introduces asymmetry in how the resources are claimed and
> released.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/video/fbdev/simplefb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, queued for 4.9.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160927/5df2018e/attachment.sig>
