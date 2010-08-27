From: cjb@laptop.org (Chris Ball)
Date: Fri, 27 Aug 2010 20:34:57 +0100
Subject: [PATCH 1/7] mmc: at91_mci: fix pointer errors
In-Reply-To: <20100827193303.GB23079@void.printf.net>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<20100827193303.GB23079@void.printf.net>
Message-ID: <20100827193457.GC23079@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 27, 2010 at 08:33:03PM +0100, Chris Ball wrote:
> Looks like only the first half of this patch was applied?  The
> kunmap_atomic() line is still present as before in Linus' tree. 

Might be related to Dan Carpenter's suggestion that the spacing for that
line should change to:

	kunmap_atomic(((void *)sgbuffer) - sg->offset, KM_BIO_SRC_IRQ);

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
