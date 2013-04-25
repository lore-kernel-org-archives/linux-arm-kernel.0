From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Apr 2013 14:51:06 +0100
Subject: [PATCH] ARM64: mm: Correct show_pte behaviour.
In-Reply-To: <1366382971-12682-1-git-send-email-steve.capper@linaro.org>
References: <1366382971-12682-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20130425135106.GB7157@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 03:49:31PM +0100, Steve Capper wrote:
> show_pte makes use of the *_none_or_clear_bad style functions. If a
> pgd, pud or pmd is identified as being bad, it will then be cleared.
> 
> As show_pte appears to be called from either the user or kernel
> fault handlers this side effect can lead to unpredictable behaviour;
> especially as TLB entries are not invalidated.
> 
> This patch removes the page table sanitisation from show_pte. If a
> bad pgd, pud or pmd is encountered it is left unmodified.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Thanks. Applied.

-- 
Catalin
