Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:50:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B365120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQm6mbFc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn3XtRSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B365120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tEvd4dtkZ4qSFLau2YZDSCnJ/bP4nzjBNN268jupAJo=; b=EQm6mbFcrRNLKr
	UiUlO+ZL+UHn3+snThCcHq5YobHalEBQCdPBgPhfoURHxAmK3u2PzdhI0tARuuHLGrOyCh/ndCimx
	RrJC+Q0vsJzJu504ZDzozpWKyPbds6M8Aw5X3+iG8x7U1dy0PC/TomWE9t2XJDhfl7vUv1aAQLPCF
	qvvHhNa1gsT3+5U+iBD0DvvWo1vbWC9dqlTMHOAxnEA8A3tW3NphACy4kIpC6VetjCjd45TFUFWt8
	jsU78zs6+dkphy51WugB+u41+m4gLMWOLx5g6M7u7S3TTVWzKgk7+xr8wDe/JmQ4n6kh3auNZkyIQ
	L4xl3sS5u6OA+tswGNZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gioa0-0007pW-4X; Sun, 13 Jan 2019 22:50:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gioZv-000733-GZ
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 22:50:05 +0000
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547419802;
 bh=f/MYeKrdd+LTFEKujv03Q0Aikv5tejg9xoutEqZs9ng=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Xn3XtRStWn9vmV9caNYZiWqCHKwK481I6ETeedrsGj7PWK04O8EW/q6PWsgvo7618
 lIEDCLN1eY86OneHnIovG/vnje3irBavd45gfvTvommMqzcZSgIT8VvbU8EFqxgzcm
 WjsybrZbTHtwj0CS+4ARFP2lhKzKRdXxWTENuAPg=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190113184825.ogv3cmshi63hxlgj@localhost>
References: <20190113184825.ogv3cmshi63hxlgj@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113184825.ogv3cmshi63hxlgj@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 465612178b44840b2066e62c3bcfae80862011d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbc3c09b819f2bd42460b148e55ac5a9d83aaeaf
Message-Id: <154741980194.4214.897523899342173742.pr-tracker-bot@kernel.org>
Date: Sun, 13 Jan 2019 22:50:01 +0000
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_145003_576877_9B0982D8 
X-CRM114-Status: UNSURE (   1.88  )
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
Cc: olof@lixom.net, arm@kernel.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Sun, 13 Jan 2019 10:48:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbc3c09b819f2bd42460b148e55ac5a9d83aaeaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
