From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jun 2016 18:02:38 +0100
Subject: [PATCH v3] arm64: Implement optimised IP checksum helpers
In-Reply-To: <4cef631ae5ff455d080cb17c8e0fa918c9a5c067.1464714040.git.robin.murphy@arm.com>
References: <4cef631ae5ff455d080cb17c8e0fa918c9a5c067.1464714040.git.robin.murphy@arm.com>
Message-ID: <20160617170238.GB24589@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 06:04:40PM +0100, Robin Murphy wrote:
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
> Acked-by: Luke Starrett <luke.starrett@broadcom.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I now applied the correct version. Thanks for pointing out.

-- 
Catalin
