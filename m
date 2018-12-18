Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:37:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CDC217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pW2aW3Du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CDC217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DKVmeTPItg0A0zrdN7+iZricLnSXaXzG7EWDn3+OWTs=; b=pW2aW3DuoTYdgH
	TADZe+aWBjZNnVB4GOrJoUsT21qYeTFJATK55bUvP3pIKZmmIkVen0PmVCmNTjo4AgdZ05tTLibuS
	0gp/x8yR7dLIWbkSn6CZ+2V1aZIYF9t29EP1MRJRA/rKgGe28JQoBhX5D6odquR6kHdAegFChFjZu
	8nTy/FXg4VItQ0t9+4q/7lD8KHrNhQU5F2MR0l1WCBQuvTnMqwk0pt5YVOpZ+y51vKFS6mz4fsV7R
	Jtx/0w48yshNG1I3B2jYnzPmz74TkKY7Cf8cbK0MB2pF6xiNHj9Qz78RrWiTk86NB1Ppixz5cGzqW
	aqVGUDBlUampZPChFYhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDgn-0005Nu-Vg; Tue, 18 Dec 2018 11:37:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDgl-0005Mk-9t
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:37:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E0B80D;
 Tue, 18 Dec 2018 03:37:14 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0C13F5C0;
 Tue, 18 Dec 2018 03:37:14 -0800 (PST)
Date: Tue, 18 Dec 2018 12:37:12 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v10 0/8] kvm: arm64: Support PUD hugepage at stage 2
Message-ID: <20181218113712.GA25383@e113682-lin.lund.arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_033727_348943_69FDAF29 
X-CRM114-Status: GOOD (  16.65  )
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
Cc: kvm@vger.kernel.org, anshuman.khandual@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 05:10:33PM +0000, Suzuki K Poulose wrote:
> This series is an update to the PUD hugepage support previously posted
> at [0]. This patchset adds support for PUD hugepages at stage 2 a
> feature that is useful on cores that have support for large sized TLB
> mappings (e.g., 1GB for 4K granule).
> 
> The patches are based on v4.20-rc4
> 
> The patches have been tested on AMD Seattle system with the following
> hugepage sizes - 2M and 1G.
> 
> Right now the PUD hugepage for stage2 is only supported if the stage2
> has 4 levels. i.e, with an IPA size of minimum 44bits with 4K pages.
> This could be relaxed to stage2 with 3 levels, with the stage1 PUD huge
> page mapped in the entry level of the stage2 (i.e, pgd). I have not
> added the change here to keep this version stable w.r.t the previous
> version. I could post a patch later after further discussions in the
> list.
> 

For the series:

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
