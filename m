From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Mar 2012 13:10:01 +0100
Subject: arm: mm: fix faulty calculation of area to perform cache operation
In-Reply-To: <002c01cd0d92$14acd5f0$3e0681d0$%cho@samsung.com>
References: <002c01cd0d92$14acd5f0$3e0681d0$%cho@samsung.com>
Message-ID: <20120329121000.GE22414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 06:55:32PM +0900, Cho KyongHo wrote:
> In dma_cache_maint_page(), if offset is larger than PAGE_SIZE,
> len becomes PAGE_SIZE - offset. If size is smaller than
> PAGE_SIZE - offset, next calcuation of left cause overflow.

It is invalid for offset to be larger than PAGE_SIZE here.
