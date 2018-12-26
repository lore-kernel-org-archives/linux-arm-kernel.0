Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F957C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:50:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE7221736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V810Y5f2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O67cjXUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE7221736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/gnrhAPRymNNx/lohVuJdBui9lAc6K7NhtMsYp5Emms=; b=V810Y5f2tyqc2n
	H+Y6uRlR3MgSOnpE1qTbs+PUdkcvlQxR6qPZu8YWVidvmUrY1z2iWjhAHxDs5dlBohKjSRWG8blEg
	IGWR/ZF0WkI+x1k1cKXiRqwN/7ZESEkt/bS1KxNvgzEN/MfFAz4l2KmkvM7s5dELKBnqbtbWyUMHv
	Hflb+ORZd7Fg6GmZ+yrSQFG16Zck9GkbcyIFSEmayXB/orkkKvIKcPXnSzGYHGPR+uKNti2W5jMGV
	UnxPY14zG5tx8MkFmguiVZ7JeqV7YFO3whaaALKiYo98y25D/mzDxWY6cRvaBXkv0qmC2uIu90608
	25DFDzwpLUhOD5MvYsdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbyKv-00011a-6J; Wed, 26 Dec 2018 01:50:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbyKq-00089z-Iw
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 01:50:14 +0000
Subject: Re: [GIT PULL] arm64: updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545789001;
 bh=PSS/U1ob9qJTQZualx0PlbLksBGiQyoYY71DNZVxVnc=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=O67cjXUR5wTGd4Vem42g5Bv0wb2rA9tJu2v3obiS/pb5f5ziPueuPbsRk2KqjODmF
 0s88kAqJnNe+Dw8WX6+Xh6CYKoiZ3LC9AidtK2gP1Y6SFh3gIq0qzUGVPRlSkND9UU
 kLRLAlPTTOHDRo7IBZK5x/MzbZuUpkbQRPk8sIsc=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
References: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: 12f799c8c739518e12248bbd000eb0a246e8e5f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5694cecdb092656a822287a6691aa7ce668c8160
Message-Id: <20181226015001.16185.53789.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Wed, 26 Dec 2018 01:50:01 +0000
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_175012_660708_189947A0 
X-CRM114-Status: UNSURE (   1.51  )
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
Cc: catalin.marinas@arm.com, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Fri, 14 Dec 2018 16:14:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5694cecdb092656a822287a6691aa7ce668c8160

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
