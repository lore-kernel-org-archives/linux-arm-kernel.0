From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Aug 2015 15:51:49 +0100
Subject: [PATCH 2/2] arm64: set MAX_MEMBLOCK_ADDR according to linear
 region size
In-Reply-To: <20150818142435.GC11571@e104818-lin.cambridge.arm.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <1439890482-20798-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150818100018.GA11021@arm.com>
 <20150818142435.GC11571@e104818-lin.cambridge.arm.com>
Message-ID: <20150818145149.GQ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 03:24:36PM +0100, Catalin Marinas wrote:
> With the current memory layout, this could also be __pa(~0UL). I guess
> we could solve this with a single patch, though I'm not sure whether we
> break other architectures:

No.  __pa() is only valid within the lowmem mapping, not outside of it.
What you'd get for a virtual address of ~0UL is not well defined, so
you should not use this in generic code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
