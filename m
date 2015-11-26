From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Nov 2015 18:17:36 +0000
Subject: [PATCHv2 1/2] arm64: mm: detect bad __create_mapping uses
In-Reply-To: <1448285180-15389-1-git-send-email-mark.rutland@arm.com>
References: <1448285180-15389-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151126181736.GU3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 01:26:19PM +0000, Mark Rutland wrote:
> If a caller of __create_mapping provides a PA and VA which have
> different sub-page offsets, it is not clear which offset they expect to
> apply to the mapping, and is indicative of a bad caller.
> 
> In some cases, the region we wish to map may validly have a sub-page
> offset in the physical and virtual addresses. For example, EFI runtime
> regions have 4K granularity, yet may be mapped by a 64K page kernel. So
> long as the physical and virtual offsets are the same, the region will
> be mapped at the expected VAs.
> 
> Disallow calls with differing sub-page offsets, and WARN when they are
> encountered, so that we can detect and fix such cases.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Steve Capper <steve.capper@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Will Deacon <will.deacon@arm.com>

On both patches:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Since they don't look urgent, I'll leave them to Will for 4.5.

-- 
Catalin
