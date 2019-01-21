Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF15C2F43D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C4520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Obg4a+kb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cecMvNOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C4520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7FUCEER5P5qi6B3nIIv9znGZT+X30QGl4agbFGG8VPk=; b=Obg
	4a+kb8WodnZ2g2opDVoxEEHwBETk+UINmUDWNP4BF8pQiDUTRAtTzHAIHx1SZggchmNZd83ZhrjQC
	5DSq8zWn8nHdOj8HIPMJ7O8iltthAYWLddusqBpuvXTyRMpkAhnUKuwOoFGNVpf9bVoyL6rPM+kk9
	61E4d52NhBjVbX3Z7iDY36lyQMqpp3JPngboVuQvgsjRjI19yCkNMQ6pbm8swXI4YHRQiZSXbjn63
	gHZYsT8uW23RvncE1TXN8vjoDchlBP3UHwa0KRbQzXVQrSw51YXLjZ3uhmOx1P7UlxAmGSLD0ku3g
	/qPJlVe4HTmAZBovCq99F2dpUMJ6JLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbi8-0005kR-T2; Mon, 21 Jan 2019 15:42:04 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbi4-0005jR-6z
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:42:01 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so11276685wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=MA5crrD4Prr0EwOduSOR30oSBtIqdGdvyHP08sn6BN4=;
 b=cecMvNORUI0LJhDEkXZiJkKGrmrINxViFgzLZLmXH+mfHUy5MUr3camUrdGLMWHInZ
 cYGLQNhxwf0h7JHoMUrNqhHozWFcG5G/1fX0nw6iQLZSxt7DL/IMVB1cgVfoiP+4ZS77
 y72HkXPbiu1T0D2e7j7dQCh/Ykfploq2teC18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MA5crrD4Prr0EwOduSOR30oSBtIqdGdvyHP08sn6BN4=;
 b=qpmc31CbqKI6Hy/qLWRjgCb4vXcteDFs/scPNljw6de0IiRJtU3IZwv7g88LqvBMJs
 J1u1NJrB77oRe5oV5fi0ZH5P9oc6Yvfl0r9vDRKYp6nc/towTPvkGXcDKEhVQvDmUnmj
 R5TU+xypbaHFU93jHCysPgegQhZaB2oO/pRnGpcLPTRDUiifrkM274vGBSwuOAe/EVzB
 GiRhvfdKHFwEeTL9DFGDy+7zwhvWwZpsdpZ4ZG24qFdvddckuwjIZTb8LQJvvW7Zw4M/
 hVtXWhuggPB/udZAGHQEKgBkAJVXkdUnS0bG9BbFE5kCY2aa1MKQtRZE/I10fb8zjy9M
 w3JA==
X-Gm-Message-State: AJcUukcHC25l33asxLB5cN0tXGLCfXv7No8SoVBS6u+Z4k8EzJkI+QMR
 8mQ2cL6zIegPCVxHheaQmInQhA==
X-Google-Smtp-Source: ALg8bN4HPyB6Ku0qpNyjY1RrtXKwI5Qwnx3O1D/4Dp2dKCdK956kiYV6Vwa5D4uHk2VtyGf9ORdkJA==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr24359200wmf.125.1548085318345; 
 Mon, 21 Jan 2019 07:41:58 -0800 (PST)
Received: from localhost ([49.248.61.1])
 by smtp.gmail.com with ESMTPSA id k15sm127527555wru.8.2019.01.21.07.41.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:41:57 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] cpufreq: Add flag to auto-register as cooling
Date: Mon, 21 Jan 2019 21:10:25 +0530
Message-Id: <cover.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074200_252858_5C91C64C 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, dianders@chromium.org,
 swboyd@chromium.org, edubezval@gmail.com, mka@chromium.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 viresh.kumar@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a flag to be used by cpufreq drivers to tell cpufreq core to
auto-register themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others.

Things needing fixing (but not a blocker for the series):
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.

Changes since v1:
- Fix compilation failures with allmodconfig
- Get rid of #ifdef in cpufreq.c
- Removed miscellaneous patches and sent them separately
- Merged patches 1 and 2 from v1

Amit Kucheria (9):
  thermal: cpu_cooling: Require thermal core to be compiled in
  cpufreq: Auto-register the driver as a thermal cooling device if asked
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  cpufreq: imx6q: Use auto-registration of thermal cooling device
  cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
  cpufreq: mediatek: Use auto-registration of thermal cooling device
  cpufreq: qoriq: Use auto-registration of thermal cooling device
  cpufreq: scmi: Use auto-registration of thermal cooling device
  cpufreq: scpi: Use auto-registration of thermal cooling device

 drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
 drivers/cpufreq/cpufreq.c          |  6 ++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            | 25 +++++++++++++++++++++++++
 10 files changed, 46 insertions(+), 84 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
