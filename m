From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 17:57:09 +0000
Subject: [PATCH V2] arm64: mm: Route pmd thp functions through pte
 equivalents
In-Reply-To: <1393322533-23725-1-git-send-email-steve.capper@linaro.org>
References: <1393322533-23725-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140314175709.GM18126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 10:02:13AM +0000, Steve Capper wrote:
> Rather than have separate hugetlb and transparent huge page pmd
> manipulation functions, re-wire our thp functions to simply call the
> pte equivalents.
> 
> This allows THP to take advantage of the new PTE_WRITE logic introduced
> in:
>   c2c93e5 arm64: mm: Introduce PTE_WRITE
> 
> To represent splitting THPs we use the PTE_SPECIAL bit as this is not
> used for pmds.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Applied. Thanks.

-- 
Catalin
