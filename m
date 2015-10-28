From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2015 19:09:49 +0000
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <1442944788-17254-1-git-send-email-rric@kernel.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
Message-ID: <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> 
> Increase the standard cacheline size to avoid having locks in the same
> cacheline.
> 
> Cavium's ThunderX core implements cache lines of 128 byte size. With
> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> share the same cache line leading a performance degradation.
> Increasing the size fixes that.
> 
> Increasing the size has no negative impact to cache invalidation on
> systems with a smaller cache line. There is an impact on memory usage,
> but that's not too important for arm64 use cases.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Applied. Thanks.

-- 
Catalin
