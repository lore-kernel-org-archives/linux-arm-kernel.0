From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jul 2013 18:09:49 +0100
Subject: [PATCH 1/1] ARM: atomic64: fix endian-ness in atomic.h
In-Reply-To: <1374856133-2939-2-git-send-email-victor.kamensky@linaro.org>
References: <1374856133-2939-1-git-send-email-victor.kamensky@linaro.org>
 <1374856133-2939-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20130726170949.GJ17886@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 05:28:53PM +0100, Victor Kamensky wrote:
> Fix inline asm for atomic64_xxx functions in arm atomic.h. Instead of
> %H operand specifiers code should use %Q for least significant part
> of the value, and %R for the most significant part of the value. %H
> always returns the higher of the two register numbers, and therefore
> it is not endian neutral. %H should be used with ldrexd and strexd
> instructions.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will
