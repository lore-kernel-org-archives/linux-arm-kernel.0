Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA9C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F8F21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JS7CMmas";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0hYTQeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F8F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QH7JoLg6rRkYCdLt1k7z1bCWdLeOKFUL/oD0FyWxjVk=; b=JS7CMmasVk72hT
	TYSqygvKw3LhFSkI2gc4Uq8tYww1o779zcV3XNcvy1sZfiX4XNx1rqQktTsaW9sbB0M4eqTb0xmet
	RhY0BCIBuwQZW77rTKNnbvNfc5sJvXzvKQfYEvVvlDWncMfZf2mRi3F6BHvEx4hP5pE3ksDBmCXr9
	AWGjpcfQ+GpFesYfFpUSFPz4GASnHHMjiNf9HbIaeFBAMUjexH+jEtMX+wqJsUr0NRxRSwNRAFbJp
	K/1kLUv4F6fPCwfZfaLZMQ13vTNTYFxD9Hayybw810n+Y6yyDgsn1cJoLpf4C1yF9vg/2pVmUp2NA
	COuvR8aS+/ThFWYzZ3hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtaDS-0005sB-3A; Tue, 12 Feb 2019 15:43:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtaDO-0005qs-ET
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:43:19 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 14B6E21773;
 Tue, 12 Feb 2019 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549986197;
 bh=Fl6g9cx+KTVtRS/rzj8ZyrdfdE1bg1TwwE1uUnu9KIQ=;
 h=From:To:Cc:Subject:Date:From;
 b=t0hYTQeGGGbEmbH6bWWM75e0pn5rp51r8KgHA5esbPESJLJrPA09YzgA8QLFFfNLl
 uTH2bvblww1t9exvAdOHLcua3zo6XYpqK7SNnn/kl6JPeGnpkfhEgynluJiqN1M6Cn
 YwNA8Cy6ugwBl1gDq1/kV8HW+kkMTxgb8Lclb/M0=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 0/4] arm64: kprobes: Update blacklist checking on arm64
Date: Wed, 13 Feb 2019 00:42:53 +0900
Message-Id: <154998617300.21869.11457765723750331236.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_074318_509587_F7CDA694 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "David A . Long" <dave.long@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

Here is the v3 series of update of the kprobe blacklist
checking on arm64.

I found that some blacklist checking code were mis-placed in
arch_prepare_kprobe() and arch_within_kprobe_blacklist().
Since the blacklist just filters by symbol, smaller than the
symbol, like extable must be checked in arch_prepare_kprobe().
Also, all function (symbol) level check must be done by blacklist.

For arm64, it checks the extable entry address in blacklist
and exception/irqentry function in arch_prepare_kprobe().
And, RODATA check is unneeded since kernel/kprobes.c
already ensures the probe address is in kernel-text area.

In v3, I rebased on the latest arm64 kernel which includes
James' KVM/HYP fixes for kprobes, and fix a reported bugs
in [4/4].

Changes in v3:
 - [4/4] Fixes to remove redundant blacklist of kprobe_text
   and add blacklist on exception_text.

Thank you,

---

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()


 arch/arm64/kernel/probes/kprobes.c |   52 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
