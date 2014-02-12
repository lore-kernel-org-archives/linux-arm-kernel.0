From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Feb 2014 13:47:07 +0000
Subject: [PATCH 0/3] arm64: Use pte manipulation functions for THP
In-Reply-To: <20140212115004.GA14527@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
 <20140212094338.GA11325@linaro.org>
 <20140212100736.GA13441@mudshark.cambridge.arm.com>
 <20140212101602.GD29702@arm.com>
 <20140212102112.GE13441@mudshark.cambridge.arm.com>
 <20140212115004.GA14527@linaro.org>
Message-ID: <20140212134707.GL29702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:50:05AM +0000, Steve Capper wrote:
> I have noticed the following for ARM:
>  36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
> Are you happy for me to re-introduce PTE_WRITE for the 3-level code
> only, and keep L_PTE_RDONLY for the 2-level code?

But don't we create more confusion by differentiating between 2-level
and 3-level? What about L_PTE_WRITE in all cases as pure software bit
and PTE_RDONLY (without L_) defined just for LPAE.

-- 
Catalin
