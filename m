Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAF4206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g8pHGeR8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqegc8gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAF4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LoiS8NxjEYBWivcSdHtK9Qlq8VwZPkckJPqU7YfsOMg=; b=g8p
	HGeR8G/2F8Zjx9pqKhs3hjvpnYACwPuWjbhM/fkS8+G3n3ldDHDVl26HFhyK5W0xhuWFrbjvsdQfH
	1risziKhDZc5yIa4Togfh55QzdarLYySE9Y4tmTFHfK/WS2NA7KQpyS6rlXHhUzTKIwPKXRHXfIAv
	4RHA9ek7IoPIuYituxfmw1y99XP8IPWVPENPCCYoNvCFY+e3wV6Rdre5K1YfWsjyPPbFVhRkmWovy
	4E1Xn7TDRqpYQBoaU465ClSnZklZlIDwi7ZdiWR//wf+5YmLFgXIJCiaJsYeLf5dGIIY0hG+xvvOw
	S3yUXH02kLs7WVcUbPnw3qVg2R3n5Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp8T-0000p0-9t; Fri, 14 Dec 2018 15:12:17 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp7y-0000LQ-UF
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:11:49 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so5767982wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=2OEhyVYGwNvGpX/TNQZpzfpD5NsrteBRRKArChDs2kg=;
 b=iqegc8gnG9oY1FO5Zo5pNCjRd1E9N7JkmsEs5fd06a2ecUBk1zH4fhsBwpAH1NO94Z
 OJhpX5P64lpJKbUIgkmd+RkqNwBSq+dFLKHD+N9nnhVPGUjT6A+MJT61fAnvvfjonEIk
 f5X51WP8E9nbXb6kzSibmn3MrpYOuUZ/ovJFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2OEhyVYGwNvGpX/TNQZpzfpD5NsrteBRRKArChDs2kg=;
 b=gukUXx2jNWXuZDgl1dLRWkHu4GNKgEolXb6L9RwQEgM2PvjJ67Tcb+id2SDR+O6A3S
 Wm3/HoOLieKNagaSfenwMUnxJ1YGJLMPmxfuOKqxxqnXnLaO0jvoGXH8JdpuSSd7v06u
 c+OiMMKvQjQ4Bt0Qy/BhCb/CXmReUwBqh0U2syx5IBUzAE0zMX6WLfV8ytR59G5z4/Dk
 Sun5BPTC2tw1thHjQB18OU2Xl6wK6wGT0187NxSi7O2gmDEXJ7EBl4WVerY3/p9DQE7T
 eeN7dZF56lO4eIngwd72NV0O+eXOk77okBB6XxcJEyabMWzts49iRuyWuzE5cSp/kCss
 ICVA==
X-Gm-Message-State: AA+aEWYwA901gh97wUtXeZMgOz4FTrum4uZxcJTYs5WErLBqdlMdzPxZ
 cI0SBySK53P7V277460y8+w22A==
X-Google-Smtp-Source: AFSGD/WHB2QQV9H9gW3wM8NzL6iAKV51gm1WmEZN9ca52EYa4pB/RhDTd+8ZH3qMcs5AT5HTVvNO4g==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr2803270wrn.307.1544800294582; 
 Fri, 14 Dec 2018 07:11:34 -0800 (PST)
Received: from lmecxl0911.lme.st.com
 ([2a04:cec0:113f:f362:2090:a70c:c5c6:347e])
 by smtp.gmail.com with ESMTPSA id i13sm3381567wrw.32.2018.12.14.07.11.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 14 Dec 2018 07:11:34 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
 robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Subject: [PATCH v2 0/2] Make STM32 interrupt controller use hwspinlock
Date: Fri, 14 Dec 2018 16:11:26 +0100
Message-Id: <20181214151128.10005-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071147_429523_0B9FA262 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

This series allow to protect STM32 interrupt controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors. 

version 2:
- rework hwspinlock locking sequence in stm32 irqchip to take care of the
  cases where hwspinlock node is disabled or not yet probed

Benjamin Gaignard (2):
  irqchip: stm32: protect configuration registers with hwspinlock
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157

 arch/arm/boot/dts/stm32mp157c.dtsi |   1 +
 drivers/irqchip/irq-stm32-exti.c   | 116 ++++++++++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 16 deletions(-)

-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
