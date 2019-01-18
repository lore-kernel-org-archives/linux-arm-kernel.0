Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F49C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8706C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PfOwUSM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8706C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v4z9/rJy2Mw0BKHSXAYAe372SUM4WUwfRSU049r5ZkI=; b=PfOwUSM8kAgP9D
	Zqy7D4oaVzNeCYfJoZr3i8dWt+ET1OLqlrzsLZ1Os3zBsAQZHBbjcbYPQHrWhp4KSxRacn5giz44k
	y59h1vwi7O1C3ISeL5p5OOno2F85fA1tIQvDDyB654l2cztTNTYX/pUZ/PT2zO4BwXS1QKeDyqhB5
	60iDn4lvW5mnXPQ3xahmpx/PaDxwnUjV55c3zOSVqXyYQ2pWtE7dTUSzHriPo0Gske+u1W01T1L9t
	7ILKDgSxey4qqA4janATBm2INpZEQjjZdeuV3843Np0LCMev5tOPI8wdmrLG9T0+lYDF0qiiys4FW
	M2yMbdK78404NHhS4wHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkNQI-0005hr-5H; Fri, 18 Jan 2019 06:14:34 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkNQD-0005gd-9v; Fri, 18 Jan 2019 06:14:31 +0000
X-UUID: 442c1c876cc846188c2f3fc481d13451-20190117
X-UUID: 442c1c876cc846188c2f3fc481d13451-20190117
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1721433949; Thu, 17 Jan 2019 22:14:20 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 22:14:18 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 18 Jan 2019 14:14:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 14:14:14 +0800
Message-ID: <1547792054.4433.254.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb controller
From: Min Guo <min.guo@mediatek.com>
To: Tony Lindgren <tony@atomide.com>
Date: Fri, 18 Jan 2019 14:14:14 +0800
In-Reply-To: <20190117143342.GS5544@atomide.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
 <20190117143342.GS5544@atomide.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_221429_345264_7A99CF7B 
X-CRM114-Status: GOOD (  10.57  )
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
 Yonglong Wu <yonglong.wu@mediatek.com>, hdegoede@redhat.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan
 Stern <stern@rowland.harvard.edu>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-17 at 06:33 -0800, Tony Lindgren wrote:
> Hi,
> 
> * min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> > There are some quirk of MediaTek musb controller, such as:
> >  -W1C interrupt status registers
> >  -Private data toggle registers
> >  -No dedicated DMA interrupt line
> 
> Can you please separate the musb generic changes listed above
> into separate individual patches in preparation for adding
> support for new hardware?
> 
> Otherwise we'll have hard time finding out with git bisect what
> exactly breaks things if we run into trouble.

Thanks for your suggestion.
I prepared to divide these changes into separate patches. Later, Mr.Bin
suggested not to do this.

The detailed information can be referred to:
https://patchwork.kernel.org/patch/10743561/
https://patchwork.kernel.org/patch/10763737/
https://patchwork.kernel.org/patch/107463741/

> Regards,
> 
> Tony



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
