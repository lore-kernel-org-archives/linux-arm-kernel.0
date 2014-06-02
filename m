From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 2 Jun 2014 12:18:34 -0300
Subject: [PATCH -mm] mm, compaction: properly signal and act upon lock and
 need_sched() contention - fix
In-Reply-To: <538C8B45.6070803@suse.cz>
References: <1399904111-23520-1-git-send-email-vbabka@suse.cz>
 <1400233673-11477-1-git-send-email-vbabka@suse.cz>
 <CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>
 <CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>
 <537F082F.50501@suse.cz>
 <CAOMZO5BKaicq7NkoJO4vU5W3hiDike6kSdH+2eD=h0B5BsDjTg@mail.gmail.com>
 <538C8B45.6070803@suse.cz>
Message-ID: <CAOMZO5CCMwT9fPie1-JF+zqBfk4AYjuD43dwEEkRYqOjUPLN2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 2, 2014 at 11:33 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> compact_should_abort() returns true instead of false and vice versa
> due to changes between v1 and v2 of the patch. This makes both async
> and sync compaction abort with high probability, and has been reported
> to cause e.g. soft lockups on some ARM boards, or drivers calling
> dma_alloc_coherent() fail to probe with CMA enabled on different boards.
>
> This patch fixes the return value to match comments and callers expecations.
>
> Reported-and-tested-by: Kevin Hilman <khilman@linaro.org>
> Reported-and-tested-by: Shawn Guo <shawn.guo@linaro.org>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
