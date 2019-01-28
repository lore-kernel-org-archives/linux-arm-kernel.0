Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9159BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:42:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CD920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IaOJ7oGy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjN/9A4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CD920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=oMi/II/9MrNBWyIZWaDP+EOXKhAy+5sDO/9tfqwT4Dg=; b=IaO
	J7oGyYJZzh+KGvS8X/soMo+LeeZxTKTgYP0PCzzF4vBCUQSjXzHEmdPP4DoP+I/KBvomx+Y3g3Uvh
	MQGXTUgPluxqDPYR56qM1PqGeQp/5A3jjM2gFU265Ysvc/0I2vNENULI2ZjBeI/g/tekwSsk3aWqv
	F8kNPhzRwRZRkFXu3o5SHb+q8Jv5+oQBdvbPFmCcKRTnYJHEazmq0nKvpZ1cLM3gvIUObgSR4jZp8
	1ToUIMZ0xiITiq+87PtlFjig7CL9cRQrMJ7nabemz6N3WcSnQKWK4eTu3Vi4Ea45DKkskeoNhppVt
	SOVo1zyjSIbzXAzmQrt6uWEbUkTEj1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0cY-0005aH-H2; Mon, 28 Jan 2019 06:42:14 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0cS-0005ZB-RB
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:42:11 +0000
Received: by mail-wm1-x344.google.com with SMTP id y8so12526257wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 22:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=s7lgGPNmk6yzNikPOAgazA8H44bs/2pQ5Wgm9TQ1twA=;
 b=gjN/9A4yevg58U7HPgUuet0K8raeSd4xai9sQWAx/DEtA2Vhcd4oB46FvobTC4vGve
 Jy7ZeUMxIZBlx30jMeRbySIQ6KYpmVZgph6e9Ps0skU2XViWZw26AJhOBjZl1H73EpdT
 cKCo4VY9DOlrx+stQcL3r0c4ae0zEkgnrxWMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=s7lgGPNmk6yzNikPOAgazA8H44bs/2pQ5Wgm9TQ1twA=;
 b=gu/ISNDg3pVa0jS7Yz8lV/mMOM39iopk/E0Gql6AgSBUsKHKwlnvxnkpHShG7XMC/C
 mA7e6UK9pUtrqwxzNSGsE/dhXzVsz+D03GE5oBhkBv7iwmIbzk9n+OZ1dld9Ht+k9CsL
 YHJMn1ZNnhX/V8rcdnUq8n3e7vgHNf2bRWYV5USVN7PMYnz1NqnME6bmDumcj83lLtPA
 9cK8cNOtAtvC7uUslET9aWRJtELrBIOhU6Vn+lqKDO2zRXmFC7pQe7pJWApNbT4mtlH5
 mxF17/vvVfCR4Vl0AJhYc+1TIaDIYPJb71gqKnh3e5E0Q3RnhpOipy81DMO7lBqNQHb9
 WeUA==
X-Gm-Message-State: AJcUukdPd4CE8+VSqWQrmM3wOHg/97ylqfUP2If6APm1YMnQi2a000rK
 l9dX0hVRVZDSIgjPegpMsm74Zw==
X-Google-Smtp-Source: ALg8bN56Oc0AMEP5gfBhIDmLIXlCubXW6Y/E9vYy7dSKP63aUa7PLIv1ymDctNxYrxzeHNRuw/P5uA==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr14803086wme.28.1548657726247; 
 Sun, 27 Jan 2019 22:42:06 -0800 (PST)
Received: from localhost ([49.248.191.44])
 by smtp.gmail.com with ESMTPSA id t4sm86845856wrb.64.2019.01.27.22.42.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Jan 2019 22:42:05 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] cpufreq: Add flag to auto-register as cooling device
Date: Mon, 28 Jan 2019 12:11:25 +0530
Message-Id: <cover.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_224208_896851_A46CB6CB 
X-CRM114-Status: UNSURE (   9.99  )
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
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
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

Add a flag for cpufreq drivers to tell cpufreq core to auto-register
themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others.

Things needing fixing (but not a blocker for the series):
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.

Chnages since v3:
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
 drivers/cpufreq/cpufreq.c          |  9 +++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            |  9 +++++++++
 12 files changed, 33 insertions(+), 92 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
