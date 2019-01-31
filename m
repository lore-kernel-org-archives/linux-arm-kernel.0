Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:47:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D1F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lukt6X3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D1F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NJgsqpfQkA3/2loecH3WyAFf3dsUm1AIxrR1WPg10+w=; b=Lukt6X3+DO1Ybi
	8MZd00nXG5qLHKcGhhXMmoN4FqekalSfLyIZMQ4OCxzIggdu9fQwxdxvG6+1dtecPtubv8N6NtIGN
	TArT+/RdlcIHApBiosUq72CZcX3YUT7OVNvxsrvk5AGi9aY2QmJsekg6VdnguZ48J90h15NGSYStZ
	2ffGE/ldTdj89xFP1Zvakkt7+jbXuE6YH1ajTcsNno/DBV2YJeiumjQACXouw2XkhpoXLeyTThoHg
	/W4cbgkB+3xYjY7S9jSbKJuBvWZa+n5CkcV0eJ9JDCL5nkhv9A9VVXSumsVOJ7O8SujPeERTB1miq
	c6q85DytkT0iBawu8MyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp1RU-0002Wl-0X; Thu, 31 Jan 2019 01:47:00 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp1RQ-0002W0-9A; Thu, 31 Jan 2019 01:46:57 +0000
X-UUID: aa8a9cdd127c4078b784857e69899a0d-20190130
X-UUID: aa8a9cdd127c4078b784857e69899a0d-20190130
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <chunfeng.yun@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1245412512; Wed, 30 Jan 2019 17:46:49 -0800
Received: from MTKMBS33N2.mediatek.inc (172.27.4.76) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 17:46:48 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 09:46:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 09:46:45 +0800
Message-ID: <1548899205.6058.9.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: xhci: remove unused member 'parent' in xhci_regset
 struct
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 31 Jan 2019 09:46:45 +0800
In-Reply-To: <20190130071259.GC1204@kroah.com>
References: <1548814341-15116-1-git-send-email-chunfeng.yun@mediatek.com>
 <20190130071259.GC1204@kroah.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_174656_326432_2E5F9BBB 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alan
 Stern <stern@rowland.harvard.edu>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 08:12 +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 30, 2019 at 10:12:21AM +0800, Chunfeng Yun wrote:
> > The member @parent of xhci_regset struct is not used in fact,
> > so remove it
> > 
> > Change-Id: Ic6727c28f7200782fe4516bcb41c789b427318a2
> 
> No need for this line :(
Oh, my bad, I'll resend it, thanks



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
