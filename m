From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 30 Mar 2015 17:07:44 +0100
Subject: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
In-Reply-To: <20150330162652.0f0c7a18@north>
References: <20150327191040.1119319d@north>
 <20150330122840.GA22949@e103592.cambridge.arm.com>
 <20150330162652.0f0c7a18@north>
Message-ID: <20150330160743.GD22949@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 04:26:52PM +0200, Jakub Kicinski wrote:
> On Mon, 30 Mar 2015 13:28:40 +0100, Dave Martin wrote:

[...]

> > TXIS reflects the live status of the FIFO, except that it is
> > "spuriously" deasserted betweem reset/clear of the interrupt and the
> > first TX IRQ, even though the FIFO may be empty.
> 
> I missed that IRQ is cleared by writing data.

No worries, it took me a fair while to be sure of that myself.  The TRM
is not very clear on it.

Thanks for the careful review.

Cheers
---Dave
