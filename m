From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 18 Feb 2010 07:37:00 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266420475.16707.31.camel@e102109-lin.cambridge.arm.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
	<1266397543.16346.264.camel@pasglop>
	<1266420475.16707.31.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1266439020.16346.285.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-17 at 15:27 +0000, Catalin Marinas wrote:
> We do the same on ARM. The problem with most (all) HCD drivers that do
> PIO is that they copy the data to the transfer buffer but there is no
> call in this driver to flush_dcache_page(). The upper mass storage or
> filesystem layers don't call this function either, so there isn't
> anything that would set the PG_arch1 bit. 

Actually, clear it :-)

I suppose that's one thing that needs to be fixed in the drivers.

Cheers,
Ben.
