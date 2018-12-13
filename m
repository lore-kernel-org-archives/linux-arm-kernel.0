Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E3EC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:48:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB14E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AkHUTvv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB14E20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VkkTDC/3gQAcgiImMrVD55UfK8GEdCFVwkthkJkMAl4=; b=AkHUTvv31KxLGg
	y5jR7U4tWpxPfL260j8N7X9GYJbjzDboKB5tBd7lprEZTY5bfnJoGoyMP5FFlp10dW1PuIGQ9sr1x
	J2qPfi0EefC1fZQybrycopw1OPOSsdyLTD0zbnepqhx6x54sPTXYvQuOWDKf/mFLa0XsB+WhuJArv
	Be3nppjE0Zix06TXz8ATBs6vPzDX34mQCkcJU8LfoYVgK/3wbzwMdt54LERob5G/S0QHGpr87rAkj
	uokoQYkH2Q1tI5/SD8YC0/hrCpVW1yjKv/10E/wYhKCHqCddzaaX5zxmvvSfrdjPvV5w7X3wDIIm/
	AsxBNDc3zOzSrSczdaSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXH3V-0008Nu-Mu; Thu, 13 Dec 2018 02:48:53 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXH3Q-0008N6-Qg; Thu, 13 Dec 2018 02:48:50 +0000
X-UUID: 7b0f650cdc584f669dc024d42bb1dfca-20181213
X-UUID: 7b0f650cdc584f669dc024d42bb1dfca-20181213
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <biao.huang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 533318123; Thu, 13 Dec 2018 10:48:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 13 Dec 2018 10:48:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 10:48:23 +0800
Message-ID: <1544669302.24219.133.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 0/2] add Ethernet driver support for mt2712
From: biao huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>
Date: Thu, 13 Dec 2018 10:48:22 +0800
In-Reply-To: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_184849_126753_FCDB8785 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
 joabreu@synopsys.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dear All,
	Sorry, I misunderstood David's reply mail in v6 series, please ignore
v7 series.

Dear David,
	I send you another follow-up patch to fix up build warning, please
check it.

Thanks!

On Thu, 2018-12-13 at 09:56 +0800, Biao Huang wrote:
> Changes in v7:
> Add MODULE_LICENSE info in driver.
> 
> Biao Huang (2):
>   net:stmmac: dwmac-mediatek: add support for mt2712
>   dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
>     DWMAC
> 
>  .../devicetree/bindings/net/mediatek-dwmac.txt     |   87 +++++
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  413 ++++++++++++++++++++
>  4 files changed, 509 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
