From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Mar 2011 16:34:48 +0000
Subject: [PATCH] arm: mmci: Add ARM variant with extended FIFO
In-Reply-To: <4D80E46C.3010103@canonical.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
	<4D80E46C.3010103@canonical.com>
Message-ID: <20110316163448.GA16538@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 10:25:16AM -0600, Matt Waddel wrote:
> On 03/11/2011 10:18 AM, Pawel Moll wrote:
> > New IO FPGA implementation for Versatile Express boards contain
> > MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> Tested-by: Matt Waddel <matt.waddel@linaro.org>
> 
> This patch improves MMC performance on my vexpress system. Also
> fixes "mmcblk0: error -5 transferring data" errors.

You should use the patch I sent to do dynamic clocking if you're
concerned about performance.  That patch improves performance by
a factor of 8 compared to anything possible by increasing the FIFO
depth.

I am very much of the opinion that deepening the FIFOs is just a
sticky plaster over the problem - and I said as much when it was
first proposed, pointing out that there's other better solutions.
