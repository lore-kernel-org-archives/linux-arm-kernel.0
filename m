From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 12:46:38 +0000
Subject: [PATCH] ARM64: Improve copy_page for 128 cache line sizes.
In-Reply-To: <1450570278-19404-1-git-send-email-apinski@cavium.com>
References: <1450570278-19404-1-git-send-email-apinski@cavium.com>
Message-ID: <20151221124637.GN23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 04:11:18PM -0800, Andrew Pinski wrote:
> Adding a check for the cache line size is not much overhead.
> Special case 128 byte cache line size.
> This improves copy_page by 85% on ThunderX compared to the
> original implementation.

So this patch seems to:

  - Align the loop
  - Increase the prefetch size
  - Unroll the loop once

Do you know where your 85% boost comes from between these? I'd really
like to avoid having multiple versions of copy_page, if possible, but
maybe we could end up with something that works well enough regardless
of cacheline size. Understanding what your bottleneck is would help to
lead us in the right direction.

Also, how are you measuring the improvement? If you can share your
test somewhere, I can see how it affects the other systems I have access
to.

Will
