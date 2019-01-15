Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7437C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8360520651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uDL4EX4Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a36Hwwf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8360520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8gBqhYt6dVj7MisbsNF69hBv4L7wX5itmkqX26qQkJM=; b=uDL4EX4Zv2XrmK
	dKmQITmsNedS9s31iRQC+cc2Hjl+dnVn2fUATtAv2RP59P9dpMuwAwzFQ9zkqYb9MqF+nI68GqmfY
	+l+mXmivNXPL1p8WRQZnxJBEZ+NCmghEriUSO+oJGO72VcacTicztwjGr/l/KkUAeYbPQjesM7ydG
	bszFc23WOUxGFKQMWxnSflJHLhj6/sBS4nIbqjCeQ0Av6qWU0Y0BV+ZAexUja1RhOkhwuzO4Z8yL7
	3fy3jPH0k7e9JkQADx382EjnliA+DfY0SRqP9uOLq/XWb8tSaOWzsyR6/iOC8T1GgHP7cwQVG2QtM
	q1/I29+/DrQH1bA+K3pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjI8t-0004na-Fz; Tue, 15 Jan 2019 06:24:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjI8p-0004nA-Di
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 06:24:04 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9446220651;
 Tue, 15 Jan 2019 06:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547533442;
 bh=M5ZDJU8js+RTgGe66Ho1fUpZuVQo2/Q9RHdHmc4kBdg=;
 h=From:To:Cc:Subject:Date:From;
 b=a36Hwwf3r5f2yM6YQmasuIow5Q2TUHgI6O8oiI/KnDXyNfz6j+fkwyLWEqfQwNp8v
 reJogmLtN64oGutxeve6OJd7zI+TrQqifZ/Owp49O9bHCBR6R0mZvMIWnpRXT2L27L
 whlC6Fxg9O8JhadwR9jvFEOQ3tQC+GAn+Cj7o3i0=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/4] arm64: kprobes: Update blacklist checking on arm64
Date: Tue, 15 Jan 2019 15:23:39 +0900
Message-Id: <154753341900.31541.8135985235882849464.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_222403_484007_06C9E7A8 
X-CRM114-Status: GOOD (  11.28  )
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

Here is the v2 series of update of the kprobe blacklist
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

In v2, I updated [1/4]'s description and added James'
Reviewed-by. Also, in this version, I added a patch which
uses arch_populate_kprobe_blacklist() instead of
arch_within_kprobe_blacklist() so that user can see the full
list of blacklisted symbols under the debugfs.

Changes in v2:
 - [1/4] change description so that it make clear and add
         James' Reviewed-by.
 - [4/4] new patch.

Thank you,

---

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()


 arch/arm64/kernel/probes/kprobes.c |   49 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
