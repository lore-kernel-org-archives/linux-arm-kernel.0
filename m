From: noodles@earth.li (Jonathan McDowell)
Date: Tue, 4 May 2010 21:55:50 +0100
Subject: [PATCH 1/2] pxa/vpac270: Enable SparseMEM for 256 MB of RAM
In-Reply-To: <1272992229-29361-1-git-send-email-marek.vasut@gmail.com>
References: <1272992229-29361-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100504205550.GP3292@earth.li>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 06:57:08PM +0200, Marek Vasut wrote:
> This patch enables SparseMEM for the Voipac PXA270 board. To work
> around the PHYS_OFFSET being set to 0xa0000000 and disallowing us to
> map the other partition at 0x80000000, the physical-to-virtual mapping
> of SDRAM was altered and the partition at 0x80000000 was moved to
> 0x10000000 in virtual memory (past the first SDRAM partition). As the
> Voipac PXA270 is probably the only PXA270 device which utilizes 256 MB
> of RAM, adding the following code into memory.h seems much less
> painful than tinkering with PHYS_OFFSET.
...
> +/*
> + * Voipac PXA270/PXA270M is probably the only board in the world with PXA27x
> + * that uses more than 128MB or SDRAM (256MB in the 'max configuration'). This

I think you mean "of SDRAM" here and the Balloon3 can be configured with
up to 512M (I'm pretty sure there were a few boards that had 768M on
them too, but I can't find any confirmation of that) and is a PXA270
board.

J.

-- 
Whatever the risk, NO one ever expects to get caught.
