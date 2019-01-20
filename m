Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A22C61CE3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:00:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6A42084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJ637QGf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy7GHFp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6A42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DCENM6B27YKyK+8eHo3pCkT2gEAKWlUGPWJE8kNVvLQ=; b=LJ637QGfkq2FMk
	bhoge6xlbmclNxtcI5gAA6+Lg/uu8QRB4aKq85zDimp26emvdWGCynYpioYmvCKO7Y+z4FNhGd1LF
	+VVLD1sPKc7YOy+GgPaBNWXSVMeQ8n0XPNotIH5u3TJEL1jIMWnCQnDZC9AbK+E0hp/7QoGTG11no
	MWhmUhb1gsBUoH5VMhFuJgx7gZVQ2CI+hdxVS1xFfd0BQCMBTD61fL+HOqiuv42YTkrqVLEi6acX2
	qrO772jltEhlvDO5ZG4csPtf/zJP6WmIGKFf+Sezg9B8Mk4aABz4Qy8sjPA7S473Qe+C+DyZ9nk+U
	z63t9e9TMZRFEqH7HPkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl4HH-0001e6-19; Sun, 20 Jan 2019 04:00:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl4HC-0001Ea-RJ
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 04:00:04 +0000
Subject: Re: [GIT PULL] arm64: fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547956802;
 bh=0NsXX9z3D0Ipytk+W6XcUHD/v1plWlIs7jL0YqB/B6o=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Sy7GHFp8nispoSSmBtLjcxhFYkbqyTGB/SIFl6zmus7NKPpIg0CLDS5yWHORlRxRc
 gcSltjERYtKbR9L4sChDXpjJReEOXc+ZK5p6ZHjbslAYnUa3RLAJt21yGv3a6oSlgl
 sLDueaRsb24esoWdT4p9YHuHGatoZuVLV7iHyMVs=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190120000420.GM26876@brain-police>
References: <20190120000420.GM26876@brain-police>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120000420.GM26876@brain-police>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7fa1e2e6afa7f4c9f46528e61de6a15d9e8dffd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0f3e768a89bbc72195023c3db1db45c40e5b70c
Message-Id: <154795680204.15924.5820126657535767382.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jan 2019 04:00:02 +0000
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_200002_931813_B93B9678 
X-CRM114-Status: UNSURE (   1.69  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Sun, 20 Jan 2019 00:04:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0f3e768a89bbc72195023c3db1db45c40e5b70c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
