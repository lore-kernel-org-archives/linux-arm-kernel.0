From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jan 2014 16:05:22 +0100
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <20140128121656.GH15937@n2100.arm.linux.org.uk>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <9156959.vu4XdoKglI@wuerfel> <20140128121656.GH15937@n2100.arm.linux.org.uk>
Message-ID: <21038487.ygragjUUsd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 January 2014 12:16:56 Russell King - ARM Linux wrote:
> On Tue, Jan 28, 2014 at 01:08:47PM +0100, Arnd Bergmann wrote:
> 
> On balance, I think the virtual channel approach makes client drivers
> more elegant and simpler, and makes the DMA engine API easier to use,
> and gives greater flexibility for future improvements.  So, I wouldn't
> miss the slave_id being removed.

Ok, good. There are some dmaengine drivers that actually behave
in hardware like the virtual-channel extension, i.e. they have
one physical channel per request line (qcom_bam_dma seems to be
one of them in fact), so they don't really have a choice.

The way that both the DT and ACPI bindings are structured,
the request ID is always known by the time the channel is
allocated to allow this model, and that means supporting both
approaches in the same master or slave driver is a mess.

	Arnd
