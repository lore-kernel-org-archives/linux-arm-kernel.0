Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B71C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:29:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DE6214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dtyDDmEq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hu9sy8Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DE6214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=610H8xsEbqb4B7uS0XRomTJassW6EeS9LZZXChSDGf8=; b=dty
	DDmEqe7On20mSDk/ymEQ0I/MFApl7tqo6XHDicW9GoRUijQ9ySoUAzT1tmislBjoCimLD/H0RREin
	YBQPG5oI1453ewCT5nWKhU1Wws5N5/pKhfmnxKXGD4faMpTWEyXKBSso/89/XYaRdY+tnSvaTgEoj
	hThYMdWhU0onvxUeRQnS1Y/BXA//HnSrZHgxSKYXw6DR331G9J9/ER0riSLp5DEoOgfDE2IAI97Mb
	XGqpoZjrt2cSjddhEkN/hfbjadJJNyDr4hb0yTS3MLEAEK04o3PiZbtpAic9XfyIIoUTmdeu+5ahC
	ipqA5NgrSiqlla5Yg6pZmOVjsEwa7xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSWX-0005UU-NK; Tue, 29 Jan 2019 12:29:53 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWT-0005Ty-DQ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:29:51 +0000
Received: by mail-pl1-x642.google.com with SMTP id t13so9256051ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 04:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fI4dv7garnzy2W+m3mE1OJK4oTIdQwDug0wFO9zg2Vo=;
 b=hu9sy8QlavPoSx0f2aSnK3yC82eHibeUy45I8SrzNFHY3bUa31DXJPZEQCIiWTnJnt
 lytDw26Mg64tahth+FZGj47OVk8Wpl7JbdfspWAn4QRsgGjbDe9k4D2p9YUYkJv7a9lS
 eaBe7U74u0OOmH75rWDk0H3D3b7wAW9obTC3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fI4dv7garnzy2W+m3mE1OJK4oTIdQwDug0wFO9zg2Vo=;
 b=nes+vfqei32AI7wPZP1acPfJbVNqDBMtMALo3v54dSj6aNvKJO0s5OtVO0Om39T/0W
 xTUJofD2pMmCcPOJGRNLKiGRw3m9rIifRSk1kYYf+EuXKBzMxlGUfueKdAOeiVDml2Y9
 jIQmswDnGd7UdWHpWQEQB3gGsWZ2nNWKycnhe0JXswZBAvCc/3FfsKX+INumjSlh0i+V
 aEFZ/XDN0X0IIJlp59autg3rlHJtvmENsnWNhYfoL63hJkE0FdHf7hX1bQFOqrQ+zaOy
 eYv8WT7LX28Y6Bj68I01E35K707/LGu+TBXCvgv3+3BEkNOdc5f9EciI2/3dtAO163D9
 hBHw==
X-Gm-Message-State: AJcUukf0B8FXXulOHczdjXxHtRNUG1FPUpRGj8q8INhRTvQgdJg+MW3A
 htSDzhumPd18MgXcKutcVpCk6Q==
X-Google-Smtp-Source: ALg8bN5WKyn2C5ryGtxlJEoMzd8powgeTXxcxgBpsMikqmir24LNyWwQZFnkEicUQfU9H/EVt24ZxQ==
X-Received: by 2002:a17:902:b943:: with SMTP id
 h3mr26151550pls.12.1548764987824; 
 Tue, 29 Jan 2019 04:29:47 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.29.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 04:29:46 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v7 0/8] perf cs-etm: Add support for sample flags
Date: Tue, 29 Jan 2019 20:28:34 +0800
Message-Id: <20190129122842.32041-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_042949_472384_DC54784E 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch seris adds support for sample flags so can facilitate perf
to print sample flags for branch instruction.

Patch 0001 is used to save last branch information in packet structure,
this includes instruction type, subtype and condition flag to help
making decision for which branch instruction it is.  It passes related
information from decoder layer to cs-etm.c, so we use cs-etm.c as a
central place to set sample flags.

Patch 0002 is used to set sample flags for instruction range packet.

Patch 0003 is used to set sample flags for trace discontinuity packet.

Patches 0004/0005/0006 are preparation for exception packet handling:
Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
traceID/metadata tuple to access metadata pointer based on traceID, this
can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
ETMv4 have totally different definition for exception numbers.

Patch 0007 sets sample flags for exception packet; patch 0008 support
sample flags for exception return packet.

This patch set is applied on the acme's perf core branch with the latest
commit bdec77cfe58d ("Merge remote-tracking branch 'tip/perf/urgent'
into perf/core").

This patch set has been verified for x86 and arm64 perf building and
also is verified with below command:

Before:

  # perf script -F,-time,+flags -k vmlinux

  [...]

  main  6650 [001]          1              branches:                                f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                  6b65a8 main+0x1c (/root/coresight_test/main)
  main  6650 [001]          1              branches:                                  6b6448 printf@plt+0x8 (/root/coresight_test/main)
  main  6650 [001]          1              branches:                                  6b642c _init+0x18 (/root/coresight_test/main)
  main  6650 [001]          1              branches:                                f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)

  [...]


After:

  # perf script -F,-time,+flags -k vmlinux

  [...]

  main  6650 [001]          1              branches:   jmp                          f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   return                       f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   call                           6b65a8 main+0x1c (/root/coresight_test/main)
  main  6650 [001]          1              branches:   return                         6b6448 printf@plt+0x8 (/root/coresight_test/main)
  main  6650 [001]          1              branches:   return                         6b642c _init+0x18 (/root/coresight_test/main)
  main  6650 [001]          1              branches:   call                         f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   call                         f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jmp                          f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   call                         f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)

  [...]


Changes from v6:
* Addressed Mathieu's suggestion for patch 0005, refined its commit log
  and comment and fixed cs_etm__get_cpu() definitions in header file;
  also tested with perf for Arm and x86 buildings.
* Added Mathieu's review tags.

Changes from v5:
* Addressed Rob's suggestion to add specification info for exception
  number encoding;
* Added Rob's review tag in patch 0007.

Changes from v4:
* Fixed typos in comments, and removed redundant info from commit log;
* Addressed Mathieu's suggestion to add helper functions for metadata
  fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
* Addressed Mathieu's suggestion to include headers with alphabetical
  order.

Changes from v3:
* Fixed typos in commit logs;
* Rearranged fields in cs_etm_packet by grouping with same variable
  types;
* Fixed ETMv4 exception number which pointed by Mike;
* Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
  instruction to distinguish them;
* Refine ETMv4 return exception packet handling.

Changes from v2:
* Addressed Mathieu's suggestion to split one big patch to 3 small
  patches for setting sample flags, one is for instruction range
  packet, one is for discontinuity packet and one is for exception
  packet.
* Added supporting for ETMv3 exception packet.
* Followed Mathieu's suggestion to move all sample flags handling
  from decoder layer to cs-etm.c, thus it has enough info to set flags
  based on trace context in single place.

Changes from v1:
* Moved exception packets handling patches into patch series 'perf
  cs-etm: Correct packets handling'.
* Added sample flags fixing up for TRACE_OFF packet.
* Created a new function which is used to maintain flags fixing up.


Leo Yan (8):
  perf cs-etm: Add last instruction information in packet
  perf cs-etm: Set sample flags for instruction range packet
  perf cs-etm: Set sample flags for trace discontinuity
  perf cs-etm: Add exception number in exception packet
  perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
  perf cs-etm: Add traceID in packet
  perf cs-etm: Set sample flags for exception packet
  perf cs-etm: Set sample flags for exception return packet

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
 tools/perf/util/cs-etm.c                      | 394 +++++++++++++++++-
 tools/perf/util/cs-etm.h                      |  53 ++-
 4 files changed, 476 insertions(+), 18 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
