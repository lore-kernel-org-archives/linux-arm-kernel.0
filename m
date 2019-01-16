Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:39:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1153120840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VE5ft43z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1153120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mafzf/KO4Rl/1B209yktSCeUD68yUckodppluJllv7E=; b=VE5ft43zVnZaO4
	AM0Q5K+dk9Pf2LOiI8h/+PCnBTlsvZWXn5htlTZ3005Z2CMJnQi7lzc9LbWnd/D3X/91R5A6KEuA2
	AF81c0UpY8VA9N0HTXg4CZGEhhEozuUZPq5xmba2f3Hw+UdV8nSzqzyrBflQ5t+rqzlpwRQDXw6yY
	Jl+UAPSY/e/SG79VUNuGj/GnTSVr8dO7OXOuavF6d1ocGtkvoPJ0oE+aMem3CXGCXxLZKDMla1N9b
	H9VpcZiWjwErjOXbCBjSsRBii+3C43zbZZOAxCywrbB3M029XFylooUc0f6aKAW3hkvzRsqsBhG40
	TefmuIzBOdPqRokAShUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhfZ-0005aB-K4; Wed, 16 Jan 2019 09:39:33 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhfG-0005Gf-9h; Wed, 16 Jan 2019 09:39:16 +0000
X-UUID: 9b0eb878327c4cb5b90d2898359db0a4-20190116
X-UUID: 9b0eb878327c4cb5b90d2898359db0a4-20190116
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1226075562; Wed, 16 Jan 2019 01:39:08 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 01:39:06 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 16 Jan 2019 17:39:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 17:39:02 +0800
Message-ID: <1547631542.4433.232.camel@mhfsdcap03>
Subject: Re: [PATCH v2 4/4] usb: musb: Add support for MediaTek musb controller
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Wed, 16 Jan 2019 17:39:02 +0800
In-Reply-To: <20190115203815.GD18026@uda0271908>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-5-git-send-email-min.guo@mediatek.com>
 <20190115203815.GD18026@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_013914_807458_4A0EA676 
X-CRM114-Status: GOOD (  10.60  )
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
 linux-kernel@vger.kernel.org, Matthias
 Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bin,

On Tue, 2019-01-15 at 14:38 -0600, Bin Liu wrote:
> Hi Min,
> 
> very close, thanks.
> Below I tried to explain a further cleanup in musb_clearb/w() and
> musb_get/set_toggle() implementation. Please let me know if it is not
> clear.
> 
> Basically, we don't need musb_default_clearb/w(), just assign the
> musb_io function pointers to musb_readb/w().
> 
> Then the mtk platform musb_clearb/w() calls musb_readb/w() and
> musb_writeb/w() to handle W1C.

Sorry to bother you again, I encounter a problem when prepare the patch.
The define of musb_clearb/w and musb_readb/w are difference as follow,
and cannot be directly assigned:
u8/u16 (*readb/w)(const void __iomem *addr, unsigned offset)
void (*clearb/w)(void __iomem *addr, unsigned int offset)) 

if modify clearb/w as:
u8/u16 (*clearb/w)(const void __iomem *addr, unsigned int offset)) 
then musb_clear needs writeb/w the const addr.
Can I delete const in (*readb/w)?

> regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
