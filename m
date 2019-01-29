Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE7AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:31:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0FB214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFeApp4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0FB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m4srey6a0bK2ZLKX/mUFlvkV96ZphYI9XYfSYV+ulME=; b=cFeApp4IFU0FEE
	xfiZ98OQLPNRyNO2Hmq06AWUzJFpX3DyN/ok54XxPcGfpIVwZYkIOUEs3fKXUOa5FyKVT+x4WX60h
	4SoLl3qziulBu9Lee5494QWZnjlhFFG95hmQZxmf2nSGbEb3ZiCOg3KhlybhAXvWmLDhY8HiJbvUi
	xA2atpjCOWa0m3a7myziUnvO3KWi0UbEuGvmjcEiv+J73Vo6gLNDRnU6SPJh+X6ZOss+X7jEjYhCX
	4UaK+u/rf19Xuo4XiuKa2FA3cDwIZXcJLfeotHLGIow3s/m5sRTR/pFq/zcaipRYThUecdILHqMkS
	YvFpqTLuc6ppSTMT6Ajg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPjg-0000wW-RJ; Tue, 29 Jan 2019 09:31:16 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPiX-0007Qm-5y; Tue, 29 Jan 2019 09:30:46 +0000
X-UUID: 858c6fdfbace42258a15db0d064e4478-20190129
X-UUID: 858c6fdfbace42258a15db0d064e4478-20190129
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1086230457; Tue, 29 Jan 2019 01:29:59 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 01:29:57 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 17:29:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 17:29:50 +0800
Message-ID: <1548754190.11055.7.camel@mtksdaap41>
Subject: Re: [PATCH 04/10] soc: mediatek: clear the event in cmdq initial flow
From: CK Hu <ck.hu@mediatek.com>
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
Date: Tue, 29 Jan 2019 17:29:50 +0800
In-Reply-To: <1548747128-60136-5-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-5-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013006_183630_D6AC1042 
X-CRM114-Status: GOOD (  15.10  )
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
> GCE hardware stored event information in own internal sysram,
> if the initial value in those sysram is not zero value
> it will cause a situation that gce can wait the event immediately
> after client ask gce to wait event but not really trigger the
> corresponding hardware.
> 
> In order to make sure that the wait event function is
> exactly correct, we need to clear the sysram value in
> cmdq initial flow.

If MT8173 has the same problem, add a fix tag.

Regards,
CK

> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 5 +++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h | 2 ++
>  include/linux/soc/mediatek/mtk-cmdq.h    | 3 ---
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index f6174ca..2b5febd 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -33,6 +33,7 @@
>  #define CMDQ_THR_END_ADDR		0x24
>  #define CMDQ_THR_WAIT_TOKEN		0x30
>  #define CMDQ_THR_PRIORITY		0x40
> +#define CMDQ_SYNC_TOKEN_UPDATE		0x68
>  
>  #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
>  #define CMDQ_THR_ENABLED		0x1
> @@ -103,8 +104,12 @@ static void cmdq_thread_resume(struct cmdq_thread *thread)
>  
>  static void cmdq_init(struct cmdq *cmdq)
>  {
> +	int i;
> +
>  	WARN_ON(clk_enable(cmdq->clock) < 0);
>  	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
> +	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
> +		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
>  	clk_disable(cmdq->clock);
>  }
>  
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index ccb7342..911475da 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -19,6 +19,8 @@
>  #define CMDQ_WFE_UPDATE			BIT(31)
>  #define CMDQ_WFE_WAIT			BIT(15)
>  #define CMDQ_WFE_WAIT_VALUE		0x1
> +/** cmdq event maximum */
> +#define CMDQ_MAX_EVENT			0x3ff
>  
>  /*
>   * CMDQ_CODE_MASK:
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 54ade13..4e88999 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -13,9 +13,6 @@
>  
>  #define CMDQ_NO_TIMEOUT		0xffffffffu
>  
> -/** cmdq event maximum */
> -#define CMDQ_MAX_EVENT				0x3ff
> -
>  struct cmdq_pkt;
>  
>  struct cmdq_client {



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
