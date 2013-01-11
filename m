From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Jan 2013 20:12:45 +0000
Subject: [PATCH v4 00/14] DMA Engine support for AM33XX
In-Reply-To: <20130111183349.GA14660@beef>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
 <201301111140.41584.arnd@arndb.de> <20130111183349.GA14660@beef>
Message-ID: <201301112012.45981.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013, Matt Porter wrote:
> We have tightly coupled the link-time dependency for
> omap_dma_filter_fn by going down the path of using
> dma_request_slave_channel_compat() as Tony suggested to avoid extra
> ifdefry.
> 
> That dependency will go away naturally if all the "legacy" OMAP platforms
> were required to only boot from DT...just as a newly added SoCs are.
> 
> Are you suggesting unwinding the _compat() approach?

No, I was thinking we could define omap_dma_filter_fn to NULL
for the DT-only case.

	Arnd
