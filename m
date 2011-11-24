From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 24 Nov 2011 01:06:49 +0000 (GMT)
Subject: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <1322088363.18388.13.camel@flow>
Message-ID: <1322096809.59552.YahooMailClassic@web29001.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Wed, 23/11/11, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Looked good on first glance, but a quick test run of those
> two patches
> against v3.2-rc2 resulted in an Oops in navpoint_int as
> soon as I
> touched the navpoint:

oops, sorry about that.

> I guess that's because you effectively pass drv_data into
> dev_warn as
> first argument here. Fix that and maybe rename the second
> parameter of
> navpoint_int to void *dev_id to avoid confusion.

Yes, void* and naming confusion conspired to pass unnoticed.

> I assume I hit this spurious interrupt because I was
> booting with haret
> and you use the SDG bootloader?

Yes I do use the SDG bootloader, but I don't know whether that accounts for my absence of spuriousness. If it does then perhaps there is a problem with haret intialization?
