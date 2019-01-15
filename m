Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD13C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0859F20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ddxJbdhi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y6EmkaZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0859F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=AmsBuBdcwq32aSrT/TGbOkSYjWHf8ximFjAzedgEYOo=; b=ddx
	JbdhizhgrwkQQnOrp90n501TKYYeqtDQhAmW4rPl7XWjnG724LK7TPhaZs0i8wEXWgjlL7Kv38sYd
	83s4sa9nEG5vkTwUMFfwtDToaF7RHGZUNKMRACrMR1X0JPv4kikjIusL7NTcS00scwkpDrqLdqXpb
	OGFLYO5g0AOtkgSOVr2LtSSe8J08XPiISn6XYJjh0Ewu+KCn1gIUNJN6JtRggyaExqEUqkauGH3dP
	fXTGW3B5IL29Pjqp7d/iwZsIg28AnoSVxxF602t5gvR2LOnDCITwgegMk/gEfk2OrY3jEYt+H2M60
	U4mJ0ZSgC8p7cA/OR9c95WCDmpLQzng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPS8-0000hS-34; Tue, 15 Jan 2019 14:12:28 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPRg-0008R5-A4
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 14:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O2JIIB4zOuJ8eTVggTjQoAaASvf78jq7+kaiahCyJEg=; b=Y6EmkaZZVjzlLIeZYz4LzUdbU
 EdILLZE5Ut55TvtEsYI1kMNuDygb/iR3ldgZCe+TFAdgyNSefH4Ph6MofsfJHCiT+YwgUYYRqXuAQ
 YX8X4gh70WJIy+ZMuVPISvGVvrI2b+5M7iMImBthpXrVAxKqELWup/F8QQENvwGtYLU3pqGrmTntT
 oqI8QGWz9qls5WP/gRgjUHrptPRyLas6/geKtKQ9GSbF4IHz5F5yNm3IBhO7M1HgII+4Fr1AAMbfN
 TA9Br7aPG+ZXj3etD+us8KwDlSQioNJ8THvmSaZ8a8yK2h62s/2aUBDtNxvnaDS6WSpB7LQKgZ9LX
 hV/ilTqAA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEk-0006F6-3h
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:58:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6CFA78;
 Tue, 15 Jan 2019 05:58:37 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99E083F70D;
 Tue, 15 Jan 2019 05:58:35 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] uaccess: Add unsafe accessors for arm64
Date: Tue, 15 Jan 2019 13:58:25 +0000
Message-Id: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_135838_310208_2C1F7876 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

First version of this series[1] was briefly in linux-next but had to be
reverted due to a bug where schedule would end up being called while
user_access was active[2].

After clarifications[3], rescheduling while in a user_access region is not
allowed.

* Patches 1 and 2 implement the unsafe accessors for arm64
* Patches 3 and 4 clarify this restriction in the API and attempts to
  check against violations of the restriction.

Changes since v2[4]:
- Rebase on v5.0-rc2
- access_ok() is now done in user_access_begin(), so rework accessors
  so access_ok() is not called in unsafe_get/put_user()
- Split addition of unsafe accessors and the user_access_region check
  into separate patches
- Avoid reading SCTLR_EL1 in user_access_region check
- Add build option for user_access_region checking
- Reword clarifications on unsafe accessors API

Changes since v1[1]:
- Add a way to detect code calling schedule within a user_access region
- Make sure put_user/get_user arguments are evaluated before disabling PAN

[1] https://www.spinics.net/lists/arm-kernel/msg674925.html
[2] https://patchwork.kernel.org/patch/10634783/
[3] https://lkml.org/lkml/2018/11/28/50
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/617080.html

Cheers,

Julien

-->

Julien Thierry (4):
  arm64: uaccess: Cleanup get/put_user()
  arm64: uaccess: Implement unsafe accessors
  uaccess: Check no rescheduling function is called in unsafe region
  arm64: uaccess: Implement user_access_region_active

 arch/arm64/include/asm/sysreg.h  |   2 +
 arch/arm64/include/asm/uaccess.h | 123 ++++++++++++++++++++++++++-------------
 include/linux/kernel.h           |  11 +++-
 include/linux/uaccess.h          |  13 +++++
 kernel/sched/core.c              |  22 +++++++
 lib/Kconfig.debug                |   8 +++
 6 files changed, 135 insertions(+), 44 deletions(-)

--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
