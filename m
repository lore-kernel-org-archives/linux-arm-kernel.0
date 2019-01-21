Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDDEC312E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 01:08:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C639D217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 01:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zhyrkv9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C639D217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xsUd01kjEusKiRPMhsTXBF4uBfhhmQ7buTyUNXrYdGE=; b=Zhyrkv9ta3xsa9
	NcupcUa2uKNAyRXEKTWEjsVs9uG1WLXfuTrOEhnaGl8W/7iY3cBEW37exdtUMMXZCF3lAfXCu9XwQ
	eqPsDoNSjJnWpiT3JhThiXSnhSeiEdJO15Hgo+FiS/HOvuARpH7vv9gj3QkkvhwUgqi3/HEaNQLkG
	E9b5k0hUxAbvFTX0K/N8TLQPCPzSv/ZAUZcC40s0w4s0rX6OVFKresuVhv8kiFvgJ9GV+0ZgeeGzN
	YsrKhotp/kdX6ghNnNAGiQwlbMtLdGaBOo3Rbu/6IVX/BwGPTHLtDPxhtQXJ1lol+gTl56CZV5DPL
	ybJjWd9jlYOyvRYhteLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glO5A-0007BC-Bu; Mon, 21 Jan 2019 01:08:56 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glO56-0007AK-Ku; Mon, 21 Jan 2019 01:08:53 +0000
X-UUID: 806509caccb14007960f614fbc0e11ee-20190120
X-UUID: 806509caccb14007960f614fbc0e11ee-20190120
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1011912232; Sun, 20 Jan 2019 17:08:42 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 20 Jan 2019 17:08:40 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 21 Jan 2019 09:08:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 09:08:37 +0800
Message-ID: <1548032917.4433.255.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb controller
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Mon, 21 Jan 2019 09:08:37 +0800
In-Reply-To: <20190118133408.GA30080@uda0271908>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
 <20190117143342.GS5544@atomide.com> <1547792054.4433.254.camel@mhfsdcap03>
 <20190118133408.GA30080@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_170852_691773_4EF906CE 
X-CRM114-Status: GOOD (  15.67  )
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
 Yonglong Wu <yonglong.wu@mediatek.com>, hdegoede@redhat.com,
 Tony Lindgren <tony@atomide.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan
 Stern <stern@rowland.harvard.edu>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-18 at 07:34 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Fri, Jan 18, 2019 at 02:14:14PM +0800, Min Guo wrote:
> > On Thu, 2019-01-17 at 06:33 -0800, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> > > > There are some quirk of MediaTek musb controller, such as:
> > > >  -W1C interrupt status registers
> > > >  -Private data toggle registers
> > > >  -No dedicated DMA interrupt line
> > > 
> > > Can you please separate the musb generic changes listed above
> > > into separate individual patches in preparation for adding
> > > support for new hardware?
> > > 
> > > Otherwise we'll have hard time finding out with git bisect what
> > > exactly breaks things if we run into trouble.
> > 
> > Thanks for your suggestion.
> > I prepared to divide these changes into separate patches. Later, Mr.Bin
> > suggested not to do this.
> 
> Initially I thought the clearb/w() changes should be just a couple
> lines, so didn't think to separate it. But after reviewed the final
> implemenation, I agree Tony's comment is the right thing to do, please
> separate the musb core changes, each for clearb/w(), get/set_toggle(),
> and dma.

OKay.

> Regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
