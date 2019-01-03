Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:41:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427B1208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="quY4PV8M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLED9VQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B1208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=IJO9Y598qLzUoLL39Hxf96LB+IHzv0hiQX9dJEhlw4U=; b=quY
	4PV8MZ5/3zhIHcWA7EXkF+UpXPPZyQXU2K4ZnhH+6fQyLt8pgYQYZ7B+RkvqFFgpIjc6t6uYRmKyd
	9YhbcBy1kj67ushYHT7w+eLW+P1lkNlF26N5xBIxfzr9gkhIXV9T1IkmhE0LFP8YNJoUc7nO5WhtW
	Jlagey3oQyARIXH8WPMDJ3hp+HL1LVbsvND/TDsd7MeKKTxY1tct7TUzrOh60mmEibSGOxdQvgjxm
	0KdWRlm0I6EToMXVScne3vv82GGKG1RLo3FVgb2n0WizvdpwXRanqcohRlP9kdh1XelZzcNf0CDGe
	q6IbPSzEiY9jCfoWgLRsPqNZDbKLGtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf57D-0006tr-In; Thu, 03 Jan 2019 15:40:59 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf57A-0006t6-8Y
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:40:57 +0000
Received: by mail-pg1-x543.google.com with SMTP id t13so16141104pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=iQ/hozz6h1sPdZTwW5rQK+ct9SafGx3dxp1vjGgqKKE=;
 b=PLED9VQ8kawvi8zFTMroY11BRMNvfyFT5kgui5T6P7qQrWLg50udMr7NEWvA41rx7p
 AIQB2d1T5qxcBUnbJqRWjmZ44QskWLwIzwDNJACeq2qdzvCi1rV4NvdIaz844CbNLiP9
 trNWyUy8A4xN3SQbQmxpkMwHp6Ha9vlZpsHAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=iQ/hozz6h1sPdZTwW5rQK+ct9SafGx3dxp1vjGgqKKE=;
 b=qTHANG1Ob1Dc6f9l/CxwCmrTocgfSlHag8eQIWaGFyAiBGskDselLPF7DzXvJHv06a
 YJlIQ8SqlcKLMZrJENtOnYOHHNnrBWhcCjJR9ASF35+t6z0kt0L3gnJysijCY4HDuW3i
 VcIfumdIUQcMCe17pD9FuCFhiR5mGeGyYgcuExuQdVuXWjsyX4bjz5je8VYd/aSwQXMh
 wF0ev2GlLDuflIdiIrHZH7//NPK4718iD/G4cxgP6LpjIQX/3gkbebyumEqJ+LWYmgtz
 +qCTPGQGgbeeUa2mDz8+eQzWdW/y5RgbYMfDsYAKbRnwONELCGGeV+s5rDM3yPOddtVX
 Dygg==
X-Gm-Message-State: AJcUukeCeVTZrGrLOJ6pTWTmceeEVdZQ10ZXNTh/058W8m7gXeVUl5qO
 b0o8CY0m2igk2MwZFoBkI/VgGg==
X-Google-Smtp-Source: ALg8bN7/mSASNjq6yTt+wJia7ODMRHvCu/sQD/0BlbyTrF6QCEPj5XkGPIhFPP3k3OApXuEcCU1lsg==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr17428052pgb.417.1546530054994; 
 Thu, 03 Jan 2019 07:40:54 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id w10sm66155494pgi.81.2019.01.03.07.40.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 03 Jan 2019 07:40:54 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 0/3] arm64: system call table generation for asm-generic
Date: Thu,  3 Jan 2019 21:10:22 +0530
Message-Id: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_074056_313730_E2A6BFFD 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This will be an automated scripts to provide easy support
for add/modify/delete the system call entry by add in 
respective *.tbl file.

System call table generation support for asm-generic is
provide for arm64 architecture which will use the common
scripts resides in scripts directory and use syscall.tbl
syscall_arm32.tbl files as inputs. This implementation 
will replace asm-generic/unistd.h.

This patch depends on:
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
 https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (3):
  arm64: add system call table generation files
  arm64: assign __NR_*_Linux_syscalls generated by the scripts
  arm64: generate uapi and kapi headers

 arch/arm64/Makefile                          |   3 +
 arch/arm64/include/asm/Kbuild                |   2 +
 arch/arm64/include/asm/unistd.h              |  10 +-
 arch/arm64/include/asm/unistd32.h            | 826 ---------------------------
 arch/arm64/include/uapi/asm/Kbuild           |   4 +
 arch/arm64/include/uapi/asm/unistd.h         |  13 +-
 arch/arm64/kernel/sys.c                      |   8 +-
 arch/arm64/kernel/sys32.c                    |   8 +-
 arch/arm64/kernel/syscall.c                  |   4 +-
 arch/arm64/kernel/syscalls/Makefile          |  70 +++
 arch/arm64/kernel/syscalls/syscall_arm32.tbl | 434 ++++++++++++++
 lib/compat_audit.c                           |   2 +-
 12 files changed, 540 insertions(+), 844 deletions(-)
 delete mode 100644 arch/arm64/include/asm/unistd32.h
 create mode 100644 arch/arm64/kernel/syscalls/Makefile
 create mode 100644 arch/arm64/kernel/syscalls/syscall_arm32.tbl

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
