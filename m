From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Feb 2015 16:43:20 +0000
Subject: [PATCH] arm64: enable PTE type bit in the mask for pte_modify
In-Reply-To: <1424821221-16396-1-git-send-email-fkan@apm.com>
References: <1424821221-16396-1-git-send-email-fkan@apm.com>
Message-ID: <20150225164319.GF1105@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 03:40:21PM -0800, Feng Kan wrote:
> Caught during Trinity testing. The pte_modify does not allow
> modification for PTE type bit. This cause the test to hang
> the system. It is found that the PTE can't transit from an
> inaccessible page (b00) to a valid page (b11) because the mask
> does not allow it. This happens when a big block of mmaped
> memory is set the PROT_NONE, then the a small piece is broken
> off and set to PROT_WRITE | PROT_READ cause a huge page split.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>

It looks fine to me. Thanks.

I wonder whether mprotect() to change between PROT_NONE and an
accessible protection ever worked (I thought we tested this).

-- 
Catalin
