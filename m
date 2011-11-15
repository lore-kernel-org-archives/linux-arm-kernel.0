From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 15 Nov 2011 14:41:32 +0530
Subject: [PATCH 4/4] ARM: PL330: Fix typo in _prepare_ccr()
In-Reply-To: <1320244259-10496-4-git-send-email-javi.merino@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
 <1320244259-10496-4-git-send-email-javi.merino@arm.com>
Message-ID: <CAJe_Zhd78O=5UzekDA1veZaA1Ru2Bax_iBKckmdC++Kwg+pkCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 November 2011 20:00, Javi Merino <javi.merino@arm.com> wrote:
> scctl should be shifted by CC_SRCCTRL_SHFT and dcctl by
> CC_DSTCCTRL_SHFT, not the other way round.
>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> Cc: Jassi Brar <jassi.brar@samsung.com>
> ---
> ?arch/arm/common/pl330.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 590fd57..1817963 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -1211,8 +1211,8 @@ static inline u32 _prepare_ccr(const struct pl330_reqcfg *rqc)
> ? ? ? ?ccr |= (rqc->brst_size << CC_SRCBRSTSIZE_SHFT);
> ? ? ? ?ccr |= (rqc->brst_size << CC_DSTBRSTSIZE_SHFT);
>
> - ? ? ? ccr |= (rqc->dcctl << CC_SRCCCTRL_SHFT);
> - ? ? ? ccr |= (rqc->scctl << CC_DSTCCTRL_SHFT);
> + ? ? ? ccr |= (rqc->scctl << CC_SRCCCTRL_SHFT);
> + ? ? ? ccr |= (rqc->dcctl << CC_DSTCCTRL_SHFT);
>
> ? ? ? ?ccr |= (rqc->swap << CC_SWAP_SHFT);
>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
