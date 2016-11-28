From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Nov 2016 11:00:24 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <609bc971-bb6d-8cd2-8e64-23c0082a6216@topic.nl>
References: <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
 <20161031162327.GA28817@obsidianresearch.com>
 <7117d821-a1b1-7c07-806a-483be99131e6@xilinx.com>
 <20161101153326.GA6193@obsidianresearch.com>
 <4e2c7e1c-7c33-a552-5b91-dbdefac58e37@xilinx.com>
 <20161108000538.GA13959@obsidianresearch.com>
 <609bc971-bb6d-8cd2-8e64-23c0082a6216@topic.nl>
Message-ID: <20161128180024.GB27818@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I seem to have missed being CC on this follow up from Mike and wanted
to respond:

> What you're creating here will require active maintenance.  There
> are already 7007 and 7012 devices which aren't in your list so the
> driver will refuse to load them until someone fills in the IDs.

I don't know what list you are refering to, are you sure you are
responding to the right patch?

The patch searches for the sync word, it has nothing to do with IDs,
and does not attempt to parse any of the proprietary headers. Based on
the Xilinx documentation this will work on 7 Series, US and US+ at a
minimum. Certainly on all Zynq hardware.

> The bitstream format is actually proprietary and undocumented.
> Any "checks" in code are likely based on guesswork and reverse
> engineering.

No, this part is fully documented in UG470.

> We also use partial reprogramming a lot. Did you test
> that? On all devices?

You should read the patch, it only does the check on a full bitstream.

Jason
