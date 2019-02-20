Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD255C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:37:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A833A214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="scGLs/Qc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky5RQCtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A833A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uk65Y0lkq80hXWE9Ioz+iYtbQYcQqM4zKopMrGpfNPc=; b=scGLs/QcGzM0Di
	Rudd+OUoacWEsDPjouyh+9GvNio5tzQrgWGFuJTsx9WnUegaMTCtXW9uf+LCcrN9+wxH5MN/bXqkW
	i04V6A0Oxao9W7Cz23pJhLUPejtsj659XsRn+so1n9EATzCdxiSYEByyZy2dx9quICo+S3tHVbGbW
	ijfL3WZ4qgPJiiubf56dxLVJby9xrTO5lz/0cBzY0BhH8YAzg9N5yaxV3JPyed4reOqcphl1R1DFV
	kk36c/dLtJlaZkRZnpep06Ooaf6WWLRcBmS4q9+XyPIvsdpogfbOmssWANft52cFJ/B4vl5KMq2Uj
	KEWadFSs+Nh+Fv85ce1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwXg9-0008NC-JJ; Wed, 20 Feb 2019 19:37:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwXg6-0008Mo-Rq; Wed, 20 Feb 2019 19:37:12 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F01872147A;
 Wed, 20 Feb 2019 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550691430;
 bh=ls9Kb/WUZC2EEQcYIXRlGgc5kXAjNg6isxqpbbiI54c=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=ky5RQCttZLD9W7GPElvHfb73aS1HjSxHPKu1hxFx290GUDtGun6k+iQ6Xy8MFBpAq
 g9BED9OpfiZbWRT3FqIwJyuQ9q61CecNsr9bhvUAenG7SXoFLfAdjTOR1EcFznnIAi
 IRYq3jdv1SCPRKSXAX1M+8OhJI5VlU/M1N53q8Uc=
MIME-Version: 1.0
Subject: Re: [PATCH V5 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Message-ID: <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
 <20190220025357.7354-6-wangyan.wang@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190220025357.7354-6-wangyan.wang@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Michael Turquette <mturquette@baylibre.com>,
 wangyan wang <wangyan.wang@mediatek.com>
Date: Wed, 20 Feb 2019 11:37:09 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_113710_923357_40B3612A 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>,
 David Airlie <airlied@linux.ie>, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, wangyan wang <wangyan.wang@mediatek.com>,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting wangyan wang (2019-02-19 18:53:54)
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.

s/falgs/flags/

> Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c |  2 +-
>  drivers/clk/mediatek/clk-mtk.h | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 9c0ae4278a94..2ed996404804 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -167,7 +167,7 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
>                 mux->mask = BIT(mc->mux_width) - 1;
>                 mux->shift = mc->mux_shift;
>                 mux->lock = lock;
> -
> +               mux->flags = mc->mux_flags;
>                 mux_hw = &mux->hw;
>                 mux_ops = &clk_mux_ops;
>  
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index f83c2bbb677e..4b88d196d52f 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -81,15 +81,13 @@ struct mtk_composite {
>         signed char divider_shift;
>         signed char divider_width;
>  
> +       unsigned char mux_flags;

Why isn't it an unsigned long? Isn't this supposed to match the
frameworks version of the clk flags?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
