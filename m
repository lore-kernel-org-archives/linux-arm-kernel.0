Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996E3C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:30:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AF3206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XrXzPy6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AF3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mk8IGL6pDhKNpdBN9rN2NaQKjdZRjw4Q4XwT5bXSmSk=; b=XrXzPy6S/vrwHL
	GyiHJWb/eV8unUu5d3AfhbQL4vaw3GZ2U5nSqI+9QP1UUnKb553aTLzmgmPA+bA6+nOloHli8xESe
	FJ3xyztyUySf7WJBUV5Xr/fRUaiH5Ry7r7kysEKjZrcrHAzXMf0n+GKocF8dQ59QZ7CBk32K4mXnx
	Qi3yZDGzdJJTKCVV6GvCYF/wKI+4zilboQZfuamqC/n3iXxt3t8Asz3sWG1QpO6QkTCDpsyCnMX+u
	rbrVfN7jnMoVF2wKRV7C9+89ksrjelddLUHdfIITYMSZgzQ+tU3cvrQbwRg6PX7M7sAHzKDAdQAi5
	R9ZFQVCa5vN3557hfTrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghErv-0004ZQ-8k; Wed, 09 Jan 2019 14:30:07 +0000
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghErq-0003t2-Np
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:30:05 +0000
Received: from [IPv6:2001:420:44c1:2579:f8c4:4546:22d:c704]
 ([IPv6:2001:420:44c1:2579:f8c4:4546:22d:c704])
 by smtp-cloud7.xs4all.net with ESMTPA
 id hErYgk5pABDyIhErbgX5lK; Wed, 09 Jan 2019 15:29:55 +0100
Subject: Re: [PATCH 2/2] media: cedrus: Allow using the current dst buffer as
 reference
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com
References: <20190109141920.12677-1-paul.kocialkowski@bootlin.com>
 <20190109141920.12677-2-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9a624f6a-0c38-f2c9-3f2d-2758f9a19299@xs4all.nl>
Date: Wed, 9 Jan 2019 15:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190109141920.12677-2-paul.kocialkowski@bootlin.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfHvQpieu/qhYiJABI7cDkWdbhBzdhR89AXpd3rc78imSyE5YzzwGte5E9IpIGNdUOJ61vx6mvqPuwg93UA6ZbcHEzajFmAAoY8wY2Xeo+76nStXZtvXo
 A42cSvcQwNuqpbHultnZ+RGSx/T6o/cgfB/t0ht7c+ynVrwA6hz1+jk5EKiWty2gE1WmxLEpupOqlnoTFw9doWupcYOV2py3LIutLYQ8YsStyIDOvLy7G4gg
 qPLJ0PaIn3b1+FbTy0IdwCMYDHxBEadtlwIGZOcrqT9/S6vYxEsLoRb4DaEBnt6j1MP5EEqx9J67atroa1wr2RN7iB/F7nRNAzFgWdX3kSt8K6GZPTIkxjc5
 tIiEZtwj8lcNovcH/M67rIK9gOKkL12fu82b5GwQxv5Z84c1IGBFOY9wyVAale4AdqHtbO6bYJG/QpV0xpMZmHK28AtXBb7DA1uVxvwoSDhaNqt5DS5gYGNu
 3TUGlAELU1l+Vy/Ay8RwjPwBAKKf7/XDbUDKHqlAQgWLG6igfWQCCUMC5UGzMuSmgGY5YBqPssif95mcpJ5SwYhu1KyNCJHUoHP35x//WRVF12U0WhVSTy2y
 eJk9G/j7dYn58Z3gkBcj/MIt5ND5bA/RqjtTcHnx4VGAF/oK+C/OzS+ZNuOaimRZSDZFvYR0awLiJd/rw6Mp8sTV4fLg8OcBIP+SCGaz1VSAEz6xdKwBPCOC
 S9i7Pw0OEvt+cpU9NrN/kO9TgGqFnxw4S+EulPQgd+nrkSAKpmdMIU3y//IXfaw6rrIAz1RIhxsZBG13cWiMPLqiLrfKQ+ZcLkUYNAeWevLlSPPixQjkDnOE
 cxmNGAvruG/GLhAu7yE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_063002_956383_EC4DF89A 
X-CRM114-Status: GOOD (  21.63  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Li <ayaka@soulik.info>,
 Tomasz Figa <tfiga@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/09/19 15:19, Paul Kocialkowski wrote:
> It was reported that some cases of interleaved video decoding require
> using the current destination buffer as a reference. However, this is
> no longer possible after the move to vb2_find_timestamp because only
> dequeued and done buffers are considered.
> 
> Add a helper in our driver that also considers the current destination
> buffer before resorting to vb2_find_timestamp and use it in MPEG-2.

This patch looks good, but can you also add checks to handle the case
when no buffer with the given timestamp was found? Probably should be done
in a third patch.

I suspect the driver will crash if an unknown timestamp is passed on to the
driver. I would really like to see that corner case fixed.

Regards,

	Hans

> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 13 +++++++++++++
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.h   |  2 ++
>  drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c | 10 ++++++----
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> index 443fb037e1cf..2c295286766c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -22,6 +22,19 @@
>  #include "cedrus_dec.h"
>  #include "cedrus_hw.h"
>  
> +int cedrus_reference_index_find(struct vb2_queue *queue,
> +				struct vb2_buffer *vb2_buf, u64 timestamp)
> +{
> +	/*
> +	 * Allow using the current capture buffer as reference, which can occur
> +	 * for field-coded pictures.
> +	 */
> +	if (vb2_buf->timestamp == timestamp)
> +		return vb2_buf->index;
> +	else
> +		return vb2_find_timestamp(queue, timestamp, 0);
> +}
> +
>  void cedrus_device_run(void *priv)
>  {
>  	struct cedrus_ctx *ctx = priv;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
> index d1ae7903677b..8d0fc248220f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
> @@ -16,6 +16,8 @@
>  #ifndef _CEDRUS_DEC_H_
>  #define _CEDRUS_DEC_H_
>  
> +int cedrus_reference_index_find(struct vb2_queue *queue,
> +				struct vb2_buffer *vb2_buf, u64 timestamp);
>  void cedrus_device_run(void *priv);
>  
>  #endif
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> index cb45fda9aaeb..81c66a8aa1ac 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -10,6 +10,7 @@
>  #include <media/videobuf2-dma-contig.h>
>  
>  #include "cedrus.h"
> +#include "cedrus_dec.h"
>  #include "cedrus_hw.h"
>  #include "cedrus_regs.h"
>  
> @@ -159,8 +160,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
>  
>  	/* Forward and backward prediction reference buffers. */
> -	forward_idx = vb2_find_timestamp(cap_q,
> -					 slice_params->forward_ref_ts, 0);
> +	forward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
> +						  slice_params->forward_ref_ts);
>  
>  	fwd_luma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 0);
>  	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 1);
> @@ -168,8 +169,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
>  	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
>  
> -	backward_idx = vb2_find_timestamp(cap_q,
> -					  slice_params->backward_ref_ts, 0);
> +	backward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
> +						   slice_params->backward_ref_ts);
> +
>  	bwd_luma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 0);
>  	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 1);
>  
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
