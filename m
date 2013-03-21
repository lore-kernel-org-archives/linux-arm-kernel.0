From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Mar 2013 15:46:07 -0600
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56C7B6D24@IL-MB01.marvell.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com>
 <20130321221523.7ede6ccc@skate>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56C7B6D24@IL-MB01.marvell.com>
Message-ID: <20130321214607.GC8431@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 11:35:21PM +0200, Lior Amsalem wrote:

> >  *) It would require Linux to change the internal registers address
> >     (for now the kernel relies on the bootloader). The problem is that
> >     we can't do it early enough to preserve the earlyprintk
> >     functionality. Maybe you have suggestions on how to achieve that?
> 
> Please note that all registers and IOs are still 32bit, the 40bit
> extension is on the CPU to DRAM path (windows) only.

Ah, I did wonder, since Ezequiel's MBUS driver was the same as on
prior families. I guess it is also the case that all on board DMA and
DMA from PCI-E devices are restricted to the low 32 bits as well?

I think lots of Linux workloads will really struggle under those
conditions..

Jason
