From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 30 Apr 2014 12:32:20 -0500
Subject: [PATCH] arm: socfpga: reserve the region at start of phys mem
In-Reply-To: <53612C70.6000109@linutronix.de>
References: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
 <20140430161717.GY5546@joshc.qualcomm.com>
 <53612C70.6000109@linutronix.de>
Message-ID: <20140430173220.GZ5546@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 07:01:36PM +0200, Sebastian Andrzej Siewior wrote:
> On 04/30/2014 06:17 PM, Josh Cartwright wrote:
> > Is there a particular reason why you aren't describing this reservation
> > in devicetree using a /memreserve/ node?
> 
> Because the kernel is using memory at a specific address it did not
> allocate. If the memory address where the second CPU come up could be
> set then this node wouldn't be required and a simple kmalloc() would do
> it, too.

I understand the need to reserve the area, but questioning the mechanism
used to do so.  How is the socfpga case different from Highbank, for
example, which makes use of /memreserve/ for what appears to be a very
similar purpose (see arch/arm/boot/dts/highbank.dts):

	/* First 4KB has pen for secondary cores. */
	/memreserve/ 0x00000000 0x0001000;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
