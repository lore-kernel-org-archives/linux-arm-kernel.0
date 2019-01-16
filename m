Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8A0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0447320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pp7JKUmE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f4cPDGrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0447320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qgFVWcmwZRgSUercyK8unc7VP7CstcJA1jVrPlUTTIo=; b=pp7JKUmElgKqaq
	SQKCHbc1FXFZ/9sfXAUaWZdOc+GVh4wSg1JmcFVia3OUR+jSPzFO0Klb7UCuVJNuVUwmNDpYJFj2L
	FKLZKEHYh/ffSd8FCGqUuLcC6tf+Yh4+HpYQyc9ME307gGC/2B6/yUBFzoDJONt9s19UNcZpk5TZV
	Z9jrraanZ7cpBVaPLhfY/V7UA7X8SbDNBGiLciLOOiRtxWptvhm8pGjy6cJUTehSOd2c8XjSjtPCI
	VVj46+mdjXEJl6Ye8oK7HcVq4lywCSZNBPX+hiFcwkV4jI2NoNkg4QO4qgVr9KfbRnXIYzWnRoZcJ
	dErTF5CqeqTYoSgbkkoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlj2-00022M-50; Wed, 16 Jan 2019 13:59:24 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjliy-00021X-FV; Wed, 16 Jan 2019 13:59:21 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GDxENM098001;
 Wed, 16 Jan 2019 07:59:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547647154;
 bh=qPKrUkrAIkB2XNH4Q+k0AA3gQLZgT3gnNmps+D3At18=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=f4cPDGrJ7X8ejUO/J1U1FfA+RcQ99VNhqlUT9YZD0bFwytwNyuDFyWLfVGqJw92fB
 gAMO7KZrHEmABGY/BtuycUtAxxv4L7d4wJGmEGZGWnA958mMC/AImmTLFVBR5PP1b5
 b6K+f5GhOTzHEUoHrCtkUtJo8b/YF49lHWbog2AE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GDxEBt054639
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 07:59:14 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 07:59:14 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 07:59:14 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GDxEBD009808;
 Wed, 16 Jan 2019 07:59:14 -0600
Date: Wed, 16 Jan 2019 07:59:14 -0600
From: Bin Liu <b-liu@ti.com>
To: Min Guo <min.guo@mediatek.com>
Subject: Re: [PATCH v2 4/4] usb: musb: Add support for MediaTek musb controller
Message-ID: <20190116135914.GF18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Yonglong Wu <yonglong.wu@mediatek.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-5-git-send-email-min.guo@mediatek.com>
 <20190115203815.GD18026@uda0271908>
 <1547631542.4433.232.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547631542.4433.232.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_055920_641361_8EBF932C 
X-CRM114-Status: GOOD (  17.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yonglong Wu <yonglong.wu@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 05:39:02PM +0800, Min Guo wrote:
> Hi Bin,
> 
> On Tue, 2019-01-15 at 14:38 -0600, Bin Liu wrote:
> > Hi Min,
> > 
> > very close, thanks.
> > Below I tried to explain a further cleanup in musb_clearb/w() and
> > musb_get/set_toggle() implementation. Please let me know if it is not
> > clear.
> > 
> > Basically, we don't need musb_default_clearb/w(), just assign the
> > musb_io function pointers to musb_readb/w().
> > 
> > Then the mtk platform musb_clearb/w() calls musb_readb/w() and
> > musb_writeb/w() to handle W1C.
> 
> Sorry to bother you again, I encounter a problem when prepare the patch.

no problem at all.

> The define of musb_clearb/w and musb_readb/w are difference as follow,
> and cannot be directly assigned:
> u8/u16 (*readb/w)(const void __iomem *addr, unsigned offset)
> void (*clearb/w)(void __iomem *addr, unsigned int offset)) 
> 
> if modify clearb/w as:
> u8/u16 (*clearb/w)(const void __iomem *addr, unsigned int offset)) 
> then musb_clear needs writeb/w the const addr.
> Can I delete const in (*readb/w)?

yes, please create a separate patch for it, and for readl() as well,
and stating it is for implementing clearing W1C registers.

Regards,
-Bin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
