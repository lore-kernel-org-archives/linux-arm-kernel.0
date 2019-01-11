Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83697C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEB021783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7+aaFG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEB021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=onbAf5xw5UVZ/a9Qsz3Dt4zQnGIqGCNVpEm0F3bx23A=; b=p7+aaFG0VbgoMI
	lm006pGstRE1RW0oGdOdwIhEfGbbij76klZbvAFTSLKgaWvKi89fTnlq0JV4bX6AaxeASI6eifBw9
	dvNGCCbR774jRgXmHFOfmoRwai0mBvs73PEJl2strZmdv2+tHC9jDlXGeE0wAdRcIwebxQ0Pzjiu3
	QqMejwnJWqlFhpyoF1kFPxkp0pf9On/YFhw0qGpq85peUoTRcd0YcScjZOr3S7qg4fGRy6GrslwJ4
	a6tCWs0ubFg/MkAb3F2nxi927d485/qHKRwId46zOBsTCuJ9ZDYbk95U4Mdev8XLrHdlBTmvVjuZZ
	fIcvL0U6EpUx6QLbRfEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv3s-0000cX-4B; Fri, 11 Jan 2019 11:33:16 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv3o-0000bc-OJ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:33:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E8C36ADD7;
 Fri, 11 Jan 2019 11:33:08 +0000 (UTC)
Date: Fri, 11 Jan 2019 12:33:08 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Message-ID: <20190111113308.5lwgl5d7m7zjvidr@suse.de>
References: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033312_939296_99396C78 
X-CRM114-Status: GOOD (  10.11  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org,
 Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 04:42:07PM +0000, Lorenzo Pieralisi wrote:
> From: Qian Cai <cai@lca.pw>
> 
> Commit 8097e53eaba2 ("ACPI/IORT: Use helper functions to access
> dev->iommu_fwspec") changed by mistake the iort_fwspec_iommu_ops() stub
> definition (compiled in when CONFIG_IOMMU_API=n), that caused the
> following compilation failure:
> 
> drivers/acpi/arm64/iort.c:880:1: error: expected identifier or
> '(' before '{' token
>  { return NULL; }
>  ^
> drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops'
> used but never defined
>  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
>                                        ^~~~~~~~~~~~~~~~~~~~~
> 
> Fix it.
> 
> Fixes: 8097e53eaba2 ("ACPI/IORT: Use helper functions to access dev->iommu_fwspec")
> Signed-off-by: Qian Cai <cai@lca.pw>
> [lorenzo.pieralisi@arm.com: updated tags and log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Joerg Roedel <jroedel@suse.de>

Applied to iommu/fixes, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
