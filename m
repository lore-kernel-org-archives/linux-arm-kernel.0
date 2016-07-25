From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2016 10:28:01 +0100
Subject: [PATCH RFC] arm64: mm: convert __dma_* routines to use start, size
In-Reply-To: <1469432406-27548-1-git-send-email-kwangwoo.lee@sk.com>
References: <1469432406-27548-1-git-send-email-kwangwoo.lee@sk.com>
Message-ID: <20160725092801.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 04:40:06PM +0900, Kwangwoo Lee wrote:
> __dma_* routines have been converted to use start and size instread of
> start and end addresses. The patch was origianlly for adding
> __clean_dcache_area_poc() which will be used in pmem driver to clean
> dcache to the PoC(Point of Coherency) in arch_wb_cache_pmem().

I'd suggest keeping to this terminology:

area: takes a start and size
range: takes a start and end

So, if you want to change the parameters to take a start and size,
the function should not contain "range" but should contain "area"
in its name.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
