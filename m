Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48878C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA65D218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cj9Qn3Nd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CkOfY2zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA65D218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bUlP9SnH6XF/UGtxNqRx4YCqRrtelM3fyxMEq02mEC0=; b=cj9Qn3NduDDDwf
	QDNgSmsoW06C77uwmDl+uuZnq/iHAExzOj3egPSfULSpuDXDtvSV7STnqPb99mriZXo+D9IgOIvGV
	Hjtx+L7OH8WIy1CbP0rb/VM9JtIRlzmFpZ1+cDpHId6YHOVxznM8POIU9KQYrqF1AHQ/N+aMsgOcu
	LbaD2BYHGz827w38uMtyaz2pcTqlj8+iwNOBaQ/Hxgbu+lGD0TkeKfPttYEmxRoK+C3fE+UfelNIw
	nnYpAKwGwFcTfZ48+C8l5ogliCRlTGngl+gP0oN2ZiDLrZGR6UjLoFwZBmvjO4jYOYCAo6Od1qGmH
	zCh1dE26Ll7KbFseHeHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcCJN-0004Ck-Pf; Wed, 26 Dec 2018 16:45:37 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcCJA-00043G-EX
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:45:26 +0000
Received: by mail-qt1-x844.google.com with SMTP id d19so17720787qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 08:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GgtfxdhiLdvQCW7QGYVErnx606LplLlDcwec6P3WJq0=;
 b=CkOfY2zv/Z1q5cs672c00kKrdcb6NbKDvzkwnCCqm+j3yCQprxJC9get3MhYmhT6HW
 WT2Fm2Zcd9hu8IsYMrVfLek4ZNi9gDKzxJQrPZyQbDKziMXxMtVFhY7Fh6LoGHLeBdM9
 9/uBhvPBWzXxZDI+zua8lgN3BdlBlaj71dd8uuVo04q5ofFAWUHEIhKFUFm5/1U/bg6P
 piiwt2Xla3lT1iZOb/zBbhZh0IAMONGE8IPrtGxS5AL3cOOQ4iqAuxNUgo+2oDmInrRT
 AvFA/XWrzfZewqTxxu9W/L2V0ThNidVidy9ndxOQ9OFZknYaALgwpjA00/+dycf0/OMY
 hD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GgtfxdhiLdvQCW7QGYVErnx606LplLlDcwec6P3WJq0=;
 b=GSoMOIkTVrDcMtGS4jhfvG4vt76jC/Q7fIqFZaOZC4lxrR/1RehUlh2WOyNI9Hhetr
 4b9FyAn0KlKOIpCpM6+eeliz4k4rRnxqPGotC/vmDSIHnfCBAH2CjeEi4u/AYXPyg0ik
 9n56Ke2YqdryNykeNCGK56fnP+i/MFIjL6tRC+3m5cnWILKWrHUNoTuQFzU7fOzcmH4e
 4IN7HtVp4TRxhgyoNEX8gfI17zhJV/lPF7V/RPY6sCgro6kAphLxzmUOfXiWcdDGFGdG
 t28QoAPfigx5iKtSHQ6yD4fu6tOSv261Tk3q+YXzrWU2yMyhNbnKP2EEM1f8fYFXZj6W
 Gpyw==
X-Gm-Message-State: AA+aEWagwA+uaululoBGx3jVy5OJWgwBVA4LxDrEACzvjSTltgKIVgJf
 awcpowxuCvMdNmULaJk0AM1AQw==
X-Google-Smtp-Source: ALg8bN7bG7R8aWj/3Z8/vN3VDVQ6HkXoBwOBo0vaBPWnVfhxTZqyOJOH4OSzdlwThfyjVARGZRGc7A==
X-Received: by 2002:aed:3968:: with SMTP id l95mr19363089qte.344.1545842711736; 
 Wed, 26 Dec 2018 08:45:11 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 08:45:10 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org,
 rppt@linux.vnet.ibm.com, mhocko@suse.com, ard.biesheuvel@linaro.org,
 andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
 sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Subject: [PATCH v3 0/3] Early boot time stamps for arm64
Date: Wed, 26 Dec 2018 11:45:06 -0500
Message-Id: <20181226164509.22916-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_084524_491440_288D88D8 
X-CRM114-Status: GOOD (  11.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Changelog:
v2 - v3
	Addressed comments from Will Deacon: split into three
	patches, removed hardcoded assumption from vdso, don't
	assign arch_timer_read_counter during early boot.
v1 - v2
	Addressed comments from Marc Zyngier

I made early boot time stamps available for SPARC and X86.

x86:
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com

sparc:
https://www.spinics.net/lists/sparclinux/msg18063.html

As discussed at plumbers, I would like to add the same for arm64. The
implementation does not have to be perfect, and should work only when early
clock is easy to determine. arm64 defines a clock register, and thus makes
it easy, but on some platforms frequency register is broken, so if it is
not known, simply don't initialize clock early.

dmesg before:
https://paste.ubuntu.com/p/3pJ5kgJHyN

dmesg after:
https://paste.ubuntu.com/p/RHKGVd9nSM

As seen from the above with base smp_init is finished after 0.47s:
[    0.464585] SMP: Total of 8 processors activated.

But, in reality, 3.2s is missing which is a quiet long considering this is
only 60G domain.


Pavel Tatashin (3):
  arm_arch_timer: add macro for timer nbits
  arm64: vdso: Use ARCH_TIMER_NBITS to calculate mask
  arm64: Early boot time stamps

 arch/arm64/kernel/asm-offsets.c       |  1 +
 arch/arm64/kernel/setup.c             | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/vdso/gettimeofday.S |  3 +--
 drivers/clocksource/arm_arch_timer.c  |  8 ++++----
 include/clocksource/arm_arch_timer.h  |  3 +++
 5 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
