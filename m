From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Sep 2015 19:29:02 +0100
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <1442944788-17254-1-git-send-email-rric@kernel.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
Message-ID: <20150922182902.GO7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 06:59:48PM +0100, Robert Richter wrote:
> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> 
> Increase the standard cacheline size to avoid having locks in the same
> cacheline.
> 
> Cavium's ThunderX core implements cache lines of 128 byte size. With
> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> share the same cache line leading a performance degradation.
> Increasing the size fixes that.

Do you have an example of that happening?

> Increasing the size has no negative impact to cache invalidation on
> systems with a smaller cache line. There is an impact on memory usage,
> but that's not too important for arm64 use cases.

Do you have any before/after numbers to show the impact of this change
on other supported SoCs?

Will
