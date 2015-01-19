From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Jan 2015 17:59 +0100
Subject: [RFC PATCH 0/3] drivers: port PCIe designware to new DT parsing
 API
In-Reply-To: <CAL_JsqLYg9vhFVmf=O4YLPfboj-dyoCR0H5dzBbMC3PeAEOwhQ@mail.gmail.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqLYg9vhFVmf=O4YLPfboj-dyoCR0H5dzBbMC3PeAEOwhQ@mail.gmail.com>
Message-ID: <1539153.bO1tVUM2dB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 January 2015 10:40:39 Rob Herring wrote:
> 
> I don't really like exposing ranges to host drivers. We've worked to
> not do that. So perhaps we need to rethink the API. I think we need to
> provide each range as a pair of resources which are the CPU address
> and PCI address. Perhaps an iterator is kind of pointless here. We do
> different things for each one. Are there cases with more than a single
> i/o space, non-prefetch memory and prefetch memory range? Perhaps we
> should just get the i/o and memory resources as separate calls. Just
> tossing out some ideas here.

Nice idea, that could be similar to platform_get_resource().

We probably also need the distinction between CPU address and (parent)
bus address here. In most drivers they are the same, but we actually
need to program the latter one into the PCI host bridge registers.

	Arnd
