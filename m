From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2016 12:14:36 +0000
Subject: [RFC PATCH 01/10] arm64: mm: move assignment of 'high_memory'
 before its first use
In-Reply-To: <1456174472-30028-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456174472-30028-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160223121435.GA4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:54:23PM +0100, Ard Biesheuvel wrote:
> The variable 'high_memory' ends up being referenced in the call to
> dma_contiguous_reserve(). So move the assignment before that call.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Does this need cc stable? It looks like we've had this issue for a while
and it ends up being used in cma_declare_contiguous(). So we either get
a high enough value to not affect this function or we don't trigger this
code path very often.

-- 
Catalin
