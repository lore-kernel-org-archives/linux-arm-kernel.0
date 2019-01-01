Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B294121783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pKDCrcvJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSaN3hCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B294121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y64x20/jCFHqqlO6lEwaxDocpgYV5os+JYz/ZgM9LT4=; b=pKDCrcvJMq9gGh
	CbdUI1J6nH3srV1aR2gDn1fFpnwTZemYpiS3IZaLTgM+RTJWY4MvVIU374E/Z+ohPkRqJmJTYcpY+
	81SAq+L+PNfWCT05NRAtowHDvNscw6Ca5/K5fT4pxQKNvm6bvARBSr5wawmQ4efxUyIra6V5cvHrW
	Vi6us1j58cWSxsxy7pGdzjqfN5jOOEZ6xUd8799KUB3q6521+MT2aKceny8H+JsDT0BilWf4W+7/6
	HLBcnXIqCIlZbJDjta+zEzy3xvB47vLVRqyFd/oqxcpDPsm/aWf3sf2bI8t696F1uZMZ7vKXStp+Y
	LOmJu67AI5xb0zGl6EOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge97Q-0006OI-Df; Tue, 01 Jan 2019 01:45:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge97B-0005Ca-Cq
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 01:45:06 +0000
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546307104;
 bh=4ccfoIcz8hHSH7I7quI0FKMtMyXrm/XaZtyvm2MXxTA=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=aSaN3hCzU2fkaG5ivvoNVzElBwteoPoRKYC3gCjRtlTQ/yvgCym9PZqCK9YTd4nlO
 iFfxzMTRVM2mAPpjxppb3k+nY/kp30benIjWUU8Baf1lUOssTufWwjVvdmIfC4U5Sf
 b7T/sd4U5YjmR1B7xTz1De091uOja6qmeXZih4p0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-2-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-2-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-2-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: cac1fc8fb561ac766468394d49c3dd11a2b8cb44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0922275ef157ba8ac93e7e7857087eb0442d5397
Message-Id: <20190101014503.19922.77591.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Tue, 01 Jan 2019 01:45:04 +0000
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_174505_492516_80E6DD6C 
X-CRM114-Status: UNSURE (   2.33  )
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
Cc: Olof Johansson <olof@lixom.net>, arm@kernel.org,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Mon, 31 Dec 2018 13:46:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0922275ef157ba8ac93e7e7857087eb0442d5397

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
