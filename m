From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 9 Nov 2016 09:00:03 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <ab7684fe-2407-330e-9001-21dccc781983@suse.com>
References: <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
 <20161031162327.GA28817@obsidianresearch.com>
 <7117d821-a1b1-7c07-806a-483be99131e6@xilinx.com>
 <20161101153326.GA6193@obsidianresearch.com>
 <4e2c7e1c-7c33-a552-5b91-dbdefac58e37@xilinx.com>
 <20161108000538.GA13959@obsidianresearch.com>
 <609bc971-bb6d-8cd2-8e64-23c0082a6216@topic.nl>
 <ab7684fe-2407-330e-9001-21dccc781983@suse.com>
Message-ID: <20161109160003.GB15076@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 04:18:29PM +0100, Matthias Brugger wrote:

> I get your point. Especially looping to the whole file to find the sync
> header can take a while, especially if the file is big and the sync header
> is not present.

Er, no not at all. If you send garbage to the FPGA the driver detects
it after a 2.5s timeout. The memory scan is always alot faster.

In the normal success case it is ~5 compares.

> So I think the whole idea behind this patch is to provide feedback to the
> user about what went wrong when trying to update the FPGA. Is there a way to
> get this information from the hardware which discards the update?

No, not with such specificity.

Jason
