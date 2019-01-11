Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F042C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2042D2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ul8jJ2wV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2042D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mudaKi/+YjOOqKzv4HyG8/RWb/cohO0WqD9hmL63Sw=; b=ul8jJ2wVywExna
	Ch5coSBE4JNAVqTEFsJZ+vdjgMxOk8BT5sxZa2OnGna6hVWmf1UvSHmuXyMan2R+7sb842UEoXYXI
	LTANywFoKLcl2duPVAV8y5L7+98G3ba9aJiJK9c7NlL5wgfLWlPoG0tCRY1q9RqAaqAjdl4CLe5Hj
	9FmpwwL03dw8rt8/V9tppHmuBRy/36GfFtRx/58Tt9Cefl9KxsN77Ii6JpZHQaOpCVuKmpO6yQ5uk
	KPy7un+miPcqQhQIxAP8qQkgoYUbnVf9stegZtKUYEhcLgfjJLMNk35N4gaVIxOIwz8pyFBOzujcZ
	iIP+04YAfNkqM2lCV3Mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv7X-0002jI-VE; Fri, 11 Jan 2019 11:37:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv7U-0002iv-M9
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:37:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6749480D;
 Fri, 11 Jan 2019 03:36:58 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08893F70D;
 Fri, 11 Jan 2019 03:36:56 -0800 (PST)
Date: Fri, 11 Jan 2019 11:36:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Message-ID: <20190111113652.GA30082@fuggles.cambridge.arm.com>
References: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
 <20190111113308.5lwgl5d7m7zjvidr@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111113308.5lwgl5d7m7zjvidr@suse.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033700_725130_2D2FF1C7 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org,
 Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 12:33:08PM +0100, Joerg Roedel wrote:
> On Mon, Jan 07, 2019 at 04:42:07PM +0000, Lorenzo Pieralisi wrote:
> > From: Qian Cai <cai@lca.pw>
> > 
> > Commit 8097e53eaba2 ("ACPI/IORT: Use helper functions to access
> > dev->iommu_fwspec") changed by mistake the iort_fwspec_iommu_ops() stub
> > definition (compiled in when CONFIG_IOMMU_API=n), that caused the
> > following compilation failure:
> > 
> > drivers/acpi/arm64/iort.c:880:1: error: expected identifier or
> > '(' before '{' token
> >  { return NULL; }
> >  ^
> > drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops'
> > used but never defined
> >  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> >                                        ^~~~~~~~~~~~~~~~~~~~~
> > 
> > Fix it.
> > 
> > Fixes: 8097e53eaba2 ("ACPI/IORT: Use helper functions to access dev->iommu_fwspec")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > [lorenzo.pieralisi@arm.com: updated tags and log]
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> 
> Applied to iommu/fixes, thanks.

I've already got this one in arm64 for-next/fixes (should be in linux-next
already). Would you prefer me to drop it (which would mean a rebase :()? I
was planning to send a pull later today, since I have some other fixes
queued as well.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
