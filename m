From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 05 Oct 2010 10:21:04 -0700
Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
In-Reply-To: <alpine.DEB.2.00.1010051058290.13816@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 5 Oct 2010 10:59:44 -0600 (MDT)")
References: <alpine.DEB.2.00.1010051058290.13816@utopia.booyaka.com>
Message-ID: <87wrpwsghr.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Some modules which have 16bit registers can cause imprecise
> aborts if a __raw_readl/writel is used to read/write 32 bits.
>
> Add an additional flag to identify modules which have such
> hard requirement, and handle it in the hwmod framework.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Paul Walmsley <paul@pwsan.com>

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

Added the flag to the 2420 hwmods and tested this patch on n810 using
the i2c hwmods and it now boots without the imprecise abort.

Kevin
