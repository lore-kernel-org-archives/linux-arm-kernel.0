Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B558C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:17:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D44A206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T2xqc+mi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z+cwwO+J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GcQQcX30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D44A206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ymI1uzRE+/nsBssOEhjLpe7BQVGxGnG0lBKW6d8dNRI=; b=T2x
	qc+miEIVtraC7eayrcG64OTxc2IPc0snkfZ4YHv2DySb6kAa1JsrPk0xS0baDf06XfNeTvwjZxbAa
	fkuYadBl6M1Wj6p8nIixnL/AEN2x2kS/FcBK4Wrr80HhcRBOm1s7JyxUkzNrB4q8CEEwy6Sd3TQ98
	ADHz5FAtPkF+OrUTQ9g0trRNDbllfFZ83eMpFV6vIW4YymS7F2lqbs9qYrfEUoHh4rU6qIOsMiNi7
	JEUfqa5iShchvc43R2M2IgCDrYMNCGjIJ/HXtmwqsFI77tuMdnB7/cSr+ki1QKVNgAP+jzRvKWw6C
	IHhSXGT1IjqrQOWlpA2CAX2/YEiRJ1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvlu-0006kc-P8; Fri, 14 Dec 2018 22:17:26 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvlQ-0006IH-71
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:16:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 54D0B606DD; Fri, 14 Dec 2018 22:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544825805;
 bh=+smpJUVAR7l2d6l++qjb4f9GCJcmiD1B0Kufu4sQ0gs=;
 h=From:To:Cc:Subject:Date:From;
 b=Z+cwwO+J8IRpIDnjkThgIE3lz11J3bQ9D777csRz1TCH0vnOFimed+QX3FP8ECXix
 APvlRQXNy+FR+Lb9hpwX0jeZn3klZI6WCrj4mKqmpYTLXGyzspkzsaHaY1kFovE5aT
 30HPHprd8tseIQ0xNNCyVlZBoJlTSyNufkWvMf34=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C9B9601C3;
 Fri, 14 Dec 2018 22:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544825804;
 bh=+smpJUVAR7l2d6l++qjb4f9GCJcmiD1B0Kufu4sQ0gs=;
 h=From:To:Cc:Subject:Date:From;
 b=GcQQcX30JIkYvIsnRGQHxyxJ3TNEUEM6EaeMvmyDo74H4YNL+JAy0K1cLL3Ts0XYz
 0dKOb2fyDW9kXRSsskvnhyqCUB06SanpAmiIIM1oA8WXCFfONGW60vzYh5An+WCSew
 nzts6zxb6X59eB+KV/PPp2yzblDjyWFFTeeB3GXA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C9B9601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] arm64: dts: sdm845: Add sdm845 GPU interconnect
Date: Fri, 14 Dec 2018 15:16:38 -0700
Message-Id: <20181214221640.25354-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_141656_288483_76CC28F1 
X-CRM114-Status: UNSURE (   8.57  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Two quick patches to document and add an interconnect port definition
for the sdm845 GPU.

This is based on the base GPU DT changes:
https://patchwork.freedesktop.org/series/39308/

As well as the DT nodes from Georgi:
https://patchwork.kernel.org/patch/10719483/

v2: Fix interconnect supplier to match latest per Doug Anderson
*** BLURB HERE ***

Jordan Crouse (2):
  dt-bindings: drm/msm/a6xx: Document interconnect properties for GPU
  arm64: dts: sdm845: Add interconnect for GPU

 Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi                  | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
