From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 2 Jan 2014 17:26:56 -0700
Subject: Issue with the emulated PCI bridge implementation
In-Reply-To: <20131226165241.2c50b244@skate>
References: <20131226160534.36cc4203@skate>
 <20131226165241.2c50b244@skate>
Message-ID: <20140103002656.GA12098@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 04:52:41PM +0100, Thomas Petazzoni wrote:

> Here is an implementation of this idea, tested to work with an e1000e
> card, with the driver modified to do a few read/write to the I/O
> region. What do you think about it?

This seems reasonable, the only down side is that a stray read to an
unused portion of the Linux IO mapping will lock the machine instead
of getting a page fault - however I don't see that as a blocker.

Regards,
Jason
