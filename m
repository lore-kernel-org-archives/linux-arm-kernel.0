From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 16:41:34 +0100
Subject: [PATCH 1/4] ARM: SCU: Add generic routines for secondary CPU
	bootup
In-Reply-To: <20100727171140.GA10375@oksana.dev.rtsoft.ru>
References: <20100727171109.GA7929@oksana.dev.rtsoft.ru>
	<20100727171140.GA10375@oksana.dev.rtsoft.ru>
Message-ID: <20100731154134.GF27064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 27, 2010 at 09:11:40PM +0400, Anton Vorontsov wrote:
> For CNS3xxx we want to reuse the original ARM approach of booting
> secondary CPUs. This patch turns VExpress' code into "SCU library",
> so that now platform code can call the generic routines.

I'm not sure this should become a "SCU library" - the name seems wrong.
When you consider that the SCU is the 'snoop control unit', which has
no relation to how secondary CPUs are booted, it makes little sense.

The secondary CPU boot protocol has much more to do with the boot
loader than with the hardware.

I also suspect that we can get rid of the 'holding pen' stuff and just
rely on the IPI being sent to the intended target CPU.  I don't think
anyone has really updated this since the initial ARM SMP implementation.
