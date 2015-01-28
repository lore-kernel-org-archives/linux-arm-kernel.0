From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Wed, 28 Jan 2015 11:23:39 -0200
Subject: [PATCH v3] dma-buf: cleanup dma_buf_export() to make it easily
 extensible
In-Reply-To: <1422449643-7829-1-git-send-email-sumit.semwal@linaro.org>
References: <1422449643-7829-1-git-send-email-sumit.semwal@linaro.org>
Message-ID: <20150128112339.164c55fd@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, 28 Jan 2015 18:24:03 +0530
Sumit Semwal <sumit.semwal@linaro.org> escreveu:

> +/**
> + * helper macro for exporters; zeros and fills in most common values
> + */
> +#define DEFINE_DMA_BUF_EXPORT_INFO(a)	\
> +	struct dma_buf_export_info a = { .exp_name = KBUILD_MODNAME }
> +

I suspect that this will let the other fields not initialized.

You likely need to do:

#define DEFINE_DMA_BUF_EXPORT_INFO(a)	\
	struct dma_buf_export_info a = { 	\
	.exp_name = KBUILD_MODNAME;		\
	.fields = 0;				\
...
}

Regards,
Mauro
