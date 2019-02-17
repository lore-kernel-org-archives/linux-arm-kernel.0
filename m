Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9254C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82750222EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kfsdSnOv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0Xhnoiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82750222EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V2sRRuwWzaV8UTBjKgXy/APaylzM2g3WifvthMjgP9s=; b=kfsdSnOvlSMV6q
	WMrl6/8huaPQrm8VkNygvyz1ADExkK+S7BZukkErHQw+3KlanPS52xmrtpQpWG4dXW2lytf6Tc4iR
	FJT2yGGNkyu+q0RWhODElHMRGesVc+jJrit3h99F3Zs1hfyW0o06T1WiLe0bEZa0+WbjM07IYR0mZ
	a0qm2Hyz+zCPpboY8ATpUmR+ScbwpGbMVCs1kOKIgBRTRuWzDLQaSieaSxVGjNb5upQ5jYoYKHGLL
	qKIedpYyVPq1YXEn1LGIN5cb1LrNADldqkWc8Xa5L8VOqe6H5SLcH6txe4qIkwrSZ/NKlgHDpgQee
	qGjIY5I25UJYtzTvByAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvMjl-0000xd-T3; Sun, 17 Feb 2019 13:44:05 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvMji-0000wo-67; Sun, 17 Feb 2019 13:44:03 +0000
Received: by mail-wm1-x342.google.com with SMTP id n19so2508086wmi.1;
 Sun, 17 Feb 2019 05:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JTP8k9O3Q/sR9rZJ8rE1e/scP/wpNjSPaZ+AmzE47J8=;
 b=a0Xhnoiw+rIG8j/hxhEe4jXBSzTTEqLhBpyh8FZGDb5Aay2yVCnlEhG49Ssn50pgvY
 ol/ANuXY+eIQMd9nyPEXZABbKDyr8+Jj4MtCSj2Xte68ibciInljoF57HXmyVjEtIZeQ
 UqCxHIanhN4irkb6bo2uIhfipxbYPiW5St/phAhHWcPS4iaiH880QZWu1EvOhQ7eir8f
 DKc9+YeBbTpGhWx3579xx7eKs/id7feyxMHThEbP9RQTbmpX5WiCC4YJgCxadyngHcZ5
 RIZXg5PgRgtkEIu/wdd89O5QOeGZWKvX3ktb1kOAZgNaI7/goxGA/nwfqt4dtu3aEzIR
 rGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JTP8k9O3Q/sR9rZJ8rE1e/scP/wpNjSPaZ+AmzE47J8=;
 b=lWpFm0zV5yKlKSva4+w6TqSPt7WEXafuQgthgr8CrCeOpSYP9XXfZNrXof3+FXrn90
 YtTqzj10Fi1RKhLOKnl7Mg52ti88WViZ51g1zhJTRR2WSge5+Ln4Nn5a+kKAP4LArVva
 B2jZCpzR8b7gx87nyaQnC1ckYeHtn9gQdy46V9PZCy23/fglUXEwovkLrIKkyGm2KN+O
 XKH/XnXkwEAyKsIbSn+CPZOxHvlKbVyJ+LYGdS+Scqj14wb+1drusRdoU6xEGPjKDemk
 x5XOtkB+YXvq35zK6xbQclTGdON+tEfvjLZFBLrkhBFXsMOFAcb4Pb2yz0e+KdoU23Pw
 xI0w==
X-Gm-Message-State: AHQUAub9ng6qynDEZagNZuIFeHVMo3LYC+1KW1sgG2Sj57xXZtbofJRI
 Q/IeuhFmys0nUN3vOG9TsANvGdY1yQ==
X-Google-Smtp-Source: AHgI3IaTAIytusszPddf5Ks15k8HO7gM++gsrTFRHX57D6fJstaVMs5XoSnGUKC0WJR7QVMoenM4JA==
X-Received: by 2002:a1c:c102:: with SMTP id r2mr12175821wmf.126.1550411039841; 
 Sun, 17 Feb 2019 05:43:59 -0800 (PST)
Received: from localhost.localdomain (esm-84-240-79-214.netplaza.fi.
 [84.240.79.214])
 by smtp.gmail.com with ESMTPSA id y22sm42233954wrd.45.2019.02.17.05.43.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 05:43:59 -0800 (PST)
From: Urja Rannikko <urjaman@gmail.com>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/rockchip: vop: Dither down to RGB666 if output bpc is 6
Date: Sun, 17 Feb 2019 13:42:27 +0000
Message-Id: <20190217134255.6287-1-urjaman@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_054402_228441_88FF3422 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: Urja Rannikko <urjaman@gmail.com>, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, hjc@rock-chips.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Tested to fix banding on the 6-bit panel of the ASUS C201.

Signed-off-by: Urja Rannikko <urjaman@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0c35a88e33dd..96ba1b4cd07b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -896,6 +896,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	u16 vsync_len = adjusted_mode->vsync_end - adjusted_mode->vsync_start;
 	u16 vact_st = adjusted_mode->vtotal - adjusted_mode->vsync_start;
 	u16 vact_end = vact_st + vdisplay;
+	uint32_t dither_bits = 0;
 	uint32_t pin_pol, val;
 	int ret;
 
@@ -951,10 +952,15 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	    !(vop_data->feature & VOP_FEATURE_OUTPUT_RGB10))
 		s->output_mode = ROCKCHIP_OUT_MODE_P888;
 
-	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc == 8)
-		VOP_REG_SET(vop, common, pre_dither_down, 1);
-	else
-		VOP_REG_SET(vop, common, pre_dither_down, 0);
+	/* dither_down includes the bit for pre_dither_down */
+	if (s->output_bpc) { /* Only dither if bpc known. */
+		if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc <= 8)
+			dither_bits = 0x1;
+		/* Enable allegro dither to RGB666 */
+		if (s->output_bpc == 6)
+			dither_bits |= 0x6;
+	}
+	VOP_REG_SET(vop, common, dither_down, dither_bits);
 
 	VOP_REG_SET(vop, common, out_mode, s->output_mode);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
