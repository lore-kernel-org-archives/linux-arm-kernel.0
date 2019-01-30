Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267EAC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:59:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E952720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rfSYFKsZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VECr5WqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E952720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fiWwjpy+tk3y4P1rOh8/qq1euWfasN1QhNNMTlLonG0=; b=rfSYFKsZG9KXPqpv7IkqEk/R5
	IsI0hbnC8F7fOfzxhlZ3u2ZvJeSZzyfuCbRR7ttS3NhWWmARCfNI7+WvZuk4ca2RdiPSnEM1sz4iu
	10kB5uju/WSyyyTiFEe9VFKSwt5H1H5gGC0+CKDmB8PqgOMe4EP64ZqgWpqUwofeORd6+zou/V1wm
	RI81ZvyyNR0vr1sOq0vkUkRJW0x5ZLm23bC1EbyQeDyZTfurw2s5fgDQMu58C1cyU4CUp1rcAb2ij
	Xv62/rGFZ22YkYaSjz+LlSaEbDD+eGemLPekrlLOzrQ1tajSrgQ4lRvJ6+z6dQ/Gx00DPGVcTZOXe
	v75j5E/rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goiuF-0002A7-W3; Wed, 30 Jan 2019 05:59:28 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goiuD-00029U-CA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 05:59:26 +0000
Received: by mail-pg1-x544.google.com with SMTP id z10so9881977pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 21:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HlqPkWRicV9BOj0h7GSFdFM+t2KAK/T/3R7673j2NLg=;
 b=VECr5WqPbfw8w43Ly2MhUA5agL0OXJDwOCwlKyKwVzgS134IfRzrAf/O4fSolT4hZX
 eIStVsu2RBzbBZNVWaWaH6DmYwzZWKevpvilFlAx3Z7FdRjo6NAmjXj3SVAChgMhOq3v
 SSylbVcihT/vSCAq7mBWPGYGVSa00HkODgg00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HlqPkWRicV9BOj0h7GSFdFM+t2KAK/T/3R7673j2NLg=;
 b=gIdfyGd8Lp2jao4Fq2uJmykynMBnRwtaImLdAD6EnLtQSypicM7yqwmWTRvRLF8abR
 m/o7CO/4bpm3EbnYCTMiJjICFQKgzb1tpiausuymbVe7xCj05R9sJqYbo1PTyOdV669e
 GrGqVPxYs5pUxGvmySlFtdYVG3Ls2RVKhTOSWN0+oO0EW6r+oTRfGW0vxlB2msx6wi33
 lDn7Kk1yG13oHAkWD/hP8y3Hm1hdEMIxI5MKftXbVIhFJx1ri0adNxrpUfoLv3Ggz/fT
 gZDegDlDAqaTkTPR/FQIRzrGOL3KOw5XTYy5k0ZmCvqDoNgvjgD6I4Km1RMWHA/SIatd
 PDgg==
X-Gm-Message-State: AJcUukeJ3r6hnOTJ6m0F4qbezRsMKFRG7Pr8IfdYP4pqOA1hxMgiFrKM
 Iz0wyr1JqI/eFFd52VxChGLOog==
X-Google-Smtp-Source: ALg8bN6W3WgkVXMV9e3mjQxX/hEuiG3E8VBXzEYhpqp+JLOFAZ35AnbEivgODr5j0j0zjLhtsfELbQ==
X-Received: by 2002:a63:d50f:: with SMTP id c15mr26409996pgg.287.1548827964113; 
 Tue, 29 Jan 2019 21:59:24 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.gmail.com with ESMTPSA id x186sm787141pfb.59.2019.01.29.21.59.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 21:59:23 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH 03/10] soc: mediatek: move the CMDQ_IRQ_MASK into cmdq
 driver data
To: Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 CK HU <ck.hu@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <e5cffd3f-5b65-b3f3-80d8-b0567bd4baf3@chromium.org>
Date: Wed, 30 Jan 2019 13:59:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_215925_445655_E7EF6E86 
X-CRM114-Status: GOOD (  20.26  )
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
> The interrupt mask and thread number has positive correlation,
> so we move the CMDQ_IRQ_MASK into cmdq driver data and calculate
> it by thread number.
>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c 
b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 909eb23..f6174ca 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -17,7 +17,6 @@
>   #include <linux/of_device.h>
>
>   #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
> -#define CMDQ_IRQ_MASK			0xffff
>   #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
>
>   #define CMDQ_CURR_IRQ_STATUS		0x10
> @@ -71,6 +70,7 @@ struct cmdq {
>   	void __iomem		*base;
>   	u32			irq;
>   	u32			thread_nr;
> +	u32			irq_mask;
>   	struct cmdq_thread	*thread;
>   	struct clk		*clock;
>   	bool			suspended;
> @@ -284,11 +284,11 @@ static irqreturn_t cmdq_irq_handler(int irq, 
void *dev)
>   	unsigned long irq_status, flags = 0L;
>   	int bit;
>
> -	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
> -	if (!(irq_status ^ CMDQ_IRQ_MASK))
> +	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & cmdq->irq_mask;
> +	if (!(irq_status ^ cmdq->irq_mask))
>   		return IRQ_NONE;
>
> -	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
> +	for_each_clear_bit(bit, &irq_status, fls(cmdq->irq_mask)) {
>   		struct cmdq_thread *thread = &cmdq->thread[bit];
>
>   		spin_lock_irqsave(&thread->chan->lock, flags);
> @@ -472,6 +472,9 @@ static int cmdq_probe(struct platform_device *pdev)
>   		dev_err(dev, "failed to get irq\n");
>   		return -EINVAL;
>   	}
> +
> +	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>   	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
>   			       "mtk_cmdq", cmdq);
>   	if (err < 0) {
> @@ -489,6 +492,7 @@ static int cmdq_probe(struct platform_device *pdev)
>   	}
>
>   	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);

The cmdq->thread_nr and cmdq->irq_mask are already set above, so these 
two lines can be removed.

>   	cmdq->mbox.dev = dev;
>   	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
>   					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
