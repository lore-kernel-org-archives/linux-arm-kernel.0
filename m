Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D3A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XdSqNtpg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S44j6YjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D3A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NJ8fmJ3fBd56EKCvwfdwif2R2OilGj87ajwyvdGUFI4=; b=XdSqNtpgZw+xsP
	y4t7l9a6q0KAjiP7b/9QvI9rXRR9GLmcleIl68oIpowp115w6coEB1syyeMKdeIvHyA1YYRpZeo4B
	Kz1eFQag4FEYVTr0RfAN3z6vGSBgwQO5UscBEib5OFDU8yTVQ3dDqq+VLPUpGJfx+VUJZt9fYTdtw
	E4WNRnelyA3yso52ijoxTroXj3Q2lPvr6qxWhSx22R8L6Wij9vWAkfTVWoEZQfOU+p1Bdpi1KjqKc
	2CZLQk7bO3uaxxFhckjc5PAOLI9R0dOTSbRx23UEMDmn6jQ48C/Pxw467ZBLl3MVIpgvREwvura7O
	T6kSJ2MVCMUK8P5S+cHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi3b7-0002d4-3n; Fri, 11 Jan 2019 20:40:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi3b3-0001bq-84
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:40:06 +0000
Subject: Re: [GIT PULL] arm64: fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547239201;
 bh=m9Ul3B7N93UFqYinGHKk2n1E+3XsbewUdmO63FEB1n0=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=S44j6YjEQ3P4UKWcY87kcKQgKAX6fRVKiyzWuBk8X4gsYXbELLJX0X5qM4jxSRbJj
 7Di7H2zslPq148CI+VbjEwLdfBUNshlMnDoAwYzNpqOqEjWGNpSwZl9Ncw4XMKXgfR
 gpCVoqMQAIkH9G+1W856g+OCILRSkOG8GuHzX9wQ=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190111182057.GB32645@fuggles.cambridge.arm.com>
References: <20190111182057.GB32645@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111182057.GB32645@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 279667212ab2a4f36c3b0347657ddcc11f9cfa25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3405d689974555532c12a4f3a5e72dedc660c0b
Message-Id: <154723920158.6200.7472731315707078708.pr-tracker-bot@kernel.org>
Date: Fri, 11 Jan 2019 20:40:01 +0000
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_124005_317029_7E66FD41 
X-CRM114-Status: UNSURE (   1.84  )
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
Cc: catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Fri, 11 Jan 2019 18:20:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3405d689974555532c12a4f3a5e72dedc660c0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
