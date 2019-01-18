Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91711C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DF42087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JaoSJkCM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KwteWK+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DF42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kQHRPWDSnb2QdcwTemR0xd8Ds+s4rBsDxwHwpm/kSKQ=; b=JaoSJkCMEY8Xl/
	iGuixMX+jtCTGtOvy68hiWQ/Dz1/JZ6ShqHRzUsWNFPtlXKDkzgVIPlTZfdM7CX6ytiekVvGFI1Yw
	ztPIzaK8S+fDA4JGcoElAJcift8CoR+tVkPNVHDI7XrR7JLxecZAumjwOGIOIWZ/p1M4xfxX81U9Q
	vVsVGbhVPt5gmQdrRG/C5tlZUybcOsUPrgTOOpL++BlcuLUFY9I1qRTWFN0E7w37RbjXKcFSoRX+L
	HE3N3T9Ud85SwTUYa8I87K35CHxpoO+1fN39obFypK+9zwTfoirs6MRwamVbwPiqbFaN/iVtX4t5s
	HH+E9RQs06DjT4zm+mrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUHt-0002N4-2H; Fri, 18 Jan 2019 13:34:21 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUHp-0002MN-3Y; Fri, 18 Jan 2019 13:34:18 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IDY8P7032089;
 Fri, 18 Jan 2019 07:34:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547818448;
 bh=JUfz9m/jPu7HP3vUJw1Fmlc+FqLxoEBdRg/fAbb2oh4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KwteWK+bUOHZ1QTw3W413+xG+YvoHU/eY+fU6gq77fG2O1cFeQxsm7L64CsbV7dDs
 t3Yek+w8+nNjH0Q5Uvgiog/qa0F5nilY8z8bFvuQ1FnwwdBn2sm918fokbCrMMDJUN
 xSdbAz2jvRXH0N7qVa5NRZw/2g+Eq1S3ZbY9i2AA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IDY8la054452
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Jan 2019 07:34:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 07:34:08 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 07:34:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IDY8bt024388;
 Fri, 18 Jan 2019 07:34:08 -0600
Date: Fri, 18 Jan 2019 07:34:08 -0600
From: Bin Liu <b-liu@ti.com>
To: Min Guo <min.guo@mediatek.com>
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb controller
Message-ID: <20190118133408.GA30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, hdegoede@redhat.com,
 Yonglong Wu <yonglong.wu@mediatek.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
 <20190117143342.GS5544@atomide.com>
 <1547792054.4433.254.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547792054.4433.254.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_053417_222937_840B5B93 
X-CRM114-Status: GOOD (  18.74  )
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
 Tony Lindgren <tony@atomide.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Min,

On Fri, Jan 18, 2019 at 02:14:14PM +0800, Min Guo wrote:
> On Thu, 2019-01-17 at 06:33 -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> > > There are some quirk of MediaTek musb controller, such as:
> > >  -W1C interrupt status registers
> > >  -Private data toggle registers
> > >  -No dedicated DMA interrupt line
> > 
> > Can you please separate the musb generic changes listed above
> > into separate individual patches in preparation for adding
> > support for new hardware?
> > 
> > Otherwise we'll have hard time finding out with git bisect what
> > exactly breaks things if we run into trouble.
> 
> Thanks for your suggestion.
> I prepared to divide these changes into separate patches. Later, Mr.Bin
> suggested not to do this.

Initially I thought the clearb/w() changes should be just a couple
lines, so didn't think to separate it. But after reviewed the final
implemenation, I agree Tony's comment is the right thing to do, please
separate the musb core changes, each for clearb/w(), get/set_toggle(),
and dma.

Regards,
-Bin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
