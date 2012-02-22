From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 09:48:27 +0000
Subject: [PATCH v2 19/19] ARM: at91/board-dt: move at91_initialize() to
 init_irq()
In-Reply-To: <5a6951fcbe28c3093c936d40c4b28f7ae3161d8d.1329903206.git.nicolas.ferre@atmel.com>
References: <0d78171672a30e8ec8084f54a557e9948260356d.1329903206.git.nicolas.ferre@atmel.com>
 <5a6951fcbe28c3093c936d40c4b28f7ae3161d8d.1329903206.git.nicolas.ferre@atmel.com>
Message-ID: <20120222094827.GT22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 10:39:45AM +0100, Nicolas Ferre wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Remove the need for at91_initialize() to be called at init_early().
> We move it to init_irq() function as we still need it before the
> timer initialization.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

NAK.  Keep the callback methods pure.  The whole point of the init_early
is so that soc people don't end up polluting things like the IRQ
initialization and timer initialization with stuff like this.

So this is a backwards step.
