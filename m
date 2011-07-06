From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 06 Jul 2011 17:47:27 +0200
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <20110706153704.GF8286@n2100.arm.linux.org.uk>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<006301cc3be4$daab1850$900148f0$%szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
	<007101cc3bec$dfbba8c0$9f32fa40$%szyprowski@samsung.com>
	<20110706153704.GF8286@n2100.arm.linux.org.uk>
Message-ID: <007801cc3bf4$01fdefe0$05f9cfa0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, July 06, 2011 5:37 PM Russell King - ARM Linux wrote:

> On Wed, Jul 06, 2011 at 04:56:23PM +0200, Marek Szyprowski wrote:
> > This will not solve our problems. We need CMA also to create at least one
> > device private area that for sure will be in low memory (video codec).
> 
> You make these statements but you don't say why.  Can you please
> explain why the video codec needs low memory - does it have a
> restricted number of memory address bits which it can manipulate?

Nope, it only needs to put some type of memory buffers in first bank 
(effectively in 30000000-34ffffff area) and the others in the second bank
(40000000-57ffffff area). The values are given for Samsung GONI board.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
