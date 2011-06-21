From: kishorek.kadiyala@gmail.com (Kishore Kadiyala)
Date: Tue, 21 Jun 2011 11:11:50 +0530
Subject: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
In-Reply-To: <1308518257-9783-3-git-send-email-per.forlin@linaro.org>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-3-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>

> +
> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?bool is_first_req)

I don't see the usage of "is_first_req" below.
Is it required?

> +{
> + ? ? ? struct omap_hsmmc_host *host = mmc_priv(mmc);
> +
> + ? ? ? if (mrq->data->host_cookie) {
> + ? ? ? ? ? ? ? mrq->data->host_cookie = 0;
> + ? ? ? ? ? ? ? return ;
> + ? ? ? }
> +
> + ? ? ? if (host->use_dma)
> + ? ? ? ? ? ? ? if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &host->next_data))
> + ? ? ? ? ? ? ? ? ? ? ? mrq->data->host_cookie = 0;
> +}
> +
> ?/*

Regards,
Kishore
