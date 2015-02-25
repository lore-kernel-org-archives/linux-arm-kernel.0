From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 10:36:20 +0000
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <1424810703-20382-1-git-send-email-drake@endlessm.com>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
Message-ID: <20150225103620.GV8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 02:45:03PM -0600, Daniel Drake wrote:
> Currently when arm_dma_mmap() is called, vm_page_prot is reset
> according to DMA attributes. Currently, writecombine is the
> only attribute supported; any other configuration will map uncached
> memory.
> 
> Add support for the non-consistent attribute so that cachable memory
> can be mapped into userspace via the dma_mmap_attrs() API.

What is your use-case for this?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
