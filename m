From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 11:48:41 +0100
Subject: [PATH V2 5/6] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1408635812-31584-6-git-send-email-steve.capper@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-6-git-send-email-steve.capper@linaro.org>
Message-ID: <20140827104840.GH6968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 04:43:31PM +0100, Steve Capper wrote:
> In order to implement fast_get_user_pages we need to ensure that the
> page table walker is protected from page table pages being freed from
> under it.
> 
> This patch enables HAVE_RCU_TABLE_FREE, any page table pages belonging
> to address spaces with multiple users will be call_rcu_sched freed.
> Meaning that disabling interrupts will block the free and protect the
> fast gup page walker.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

I'm happy to take this patch independently of this series. But if the
whole series goes in via some other tree (mm):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
