Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F057CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:05:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EB3217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BOZBASnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EB3217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TGA6lcq9zjq+LI78ta0jJ9lTfJS6elj3P2HuQIlv5Ss=; b=BOZBASnMuNLZG1
	qFnLT/pWW3LV2gvn6GFtAh3vVt/eWKIADM/cVdaVJWhUQQCIFsZxFvfIit5ZJHlu+9YQaQAAWEVbY
	2w1f/XPzKg4pTTlOo5q4KsGzxRxCdxnHNTVRbf51FlGmNpxWxERAEnwfNpieQc4KqCggUfkdjZbnR
	WEyzpZn2Vem0pejjRkp7zlbXIaM8+XJqi0E00uikhCEsdPaueIEUJBv8tLupVuJi0tzNcpcTS7ZeR
	XS+4tG1p2JuAuKM5tpmMmPCo5lTLlCrsTvzNGymfl/UO4ucuN7guE7kJuTmZTwVgxOiDADz588Mv5
	0S2AX9shd4eneV6r3T8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0GH-0007j3-HS; Fri, 28 Dec 2018 22:05:45 +0000
Received: from dliviu.plus.com ([80.229.23.120] helo=smtp.dudau.co.uk)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0GD-0007iQ-Kf
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:05:43 +0000
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
 by smtp.dudau.co.uk (Postfix) with SMTP id 5A09641080C1;
 Fri, 28 Dec 2018 22:05:29 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation);
 Fri, 28 Dec 2018 22:05:29 +0000
Date: Fri, 28 Dec 2018 22:05:29 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping in
 get_arch_dma_ops
Message-ID: <20181228220529.GB20342@bart.dudau.co.uk>
References: <20181214150240.26427-1-hch@lst.de> <20181219165502.GA25904@lst.de>
 <20181228173057.GA20342@bart.dudau.co.uk>
 <20181228175900.GB16929@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228175900.GB16929@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_140541_822141_E07F683B 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 06:59:00PM +0100, Christoph Hellwig wrote:
> On Fri, Dec 28, 2018 at 05:30:57PM +0000, Liviu Dudau wrote:
> > On Wed, Dec 19, 2018 at 05:55:02PM +0100, Christoph Hellwig wrote:
> > > As all maintainers seem to be off to their holidays already I've
> > > applied this now given that I don't want to leave arm64 in broken
> > > state in linux-next any longer.
> > 
> > Hi Christoph,
> > 
> > Talking about linux-next being broken, I found out that with
> > next-20181224 the nvme driver with an HMB NVMe SSD (Toshiba RC-100)
> > also fails on a RK3399 board (NanoPC T4). It works with v4.20 just fine.
> > 
> > The reason for linking it to your patchset is that I get this on
> > next-20181224 (the DMA addresses looks the same for the allocated buffers):
> 
> Your patch looks correct.  Can you send the dma_alloc_coherent
> to dma_alloc_attrs switch to linux-nvme list with a proper commit log
> and signoff?

Sure, but that still doesn't make nvme work. Do you have any suggestions?

Best regards,
Liviu


-- 
           ________________________________________________________
  ________|                                                        |_______
  \       |  With enough courage, you can do without a reputation  |      /
   \      |                                  -- Rhett Butler       |     /
   /      |________________________________________________________|     \
  /__________)                                                  (_________\

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
