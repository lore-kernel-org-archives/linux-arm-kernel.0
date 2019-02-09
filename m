Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E4C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:10:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7C4218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDd+uVBz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="boy6UUUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7C4218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=62sIkbsttgjNu7APjvOOIgN/054rA/PNogDfD1FwrkI=; b=fDd+uVBz9On7CO
	ef5/j+dNAoxQ8aFSFmawaxkekaIHIJZvrATeCsoHRVVoAdij53/JeLpEEOVLtMbpJp3T1SwYmt4lM
	tM1sfBbDKY8rSjnsEOjagF2U+qyAfaJ7DcbF3/R63BY0unjorpc+6VI8wkFd+jzafha5bKYAXQ4O1
	eByQ8h+/9ptubFnL5yXTAuWXOoCXVXBzBBVqcyyKhXfVdpxVGVrAorX9TzzE6jkB0E9nqhqULeUqs
	oTV22tAHWPZ5eqbym3LGLPllnC80N6E6vZtAbeKD0Zchy6Gu2exd9B/KOCV8BWn/6GKkkrA/bwNBq
	VuiiJIfoKop0OyeWP0qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsbks-0005S2-MK; Sat, 09 Feb 2019 23:09:50 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsbkK-0004tM-8k
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 23:09:19 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 8CB2F5C210A;
 Sun, 10 Feb 2019 00:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549753754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=yelkleMCJXLHP5LlESFJtU0Z18t/+Mx5P7qCJU7puu8=;
 b=boy6UUUDaweYefxBP4z+oAdgfxYxs8AXx7bmhFEwkY5EBzvu+4MtumDximF4Nk1y85uiOs
 rHjjcWZvW19PLjWqk8ZI4JdqHueJSpGqgzBs+NTmktnmECFIJf6jgRp9fsf/SitCisKVr8
 1o2S/ckZMqNlSgYzS3GGZD7P0BMJhd8=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v2 0/5] ARM: convert to unified syntax
Date: Sun, 10 Feb 2019 00:08:57 +0100
Message-Id: <cover.1549753425.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_150916_667481_6FF95511 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset converts all assembly code to unified assembler
language (UAL) compatible assembly code. From what I can tell,
this mainly boils down to using conditional infixes instead of
postfixes.

Most of the conversion has been done using the following regular
expression:
  find ./arch/arm/ -name "*.[hSc]" -exec sed -i -r \
    "s/^((\s*[._a-zA-Z0-9]*[\:\(])?\s*)([a-z]{3})(eq|ne|cs|hs|cc|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)([a-z]{1,2})(\s)/\1\3\5\4\6/"
\
    {} \;

The expression resulted in some false positives and missed some
instances where infix conditionals have been used. With this
changes applied, I compiled several kernel configurations
successfully and without a warning.

The file arch/arm/probes/kprobes/test-arm.c is still using some
divided syntax assembler.

This does not allow to use LLVM's integrated assembler just yet,
there is still some assembler which the integrated assembler does
not like (yet). But it is a big step towards that direction.

--
Stefan

Stefan Agner (5):
  ARM: use unified assembler in macros
  ARM: use unified assembler in headers
  ARM: use unified assembler in assembly files
  ARM: use unified assembler in c files
  ARM: warn if divided syntax assembler is used

 arch/arm/Makefile                             |  7 +---
 arch/arm/boot/bootp/init.S                    |  2 +-
 arch/arm/boot/compressed/ll_char_wr.S         |  4 +-
 arch/arm/include/asm/assembler.h              | 12 +++---
 .../include/asm/hardware/entry-macro-iomd.S   | 10 ++---
 arch/arm/include/asm/vfpmacros.h              |  8 ++--
 arch/arm/include/debug/tegra.S                |  2 +-
 arch/arm/kernel/debug.S                       |  2 +-
 arch/arm/kernel/entry-armv.S                  | 12 +++---
 arch/arm/kernel/entry-common.S                |  2 +-
 arch/arm/kernel/entry-header.S                |  8 ++--
 arch/arm/lib/bitops.h                         |  8 ++--
 arch/arm/lib/clear_user.S                     |  2 +-
 arch/arm/lib/copy_from_user.S                 |  2 +-
 arch/arm/lib/copy_page.S                      |  4 +-
 arch/arm/lib/copy_template.S                  |  4 +-
 arch/arm/lib/copy_to_user.S                   |  2 +-
 arch/arm/lib/csumpartial.S                    | 20 ++++-----
 arch/arm/lib/csumpartialcopygeneric.S         |  4 +-
 arch/arm/lib/csumpartialcopyuser.S            |  2 +-
 arch/arm/lib/div64.S                          |  4 +-
 arch/arm/lib/floppydma.S                      | 10 ++---
 arch/arm/lib/io-readsb.S                      | 20 ++++-----
 arch/arm/lib/io-readsl.S                      |  2 +-
 arch/arm/lib/io-readsw-armv3.S                |  6 +--
 arch/arm/lib/io-readsw-armv4.S                | 12 +++---
 arch/arm/lib/io-writesb.S                     | 20 ++++-----
 arch/arm/lib/io-writesl.S                     |  2 +-
 arch/arm/lib/io-writesw-armv3.S               |  2 +-
 arch/arm/lib/io-writesw-armv4.S               |  6 +--
 arch/arm/lib/lib1funcs.S                      |  4 +-
 arch/arm/lib/memcpy.S                         |  4 +-
 arch/arm/lib/memmove.S                        | 24 +++++------
 arch/arm/lib/memset.S                         | 42 +++++++++----------
 .../mach-ks8695/include/mach/entry-macro.S    |  2 +-
 arch/arm/mach-tegra/reset-handler.S           |  2 +-
 arch/arm/mm/cache-v6.S                        |  8 ++--
 arch/arm/mm/copypage-v4mc.c                   |  3 +-
 arch/arm/mm/copypage-v4wb.c                   |  3 +-
 arch/arm/mm/copypage-v4wt.c                   |  3 +-
 arch/arm/mm/proc-v7m.S                        |  4 +-
 41 files changed, 150 insertions(+), 150 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
