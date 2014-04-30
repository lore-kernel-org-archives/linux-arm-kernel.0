From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 30 Apr 2014 19:01:36 +0200
Subject: [PATCH] arm: socfpga: reserve the region at start of phys mem
In-Reply-To: <20140430161717.GY5546@joshc.qualcomm.com>
References: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
 <20140430161717.GY5546@joshc.qualcomm.com>
Message-ID: <53612C70.6000109@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2014 06:17 PM, Josh Cartwright wrote:
> Is there a particular reason why you aren't describing this reservation
> in devicetree using a /memreserve/ node?

Because the kernel is using memory at a specific address it did not
allocate. If the memory address where the second CPU come up could be
set then this node wouldn't be required and a simple kmalloc() would do
it, too.

Sebastian
