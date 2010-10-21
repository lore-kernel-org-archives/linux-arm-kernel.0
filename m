From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 21 Oct 2010 19:57:45 -0400 (EDT)
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <1287704855.12734.14.camel@maxim-laptop>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<1287704855.12734.14.camel@maxim-laptop>
Message-ID: <alpine.LFD.2.00.1010211956010.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Oct 2010, Maxim Levitsky wrote:

> This reintroduces the bug I fixed.
> 
> if the CONFIG_MMC_UNSAFE_RESUME isn't set (and that is default
> unfortunately), the host->bus_ops->resume will be NULL (see core/mmc.c
> mmc_ops), and therefore card will be removed, that will trigger a block
> device removal, sync, and deadlock).

Maybe mmc_ops should have a non NULL resume method then?


Nicolas
