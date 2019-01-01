Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA7AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01C420828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YjaUXbLO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1cwEuhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01C420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=97mcO2TjFFa/mHzABqh4E7lsu8cFG/WM5e+uFtSjnHI=; b=YjaUXbLOTf9nWn
	4W263NwD3v/QciTceCrbrX89rfAufOExDkMltajd/x+3FNs/ctOPVVvVXiApg+CYJ/De1lluncQr0
	3kpltMSnQIsYR1rGEX4UPZQQ1Z4/nphNvGSxIJoHpCeWZmH3sHwlrNno7rwc4MuggIKWPz5Uv/L34
	+QyHJysXHVz/Bhp8DQJhqRT0k7TXPO+xPpMh53+rB3xKPqqvXMsD81FxgAdveJu4/bEAyDT6oQGrK
	usrNO+qmNJKFHRgl803XJO9QeBZtIqp5H0Tklnche0DviflpKuPoAWmNm1Z1czg/jGp89J1rusyPo
	8r0uHq1pFz1aLQqVAEDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge981-0006sT-CW; Tue, 01 Jan 2019 01:45:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge97B-0005N6-IT
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 01:45:08 +0000
Subject: Re: [GIT PULL 4/4] ARM: SoC defconfig updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546307105;
 bh=VRY/GxmIK175Ds9hKojiZ/IB3jv0NBNzsd9O4PLeoNI=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Q1cwEuhg+Yfb5FKXhlgGkLUrsdeb3o8xvEXvu/V4RwuQ1lGBx609BxgyAm3JQHcO+
 aVpxEvkd/jYpoBbvaAeCVz874t3ui7lT0ETS2TlMd/LQsUr/wiMuQugQHwjBS3djVM
 XgKTFbSUn2yI1U3NSHIZwRPFkrqWRK8w55w14Z0Q=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-5-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-5-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-5-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: 82c7b351be3fad005ba38a26f7f1ab7f0841e505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1ef035d272ef4dbfdda98e58699698305138856
Message-Id: <20190101014505.19922.69449.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Tue, 01 Jan 2019 01:45:05 +0000
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_174505_709255_23DAF436 
X-CRM114-Status: UNSURE (   2.23  )
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

The pull request you sent on Mon, 31 Dec 2018 13:46:40 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1ef035d272ef4dbfdda98e58699698305138856

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
