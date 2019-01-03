Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B72620833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Upp2rqJn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omLfQ9Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B72620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7cmT3G7HDCGYh8lER7TnTNJrBs8bDUz3YNiPbpWN1Zo=; b=Upp2rqJn1dGERA
	ioBm36r5bbmQBRhx8OhpTAdSC1UH926BeBYAbMXOs8Qhc15g+4LI272JISpprvfD8tDoCKBiHceEV
	bSqUl/Kg0LUCdBUyW4GHnkDigUOtTa5jAnWplwmV3So2HXly0RDy7B+i4qbonTVLsNylkIJkGjXLk
	9kOP2i5ds+FPp7lkPnO4AEJ7Cf+tw+hE0azmaSe8ro3mdKTAj4MjBypR+Nyaa4FBff49ymB8QhxA+
	3GfYVODL6CCqMMq0bgJKBCZeKbWJFoHYwfJf1UVZIyJ+VZgTo0grHli3yvB2krfw2AtYB3SCYO2en
	Huverk9CVJPryFSGZBXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1getJk-0006jV-MG; Thu, 03 Jan 2019 03:05:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1getJh-0005mr-Qz
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 03:05:07 +0000
Subject: Re: [GIT PULL] Mailbox changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546484702;
 bh=RLbHI34J0YgLbn374kaeXeNUOrzyupgNKBFNndfVyN8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=omLfQ9RwQHlK8BCgMuqH5EWgLXxp0nBlqn+hE+MrXhTUK0jMmpH2qqTGBl1sTTDr/
 E/6cX1uYWD5Tik84XD217W1Uesexrt29DDxvdA/EUmYpZZ5SMz7rAu29+xsM3Kh1gm
 3ZvhpRkbLsyMEa5XVAaajOoqRGGO/1lwIN3+eUOo=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
References: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v4.21
X-PR-Tracked-Commit-Id: d69e11648e486ee0f21cb246f687b083f0d4e124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35ddb06a467538434b4139fbf5c02a2ef073162a
Message-Id: <20190103030502.10885.28248.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Thu, 03 Jan 2019 03:05:02 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_190505_904404_60F8CF93 
X-CRM114-Status: UNSURE (   2.36  )
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Tue, 1 Jan 2019 23:34:36 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35ddb06a467538434b4139fbf5c02a2ef073162a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
