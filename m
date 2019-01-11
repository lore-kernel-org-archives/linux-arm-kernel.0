Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96101C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:30:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FAD2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pTrWn/n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FAD2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qyncTfzPqQ9W1VPqfc1/EpJpnKO9kRgk3s7TSxTLd6A=; b=pTrWn/n2YcorIu
	pOxJg2IdBTbI/XRiMLz3QMHAm1y7zODqVosZxn97XONPpuq1RTGeRJ4PKRIlh8rtbF6rTdhpJedw0
	gOX4d4Ei7QmTeekQkDJdS31tGHxVhyvWpHxbLSO/NE9E8UJYzPClhVvuPPVsEkG6AQpInOQ1CmnJ+
	601VxlFLjfVTjisO7yCCG6yxXaCyolf6Y3ilR4uLvasx91QiNJIF6i3grOl8fWUiYmpDTW7zQRQBR
	iFxf3fHN9C7pBdK9JmgxNnBuFbpMiGWl62xh8rF7maF0Y6Q5rKt7V6QwoY25gmt1xsLRRXQMYLfzD
	VeStp03E2k+IIEuIbeAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvwt-0002eu-62; Fri, 11 Jan 2019 12:30:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvwm-0002W6-B8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:30:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB4F80D;
 Fri, 11 Jan 2019 04:29:59 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23FC53F70D;
 Fri, 11 Jan 2019 04:29:58 -0800 (PST)
Date: Fri, 11 Jan 2019 12:29:55 +0000
From: Will Deacon <will.deacon@arm.com>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Message-ID: <20190111122955.GB30082@fuggles.cambridge.arm.com>
References: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
 <20190111113308.5lwgl5d7m7zjvidr@suse.de>
 <20190111113652.GA30082@fuggles.cambridge.arm.com>
 <20190111120859.iqq7gju2ecrmi66t@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111120859.iqq7gju2ecrmi66t@suse.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_043000_581076_B05306DF 
X-CRM114-Status: GOOD (  13.03  )
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

On Fri, Jan 11, 2019 at 01:08:59PM +0100, Joerg Roedel wrote:
> Hi Will,
> 
> On Fri, Jan 11, 2019 at 11:36:52AM +0000, Will Deacon wrote:
> > I've already got this one in arm64 for-next/fixes (should be in linux-next
> > already). Would you prefer me to drop it (which would mean a rebase :()? I
> > was planning to send a pull later today, since I have some other fixes
> > queued as well.
> 
> Ah okay, didn't check linux-next, just linus/master. Keep it in your
> tree, I'll drop it from my branch. It is not pushed yet anywhere public,
> so it's easy for me to do.

Thanks Joerg, that keeps things simple! Should land in -rc2.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
