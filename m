From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:11:52 +0100
Subject: [PATCH 01/11] mm: hugetlb: Copy huge_pmd_share from x86 to mm.
In-Reply-To: <1369328878-11706-2-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524111152.GD18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:48PM +0100, Steve Capper wrote:
> Under x86, multiple puds can be made to reference the same bank of
> huge pmds provided that they represent a full PUD_SIZE of shared
> huge memory that is aligned to a PUD_SIZE boundary.
> 
> The code to share pmds does not require any architecture specific
> knowledge other than the fact that pmds can be indexed, thus can
> be beneficial to some other architectures.
> 
> This patch copies the huge pmd sharing (and unsharing) logic from
> x86/ to mm/ and introduces a new config option to activate it:
> CONFIG_ARCH_WANTS_HUGE_PMD_SHARE
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
