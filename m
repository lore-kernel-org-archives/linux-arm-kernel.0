Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:23:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3528F20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXR/NhIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3528F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTEF203N3oUUbQLYXCbBfh/gcslbGEqhVWa3/13/r84=; b=qXR/NhIH5e1f6o
	JHLUQ/4UVMd/NxKj7WgPZ9icuKc17m5TIKzMXU0u77/4L0Vt2V+zMm6yqSk77YvO48AJaoit/v7nm
	K4+HbVnvty1FQdKDzTYsf2lvIPtbVfJQzPLVi6rTYZEsJb728iM1yC5wWb1Use9b66g2A1jQPl7z+
	2SQJ+Ox7XHSrfVGeaCytsLOvfxCX/3MhcySsNiLFJd4ctTyAhPEItr3ImlmRRmhBU3ChsspnCMG9C
	j5YUTID2ec0/nLD9uIvj80Lig83bngEUQmNYlVg4R9zT62xKVD8uqhpTr5Oo+N8l87C2xTjhNt6z5
	EOKPI04HbUsLSEUT+cQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPbu-0003di-MO; Tue, 29 Jan 2019 09:23:14 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPbj-0003bQ-Qg; Tue, 29 Jan 2019 09:23:11 +0000
X-UUID: 5ba96a199ed946babb70797dc51f5163-20190129
X-UUID: 5ba96a199ed946babb70797dc51f5163-20190129
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1136185235; Tue, 29 Jan 2019 01:22:59 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 01:22:57 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 17:22:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 17:22:56 +0800
Message-ID: <1548753776.11055.4.camel@mtksdaap41>
Subject: Re: [PATCH 03/10] soc: mediatek: move the CMDQ_IRQ_MASK into cmdq
 driver data
From: CK Hu <ck.hu@mediatek.com>
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
Date: Tue, 29 Jan 2019 17:22:56 +0800
In-Reply-To: <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012304_000312_642BDCEA 
X-CRM114-Status: GOOD (  15.05  )
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
 Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 kendrick.hsu@mediatek.com, Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>,
 Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>, YT
 Shen <yt.shen@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Houlong Wei <houlong.wei@mediatek.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Frederic Chen <Frederic.Chen@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, ginny.chen@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Bibby:

On Tue, 2019-01-29 at 15:32 +0800, Bibby Hsieh wrote:
> The interrupt mask and thread number has positive correlation,
> so we move the CMDQ_IRQ_MASK into cmdq driver data and calculate
> it by thread number.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 909eb23..f6174ca 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -17,7 +17,6 @@
>  #include <linux/of_device.h>
>  
>  #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
> -#define CMDQ_IRQ_MASK			0xffff
>  #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
>  
>  #define CMDQ_CURR_IRQ_STATUS		0x10
> @@ -71,6 +70,7 @@ struct cmdq {
>  	void __iomem		*base;
>  	u32			irq;
>  	u32			thread_nr;
> +	u32			irq_mask;
>  	struct cmdq_thread	*thread;
>  	struct clk		*clock;
>  	bool			suspended;
> @@ -284,11 +284,11 @@ static irqreturn_t cmdq_irq_handler(int irq, void *dev)
>  	unsigned long irq_status, flags = 0L;
>  	int bit;
>  
> -	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
> -	if (!(irq_status ^ CMDQ_IRQ_MASK))
> +	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & cmdq->irq_mask;
> +	if (!(irq_status ^ cmdq->irq_mask))
>  		return IRQ_NONE;
>  
> -	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
> +	for_each_clear_bit(bit, &irq_status, fls(cmdq->irq_mask)) {

for_each_clear_bit(bit, &irq_status, cmdq->thread_nr) {

Regards,
CK

>  		struct cmdq_thread *thread = &cmdq->thread[bit];
>  
>  		spin_lock_irqsave(&thread->chan->lock, flags);
> @@ -472,6 +472,9 @@ static int cmdq_probe(struct platform_device *pdev)
>  		dev_err(dev, "failed to get irq\n");
>  		return -EINVAL;
>  	}
> +
> +	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>  	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
>  			       "mtk_cmdq", cmdq);
>  	if (err < 0) {
> @@ -489,6 +492,7 @@ static int cmdq_probe(struct platform_device *pdev)
>  	}
>  
>  	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>  	cmdq->mbox.dev = dev;
>  	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
>  					sizeof(*cmdq->mbox.chans), GFP_KERNEL);



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
