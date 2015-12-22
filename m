From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Dec 2015 21:38:53 +0100
Subject: [PATCH] [media] rc: sunxi-cir: Initialize the spinlock properly
In-Reply-To: <1450758455-22945-1-git-send-email-wens@csie.org>
References: <1450758455-22945-1-git-send-email-wens@csie.org>
Message-ID: <20151222203853.GC30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 22, 2015 at 12:27:35PM +0800, Chen-Yu Tsai wrote:
> The driver allocates the spinlock but fails to initialize it correctly.
> The kernel reports a BUG indicating bad spinlock magic when spinlock
> debugging is enabled.
> 
> Call spin_lock_init() on it to initialize it correctly.
> 
> Fixes: b4e3e59fb59c ("[media] rc: add sunxi-ir driver")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

You should probably Cc stable on this one.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/fca30fd0/attachment.sig>
