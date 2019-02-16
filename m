Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E98BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A97222E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lv6FOvZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A97222E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2yO1InnMOoB3GpBy9p+W8qTI5kFbAh2aiMHwCBIOlYQ=; b=Lv6FOvZ6Jc6YdQ
	cVXRtnvoR5CmZZIIg2r84qyIbAlJwv6FwwAYoysCLQWnaHv8YXYhPdluurZg+IXHhQqM/fpd0ZKuV
	lHywAhfMz7tO/OB1QeYPL6wT/xFLLUjVRXvRsmw84X1cC/fknkzq+RMjrNOOV0Emgd/yhxEdctSa9
	Gm8kzC8m1/woZtCkVgzgeLGKXsSsY00JALreLjXgcL6kF+fyn9s42G1/wZf9hLq61PMYW5JQAXWgF
	LeSRrZscrDsgMU5n/lNtbTD0ygg7+4ooIEe/CxkCWaNQGBjz/UnaAz5lItn/nYF+2lX2bsXmH2iIk
	DuAjCcWxZ6Q99fpMmajA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guyCi-0004d7-GD; Sat, 16 Feb 2019 11:32:20 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guyCe-0004cD-9n; Sat, 16 Feb 2019 11:32:18 +0000
X-UUID: ace2f5d8f6cb45acbfbc0eb6c2557eb4-20190216
X-UUID: ace2f5d8f6cb45acbfbc0eb6c2557eb4-20190216
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1603113016; Sat, 16 Feb 2019 03:32:08 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 16 Feb 2019 03:32:06 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sat, 16 Feb 2019 19:32:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 16 Feb 2019 19:32:03 +0800
Message-ID: <1550316723.30065.44.camel@mhfsdcap03>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From: Qii Wang <qii.wang@mediatek.com>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 16 Feb 2019 19:32:03 +0800
In-Reply-To: <20190215090257.geumssb2cucs7rzt@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai> <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_033216_346684_CDB976D3 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, Rob Herring <robh@kernel.org>,
 leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-15 at 10:02 +0100, Wolfram Sang wrote:
> On Thu, Feb 14, 2019 at 09:54:28AM +0800, Qii Wang wrote:
> > On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> > > 
> > > I am not happy with this binding. There must be a better way of using
> > > the I3C controller in I2C mode. I think it would be easier to tell if we
> > > had an I3C driver to see how it implements I2C fallback there. Is the
> > > I3C driver on the way?
> > > 
> > 
> > I am very sorry for the late reply due to the Chinese New Year holiday.
> 
> No worries. I hope you enjoyed the holidays!
> 
> > After confirmation, for I2C mode in I3C controller, we will push an I3C
> > driver to implement I2C fallback there later, and we will remove
> > "mediatek,share-i3c" for i2c controller driver in the next patch.
> 
> The problem with DT bindings is that you need to support them forever
> once you introduced them. Because there might be old device trees on
> boards out there which need the property. So, I don't like the idea of
> having a temporary binding which is meant to be removed anyway. My take
> is that you should just send out the I3C driver which will handle the
> I2C support then.
> 
> Adding Rob to CC in case he has a different opinion.
> 

Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
there are I2C and I3C controllers on MT8183 SoC. We will remove
"mediatek,share-i3c" for I2C controller driver, so these patches are
just to support the I2C controllers on MT8183 SoC. For the I3C
controller we will send some new patches which are based on i3c
framework directories(kernel/drivers/i3c), not based on
i2c-mt65xx.c.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
