From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Sep 2011 19:07:53 +0100
Subject: [PATCH 0/3] RFC: addition to DMA API
In-Reply-To: <20110901173149.GE2803@e102144-lin.cambridge.arm.com>
References: <CACVXFVOT9FZexiZhuJtvyFP8qOPYUKg0JqGarBJgT4R8SN7p5Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1109011127080.1896-100000@iolanthe.rowland.org>
	<20110901160429.GA15814@n2100.arm.linux.org.uk>
	<20110901173149.GE2803@e102144-lin.cambridge.arm.com>
Message-ID: <20110901180753.GB15814@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 06:31:49PM +0100, Will Deacon wrote:
> Given that I believe our coherent DMA memory is `cacheable, bufferable, do
> not allocate' in terms of AXI attributes, then writes will go straight to
> the write buffer on the PL310.

It's TEXCB=001, which due to the PRRR and NMRR registers is memory type
10, inner policy 00 outer policy 00, which translated means (as I said)
"Normal memory", "non-cacheable" at both the inner and outer levels.

How that gets translated to AXI attributes is outside the scope of the
ARM ARM, it's probably in some mega secret AXI document somewhere which
I don't have access to.
