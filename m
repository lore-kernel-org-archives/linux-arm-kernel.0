Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED0BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9505F21908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zak87sr3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+UsFwmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9505F21908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i2s/XDDyZQBLXwa6BPLVHkobYxReXDEUnjSiAdKqf5A=; b=Zak87sr32Now4P
	XwWHEd7zYlLJqdpXyb6xtUBfIhEqB5Qc150arFdsFkqEy9Lukt8OlE4mbqGc277WDH6wUtEdaKyUV
	vbe7F3Wv7jgYBwRlqIp25T27XeFukaRF84oYoQpJr+cRUSgLhRBi/xWPHurFrcuoTZ16Svdrgpn+h
	VhGIuU04RVt9iXygD8DPrJ9J41Yl3UuyFtbbGQp5dYUtBgD2OelZM3NB6VPEvAgGRf7BbBvtO370b
	x04lu9yAVThcByeM71dtofiBnL0eFaoe7DmRfD7ypl4smTbRwD9vRt5jZkYvclKxsMb7JWnYwKV2b
	U016xjJLE1KOd3q6IvHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGgz-0003b8-7T; Sat, 09 Feb 2019 00:40:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGgh-0002rV-Tj
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 00:40:09 +0000
Subject: Re: [GIT PULL] ARM: SoC fixes for linux-5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549672806;
 bh=xsF8nzW7KA4G0+LaoHiOvQsKTUG0QQTEtzvv0kikEgY=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=C+UsFwmreU+dRTi6lklqabECI6oAMWYzDwyZbD3idLDKUYfsJYmUciAWbDqwwngAz
 QtS4Rc1/annaPNqF4GorAIkFs0BQppeqA8bSr/jrr24VNthRxljvAy35qyzMMhgNn0
 rCahW/X66hkiS1jaMnk7aQlcf1vrP3oXh7xNCypU=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
References: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git armsoc-fixes-5.0
X-PR-Tracked-Commit-Id: d0f9f16788e15d9eb40f68b047732d49658c5a3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46c291e277f93737877305f5626a2c5c35522cb1
Message-Id: <154967280661.26526.2498192879181673865.pr-tracker-bot@kernel.org>
Date: Sat, 09 Feb 2019 00:40:06 +0000
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_164008_311126_1148A1EF 
X-CRM114-Status: UNSURE (   2.73  )
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
Cc: soc@kernel.org, arm-soc <arm@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Sat, 9 Feb 2019 00:27:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git armsoc-fixes-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46c291e277f93737877305f5626a2c5c35522cb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
