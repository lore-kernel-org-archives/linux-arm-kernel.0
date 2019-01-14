Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:35:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45BC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YEVXOdRU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt/1jw4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45BC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YMzwl/9jx9Pd3qxkcvuRIIY/IBlPxtJwKCZ2D6kINkM=; b=YEV
	XOdRUCJtzrn97CeExaSxak8vIHXSIkOAtVC2rihA8Q6/cqKEUmBihIsVZMsf23tQbF+jPwAaJ1KCa
	RV/U6Ju4IaFLTmdpjd7Cay+udXhgAlS57lf9NwLkl9pC3ab8E353eKNfbIPVDpSH/i3hOybjYiMCa
	CGupkgEd/O08UXRYOHqTrC9utJQqjjuPxnqFJDI4xk53Ur/6AdD2aiTtrlH8byby05yIakxG8GolD
	WJeqlqZkmju5O/sKdtD5lLUUOGBiE5+1rsyBbIYTZv5AAAsR/yynhogjpR9FQhy69/ftOprcr6z7E
	j3kLtjCbPPHVUan9Sfbz70pe+ya8eEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5Cx-0003gS-JO; Mon, 14 Jan 2019 16:35:27 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Cu-0003ez-0V
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:35:25 +0000
Received: by mail-wr1-x441.google.com with SMTP id u4so23660069wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fpr0EFghkVyQH0EiyG1VDE5LspytkbV2ayoT+IrLjlk=;
 b=Xt/1jw4waa3lxjlieWv0tTk3gDceBhD3HUc7luQtVdqZVtK0ir4846YNAijauV6u+F
 wH3v0lRb/1OC+duPFMPoVhmthEhaqmlHb6Tm57SIAEX0kyeb4SDmrGHFQe5BGeyxZ+1J
 s8yn8lxne1kmnT2AUdV+GDk0CxDaUKMnuyYCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fpr0EFghkVyQH0EiyG1VDE5LspytkbV2ayoT+IrLjlk=;
 b=INvM7ma7sL1LRp+430q1SeGevHwk1g5k7hcMv9KszcXQFR7BzG/upXlRGEiR3s5yT1
 Rns5Q8b5nWd9jnPq4d6LYLmFd7Xh5WjBVNGUvnWqz7pr38GLlEChrRptRZE2zYUnzk24
 dHi1IH2WDYRfNNppJr/bzD0TuLGswWF7uZH9ughYYu9orp4mXjb9aFvfH0ZEO70Ktq0Z
 BtF1tgMFtpn+qXPob9qEm1SfWSjDR9CCYnwW7UBOaKqY7oQex6JfFvKxEJOWKtj9qJVc
 VCn33PARzu+G3A0/1qD1qVkZfCXlqlOzM88NRxsFuga5+6XB2o/xYfIJ7pQdeJbzSEi2
 Bb1w==
X-Gm-Message-State: AJcUukcnvkfzEiXv+sNXt6YZ9dO6qESy/2fC2PlJCBuHeJeCDzW8sruC
 /UP5pWE99u8q+qe+aEZ64ixykQ==
X-Google-Smtp-Source: ALg8bN43Uf7vBoXQ6dtcNgCxMFAYVTr7hrdeoH3nJIhlUZ26zED6ERY0Wvvoxeu5vDsovLf0fX5r8A==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr24266430wrm.238.1547483721699; 
 Mon, 14 Jan 2019 08:35:21 -0800 (PST)
Received: from localhost ([49.248.190.171])
 by smtp.gmail.com with ESMTPSA id h17sm70337170wrt.59.2019.01.14.08.35.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:35:20 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
Date: Mon, 14 Jan 2019 22:04:52 +0530
Message-Id: <cover.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_083524_079751_9DB0E0C5 
X-CRM114-Status: UNSURE (   8.88  )
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
Cc: "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, dianders@chromium.org,
 swboyd@chromium.org, edubezval@gmail.com, mka@chromium.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 viresh.kumar@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
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

Things needing fixing:
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.
 - The other pending issue is to fix allmodconfig that leaves us with
   CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
   references for functions defined in cpu_cooling.c

Amit Kucheria (10):
  cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
  cpufreq: Add a flag to auto-register a cooling device
  cpufreq: Replace open-coded << with BIT()
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  cpufreq: imx6q: Use auto-registration of thermal cooling device
  cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
  cpufreq: mediatek: Use auto-registration of thermal cooling device
  cpufreq: qoriq: Use auto-registration of thermal cooling device
  cpufreq: scmi: Use auto-registration of thermal cooling device
  cpufreq: scpi: Use auto-registration of thermal cooling device

 drivers/cpufreq/cpufreq-dt.c       | 14 ++----------
 drivers/cpufreq/cpufreq.c          | 17 ++++++++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 18 ++-------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++----------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-----------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++----------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++----------
 include/linux/cpufreq.h            | 36 ++++++++++++++++++++----------
 9 files changed, 55 insertions(+), 90 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
