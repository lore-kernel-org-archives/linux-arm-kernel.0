Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E76C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5A1222A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6QXzDMZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afl2avWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A1222A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JvFk76zCEZmj3RTIMj2090TAO7k82QZZhos/cnx00io=; b=s6QXzDMZn8/Uaf
	OsF4qQGQVnRgAq/2UgLlGJXFCjQla0HdsiSbG4VquVyKMcKVqKs30xDMUAsealgFnxQq1ZhvQ41C4
	3BrW+A08a48LoRIyhzsfISEVV6z0JcH3mqgjA/N+xlTlusm1qPWfZ92rR9B32iNjBbOXRGYLGmg2i
	VRULFliNIr42RmVR/590hk8IDSwtyBUvxMu5wKgjcueAgqiWVBtdqcJS/rCr98aDkQ7W56D6IULFR
	7mN45B06m8Ju0YLu8Cxsjc9A+vIOhhm0La4D9rDK7DWBJbh6iaXr0th95gN4U3CkfrOuSnax7IKTZ
	rYhndEDCUyUPqHG8KpMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvBas-0002nj-7e; Sun, 17 Feb 2019 01:50:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvBap-00022O-18
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 01:50:08 +0000
Subject: Re: [GIT PULL] ARM: SoC fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550368204;
 bh=ibMEoFDPTKWmqS1VaU3P+5VKNrOFsJ1QLpwGguQwHRw=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Afl2avWfs6mcnDjGTe7ifxXBaRHr1JCL4n35Okr/pwtPUNMg/2DlK/l6SfjcXq/4u
 Wn2NIJAQGe9Kkp+KAXSGkDpp9cFQGxiu7G/sc/haoKPzROP0POvin5gInEYWuuOXSS
 SXkDogqvrdr6QSLu5f8ljxUamhw6eAkPh6Gf6wso=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
References: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 410d7360541c0e21b58e56b64e5bcdbec9c1d285
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64c0133eb88a3b0c11c42580a520fe78b71b3932
Message-Id: <155036820398.25738.788305032317721076.pr-tracker-bot@kernel.org>
Date: Sun, 17 Feb 2019 01:50:03 +0000
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_175007_095605_3C11D7CC 
X-CRM114-Status: UNSURE (   2.86  )
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

The pull request you sent on Sat, 16 Feb 2019 21:20:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64c0133eb88a3b0c11c42580a520fe78b71b3932

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
