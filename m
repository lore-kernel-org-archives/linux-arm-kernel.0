Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA27C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:26:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E87E20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmX06Nbf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dfbqIpIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E87E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C8vQoGKo+o04XN3+5q3Po0b5jtAENQRAPVwiRsrKm88=; b=hmX06NbfYbw7MJ
	6gqeNlnpfqGK5Vo+WJyHo/03+5HCBhchgGrbluw7cdNBD/WubXWaCOlbbJAyyv/9KHjK51oKg9kEy
	SGRZBVtsdmCdw9fZ15hVRcNDwmITcj4tPi6ba1fg5Wz6iD4+8+x9vLiujYhFwqUT/I7z6xemYPmRQ
	mJCyyYSZuOpkj7Dkfq1RtoWNGlRwcxZZOo0vvEKSFp3AWWvB7cPBIFqH9zHHjuQmS6JjvFku0lJ3p
	lEHZqnZXGeuAIGnbyxZf4cJ4b+8ViZrXVg3GjPmSHkSNb93TpTlhGiWSMXSo1fGB1Jn/ecy2tV+1a
	vSNvOsd+nfqS8M4I2Txw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsxYo-00019H-9W; Sun, 10 Feb 2019 22:26:50 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsxYU-0000rQ-Ei; Sun, 10 Feb 2019 22:26:31 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so13889176wml.2;
 Sun, 10 Feb 2019 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g0VNVBLfeMjVI3jgvlleGnqheZI5FIaCWf24UqkIZVw=;
 b=dfbqIpIyT7tIU7DCGZ1kMLCz1tsQ64q+jSr3EMLek7FVU3QWCuV1AB9D2bj5owXDlQ
 It9AlrdsQHz9ru/4xPj7Y2XvM7n1Pfj01sVYRZuoFzyFUvm1l/dADiAiU4V8S6phoiCG
 ltGdkHNwrrXiz58RNo2P9Jip9MfeXeWxSukGvRKMjrKH0b1VBJg3HlQlPoGyZ6gBLr+Z
 YUZzIVmB8xUzR2ENWkm257rqrb3JR7t3rKBbP/Q4m2UbqpyWlXohSZKPrOWyNYIaPv3b
 83Dfi9fnNCr3ixv9nc5bfIRCEGrRDDkn/00Ur7/SPXQ7Mx0mD4iaqyma0+OnJ2+lXH7P
 NeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g0VNVBLfeMjVI3jgvlleGnqheZI5FIaCWf24UqkIZVw=;
 b=KpG6QyEjrJJbf0VKBindIfSFYqh/u4DVbIiP8T+vbBhv2uNkyaOKcHUkm1W0swSoIZ
 8jVWPNRwztPJTUdJ2YHRcGwOHRW1E7AWYj8vjQ7wsMsJZNcAeRj65jPZLn50Uc42O6Bo
 Tud31drTofj8fmJXPX3b0JIjGqEDMBCS16WVA3cP2ak68GeAiAA/H+H6b97EXWeZ0BwF
 zVN/ay4tLJ1BMXhhfuI+gA+gJ4W5If5prHU54rxeHHfpx+TiqUBCYXAHCFiiapZ6vxLm
 u7h3zxhmamkR8u/E35Cx+Glll9W1ZY/S6ZRpqKmavdlrrHEahvCix0LlOSv+eMCdfNUQ
 PPqA==
X-Gm-Message-State: AHQUAuYnXb6q/lj9jK6efUrwIOZ4yD9qcV2py+7xqqIAVV2hhFt61SAx
 6DUvUveYw0n1VI9DKt6hIiZyg8aa
X-Google-Smtp-Source: AHgI3IYUeFOpVMeqnkBbllGykDGA8NKIZkt1iXsShS9GP0FIqAjNz+WXawdELDgMkFsvmecslMPFqw==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr6573118wme.116.1549837586256; 
 Sun, 10 Feb 2019 14:26:26 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C064670D88EA61CD.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c064:670d:88ea:61cd])
 by smtp.googlemail.com with ESMTPSA id b14sm15523330wrx.36.2019.02.10.14.26.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 Feb 2019 14:26:25 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 0/2] clk: meson8b: fix typo "ABP" -> "APB"
Date: Sun, 10 Feb 2019 23:26:01 +0100
Message-Id: <20190210222603.6404-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_142630_496060_FFE854C6 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: mark.rutland@arm.com, sboyd@kernel.org, mturquette@baylibre.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out that I'm not good at spelling "APB". Unfortunately an ABP
(instead of APB) typo snug into two clocks in v5.0.

Currently there are no users of that clock yet, so fix it now
before it's too late (meaning before it's used by <something>).

I decided to go the "normal" route where we can have separate
branches for the dt-bindings and the drivers in the clk-meson
repo. This means:
- new (typo-free) clock #define
- change the clock controller to use the new #define
- (next development cycle) drop the old #define

resend - changes since v2 at [1]:
- include the device-tree maintainers / mailing list

Changes since v1 at [0]:
- split into a dt-bindings and clock controller driver patch


[0] https://patchwork.kernel.org/cover/10742001/
[1] https://patchwork.kernel.org/cover/10772199/


Martin Blumenstingl (2):
  dt-bindings: clock: meson8b: add APB clock definition
  clk: meson: meson8b: fix the naming of the APB clocks

 drivers/clk/meson/meson8b.c              | 26 ++++++++++++------------
 drivers/clk/meson/meson8b.h              |  2 +-
 include/dt-bindings/clock/meson8b-clkc.h |  1 +
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
