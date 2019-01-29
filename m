Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5D5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB5D2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GM2ynXx7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVWXMh6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB5D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fqTq4fFtxG+8CwcZNPUD1seVpdHtRN9s0b0C3oN5YE4=; b=GM2ynXx7YFxtwO
	zW3KScg7lYw6VgCH4pgLLfYiMAHitXDl4BbwgtzRdM2DxI4XNGQITTx1KKiw30auws/6gPffMYdK7
	XOOufTYZbEnUDGHWQWH92cMiUb2J3VBhX0jI9g6VTJjgrppYXSvUeuWcE+VzBIPgA9/hgEKpuUxl8
	jOJWgOsX9m7Nh2DfDX+XYfd8Of1KQW83Pq7t5H9MDsSeqD5bswi2XIFkK1jy0qQiQ0OZtyvmUjEDW
	YXia7VJsrMHWab3IM1zJ3oK9Q1rgm6+gBQBtpiIqxdAdEx9VXasol1s/rUMAK7tOhDtPtmurLzovo
	dtPxxCW8TFp0R4O5zCmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTN3-0003Gx-Qu; Tue, 29 Jan 2019 13:24:09 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTMn-000367-U1
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:23:58 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so22081988wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Deu/KVx4Gy2UgCNwMxu3XakkocwgFPvStdYJer1xYzo=;
 b=GVWXMh6c55my0PHhnfFDXq6Tb+z7q7/ov8sX9kMcjYOvoJe1Nd4JCHySP+NAfQ0bgd
 j147Ep8NPVFz7APwsewfsvSaUuttQJfBT+eAr+o1cBtgP5Yk7zvmGkaNqtUMd35UHfYl
 D4iTdL2Bcr7/h0zyFjWi/PdpUPIqr9Yky/jMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Deu/KVx4Gy2UgCNwMxu3XakkocwgFPvStdYJer1xYzo=;
 b=dXl4ojkdXZAKVKb3qEMuZ85uQxwK10zSL39ScX1xbTdFK2WRxDtiN9WhHeyf1QGX5V
 8Mbanb990tHK0gCu7+CZ5gfmKjlxVb2JD/H9LKFokm44UOoIAgPa1Tz7lWiEKPjS7ABz
 lDfCfJVYnZqlLBZLNVQVFyFIgFk6tBKGHBKFh5BfjFge9SlXfoXIVuO/AOGpx1dJ8LjX
 Qos9JhsZXQ1jCu/DyIokqebhtGfm1FYq+DKOlHlv9xq0oxsEfGyMcag/EtxCpbtWUU6E
 Ce7S+u8BhK6TOkZw9HDcK/t1ft2tTEQ110Tc/lZlW6Vhxg8taWG0Z7+kbQ22AvhtKcnA
 kxbA==
X-Gm-Message-State: AJcUukfl5jpK96agXoH6V5zCBIMFak2RDG3eL5JlI7MGlLsPC95XApPk
 Ees7B61t1rQ/8aecJeF+QaGOot8JmRo=
X-Google-Smtp-Source: ALg8bN4xHBQ+wEFjuwd8l86OD+NwyOabrY8FJg9GHguCKGku1fL8PUlkT0DiyHPzW2kl8G5yARh8tg==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr27488057wrs.53.1548768230591; 
 Tue, 29 Jan 2019 05:23:50 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w80sm3739628wme.38.2019.01.29.05.23.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 05:23:49 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH 0/6] arm64: dts: DB820c: Add display and audio support
Date: Tue, 29 Jan 2019 13:23:29 +0000
Message-Id: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052356_777060_0D9F9217 
X-CRM114-Status: GOOD (  10.02  )
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

Archit Taneja (3):
  arm64: dts: msm8996: Add display smmu node
  arm64: qcom: msm8996.dtsi: Add Display nodes
  arm64: dts: apq8096-db820c: Add HDMI display support

Jordan Crouse (2):
  arm64: dts: msm8996: Add graphics smmu node
  arm64: dts: Add Adreno GPU and GPU smmu definitions

Srinivas Kandagatla (1):
  arm64: dts: db820c: Add sound card support

 .../boot/dts/qcom/apq8096-db820c-pins.dtsi    |  52 +++
 .../dts/qcom/apq8096-db820c-pmic-pins.dtsi    |   9 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  | 125 +++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi    |  46 +++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 346 ++++++++++++++++++
 5 files changed, 578 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
