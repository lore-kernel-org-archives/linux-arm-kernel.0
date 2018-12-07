Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:18:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D11D20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u45l5uZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D11D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IoTL8xU/FAgNoICxqFdEBq/dh25EQN8jrE7JWH1GEVA=; b=u45l5uZJPhd6wQ
	P5Zy8U719qR+6sWcEE3D7Nrw94gXCbHam+TRjvuT8wRKxBKfCo2XPoN+4MwiVeFvfavZxV2WbbCX7
	RC5Y5sYJ9i4PRYVGwJ3esrTl+IOEuyiNhZB5eYQRinQNksBgTzpDomWfa3ZZ1cVspaX1oNL8whd94
	m5Z0L5bvHr9OIyV2KFkcSgtxt34fXb/ozgNXTPcu+uFzS/8RddsalF8nDsfVONHr02uWBvcoadcL1
	2FlR3W8jYrg0YEJp19MEZNx76KqaQqYh0fx63DlS1erhW/PPsmt3a19NQQwNmg/fBYwVFbTo/YbQA
	awIO9Iue8eq3UldqkMoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV8Ws-0003lQ-VX; Fri, 07 Dec 2018 05:18:22 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV8Wm-0003gc-2T; Fri, 07 Dec 2018 05:18:20 +0000
X-UUID: af3828a5ab414873b318bd9e0465e58d-20181207
X-UUID: af3828a5ab414873b318bd9e0465e58d-20181207
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <chunfeng.yun@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 98319364; Fri, 07 Dec 2018 13:17:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 7 Dec 2018 13:17:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 13:17:45 +0800
Message-ID: <1544159865.32173.116.camel@mhfsdcap03>
Subject: Re: [PATCH -next] usb: mtu3: fix dbginfo in qmu_tx_zlp_error_handler
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 7 Dec 2018 13:17:45 +0800
In-Reply-To: <1544154763-156094-1-git-send-email-yuehaibing@huawei.com>
References: <1544154763-156094-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_211816_338166_F976A02A 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Haibing,

On Fri, 2018-12-07 at 03:52 +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/usb/mtu3/mtu3_qmu.c: In function 'qmu_tx_zlp_error_handler':
> drivers/usb/mtu3/mtu3_qmu.c:385:22: warning:
>  variable 'req' set but not used [-Wunused-but-set-variable]
> 
> It seems dbginfo original intention is print 'req' other than 'mreq'
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/usb/mtu3/mtu3_qmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
> index 73ac042..09f19f7 100644
> --- a/drivers/usb/mtu3/mtu3_qmu.c
> +++ b/drivers/usb/mtu3/mtu3_qmu.c
> @@ -402,7 +402,7 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
>  		return;
>  	}
>  
> -	dev_dbg(mtu->dev, "%s send ZLP for req=%p\n", __func__, mreq);
> +	dev_dbg(mtu->dev, "%s send ZLP for req=%p\n", __func__, req);
>  
>  	mtu3_clrbits(mbase, MU3D_EP_TXCR0(mep->epnum), TX_DMAREQEN);
> 
Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
