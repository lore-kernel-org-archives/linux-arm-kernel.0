Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6335DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:06:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296EE20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXJqKjqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296EE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x/mEv337u5hCdRfNidKAervY6+qenMlAkjenD3nFdEM=; b=GXJqKjqFIoaZPg
	Yy5m3XyhGwaPyG7xLznbdKVJc6pVrcHh1bOtVTCRx8DU2uZsZ7tsHbrTE/OM2hboEnvm0Occc0ujv
	DJCCw3QLY9aU15COkCOW3/wkT9mbMhbJnY/ZU69O1U6sTD0IVfeGabPi/WsWOClF+3zNGYKZid+QA
	oZo8zn1BpKSdCTaOPwxY88ZCbopYuJEsD6kMd3CUNfhuH+iiKwXLgEhM6dWxdlmGN0y0hlOKZ7a6m
	qMg3VD0j981fqsln449bGSyKiIjDKJ+tmQRgyzFR32LFlU+HNWMTGQyORX0gUn7KzvS/f4Pa+IfsS
	hCE2jyMJ10Wjl/t+Ey/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQhD-0006w2-Tu; Thu, 13 Dec 2018 13:06:31 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQh9-0006uC-8j
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:06:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9830EEBD;
 Thu, 13 Dec 2018 05:06:16 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67FA63F575;
 Thu, 13 Dec 2018 05:06:16 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 3ACCD1AE0D04; Thu, 13 Dec 2018 13:06:40 +0000 (GMT)
Date: Thu, 13 Dec 2018 13:06:40 +0000
From: Will Deacon <will.deacon@arm.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 4.21
Message-ID: <20181213130639.GD31177@edgewater-inn.cambridge.arm.com>
References: <20181211200847.GB5218@edgewater-inn.cambridge.arm.com>
 <20181212091702.hevwn4edprffzbhi@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212091702.hevwn4edprffzbhi@8bytes.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_050627_316421_BC266434 
X-CRM114-Status: GOOD (  15.76  )
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

On Wed, Dec 12, 2018 at 10:17:02AM +0100, Joerg Roedel wrote:
> On Tue, Dec 11, 2018 at 08:08:48PM +0000, Will Deacon wrote:
> > The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:
> > 
> >   Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates
> 
> Pulled, thanks Will.
> 
> Btw, there was a merge conflict with the patches to unmodularize the
> IOMMU drivers in drivers/iommu/arm-smmu.c. I think I fixed it up, but it
> would be good if you can check it later when I pushed it out.

Looks fine to me, thanks Joerg.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
