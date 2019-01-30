Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BAC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:01:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2CA20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZZlyMty";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wi6gewMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2CA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tqFB4MsURh8XMeH/WcockRPx+o5yfaRPQiQr2X1GKRE=; b=AZZlyMtyf28ohApazbwzz8AYH
	HP0u7AiNTImiFeQAy/rIe+ayD6m0E6bdu5735+Q67obuL3ax0H1CsIAz72SDvQrm0jKSwE2msHmO3
	VjVlixXtwPawInY2XLw5Wr4JSul6fNUAWeySJA2wRgrmRiIeQ3mfroghDzlQ0eBnSbe+Y/a1J2prf
	U13/M3EG8rVAG0LRKGPFDoHh5KJpfsFXajjoxFctt3mPZ4bJDCXNDLksDzjDSDFf6zgRqfftTs/Kr
	bAy9JeDbXxGQLaT+I7RLdSJcUSeGPzEL1MBMihGhEtDpO0BVkptB21VogkImTpBykCChEOwSmJiAN
	TJIgNrDqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goiw1-0004H4-Jj; Wed, 30 Jan 2019 06:01:17 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goivj-00043l-SA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 06:01:09 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so9866073pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 22:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RKKy7Zp7rHZIgz0Vlqdz0knCbBY+6CXoKW8FO1Am1iA=;
 b=Wi6gewMNPfCuXhGbctuuPwEPCohGiR7PHkl3xxMZscIE8PVutOFjG6IctY77YggX8a
 D64ttY3/WQK0MnrcHZfU2jJBUkHHecb1WBy88ni+4GoonYavRNaYx63tZQCNzTw71/Mo
 1384JzJ+PtchdC4Z+14dQvVVTxbqXtj3PLvPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RKKy7Zp7rHZIgz0Vlqdz0knCbBY+6CXoKW8FO1Am1iA=;
 b=CtWm3rx5MS/9qNCifbznbWYyP7gukKkyKO8W0ovBod3e7gTYiyApoSLL8eqTS5tArX
 I1A/uvPSERnqrCol6ycN6rcvOZ+9V1pCqRXkQLCfSsCwYoeCxZFsE/9wTaLBcK+2Ar0I
 Uu5HoqswpnmadntP0tqyNvHwt0h1l2La4bR/L4hdcP/BMKidSd2kphVDsNMq1wgzIdq5
 RbT6V3AjZ93hdcTL3RXHsv38F8o8yaX9CQQ/aBoXkySDfaWnUsLOK5bAOtaFQlQFqMcf
 MEV0yXmUa/xJQFCG92VAc4+bNtxYTwYJFyoWmNVQTU/a/Vpx+xNeTtEohey4TTdDp/40
 3CpA==
X-Gm-Message-State: AJcUukeBrm4VnI63K9J6emoqAqQKSlXEMWlKhYWyEDMgCB5ZqbP3JHGL
 nwUjNT3LixtMGZqWeJGHzZFn0A==
X-Google-Smtp-Source: ALg8bN5Y2WzVzwuUyOkOjtFgT7y7OWrAS7VbV2j9Hzs8UbwwevKW+UjYzQrize81jlFNzK3gtJuOeQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr24414736pgd.97.1548828058939; 
 Tue, 29 Jan 2019 22:00:58 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.gmail.com with ESMTPSA id f62sm683412pgc.67.2019.01.29.22.00.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 22:00:58 -0800 (PST)
Subject: Re: [PATCH 07/10] soc: mediatek: add cmdq_dev_get_event function
To: Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 CK HU <ck.hu@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-8-git-send-email-bibby.hsieh@mediatek.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Message-ID: <4d6f8e17-58d7-2986-29b0-3e0134836929@chromium.org>
Date: Wed, 30 Jan 2019 14:00:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-8-git-send-email-bibby.hsieh@mediatek.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_220100_796287_73F32463 
X-CRM114-Status: GOOD (  19.47  )
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
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 Sascha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com,
 Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Houlong Wei <houlong.wei@mediatek.com>,
 Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>, kendrick.hsu@mediatek.com,
 linux-mediatek@lists.infradead.org, ginny.chen@mediatek.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Frederic Chen <Frederic.Chen@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/29/2019 03:32 PM, Bibby Hsieh wrote:
> When client ask gce to clear or wait for event,
> client need to pass event number to the API.
> We suggest client store the event information in device node,
> so we provide an API for client parse the event property.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 29 +++++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 6ad997f..16c0393 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -56,6 +56,35 @@ struct cmdq_base *cmdq_register_device(struct device *dev)
>   }
>   EXPORT_SYMBOL(cmdq_register_device);
>   
> +s32 cmdq_dev_get_event(struct device *dev, const char *name)
> +{
> +	s32 index = 0;
> +	struct of_phandle_args spec;
> +	s32 result;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	index = of_property_match_string(dev->of_node, "gce-event-names", name);
> +	if (index < 0) {
> +		dev_err(dev, "no gce-event-names property or no such event:%s",
> +			name);
> +		return index;
> +	}
> +
> +	if (of_parse_phandle_with_args(dev->of_node, "gce-events",
> +	    "#gce-event-cells", index, &spec)) {

nit: Should have more indention for the line above. (Align with the
dev->of_node?)

> +		dev_err(dev, "can't parse gce-events property");
> +		return -ENODEV;
> +	}
> +
> +	result = spec.args[0];
> +	of_node_put(spec.np);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(cmdq_dev_get_event);
> +
>   static void cmdq_client_timeout(struct timer_list *t)
>   {
>   	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index a1f5eb6..e5b0a98 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -139,5 +139,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>   
>   u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
>   struct cmdq_base *cmdq_register_device(struct device *dev);
> +s32 cmdq_dev_get_event(struct device *dev, const char *name);
>   
>   #endif	/* __MTK_CMDQ_H__ */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
