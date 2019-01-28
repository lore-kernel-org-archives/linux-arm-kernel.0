Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E7C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14DB21741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gNONXqlk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QST1QHTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14DB21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=kvN+yGSBN/cIIrd3Ft80vn4JW5ILonQd2YzYMZnMAvQ=; b=gNO
	NXqlkz98gChi/1dc2KmPce1pS6Dn59oFqbTAsvMxsm4RNdcyHzf3Cpf/cyN6POamM50bw3nrtuNp9
	c/411ha2iHrm1xIfGUKIR3SaF28di0P45rjWv5p7J3fTic/VAEJh1O1seLC86zQ0OyZLOf3pmNZLZ
	0Ct0nDqZmCsGyVlBq5mu++zLWjitouYoYsgBvMa8P/tdTkSQMCpTPlIFGM5YYSZHoH97mtGwfP+Tz
	JM+R1IzUGYhEA4l82hgWpLeqQoWrC0Q0jHdpw0FjlOJp+R9gdQSTYzV31kI3KP27Mayfq39J44o16
	qSVaZVGCO+p/YM8qOKLe/x0ObLXq9sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5Lq-00048Q-Tg; Mon, 28 Jan 2019 11:45:18 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5Ln-00047i-Si
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:45:17 +0000
Received: by mail-wr1-x443.google.com with SMTP id u4so17685499wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 03:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=XXP3hIFo09qbYxDEZ84UjroMfNXRwbZdmDEOnudwpmA=;
 b=QST1QHTo+SnjfGWbtje9MmvxvXe4/o/N50DokM5mJxKpXFb63tUU1x/mmlOjswaquL
 x/B9ltLTidkjQvB8ltU33qlfqwIxGvVVLsfIHFn55bKZF287AeDlb6uuaC5f7M+g6XBd
 0wU+H6OCt7OAaazBWp9kitFWKCJEp6s4QFmzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XXP3hIFo09qbYxDEZ84UjroMfNXRwbZdmDEOnudwpmA=;
 b=ZCSoXZeeUziJ084u426700tk5eQbRWD74BtdDM4/IhvMk7go0Vccl6mukFgQvNaoIW
 XwH89bCVqirt8FDeo49SW+02BGhvDstu+K+t6y6eNMBj4UlxkjOCjKO/es8XF4ozisOQ
 Ez9KH/qcVhYqHAlFxk5b0Eel2s1/UhGbmVBuWzcIVx1cI5RtL00gMepKjPivMdUEHf+j
 0BOTm8Y52gB4ASsx+3l4TQp/l5/9uh0oIJJ1GrDAoKwGQ9uS43CyI4HAlVWAjZDjELI0
 vDS/f3moYbTQvmveaxwgwcFf0G+2Q1rex5gOHLRsbVRuViL/RTCD7XmDXiD9VYjL3jXN
 Ielg==
X-Gm-Message-State: AJcUukfmWTS5Ie9HYN1XMk1VUzScwBZQwPfT46gqbcsKlTv45z5rPLSt
 2rYbcuMjaEsgo01CqGHiEXwGBA==
X-Google-Smtp-Source: ALg8bN4EHw6SpI3q7wRaHuK0UXmG8c7NqpCc59mw5ZFdAx5u6QilmJUB2vTbnMbhKqBMYELKaKRDdA==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr22526419wrw.304.1548675913628; 
 Mon, 28 Jan 2019 03:45:13 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 03:45:13 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 0/3] qcom: add PMS405 SPMI regulator
Date: Mon, 28 Jan 2019 12:45:01 +0100
Message-Id: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_034515_940569_16697E56 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: devicetree@vger.kernel.org, vinod.koul@linaro.org,
 linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following patchset applies cleanly on linux 5.0-rc2.

It adds support for the pms405 spmi regulators and configures s3 as a
supply.

The dts modifications required to enable voltage scaling will be
posted after the currently pending cpufreq patches are merged.

Jorge Ramirez-Ortiz (3):
  dt-bindings: qcom_spmi: Document pms405 support
  drivers: regulator: qcom: add PMS405 SPMI regulator
  arm64: dts: qcom: pms405: add spmi regulators

 .../bindings/regulator/qcom,spmi-regulator.txt     |  24 +++
 arch/arm64/boot/dts/qcom/pms405.dtsi               |  20 +++
 drivers/regulator/qcom_spmi-regulator.c            | 197 +++++++++++++++++++--
 3 files changed, 224 insertions(+), 17 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
