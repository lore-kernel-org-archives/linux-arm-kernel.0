From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Apr 2018 16:17:58 +0100
Subject: [PATCH] arm64: kasan: avoid pfn_to_nid() before page array is
 initialized
In-Reply-To: <20180416134441.49730-1-mark.rutland@arm.com>
References: <20180416134441.49730-1-mark.rutland@arm.com>
Message-ID: <20180417151757.34fxihdsmqs2dmhg@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 02:44:41PM +0100, Mark Rutland wrote:
> In arm64's kasan_init(), we use pfn_to_nid() to find the NUMA node a
> span of memory is in, hoping to allocate shadow from the same NUMA node.
> However, at this point, the page array has not been initialized, and
> thus this is bogus.

Queued for 4.17-rc2. Thanks.

-- 
Catalin
