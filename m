From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 08:27:25 +0000
Subject: [PATCH 4/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <8718a09f-604a-41b0-8b5a-856bacac9e9a@VA3EHSMHS025.ehs.local>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-3-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-4-git-send-email-john.linn@xilinx.com>
	<a45cf64b-c91a-4f8b-a121-5a675daee4ca@VA3EHSMHS006.ehs.local>
	<20110205164325.GE29411@n2100.arm.linux.org.uk>
	<8718a09f-604a-41b0-8b5a-856bacac9e9a@VA3EHSMHS025.ehs.local>
Message-ID: <20110208082725.GA20822@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 05:14:13PM -0700, John Linn wrote:
> I'm assuming you meant to change all addresses of devices (#defines) to
> use the IOMEM.
> 
> I did that and it's ok. You also have to cast them to ints when putting
> the addresses into
> the resource for a platform device.

Hang on.  The reason I mentioned it was because you were passing some
of these into readl() et.al.  readl() takes the mapped cookie, not the
physical address.

Physical addresses should be integer like, virtual addresses should be
pointer like.
