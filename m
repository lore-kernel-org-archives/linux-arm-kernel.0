From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 5 Dec 2016 09:52:20 +0100
Subject: [PATCH v1 1/2] Add crypto driver support for some MediaTek chips
In-Reply-To: <1480921284-45827-2-git-send-email-ryder.lee@mediatek.com>
References: <1480921284-45827-1-git-send-email-ryder.lee@mediatek.com>
 <1480921284-45827-2-git-send-email-ryder.lee@mediatek.com>
Message-ID: <20161205085220.GA333@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I have two minor comment.

On Mon, Dec 05, 2016 at 03:01:23PM +0800, Ryder Lee wrote:
> This adds support for the MediaTek hardware accelerator on
> mt7623/mt2701/mt8521p SoC.
> 
> This driver currently implement:
> - SHA1 and SHA2 family(HMAC) hash alogrithms.

There is a typo for algorithms.

[...]
> +/**
> + * struct mtk_desc - DMA descriptor
> + * @hdr:	the descriptor control header
> + * @buf:	DMA address of input buffer segment
> + * @ct:		DMA address of command token that control operation flow
> + * @ct_hdr:	the command token control header
> + * @tag:	the user-defined field
> + * @tfm:	DMA address of transform state
> + * @bound:	align descriptors offset boundary
> + *
> + * Structure passed to the crypto engine to describe where source
> + * data needs to be fetched and how it needs to be processed.
> + */
> +struct mtk_desc {
> +	u32 hdr;
> +	u32 buf;
> +	u32 ct;
> +	u32 ct_hdr;
> +	u32 tag;
> +	u32 tfm;
> +	u32 bound[2];
> +};

Do you have tested this descriptor with BE/LE kernel ?

Regards
Corentin Labbe
