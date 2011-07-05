From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 08:53:11 +0100
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<201107041859.11548.heiko@sntech.de>
	<20110704170217.GH28042@ponder.secretlab.ca>
	<201107042151.44075.heiko@sntech.de>
	<20110704232758.GB12824@ponder.secretlab.ca>
	<00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
Message-ID: <20110705075311.GO8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 04:05:32PM +0900, Kukjin Kim wrote:
> Of course, if we can remove every S3C_DMA_API, that can be the best solution
> but it needs more time. I'd like to go to our goal step by step.

Surely one of the preconditions then is to improve the existing PL080
dmaengine driver to do what you need it to.

I've worked on that driver to bring it closer to sanity and correctness,
and its almost there.  The problem I have working on the driver is the
crippled ARM development hardware, where most DMA just doesn't work in
one way or another.
