Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA18C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF0C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5kq1GPJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgC6DsST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF0C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KNz9IEMkAt0+gLFnhc+iF953tN4k1d3UHXFytwtq4KI=; b=U5k
	q1GPJn/P3Nuh2o+pi5Vr6QEuq2IwSmVT6CWJKmcXM3XaF7PEsn/sidaE9EUrvNApxyMoUXExS3a5E
	keKRiRhs+NszpS0gTZGxoAxF2zMB4DrpNPaDah8fxx2iFm69VZ6XwB5CytZ7YSiZgGFTfzDQYr8cT
	yg4cPVghcbO91HYngacTESmWrMBsyTFg+Jyc0VN2oVvh66QfQvbQrnngAwbyXpVybrqG0CHmUjRMZ
	99XIYAXXO3CMgrwH5sjaChzNWFGp9067nKX0TWqH5f9bSlRLgHv/lFmIlgqkyu//xW508R40VgfCz
	UCbYmy79q6wfHYKZP+vgfu6KSnB1+UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHTf-00079U-8m; Tue, 04 Dec 2018 20:39:31 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHTR-0006xl-NS
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:39:19 +0000
Received: by mail-pg1-x544.google.com with SMTP id t13so7882004pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=wJ/j62LiSch6bvKVll7Ac7D2SHOc9QfdG+9Z3J+Td8Y=;
 b=fgC6DsST2PrCjZ14iXyAwzH9xdulZU3S3eQ0J/vuo+Ruher0dWrKlDtX4cI8HGrt1I
 ivJXMdrLgalI66ZDh6OQoFxjCf7NKPRzVNBx1l6fyabR4143DdqXk9o+D9yrKxBl2pQU
 /PoQu7JN9CovdgffPfR9cylfjrZ9s4GW93Cqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wJ/j62LiSch6bvKVll7Ac7D2SHOc9QfdG+9Z3J+Td8Y=;
 b=Snmds8gZ10z5f30oQFnA7O9R6YK6V/i/3l0OgWUW07WIIidyV675uQ08ZFDNee0FHL
 2P9lypGctECW5x0lb9CaQ6ROigH/tINakTQYvGzxDE9gPqulloaYSm8DKbfCiLYHb06Y
 xDLXtcVH3F2/yHz+3cZ9rJ3CbKfG9g6HFK2gWCyjF50Zcjo/ATMG4VSvwbej1oohpwFa
 ZBohUC4Z/6p5TOya+ghy6nlH8mX2r5Ln7THONALCsAoGpvmvr4TFoJQIHvi+w8BDLKIN
 tIHsH7nbgJYzOoUyDAff3yWXSENYsApk44YLexSXOuCv3qbt9ooJJMjRfUjavVtht2h0
 X/EQ==
X-Gm-Message-State: AA+aEWbK623sZ4Up4HbkVNVt6UJkdPahadktbcz2iInwKI5ZKmvfufX0
 qVc7rigXbs/X5HSWnsw+E4cKfw==
X-Google-Smtp-Source: AFSGD/WpnY5IDI33GsU6V2fG8hr8j58z0pD6J5ea4LS3kMD9TZviBzIXqwPO0tU4RQ/R03HWFjJMaw==
X-Received: by 2002:a62:c583:: with SMTP id j125mr21727839pfg.37.1543955946497; 
 Tue, 04 Dec 2018 12:39:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id r76sm29783274pfb.69.2018.12.04.12.39.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 04 Dec 2018 12:39:05 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH RESEND 0/3] perf tools: Add support for ETMv3/PTM1.1 decoding 
Date: Tue,  4 Dec 2018 13:39:01 -0700
Message-Id: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_123917_764932_DEB509EF 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: peterz@infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, namhyung@kernel.org, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnaldo,

This is a resend of a set previously published in November [1].  It adds support
for ETMv3/PTM1.1 trace decoding.  The work has been tested on TC2 and
ST-Microelectronics' mp157c-ev1 boards.  It also applies cleanly to your
perf/core branch [2] and does not affect results yielded by "perf test".

If it is already in your set of patches to apply, please disregard and delete.
Otherwise I would appreciate if you could consider adding to your next branch
for the 4.21 cycle.

*** Before this set ***

$ perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
Warning:
AUX data lost 2 times out of 2!

Error:
The perf.data file has no samples!


*** After this set ***

$ perf report --stdio
[...]

# Samples: 12K of event 'branches'
# Event count (approx.): 12049
#
# Children      Self  Command  Shared Object     Symbol                 
# ........  ........  .......  ................  .......................
#
    28.18%    28.18%  uname    libc-2.19.so      [.] strcmp
     9.13%     9.13%  uname    libc-2.19.so      [.] strcpy
     7.87%     7.87%  uname    libc-2.19.so      [.] strnlen
     5.58%     5.58%  uname    libc-2.19.so      [.] strlen
     2.24%     2.24%  uname    libc-2.19.so      [.] __rawmemchr
     1.91%     1.91%  uname    ld-2.19.so        [.] 0x000000000001156a
     1.49%     1.49%  uname    libc-2.19.so      [.] __argz_stringify
     1.46%     1.46%  uname    libc-2.19.so      [.] malloc
     0.96%     0.96%  uname    libc-2.19.so      [.] 0x0000000000054770
     0.91%     0.91%  uname    libc-2.19.so      [.] 0x000000000002430a
     0.85%     0.85%  uname    ld-2.19.so        [.] 0x0000000000007244
     0.83%     0.83%  uname    libc-2.19.so      [.] __stpcpy

[...]

Regards,
Mathieu

[1]. https://lkml.org/lkml/2018/11/16/884
[2]. 34434e3633de tools lib traceevent: traceevent API cleanup

Mathieu Poirier (3):
  perf tools: Add configuration for ETMv3 trace protocol
  perf tools: Add support for ETMv3 trace decoding
  perf tools: Add support for PTMv1.1 decoding

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 31 +++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  9 +++
 tools/perf/util/cs-etm.c                        | 73 ++++++++++++++++++++-----
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
