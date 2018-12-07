Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD418C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEC620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VsEU0Gx5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqj0uZHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9BY7oPaiTc/gUSsCSHgitm7h5KP7+45jPqbFYPcqHb4=; b=VsEU0Gx5J/oGKW
	W6kk7vw7VvzfkIaoS4ijoMIy+JZhvJEINMcNTku4bJ42ZRcdATVxfpRs7zlnVM9ozVIDnO0kl1enI
	jGit+L5D6NScNYlPXdL3qeSaE/dniNmS+b2+AP3ChezCnM/FsatJDhB6hRu5gONV70ykAnkawjzAx
	hQYPPGLVt40mawRTE0PJlOM7kRraBRjW2wvYdMtviMuP4U45PKMsxD8KP6/GRjpl4jpTNBRNwYkdZ
	GD+tS3csxMXhiU01BFLfCbfrTk7+tQYqpJkvt7jzTCcDC/U55VgpWp9YF+r/ULnmmKpLL5qJ8FtDE
	bTs7irnwvJEu24ufPCSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVOnA-0001cL-8N; Fri, 07 Dec 2018 22:40:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVOn7-0000V3-Aq
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 22:40:14 +0000
Subject: Re: [GIT PULL] arm64 fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544222402;
 bh=oh86BxsexgcbmjEHl72C+OdMVeeyvFJ6TV48Z80CApg=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=eqj0uZHxRPN+BuMu5DJXkW/WJxSQEFQVieClHKqFsC1YjLoDdXlEPh/3UjLcqtnqA
 Bq/H6nY0gqujGKCBFJ1Gwh56Bh2a3lwoXRUyoEhbhmv/n3uHxVGHFjLOwcsV60xgwW
 61LO/7HIjm0e3kYDbI9WaLjTs4hYbwHSEljExWwc=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181207183459.GA30569@arrakis.emea.arm.com>
References: <20181207183459.GA30569@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181207183459.GA30569@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: b4aecf78083d8c6424657c1746c7c3de6e61669f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8bf4692c98038a1ec98faf09e545d1a32429b54
Message-Id: <20181207224002.10788.79437.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Fri, 07 Dec 2018 22:40:02 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_144013_406273_CDA43AEB 
X-CRM114-Status: UNSURE (   1.82  )
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
Cc: Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Fri, 7 Dec 2018 18:35:01 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8bf4692c98038a1ec98faf09e545d1a32429b54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
