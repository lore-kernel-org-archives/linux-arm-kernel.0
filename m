From: davem@davemloft.net (David Miller)
Date: Fri, 28 Aug 2015 14:26:40 -0700 (PDT)
Subject: [PATCH net-next 6/8] net: thunderx: Rework interrupt handler
In-Reply-To: <1440774004-27923-6-git-send-email-aleksey.makarov@auriga.com>
References: <1440774004-27923-1-git-send-email-aleksey.makarov@auriga.com>
 <1440774004-27923-6-git-send-email-aleksey.makarov@auriga.com>
Message-ID: <20150828.142640.647193074690125620.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <aleksey.makarov@auriga.com>
Date: Fri, 28 Aug 2015 17:59:58 +0300

> @@ -251,6 +251,8 @@ struct cmp_queue {
>  	void		*desc;
>  	struct q_desc_mem   dmem;
>  	struct cmp_queue_stats	stats;
> +	int		irq;
> +	cpumask_t	affinity_mask;
>  } ____cacheline_aligned_in_smp;
>  
>  struct snd_queue {

This new "affinity_mask" member is not used, please remove it and respin
this patch series.

Thanks.
