Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0166C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8473B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GuB48bhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XgRO2wycF52iB7ZglV7eKe6JRB/QnlLLvMzWI2zjTn8=; b=GuB
	48bhSLPwfYhSAeYL/I8VAcbF60C8kFRCqLsZa7Xb4kV0Roc1GUpzWY+PoGevyZSyiD4TvX2022Rhh
	411j2rt002fV+Zdi5vZUxg1HI7B2lhdvac9MM3iGbNMIP3/AmzpFBexCmhj0GFhuLlPnDclpzcIX1
	2bQr/tZvfbfGqnYraSRgQtSErvTf+eG2giBtCgCXZfdv9itMF+IY6gYAhPJaLS6h/aS852GL8RsvW
	IFQpsdQH+zEXCz62bIkwpcDuDIY8+R9zefX07eIR5Q8l13KAKy9mBlUalnWcB2MIqhVVtz12qlJq4
	9JMoVRJ/a/Yey6WX6r6M0bg6KX7E3uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTohQ-0002uO-5a; Mon, 03 Dec 2018 13:55:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTohE-0002k5-23
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:55:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73361682;
 Mon,  3 Dec 2018 05:55:25 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 009853F614;
 Mon,  3 Dec 2018 05:55:23 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] uaccess: Add unsafe accessors for arm64
Date: Mon,  3 Dec 2018 13:55:16 +0000
Message-Id: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_055536_114654_BD09E21B 
X-CRM114-Status: UNSURE (   9.95  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com
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

* Patch 1 clarifies this restriction in the API and attempts to check
  against violations of the restriction.
* Patch 2 implements the unsafe accessors for arm64

Changes since v1:
- Add a way to detect code calling schedule within a user_access region
- Make sure put_user/get_user arguments are evaluated before disabling PAN

[1] https://www.spinics.net/lists/arm-kernel/msg674925.html
[2] https://patchwork.kernel.org/patch/10634783/
[3] https://lkml.org/lkml/2018/11/28/50

Cheers,

Julien

-->

Julien Thierry (2):
  uaccess: Check no rescheduling function is called in unsafe region
  arm64: uaccess: Implement unsafe accessors

 arch/arm64/include/asm/sysreg.h  |  2 +
 arch/arm64/include/asm/uaccess.h | 89 +++++++++++++++++++++++++++++++---------
 include/linux/kernel.h           |  6 ++-
 include/linux/uaccess.h          | 11 +++++
 kernel/sched/core.c              | 19 +++++++++
 5 files changed, 105 insertions(+), 22 deletions(-)

--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
