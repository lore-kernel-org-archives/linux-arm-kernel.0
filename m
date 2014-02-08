From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Feb 2014 10:45:37 -0500
Subject: [PATCH 02/21] IRQ: Orion: Fix getting generic chip pointer.
In-Reply-To: <52F55F19.3060800@gmail.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-3-git-send-email-andrew@lunn.ch>
 <52F55F19.3060800@gmail.com>
Message-ID: <20140208154537.GH8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 11:32:57PM +0100, Sebastian Hesselbarth wrote:
> On 02/07/2014 12:41 AM, Andrew Lunn wrote:
> >Enabling SPARSE_IRQ shows up a bug in the irq-orion bridge interrupt
> >handler. The bridge interrupt is implemented using a single generic
> >chip. Thus the parameter passed to irq_get_domain_generic_chip()
> >should always be zero.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Indeed, I remember we talked about it: irq_get_domain_generic_chip takes
> hwirqs, so passing 0 is sane here.
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Added and pushed to mvebu-next/irqchip-fixes

thx,

Jason.
