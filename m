Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474BE2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VCNb0rzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474BE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fLPDgkUK+rH7G2QLnMiLDcSXA4vFE7M66Eh+fjmDUoQ=; b=VCNb0rzcpWga2r
	kbiJh24ZgDhPY37q5VRJSDNhXiHifNGqCTpZz/1CmOBVxQxf5+cdfT+3uClSPlxH46r4B91sJB/be
	Aw+j3JBK1T0vgF4J8eFJTc1qHyk+mLfrf0mcPmP0z0GtNp+AoTBRjOwSPxYGQxljkZvpoWxwxRerv
	unvqEDJ4NXj7QzMQSbmVnkZN+Xj2j7hr6yn1CwhJ161g9sWjVyeOOhd1eBIWbZ9fHRDVFPpYWL1FA
	SuCJn0xLTI/c9a2fxdyx5PRWDjYXBa4dlCs9WG+jPjF+xQQG38tVHhUdJLLbeTcj7VxwtirvQVB4c
	OAzOo6Wyy80XtlXMXjMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvcY-0001aI-Bx; Fri, 11 Jan 2019 12:09:06 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvcU-0001Zr-2Y
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:09:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 95447ABD4;
 Fri, 11 Jan 2019 12:09:00 +0000 (UTC)
Date: Fri, 11 Jan 2019 13:08:59 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Message-ID: <20190111120859.iqq7gju2ecrmi66t@suse.de>
References: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
 <20190111113308.5lwgl5d7m7zjvidr@suse.de>
 <20190111113652.GA30082@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111113652.GA30082@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_040902_266591_4EAE5913 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org,
 Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Fri, Jan 11, 2019 at 11:36:52AM +0000, Will Deacon wrote:
> I've already got this one in arm64 for-next/fixes (should be in linux-next
> already). Would you prefer me to drop it (which would mean a rebase :()? I
> was planning to send a pull later today, since I have some other fixes
> queued as well.

Ah okay, didn't check linux-next, just linus/master. Keep it in your
tree, I'll drop it from my branch. It is not pushed yet anywhere public,
so it's easy for me to do.

Thanks,

	Joerg

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
