From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Jan 2017 10:27:31 +0000
Subject: [PATCH v2] arm64: hugetlb: fix the wrong return value for
 huge_ptep_set_access_flags
In-Reply-To: <1484114520-6168-1-git-send-email-shijie.huang@arm.com>
References: <1484114520-6168-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20170111102731.GB18044@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:02:00PM +0800, Huang Shijie wrote:
> In current code, the @changed always returns the last one's
> status for the huge page with the contiguous bit set.
> This is really not what we want. Even one of the PTEs is changed,
> we should tell it to the caller.
> 
> This patch fixes this issue.
> 
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
> Cc: stable at vger.kernel.org
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>

Applied for 4.10. Thanks.

-- 
Catalin
