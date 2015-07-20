From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Jul 2015 11:03:25 +0200
Subject: [PATCH v2 1/2] dmaengine: Add an enum for the dmaengine
 alignment constraints
In-Reply-To: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150720110325.502af335@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

On Mon, 20 Jul 2015 10:41:32 +0200, Maxime Ripard wrote:

>  /**
> + * enum dmaengine_alignment - defines alignment of the DMA async tx
> + * buffers
> + */
> +enum dmaengine_alignment {
> +	DMAENGINE_ALIGN_1_BYTE = 0,
> +	DMAENGINE_ALIGN_2_BYTES = 1,
> +	DMAENGINE_ALIGN_4_BYTES = 2,
> +	DMAENGINE_ALIGN_8_BYTES = 3,
> +	DMAENGINE_ALIGN_16_BYTES = 4,
> +	DMAENGINE_ALIGN_32_BYTES = 5,
> +	DMAENGINE_ALIGN_64_BYTES = 6,
> +};

Sorry I didn't think about this during the first iteration, but this
define is just the log2 of the values, no? So maybe you could simply do
something like:

static inline unsigned int dmaengine_alignment(size_t bytes)
{
	return ilog2(bytes);
}

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
