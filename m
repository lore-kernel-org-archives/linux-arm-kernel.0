From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Mar 2015 19:00:12 +0000
Subject: [PATCH] spi: xilinx: Use standard num-cs binding
In-Reply-To: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
Message-ID: <20150308190012.GV28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 01:55:14PM +0100, Michal Simek wrote:
> Use standard num-cs binding property and setup
> "xlnx,num-ss-bits" as deprecated.

Why?  These properties mean different things - num-cs is a bit confused
and is the total number of available chip selects for the system (which
could include GPIOs) while num-ss-bits is the size of the bitfield
(which could include things not actually mapped out properly/successfully 
or something if the hardware designers were feeling particularly inspired).

I'm not convinced num-cs ever made any sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/f9e6ca0e/attachment.sig>
