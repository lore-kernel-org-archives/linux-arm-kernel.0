From: davem@davemloft.net (David Miller)
Date: Wed, 25 Jun 2014 16:32:00 -0700 (PDT)
Subject: [PATCH] net: allwinner: emac: Add missing free_irq
In-Reply-To: <1403556580-21818-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1403556580-21818-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140625.163200.509097762043557956.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 23 Jun 2014 22:49:40 +0200

> If the mdio probe function fails in emac_open, the interrupt we just requested
> isn't freed. If emac_open is called again, for example because we try to set up
> the interface again, the kernel will oops because the interrupt wasn't properly
> released.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: <stable@vger.kernel.org> # 3.11+

Applied, thank you.
