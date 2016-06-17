From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jun 2016 18:00:13 +0100
Subject: [PATCH] arm64: Implement optimised IP checksum helpers
In-Reply-To: <6ca77904d1eced60d86145dc5da361f3aefc6fec.1463062758.git.robin.murphy@arm.com>
References: <6ca77904d1eced60d86145dc5da361f3aefc6fec.1463062758.git.robin.murphy@arm.com>
Message-ID: <20160617170012.GA24589@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 03:26:48PM +0100, Robin Murphy wrote:
> AArch64 is capable of 128-bit memory accesses without alignment
> restrictions, which makes it both possible and highly practical to slurp
> up a typical 20-byte IP header in just 2 loads. Implement our own
> version of ip_fast_checksum() to take advantage of that, resulting in
> considerably fewer instructions and memory accesses than the generic
> version. We can also get more optimal code generation for csum_fold() by
> defining it a slightly different way round from the generic version, so
> throw that into the mix too.
> 
> Suggested-by: Luke Starrett <luke.starrett@broadcom.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Queued for 4.8. Thanks.

-- 
Catalin
