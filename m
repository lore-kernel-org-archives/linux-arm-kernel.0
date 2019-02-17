Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2C820665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WVfJ5exM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1RNXBQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2C820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1FRbC4KBq9NlxOINLiF1L0DdFkb/lpBwYYjcV2eieHE=; b=WVfJ5exM0mV81gJetMn/lbvTOR
	rLIFpaZN7ZXd3/T0WT/jbErJQO0rovOjytDUnvCduLjivktG8aLkI4KXleNnuLFpbarcGPXfGrRXu
	VTjprwiC4hCNqOCF55RDng4zI+ZTwNDFiD8qF+6nCVRzmkIbE2q0BMZMbJ0sneHx+DmguL2gyXDxK
	b/dI3GbpSemhd4X/yv4UZGXyqUbRjBMvdfivE8W0e9k1IsPHqFVHywp254K/ghGDGquMyJoGqdL2h
	wubMa/0RQT5cfsxxOoy8AfokhWb/KjGWNE/mlogPTRKQepYoegNmqLdG6rLlp6nRAcAcp+zoksyaP
	Ze6F0xEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPEL-0002Wp-V8; Sun, 17 Feb 2019 16:23:49 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPE7-0002DU-4u
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 16:23:37 +0000
Received: by mail-pl1-x643.google.com with SMTP id y10so7513719plp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l0Z1b8BC2pttHCDOIu6v+lf74XsTzc0qioBaG3nshfk=;
 b=H1RNXBQyWwvUvFimsnQaKsApwBgZZRoA48sVue+RJ/bohxA/tPVw/7Wu68+shB4ytR
 IkztkblLHEI3PV0Qm7JY+0kMgUz4Wc0N0PH0HfJjF8yDSxyFg2ZVl845X4H2iFyTSfZO
 ZUOs9+EYZJJ1eASZQW+LE2Zy7RmHZpzQ2VsrbHOnk/5XPD347SuQ7QG3MDrXgPmaIqeP
 2yulNvyME88OSBPdqtVcqhHW9WiUUBqS6J1AiNLaAdEF/8cVf1LJH79Ihiai3xD+MP2L
 PZ54teH89F+2KnLwrp28Pi58fZRGTn4DS+TPK/q0n0F05VbnsfOM3D7YQG+UFMlTkbxr
 A68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l0Z1b8BC2pttHCDOIu6v+lf74XsTzc0qioBaG3nshfk=;
 b=Fc56SvPhoCuJO0QtdyIWVXpGLfN3FK4kELxwkeHrMvmg74lcwNfOzvCe3X1lEiaQSX
 xS4Zm/fQ64VWa1lIt97VY735lHqlBeSYmuWpYQ9chcss2rSqGWfAJC0M6/3smIkVFjnz
 XBbDidoAe3EoiPp2W4OoXgRdTMJGDDOk+/S6A0qtzGVNXceL477E8llS8/Nw2V4W/iQG
 +noOoqxSbQ4WIw2f1N4I2+Eq0hOrU9VZlSDRd73OtgXe4Hky1efhxOG+QPh+SWiwhblc
 sEzLtK+WJ/wMSLbM2FzNXaAChn8gIk8C7Jv5WYNzsK8i76xgCJIyYm5cVGJK254bsO00
 4E0A==
X-Gm-Message-State: AHQUAuabn7D6LZbRi+LI0CGlKnfsoKcmRlj+6YwkgNYRmN/iIDd55aY5
 /0BYTP4za2MDMWwdzM+TF7U=
X-Google-Smtp-Source: AHgI3IatCozi52BBjxYj9wpcWegsHycTPpd+H3xV8EpBNaBUTb92zGixVALQES0YRocPtZTjcjg/fg==
X-Received: by 2002:a17:902:2aa8:: with SMTP id
 j37mr19969310plb.226.1550420614357; 
 Sun, 17 Feb 2019 08:23:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id x11sm12541697pgp.88.2019.02.17.08.23.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 08:23:33 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: srinivas.kandagatla@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@bootlin.com, wens@csie.org
Subject: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
Date: Sun, 17 Feb 2019 11:23:13 -0500
Message-Id: <20190217162316.14111-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_082335_381817_34D6E06F 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for H5's SID controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 570a2e354f30..036029e90921 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h5_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_h5_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
