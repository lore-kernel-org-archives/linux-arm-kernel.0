Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0778217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QXZ4EyQk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vStZKTeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0778217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=gSXIpcVN59fTYfXd25mFp/WnZLwA/W+jsP01LMYxiTQ=; b=QXZ
	4EyQkiZqU19ZpbYSV3vc0+p74jLr1z6+XBe0BHVl29PqxY93fQSfIWCEfJbBiTjHoBmRwYTSt7jNg
	rX191pphv9j1nJUX0gUFfrw1gzC9M/K6Ovw7KtWgYGVSTfvx9Yykr4ScpNM/ftb2/tMQwI9GQE/GS
	8BFKLl48GcWg9DKdLsNgLi9C4YPzrA45PhYPjv+R7wyqz/jCObMvWlf3UEATXZJDOF1JJ6YeAQP+V
	P6Ml5SQYxyhHj9ejTCuhw2HhKMlKg973tp35mN14hCGq1XwCpijggis01yrVl7lGMG1xJcgmr0/D+
	4IKC7TRC5Bi5ce/x5ti/Zd89XVThjhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grA5y-0000bJ-S8; Tue, 05 Feb 2019 23:25:38 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grA5Q-0007Ef-Gl
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:25:06 +0000
Received: by mail-pl1-x644.google.com with SMTP id k15so2222117pls.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 15:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=D6m7CRodh/5/YlGIlRz4UJH8J7WubmYTTIvewhZXqRU=;
 b=vStZKTeFssW5spCaYPYAW7lYGyYoVFdWjqki1J0IYTxKl0Brd8dz8blOECkVlsa64e
 8ZZI84ngeH/XTiwC1yIttd8pF9CnW2LXVOTLio6fYXZHWtRzQ16N/iXf7JIMEKb7nrI5
 lv6dmR52WZHnaiZ/ZewDAndqdjomWEitZ0RTlRXwUwbwX83HOqX2iIiTaoYf7ycQNNv5
 dSJ/m8dI3+DwFKZFJi/+Wzdkn8aHdOJmD/KHl0JE4l5g8ajMbEukxTfEZ5KijnXRpHqy
 PJCkPyNxwFbWiOactJeGPFl+IzFYXZ4d4Yf6m/DJ46gpkUqPu8Er/iggcSxTeNcn8+ea
 NjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=D6m7CRodh/5/YlGIlRz4UJH8J7WubmYTTIvewhZXqRU=;
 b=XkAyJh90OqEaulY7QlHIy69hhg2aW9kceD+x/uQq3zyDYWp4OtbHqvSPhMy5Nq2idZ
 nLtBQx8HCLPvoV7Rwo5umbE8NJpSLrXNq6ZZAtC5pF8TC18shnnt2j12Uj6bdeRooglH
 p5lO0IcisE3kkEfXA2SlqTkL/tI/ZFPDmfTcxaJRVfua0F/EehrSunWvYCinf3B45ZPU
 jq0rvuqtNKKYdMmMHQLXFDbmsdP7G4FVXftc3WpnJ1XWbUwKRopCwLeZUPxhzRUWKGce
 GxZxHFwIvd+ZErkcRI9PWGd99ykauBQFyi1IgSJP9kBEBkU+Ck5m5tnkYudziZvKcZlN
 OE1g==
X-Gm-Message-State: AHQUAubqQJbm2RHhxWIF8QMs5fblYvCyyZGpqW/StknybwUFf1mayEuq
 hB12oBBtWU2U21IFvW8ZlOAUow==
X-Google-Smtp-Source: AHgI3IZdi4iZPABPFMSthoi5pV537yzWe4jmP3gIZW6mxxRnLZiEiI8UgLFafNCh7evuevhkdyAgWQ==
X-Received: by 2002:a17:902:9887:: with SMTP id
 s7mr7443761plp.199.1549409100461; 
 Tue, 05 Feb 2019 15:25:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.24.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 15:24:59 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 0/6] coresight: next v5.0-rc5 
Date: Tue,  5 Feb 2019 16:24:52 -0700
Message-Id: <20190205232458.7074-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_152504_591226_E01BD2D8 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Greg,

Here is what I collected for inclusion in the 5.1 cycle, please have a look when
you have a minute.

Applies cleanly on the char-misc-next branch (9f23379c67fa).

Thanks,
Mathieu

Leo Yan (1):
  coresight: cpu-debug: Support for CA73 CPUs

Mathieu Poirier (3):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection

Rob Herring (1):
  coresight: Use of_node_name_eq for node name comparisons

YueHaibing (1):
  coresight: stm: Remove set but not used variable 'res_size'

 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 arch/x86/events/intel/bts.c                   |   4 +-
 arch/x86/events/intel/pt.c                    |   5 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |   4 +
 .../hwtracing/coresight/coresight-etm-perf.c  | 112 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |  12 +-
 drivers/hwtracing/coresight/coresight.c       |  60 ++++++++++
 drivers/hwtracing/coresight/of_coresight.c    |   4 +-
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 14 files changed, 192 insertions(+), 39 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
