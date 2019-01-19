Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B827C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF17120883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F7gc/L1B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ovLXPns6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF17120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dtwfqX7Jxl6B/6yZNdftNbfVzO9ySD0KVndIZLoRbG8=; b=F7gc/L1B6N0/dG
	RpXrtR+R3rQvl738uOI/Ta7Oig+lX3dWxg/APFRKXRPS822++zGMJDK6/4SSQtytLQUUrF+u4PaRH
	RWc0CfZiPUWSWC6EurhU/Ha50WH0u2hvw0NF0fmVPWu0x4C8t7eoo6eA+/OZ6ZTj7qovnGDa3JtcA
	QO16Rotqzna/SOsXIKLHo5kek8OpIG6i0v52XYvWEXgzBKmfE8iGVdb24gAXOH1DKmeVzE4flkTp8
	bO62UX62hcEMa4FbwOyWSYkQChzhtamirg1CS24gzKramwL96FwsubPNWflSPhyy5U1yClEfQlSls
	W0naYuWCBwRdRDu9kabw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkxam-0004ew-NW; Sat, 19 Jan 2019 20:51:48 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkxaW-0004R2-Po; Sat, 19 Jan 2019 20:51:34 +0000
Received: by mail-wm1-x341.google.com with SMTP id y8so7466632wmi.4;
 Sat, 19 Jan 2019 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D8GzsuGIY+2IwCvvQJKrmjMBhUhjETBp1QUWiVjEP6g=;
 b=ovLXPns6H/1n+bxUQgtSijMLLp9HWubPS2iprDkMlqaRmpxbKxQKkC7pwM5I8udij6
 trJCNj4f4HOJaCUhraUPetxOvSd5YObvWZzgVmikHVDkUfmlNG5yxkz6Evu69jtew5ox
 /ff3JqJnMy3VbqiDUJDqdk7SzdUxEgAFxfJypp8hrvLENzRGde9y8VM4hIk9MPFQMe2u
 mO1ksjV0r2/j+ExVR7NsV4lN2qKeK9uWVHaE1zENQpCLzE2rrnHBFX5uzmsWKLXb2nnn
 DHPq0PHTtyjOblXyVvmCNCFZ67b27yZ76UTSADDmoAaRaFiQLzUDIXPOIOyBVxep82op
 zLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D8GzsuGIY+2IwCvvQJKrmjMBhUhjETBp1QUWiVjEP6g=;
 b=UIl5uX97kZpdT9IcWOBcINIOa3QRL+P6lnxHHkmwvAMWOyXIpZKweJ0bbL/uBKZ7+U
 gxkjbZR+rWsnQfik2wiq3S54rhwa1QfwzgTCc6VwOrj53oMb4IOUPl6x0euxjWdsQwWW
 VK/rxLwVZn0omRGB4nhDCAIv6Uth0fGqUX5682ZTCe4gKg/75fM4RyPDlDNMiSXtXYeh
 qZKA8f6hqEpAEcLTF0nbNy72v3j9a8UD4z1X9Rxv63X5UdlcvmK99KNbG6JEn2lHvt1n
 Sk8cH1GYNqf2XoEiNPcRBSacqIWBcNKg5CsKiFlPRyCzvMoUHGznD5mN6QFR75Y3Roda
 DEWg==
X-Gm-Message-State: AJcUukd7lZlp4w/26FlTKmv0YLfMwz1hJSaWm87ZO2LckFRluM9vWoQy
 mqF7ZDh/jc3cCjnPqHeYU+z6hK9c
X-Google-Smtp-Source: ALg8bN6Kbc3kdLaVfYXLaPjGHHIKNRJiuGJkqmsYrDQUV1CATv+V2qtzGm40C0QOhSxSo2nWcipMpQ==
X-Received: by 2002:a1c:6657:: with SMTP id a84mr18531361wmc.23.1547931088231; 
 Sat, 19 Jan 2019 12:51:28 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A8100FDA9BD4E9DEACC2C.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:fda9:bd4e:9dea:cc2c])
 by smtp.googlemail.com with ESMTPSA id 10sm58176662wmy.40.2019.01.19.12.51.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 12:51:27 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
 jbrunet@baylibre.com
Subject: [PATCH v2 0/2] clk: meson8b: fix typo "ABP" -> "APB"
Date: Sat, 19 Jan 2019 21:51:19 +0100
Message-Id: <20190119205121.9621-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_125132_873696_6B28DD2D 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: sboyd@kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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


Changes since v1 at [0]:
- split into a dt-bindings and clock controller driver patch


[0] https://patchwork.kernel.org/cover/10742001/


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
