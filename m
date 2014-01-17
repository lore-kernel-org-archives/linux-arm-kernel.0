From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Fri, 17 Jan 2014 21:35:40 +0900
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <87y52fok4r.fsf@linaro.org>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
 <1389876527-13498-1-git-send-email-zhangfei.gao@linaro.org>
 <87y52fok4r.fsf@linaro.org>
Message-ID: <003401cf1380$a194aa10$e4bdfe30$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, January 17, 2014, Kevin Hilman wrote:
> Zhangfei Gao <zhangfei.gao@linaro.org> writes:
> 
> > Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
> > CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
> > can not be checked by IS_ERR_VALUE.
> > Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
> > otherwise sd detect may occasionally fail.
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> I didn't look at the patch in detail, but can at least confirm that
> Arndale boots again in -next with this patch applied.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
