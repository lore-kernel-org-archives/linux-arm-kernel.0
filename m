Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C26C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:17:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9544E20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJJ6ApUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9544E20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mvqNm2h8r+96OiHfW/VN6UDqZCkw05yvz5wMDZ2lYHs=; b=IJJ6ApULJ20M/I
	73kPvtH976zLIu24PSo8ajoIjkt6deqAk/z8EId98W3rB2e3ZAsoYbSd9sTr1kCHod0gkzTYNINw6
	vdTSGL9pmFeCTv7XQ1gaotxMtSiRaGAQee5HEh/262RRrnq+OkrVH0SuuFB8BkUBqijuNR51D3zld
	tKrb7Ps9YFRiAZ5GbtCsI5AuISlUB8ZsWXDLdWa6Jy+gdLprb9rzJklqJjr533snbHaWkQfhE+eZo
	n4rBtos/ZC9Mg2y4El9FIghDKBoecaNVKBKpoaamBe1TqCusevvsWMUGbhR1sGvQg4WFSk+/pje0k
	Wm3oWxF7cYccawfdmV8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0dv-0003bv-SJ; Wed, 12 Dec 2018 09:17:23 +0000
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0ds-0003aS-7Q
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:17:21 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 540623D8; Wed, 12 Dec 2018 10:17:05 +0100 (CET)
Date: Wed, 12 Dec 2018 10:17:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 4.21
Message-ID: <20181212091702.hevwn4edprffzbhi@8bytes.org>
References: <20181211200847.GB5218@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211200847.GB5218@edgewater-inn.cambridge.arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_011720_422152_B012B00F 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 08:08:48PM +0000, Will Deacon wrote:
> The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:
> 
>   Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

Pulled, thanks Will.

Btw, there was a merge conflict with the patches to unmodularize the
IOMMU drivers in drivers/iommu/arm-smmu.c. I think I fixed it up, but it
would be good if you can check it later when I pushed it out.

Thanks,

	Joerg

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
