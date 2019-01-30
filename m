Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B41AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:04:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E06E218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WHv57MjR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sdq5mXyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E06E218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j2N/8s+l1TncNnGBAVs3grZhWXeOqU0Mi/E1CQ4GJpc=; b=WHv57MjRK5uBRq
	OjNTDUcEvgSkCYQVKXShTFusM46gHxD40bOgw+8EegFMI/lp3jg43HxncLxaOiVck/iqHsQdO0JS5
	0w79AIsJ/RYQe1+ult5pDaa3QzoK+t0uEYlG2BiiuLEJLXBWi+MKlbRvS6wfMW8IanQiFZnKkwvib
	AIwZWvrnXUfOEQMulCbM7R8qhYUuJoP71lV6VWuMM2mPRnJW//uj6/InrI/94JB+24P2FQPr6ED37
	M4ivlRPZzPM28Vugc4DxyDG4b7RSzBwMY0V3GuTHzqO1eIBGxqJOvmVpij9LzbJTkvM4z2wi8dlAE
	h331nMF0s/ZsK1yi6RsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonfl-0000Zy-0A; Wed, 30 Jan 2019 11:04:49 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonff-0000YI-UX
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:04:46 +0000
Received: by mail-wr1-x443.google.com with SMTP id p7so25615183wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RFrJaTBtuyW9jnIf1EYpnn9srDwoF1i9vdIKVnuq03s=;
 b=Sdq5mXyAv9UuH6g1rotGfcXo0uyGrAxKkvrLNbyjppjryW5MKaclpxfut9tfTXbPr/
 MLBQcmp/+Fg76FsKKnVYjqOymDJmQtfO8cGFcNFxH4pa37xvhEw03V+LWxYKdluZMeEe
 ZYy4YeA2Oi4S3g+JNmljYJPniA3PeqBkfcbDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RFrJaTBtuyW9jnIf1EYpnn9srDwoF1i9vdIKVnuq03s=;
 b=FNo4nmIh2pTlhgvJbPKuWanuS3Hbn5Fze8kJbx0xCeg9PkVKgZC2FYuGdvvBw2jDIa
 4ZzI46ye5mgsELd0YKDiVGph8yWVhja5KZPoWOSk/xBeko1yItDPE3DqCT8LSNKerMze
 0yUrbg4qSRcfW15JHWsnfOIvqf+KcnoOgie6xH7wcz6K88uCLHx5oRioKK2VTuR4i3js
 UmyAEzkdOVpDYP8uZU0iU7l/laWU1E0nlFMcqyN2lDPHBHjCNC3uF1vM+9FlFhY73c3w
 E8SoXSERS9Nf8o56Dlgo23fehpdJo0gKPQWQIxRzDTt8e+9EOpnNIlf4eAO8LCjQTQcN
 TSSA==
X-Gm-Message-State: AJcUukdSygo9nK1Gcnn2jV1GgineW6B1H1CSLLNaI1YWdyGiRAqfQCLW
 6dyd3g6iLCH+bQg+VTcqfzQ+Mg==
X-Google-Smtp-Source: ALg8bN6HIbAvbAVU46otX3XeFwy2YTQzmJnvE99oJzZn5matUm1pPm2V6p3uRHe6gv9qKoRmdQhXvg==
X-Received: by 2002:a05:6000:1c8:: with SMTP id
 t8mr30248562wrx.146.1548846281293; 
 Wed, 30 Jan 2019 03:04:41 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:40 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 0/6] arm64: dts: DB820c: Add display and audio support
Date: Wed, 30 Jan 2019 11:04:31 +0000
Message-Id: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030443_991333_95B7A58F 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andy, 

Now that most of the bits are in mainline, its good time to add display
and audio support to DB820c.
These patches are being tested in integration branch from long time.

Am resending 2 SMMU patches (https://patchwork.kernel.org/cover/10726329/)
in this series to keep all the display and sound patches together.

Can you pick these up for 5.1

thanks,
srini

Changes since v1:
- GPU node updated by Jordan.
- deleted extra lines from sound card dt patch

Archit Taneja (3):
  arm64: dts: msm8996: Add display smmu node
  arm64: qcom: msm8996.dtsi: Add Display nodes
  arm64: dts: apq8096-db820c: Add HDMI display support

Jordan Crouse (2):
  arm64: dts: msm8996: Add graphics smmu node
  arm64: dts: Add Adreno GPU definitions

Srinivas Kandagatla (1):
  arm64: dts: db820c: Add sound card support

 .../boot/dts/qcom/apq8096-db820c-pins.dtsi    |  52 +++
 .../dts/qcom/apq8096-db820c-pmic-pins.dtsi    |   8 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  | 121 ++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi    |  43 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 380 ++++++++++++++++++
 5 files changed, 604 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
