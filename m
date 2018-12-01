Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581A320660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEwAmoCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581A320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xxmkgUhIP3U+vc7J9lMRS+rDj1BVhqanONPbxbQfVuM=; b=IEwAmoCdRxn0vI
	Oq0wu/MQ3v61wDvqZhJDD7O1vjhFpIpa+wdsR5GCc48y5QaNWLRek5OQxNlQO/UXFfZ5UxGmNaR9+
	q8r13u/Yo+O44wXBt4rWgmTjGQCcqCVkjw4H532cD+J9q7nY2FTAZyvWupdIryYDHGg4Ibg4ZI5IP
	WsS42aOBzzKM2/TDZUdG2zOPyvRQgl5UOvAQNaG4OATPBRhQ0ooUNwTdX96vF4f+Hh0VOodcKr9qL
	o2Zu2JH2WRtwSgJ6jbgBOxI8g7n7V9mha/7zZ9NkAyl2mQpd7BMqJGb0T103NKSGjfbhBjviWfgm7
	ozn4YwzaydyUINTtGXYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSvR7-0000JM-2Q; Sat, 01 Dec 2018 02:55:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSvR3-0007Vw-Lv
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 02:55:15 +0000
Subject: Re: [GIT PULL] arm64 fixes for 4.20-rc5
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078F52146D
Authentication-Results: mail.kernel.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181130185455.GA24239@arrakis.emea.arm.com>
References: <20181130185455.GA24239@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181130185455.GA24239@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: ea2412dc21cc790335d319181dddc43682aef164
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 868dda00b98ccc701a70b8c1b0168fc3bbfd595d
Message-Id: <20181201025502.16477.66940.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Sat, 01 Dec 2018 02:55:02 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_185513_743736_D01510A4 
X-CRM114-Status: UNSURE (   1.89  )
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

The pull request you sent on Fri, 30 Nov 2018 18:54:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/868dda00b98ccc701a70b8c1b0168fc3bbfd595d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
