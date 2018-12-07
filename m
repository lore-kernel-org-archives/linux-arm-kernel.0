Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C63FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E522083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gx+kSepJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E522083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=3Z0UOAtAM2YPZBPgRU3loRQM/JjkyGrMgIhPeShUtGk=; b=gx+
	kSepJAqucT7pOn6WKIVJmgdze5kYXsLUHi/8kmrruEQaqPj5BLQx2nqfklpUFuzwIVg6Pl3J6qHTv
	HlgxhjQszyecU9hKwUVtLmi5Gkfl8hTbqznBw6GdFms8+m0y1gawnHG+7tg6rSxX+ElvZJDdPmmZX
	3iBJ5GKyR6M3kn5LFbobB3oyB6UqILCfJIrQCgEPrrryfYflxKNuNYJpXEBGxk+yxLI23VDMyo01K
	uAq0mL8js6q6mwxDxpDL68YDAbc3+ySzEhrBxXTARb4DXlCPb1U8RphpE/SmA5or4GwvnaXej9Sqq
	4hg822xPygLAjw8rfpqo90YVEC0TPyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKaz-0003qn-Ll; Fri, 07 Dec 2018 18:11:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKYO-0008Lt-LC
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:08:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5366AEBD;
 Fri,  7 Dec 2018 10:08:32 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66E4F3F5AF;
 Fri,  7 Dec 2018 10:08:31 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 00/10] arm64: assembly export cleanup
Date: Fri,  7 Dec 2018 18:08:13 +0000
Message-Id: <20181207180823.36612-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100844_719363_09EDDDFB 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When exporting a C function, we place the EXPORT_SYMBOL() immediately after the
function definition. Historically we couldn't do this with assembly functions,
and hence we collected all of these exports in arm64ksyms.c. Over time, this
has retained redundant includes and exports for items defined in C code.

For a while now it has been possible to export functions directly from assembly
files, which is beneficial for ongoing maintenance.

These patches move the exports from arm64ksyms.c into their relevant assembly
files, and remove the newly redundant arm64ksyms.c. I've pushed the series to
my arm64/export-cleanup branch [1] on kernel.org.

Thanks,
Mark.

Since v1 [2]:
* fold arm64 <asm/export.h> into <asm/assembler.h>
* rebase to for-next/core

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/export-cleanup
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/610372.html

Mark Rutland (10):
  arm64: remove bitop exports
  arm64: move memstart_addr export inline
  arm64: add EXPORT_SYMBOL_NOKASAN()
  arm64: tishift: use asm EXPORT_SYMBOL()
  arm64: smccc: use asm EXPORT_SYMBOL()
  arm64: page: use asm EXPORT_SYMBOL()
  arm64: uaccess: use asm EXPORT_SYMBOL()
  arm64: string: use asm EXPORT_SYMBOL()
  arm64: frace: use asm EXPORT_SYMBOL()
  arm64: remove arm64ksyms.c

 arch/arm64/include/asm/assembler.h |  9 ++++
 arch/arm64/kernel/Makefile         |  2 +-
 arch/arm64/kernel/arm64ksyms.c     | 88 --------------------------------------
 arch/arm64/kernel/entry-ftrace.S   |  4 ++
 arch/arm64/kernel/smccc-call.S     |  4 ++
 arch/arm64/lib/clear_page.S        |  1 +
 arch/arm64/lib/clear_user.S        |  2 +
 arch/arm64/lib/copy_from_user.S    |  4 +-
 arch/arm64/lib/copy_in_user.S      |  4 +-
 arch/arm64/lib/copy_page.S         |  1 +
 arch/arm64/lib/copy_to_user.S      |  4 +-
 arch/arm64/lib/memchr.S            |  1 +
 arch/arm64/lib/memcmp.S            |  1 +
 arch/arm64/lib/memcpy.S            |  2 +
 arch/arm64/lib/memmove.S           |  2 +
 arch/arm64/lib/memset.S            |  2 +
 arch/arm64/lib/strchr.S            |  1 +
 arch/arm64/lib/strcmp.S            |  1 +
 arch/arm64/lib/strlen.S            |  1 +
 arch/arm64/lib/strncmp.S           |  1 +
 arch/arm64/lib/strnlen.S           |  1 +
 arch/arm64/lib/strrchr.S           |  1 +
 arch/arm64/lib/tishift.S           |  5 +++
 arch/arm64/mm/init.c               |  2 +
 24 files changed, 52 insertions(+), 92 deletions(-)
 delete mode 100644 arch/arm64/kernel/arm64ksyms.c

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
