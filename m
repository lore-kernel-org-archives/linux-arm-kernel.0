Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:40:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A18B20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YelFxtio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A18B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vry3q33CnDAgtqgV6s73LfjOoULOCRNF/rysBBG8MmE=; b=YelFxtio333kxI
	I8asQpGNhNBUKXmNsPmvVZRTdjVr+00eSiB8ttiB500O6NTXJRGPaWk2bl82Xim2MiviiGj91AnLB
	hQGGcqtICv4PyB6+o7vVfNQirXfxe1mLK+y5dS2TFJ2pG/xj5Y54hDAA85E0pSdpXQZW7V+o6JoXA
	HBMBkfayW+Day35W5Sis5fzHt1YVEwYYa3yhlLPurInbdqZM0823hw26IyOfBD0eLxHmFZ0fbBpP0
	eTh0vpx1GKFm8LVXOVsyFIQWspvwKKY5pof487GoDMkxLpB3VDyx9RZdq8PaOGzztPBiarSt9L+Mi
	Lp8q5R//23oPHjkPGTUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUies-0006ee-Nl; Thu, 06 Dec 2018 01:40:54 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUiel-0006dR-Ip; Thu, 06 Dec 2018 01:40:53 +0000
X-UUID: f14a2ebd3ef64324a3750387f62be4d8-20181206
X-UUID: f14a2ebd3ef64324a3750387f62be4d8-20181206
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 174642803; Thu, 06 Dec 2018 09:40:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Dec 2018 09:40:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Dec 2018 09:40:18 +0800
Message-ID: <1544060418.20681.0.camel@mtkswgap22>
Subject: Re: [PATCH 0/2] PCI: mediatek: Add support for MT7629
From: Ryder Lee <ryder.lee@mediatek.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Date: Thu, 6 Dec 2018 09:40:18 +0800
In-Reply-To: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_174047_829380_ACD51A11 
X-CRM114-Status: UNSURE (   8.74  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-06 at 09:09 +0800, Jianjun Wang wrote:
> These series patches modify pcie-mediatek.c and dt-bindings compatible
> string to support MT7629 PCIe host.
> 
> There was something wrong with the mail server's permission setting, sorry
> for sent these mails repeatedly.
> 
> Jianjun Wang (2):
>   dt-bindings: PCI: Add support for MT7629
>   PCI: mediatek: Add controller support for MT7629
> 
>  .../devicetree/bindings/pci/mediatek-pcie.txt |  1 +
>  drivers/pci/controller/pcie-mediatek.c        | 26 +++++++++++++++++++
>  include/linux/pci_ids.h                       |  1 +
>  3 files changed, 28 insertions(+)
> 


Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
