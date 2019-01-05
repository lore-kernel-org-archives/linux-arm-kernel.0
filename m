Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0463222FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcFb/iOJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x4E/YpxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0463222FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Ko/nixdZGBcolZ6E842mRRWn7NiVwe4KLOxHxGv/s0=; b=gcFb/iOJqYyr08
	HReWRoGVzoItRHtxf9Br6nA1MLelAHXJiw2brZnhpNiDh3WBZYhlYlROHOvvpBmwWiFVXpJT/gVxT
	crMqbPGDV01xMxVEJ7A7hjhCwG1otq9nsofpP7OBxwWszxUlrS4Zqpm6wNPujRc6VBfiWi5l/bEYV
	vf6HTe+IMm0l6Zl/7ri3cSK2/6ZET5tKYCTzTfMPBbnq6fmPghepOxn6NmfzLhKff24PNbbWofAgq
	IPrK6UyIHAFg3kyAXEeO4wFs0o498a163D/amFtUqM61STN6olxPmUWGOCuDxraCR0o5CyAqX18tE
	HW621DqraFCeQnd41Klg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfsQe-0005Ej-2Q; Sat, 05 Jan 2019 20:20:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfsQb-0005Do-0I
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 20:20:18 +0000
Subject: Re: [GIT PULL] arm64: fixes for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546719610;
 bh=ycV8mFn1D5rPXS1M7KCg9sRlIHPxqjg0ZsVTe4r3sP0=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=x4E/YpxB5m7r/FhZ/9/dWsMDOSnvkzAsicyOUYuZMKykm175MF3bqvXLAnRI2bT2x
 Nww1YqZr90ADsdyXAx9j+iirNTrH/Gdl1aqV8vauCJBFoh4rRBQ2zKULz8ebLNpS7t
 nFIheBLuNJcOhnsetDo5tDLYhh8YA4Ate1acHeP0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190104182427.GD6299@fuggles.cambridge.arm.com>
References: <20190104182427.GD6299@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104182427.GD6299@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7e0b44e870cf265bb4a73fd25e0508c7363fcbd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 078a5a4faf64fefaf13478a9091782432cad33fa
Message-Id: <20190105202004.12651.2681.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Sat, 05 Jan 2019 20:20:04 +0000
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_122017_064735_5FCD2DEF 
X-CRM114-Status: UNSURE (   1.58  )
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

The pull request you sent on Fri, 4 Jan 2019 18:24:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/078a5a4faf64fefaf13478a9091782432cad33fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
