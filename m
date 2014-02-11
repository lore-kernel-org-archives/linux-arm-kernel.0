From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Feb 2014 10:29:55 +0800
Subject: [RFC PATCH V2 3/4] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1391703531-12845-4-git-send-email-steve.capper@linaro.org>
References: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
 <1391703531-12845-4-git-send-email-steve.capper@linaro.org>
Message-ID: <CACVXFVM6vbtHQo=EhvX3LKqKSjE2169Bo6KMdA1E_mdasW766Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 12:18 AM, Steve Capper <steve.capper@linaro.org> wrote:
> In order to implement fast_get_user_pages we need to ensure that the
> page table walker is protected from page table pages being freed from
> under it.
>
> This patch enables HAVE_RCU_TABLE_FREE and incorporates it into the
> existing arm64 TLB logic. Any page table pages belonging to address
> spaces with multiple users will be call_rcu_sched freed. Meaning
> that disabling interrupts will block the free and protect the fast
> gup page walker.
>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Tested-by: Ming Lei <ming.lei@canonical.com>

Without patch 3 and 4 in this patchset, we can't run go script
successfully with thp enabled on arm64, after applying the two
patches,  go can start working.

Thanks,
--
Ming Lei
