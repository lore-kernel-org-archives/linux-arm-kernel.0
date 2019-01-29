Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA0AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA47820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rz4+j/De";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xi871oKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA47820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=m6WJQNxI+BKvRRIMfEzcsk2vkR+YAw6PL9SuDUaYGto=; b=Rz4
	+j/DeKZ/ShYKv4hmAnixu7dDAiecAhGu5ygZil3h10AD3AIxhc6ugXgFs0hjnoDknWnVJ7keihlIY
	dz2cdTO4hvb7aHHcsiqIcM4592LN+s81CvC6Y2xPDLaIoXrirAFW9v9fIYhqDmv2ZYmGfkcPOmqOr
	PKOhHirzwHa08rNvAq8vpsL1GFWGhobhD1hKZ/8K4yHYIpjO+o9VP3OFFrgaDXGHofkfapIMSACYV
	dlbIHL7HOevpvKvSgvZM1vf7ZpOZ/WS8CmicYU6St4rBVIpRH2JEzdzT6gvnn8XsNXMtrBluw75uR
	rY1BGVOAcP+HGdz0dNjjIqIMdJUf0FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLQx-0002eF-J0; Tue, 29 Jan 2019 04:55:39 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLQt-0002d9-UI
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 04:55:37 +0000
Received: by mail-wm1-x341.google.com with SMTP id p6so16201208wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 20:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=M2SV/8aQjo2L+qxKWqLLEIli4Sge3OFMh4QMcOPhDng=;
 b=Xi871oKhsdq0rrYMC0qEbeeYcMpKRS6M9HYgxIe6nn1J1CuL+vOmEccltrF6leCElw
 2CkifFK0rpJimAfXhLmEplx+ceVwPPsbX4rs20txQflEGcetrfZvS19+5IqEtHumjFte
 oV2WgOGHDnhEftO9wCUO0bo2d0IfhlFfuEUwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M2SV/8aQjo2L+qxKWqLLEIli4Sge3OFMh4QMcOPhDng=;
 b=GbZdQq2G+AHGxwSvrkmPdmSinA3jNMIlgMFSWlXsWqilzJJmC7+6CQ48EbeA2aJZTW
 O/9oo+KR6TQ0/ML0fESmPs9lOkiOhIdwWqus/PE2bmW3t3OcXv7mwaXZZXIISeJDLKey
 b1qx7oWwzMwNYXVBp0SrgQwuUWRNzk72+tzpHs07t2v0n9nJpsjVy9decksDzCIj7Fux
 rMC8Gm5md3//olxP7XwCkbkDCCc3JQJf36BZHEbF23pbGzHXTIanh0wYbELlgeaEkfmq
 K3D/VWSWAUxTSWmLsRfcO7aeUe8XAPjAC0Zbu0JBbG+ui/Yvn/MQUur59FO83HMa/iTa
 U8LA==
X-Gm-Message-State: AJcUukfd+Of6Wuwl810tV9srqjj4lI01/qbA/PrutvZIbtulrrazUHKS
 pU2IpYbRZV6wVZW3HENRjnD2QQ==
X-Google-Smtp-Source: ALg8bN7Bver4xPLrWq5gOA2n3jxdvqaiQge+Oo5+7SI44Sp2IkkqChQ15AWYj+3LFTY/hLtgvjgmVA==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr19092861wmh.12.1548737732549; 
 Mon, 28 Jan 2019 20:55:32 -0800 (PST)
Received: from localhost ([49.248.171.30])
 by smtp.gmail.com with ESMTPSA id f3sm2032270wmd.22.2019.01.28.20.55.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 20:55:31 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] cpufreq: Add flag to auto-register as cooling device
Date: Tue, 29 Jan 2019 10:25:06 +0530
Message-Id: <cover.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_205535_982975_EE540D63 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Eduardo Valentin <edubezval@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a flag for cpufreq drivers to tell cpufreq core to auto-register
themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others.

Things needing fixing (but not a blocker for the series):
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.

Changes since v4:
 - Added IS_ENABLED guards in cpufreq.c
 - Changed flag name to CPUFREQ_IS_COOLING_DEV
 - Collected various review tags

Changes since v3:
 - Got rid of wrapper function to register/unregister cooling devices.
   Directly call the function in cpufreq.c

Changes since v2:
 - Get rid of #ifdef'ery and let the pointer exist in all cases
 - Get rid of (!CPU_THERMAL || THERMAL) dependency in all cpufreq drivers'
   Kconfig

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

 drivers/cpufreq/Kconfig            |  3 ---
 drivers/cpufreq/Kconfig.arm        |  5 -----
 drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
 drivers/cpufreq/cpufreq.c          | 13 +++++++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            |  9 +++++++++
 12 files changed, 37 insertions(+), 92 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
