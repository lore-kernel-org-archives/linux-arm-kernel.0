Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06771C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:00:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C276D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MLeSRzxb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfetoDoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C276D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wrTFDSWD0dT9e27F2wwr7aDWzHRb0BzQic9eY7qxlyc=; b=MLeSRzxb7ko0h4
	SoC4pMYkUhqt1ADttNkmTR0TGENr8tiFcACTe4KZZcVcWNH3wAbpcSGxb6U/frk3h3WUPHc64kTUK
	zX3+58ma4JZrnwmtU9R67J8KWpUCVkfknjhXhJJYmanjrkXInZYuKx6Sg6yCjNIek7Ou7R7Pp68qm
	DTFgooC/Ygz3hFU1dIxk8E9nIw+Mk3FOoj4X3Un5wi0Bo0Rp+zAisLWKPUMYp4H155YIU+uSKiiy1
	K2s+OM8IQGZcj4DYn82KnRucUJ7JBLxvSyoon2trIEkzCFjIWrAH2khQIaN9cS78kFowY+kkrUkzy
	Ga64CCuUIbAPJNkCxQ6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEPd-0000a7-5t; Wed, 09 Jan 2019 14:00:53 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEPZ-0000ZH-N5
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:00:51 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so7832081wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vZjCLEPCAt+4U1c3gD/GWGjUg9HPaZfO6HiogV76xX0=;
 b=gfetoDoJh4/rQkkEqfkG7beLuhunI9FjG+SNJNyOvbTJq/svz0OcGwXy5gxbM4sfPf
 u8nrAXtcl7MgbDB7PoKuUYbBlF0U2ZlXWCdJsrk/k5+BMkhZ+KjKRitl6V9rQsRSVS8y
 HUOld1v5GDdD6nTqx1w6v9po6gXdWu91ZhBX1no/msmObGNhAAYWlIAwlZfjz7v1quhN
 00a/KMLnUyPPUR1km+D4ch7gGW2kvvcJYQGry+Yg4toG/5L7+I0GWG4kdT7gh7ErnHGK
 U8aP888WFiCOkj9LE5s1NzTPLua3Ue9JZttBWoOCqcl0zdDjPXYo2ANvAnnvl2x+rmlN
 oNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vZjCLEPCAt+4U1c3gD/GWGjUg9HPaZfO6HiogV76xX0=;
 b=EFjwuiLYDu9HTonKBs2SU/rOcf9iQja7Co2QoWsQClCy1Ie6cNfmmPh1y0rSfKMuPV
 27XnZW+rWpE3E0YEZtR6QhpXe0k01JjYYZrYUvTR3FX3JOa+lpXk4ylNM6cLcZVQfRzo
 HDDEzj+mSAV9fEt0RgAZIn1scOyCROdz1oTP+RaImFnepEFui3p/eyd2lSI5ElZmKmy/
 LW/zR3RzNXs2yl2fXspmQMb+VwV9HkvMWlfHVNC/mfbAA8b+6h9huEV/0pMtG7hIXAtp
 1jT1/9L80nnAo95c256wArP/mcSx6Phm+K3/P66rvucFH4yO/nAa3bc1/NTsE4WduIaf
 DlqA==
X-Gm-Message-State: AJcUukdBWkOI8Ms81nJwJVL6GpnlbA8il+pS+s9SbKO7K/d9PbMAcgsG
 F4lepO7bJVF8krMOGQdu2In43EoZ
X-Google-Smtp-Source: ALg8bN6yQkHsmN+SOFWU0tXNg3a+dynek9KTyhGgMAoo0CTbnQznS4lKL2wfPqm1uvdeSWT59Ivzyg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr5479650wrn.27.1547042447724; 
 Wed, 09 Jan 2019 06:00:47 -0800 (PST)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id k23sm10376044wmj.32.2019.01.09.06.00.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 06:00:46 -0800 (PST)
From: marek.vasut@gmail.com
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight regulator
 numbering
Date: Wed,  9 Jan 2019 15:00:45 +0100
Message-Id: <20190109140045.17449-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_060049_746698_48F2E49B 
X-CRM114-Status: GOOD (  12.19  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms+renesas@verge.net.au>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
the eMMC and one 12V for the backlight. This causes one to be overwritten
by the other, ultimatelly resulting in inoperable eMMC, which depends on
the former. Fix this by renumbering the backlight regulator to regulator2.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Reported-by: Simon Horman <horms+renesas@verge.net.au>
Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add backlight")
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index e0590c0af4c4..89383aa35d65 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -191,7 +191,7 @@
 		clock-frequency = <24576000>;
 	};
 
-	reg_12p0v: regulator1 {
+	reg_12p0v: regulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "D12.0V";
 		regulator-min-microvolt = <12000000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
