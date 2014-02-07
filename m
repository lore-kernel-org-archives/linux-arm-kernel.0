From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Feb 2014 21:38:29 -0500
Subject: [PATCH 02/21] IRQ: Orion: Fix getting generic chip pointer.
In-Reply-To: <1391730137-14814-3-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140207023829.GS8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 12:41:58AM +0100, Andrew Lunn wrote:
> Enabling SPARSE_IRQ shows up a bug in the irq-orion bridge interrupt
> handler. The bridge interrupt is implemented using a single generic
> chip. Thus the parameter passed to irq_get_domain_generic_chip()
> should always be zero.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/irqchip/irq-orion.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied to mvebu-next/irqchip-fixes with:

Fixes: 9dbd90f17e4f ("irqchip: Add support for Marvell Orion SoCs")
Cc: <stable@vger.kernel.org> # v3.11+

thx,

Jason.
