Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197C1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:28:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8902176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KrdksRDf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlrzRCmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8902176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RNZnxlEUBL2pSfFL2boISbbdk279upMRVkhlxONWIH0=; b=KrdksRDf1jfzD+
	WGSYmy3mY0fMlawLpBZqnccr0seYJqLSIvuTFRl8DD2VyV7nrWQ6H5hiBn9KpzT12cTcIvBB0le/A
	U0fSaehpKB0Z7oF00fMqZx6BA/dOj23T15kqqXKX6/opnmCwevFNGthwQLSNzRupFYWneNf89Ka4A
	nrI3YyNRvBamsStcgqYEO9aM1tTk06EPCmWSVqXeoZTI8Va2/734agzm9HYHccikOCIlUaPCjjySD
	n2GHahHaqbRGNVoTB9uByPyGK0hQaSDbhckUkClZLUszr5r7qs6rxor6ZE8I5Zv/utMAcfghHuoOy
	6cKmC817rW+CBmfps/eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjug-0007Tk-9d; Mon, 04 Feb 2019 19:28:14 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjue-0007Te-HR
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 19:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ddpLCpUtntO4q2hH/ZOtsI1KfXO6kOTHtpv7ewThn44=; b=LlrzRCmSgUhGcqyvxAPinBDJG
 lwK7CEyBcvn8GsnT/HJQgmkPOYqV5LdnbHe4MhR3Tbut3fpdR6iimJOvctYmsv8JnC86nRC03zEb/
 7n50i8E5TPzzmeDI2fGFzoSSdIVQz8R/oLf/SwjbVdFenehrBa5TE0aAtTkc1XcvCU0K69m/mYu1W
 H6wxghZhltIm/KeYqlKXR1yOOnaDHXx5+6oDr68zBzvYd4IorZ3iPQEISIBXpKgrRoUDvCtqqLZMX
 eN8jdZUxVJDdp13sJ/7dbQhQs2+M2joDICRJdCm19VVD0M4sSSJ6fxfgK1xYhmumRB5bh7aTHVVgi
 Fdb0pWMww==;
Received: from [190.15.121.82] (helo=quaco.ghostprotocols.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjuc-0006Qu-Cp
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 19:28:10 +0000
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id D6AD34034F; Mon,  4 Feb 2019 16:27:58 -0300 (-03)
Date: Mon, 4 Feb 2019 16:27:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v7 0/8] perf cs-etm: Add support for sample flags
Message-ID: <20190204192758.GJ5593@kernel.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
 <CANLsYky9fUcCkek3CWh8vXpRN07YbnnPirWxtRLum13a1FEQ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYky9fUcCkek3CWh8vXpRN07YbnnPirWxtRLum13a1FEQ2g@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Mon, Feb 04, 2019 at 11:41:28AM -0700, Mathieu Poirier escreveu:
> On Tue, 29 Jan 2019 at 05:29, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch seris adds support for sample flags so can facilitate perf
> > to print sample flags for branch instruction.
> >
> > Patch 0001 is used to save last branch information in packet structure,
> > this includes instruction type, subtype and condition flag to help
> > making decision for which branch instruction it is.  It passes related
> > information from decoder layer to cs-etm.c, so we use cs-etm.c as a
> > central place to set sample flags.
> >
> > Patch 0002 is used to set sample flags for instruction range packet.
> >
> > Patch 0003 is used to set sample flags for trace discontinuity packet.
> >
> > Patches 0004/0005/0006 are preparation for exception packet handling:
> > Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
> > traceID/metadata tuple to access metadata pointer based on traceID, this
> > can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
> > ETMv4 have totally different definition for exception numbers.
> >
> > Patch 0007 sets sample flags for exception packet; patch 0008 support
> > sample flags for exception return packet.
> >
> > This patch set is applied on the acme's perf core branch with the latest
> > commit bdec77cfe58d ("Merge remote-tracking branch 'tip/perf/urgent'
> > into perf/core").
> >
> > This patch set has been verified for x86 and arm64 perf building and
> > also is verified with below command:
> >
> > Before:
> >
> >   # perf script -F,-time,+flags -k vmlinux
> >
> >   [...]
> >
> >   main  6650 [001]          1              branches:                                f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                  6b65a8 main+0x1c (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:                                  6b6448 printf@plt+0x8 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:                                  6b642c _init+0x18 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:                                f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >
> >   [...]
> >
> >
> > After:
> >
> >   # perf script -F,-time,+flags -k vmlinux
> >
> >   [...]
> >
> >   main  6650 [001]          1              branches:   jmp                          f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   return                       f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   call                           6b65a8 main+0x1c (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:   return                         6b6448 printf@plt+0x8 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:   return                         6b642c _init+0x18 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:   call                         f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   call                         f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jmp                          f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   call                         f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >
> >   [...]
> 
> Good day Arnaldo,
> 
> I have reviewed, compiled and tested this patchset - please consider
> for inclusion.


Thanks, I'll check it after I push perf/urgent, that is almost ready.

> Regards,
> Mathieu
> 
> >
> >
> > Changes from v6:
> > * Addressed Mathieu's suggestion for patch 0005, refined its commit log
> >   and comment and fixed cs_etm__get_cpu() definitions in header file;
> >   also tested with perf for Arm and x86 buildings.
> > * Added Mathieu's review tags.
> >
> > Changes from v5:
> > * Addressed Rob's suggestion to add specification info for exception
> >   number encoding;
> > * Added Rob's review tag in patch 0007.
> >
> > Changes from v4:
> > * Fixed typos in comments, and removed redundant info from commit log;
> > * Addressed Mathieu's suggestion to add helper functions for metadata
> >   fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
> > * Addressed Mathieu's suggestion to include headers with alphabetical
> >   order.
> >
> > Changes from v3:
> > * Fixed typos in commit logs;
> > * Rearranged fields in cs_etm_packet by grouping with same variable
> >   types;
> > * Fixed ETMv4 exception number which pointed by Mike;
> > * Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
> >   instruction to distinguish them;
> > * Refine ETMv4 return exception packet handling.
> >
> > Changes from v2:
> > * Addressed Mathieu's suggestion to split one big patch to 3 small
> >   patches for setting sample flags, one is for instruction range
> >   packet, one is for discontinuity packet and one is for exception
> >   packet.
> > * Added supporting for ETMv3 exception packet.
> > * Followed Mathieu's suggestion to move all sample flags handling
> >   from decoder layer to cs-etm.c, thus it has enough info to set flags
> >   based on trace context in single place.
> >
> > Changes from v1:
> > * Moved exception packets handling patches into patch series 'perf
> >   cs-etm: Correct packets handling'.
> > * Added sample flags fixing up for TRACE_OFF packet.
> > * Created a new function which is used to maintain flags fixing up.
> >
> >
> > Leo Yan (8):
> >   perf cs-etm: Add last instruction information in packet
> >   perf cs-etm: Set sample flags for instruction range packet
> >   perf cs-etm: Set sample flags for trace discontinuity
> >   perf cs-etm: Add exception number in exception packet
> >   perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
> >   perf cs-etm: Add traceID in packet
> >   perf cs-etm: Set sample flags for exception packet
> >   perf cs-etm: Set sample flags for exception return packet
> >
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
> >  tools/perf/util/cs-etm.c                      | 394 +++++++++++++++++-
> >  tools/perf/util/cs-etm.h                      |  53 ++-
> >  4 files changed, 476 insertions(+), 18 deletions(-)
> >
> > --
> > 2.17.1
> >

-- 

- Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
