From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 May 2018 20:11:23 +0200
Subject: [PATCH v2 02/13] ARM: pxa: add dma slave map
In-Reply-To: <20180524070703.11901-3-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Thu, 24 May 2018 09:06:52 +0200")
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
 <20180524070703.11901-3-robert.jarzmik@free.fr>
Message-ID: <871se0yldg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> In order to remove the specific knowledge of the dma mapping from PXA
> drivers, add a default slave map for pxa architectures.
>
> This is the first step, and once all drivers are converted,
> pxad_filter_fn() will be made static, and the DMA resources removed from
> device.c.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> +	{ "smc911x.0", "rx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +	{ "smc911x.0", "tx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +	{ "smc91x.0", "data", PDMA_FILTER_PARAM(LOWEST, -1) },

Hi Arnd,

Actually after rereading this, I realised that I completely forgot your former
comment about having a NULL parameter for network devices (as there is no
requestor behind).

I will cook it up for v3 ... that will be a minor change in this patch (hence
I'll keep any Ack), but for patches 0006 and 0007, things will change, and
another patch for Vinod will appear.

Cheers.

--
Robert
