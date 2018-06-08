From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2018 23:26:02 -0700
Subject: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
In-Reply-To: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
References: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180608062602.GK5738@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Geert Uytterhoeven <geert+renesas@glider.be> [180607 13:40]:
> The divisions (and multiplications) can be avoided by changing the loops
> to use increments of mux_bytes instead of 1.
> While at it, remove the unneeded casts when assigning void pointers.
> 
> This saves +100 bytes of kernel size on arm32/arm64.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.

Makes sense to me:

Acked-by: Tony Lindgren <tony@atomide.com>

Keerthy can you please test?

Regards,

Tony
