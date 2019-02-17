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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53288C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:24:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8C4206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKgy90pu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdyNqe7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8C4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mcjmYblUaiGUcWX1Fi0LjA8ck6I7nv670cg0ND+3B5o=; b=lKgy90puru+C0Lz+y07cFQ2QcL
	0O4A58DAtInEukwZUNz4R0JUVMutVohH3p452NKVnJrQd2JfwcuZrJrMH4RTGk/DmLNbcWAw+sQnq
	UcesaIYM/TtnZOuxKY/umg5mWtEjv/tjfZY0ZzgwBn63DgZLggNUdx94tb85O0XcfjlqBlaMIEw3u
	4+gUxlqEfWBT6VUC/DR+Hg6ZH4arU3iZlRMXEmNyv9pD3By4029dV1l/gHqJGM2noQwSFLnC7lBvD
	oUpgdgY+o3TdUjPoMGBG+/iJlg/rUiEvU5x0A9VYlgP+QjUKm3oSWKLFXPkAZTi1l6EcDzDlX3deO
	omRV9aNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPEt-00038e-Jp; Sun, 17 Feb 2019 16:24:23 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPEJ-0002V4-ER
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 16:23:52 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so7493102plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bohSFX1l++RtGX/SzC4HgfDL1CVVoHjCGwPOHLnV08I=;
 b=FdyNqe7Zqiv7AeFHDpDUYcffaOGYduDvgb0wLI6n1R/tuQJy2GysI0crXRY7Gywwre
 yHguCo6IucwQTPIuTBFtew41UjCFZwgvoWyQtzZPeEM7eZYnloaHu4m1OaX2q9cTXKed
 xXLaDaZ7KPo2GenVRx4jlGw0ucQM7A/warcTvfl1eGrjWbmPqC7ds1kz4VvYy1Yvb4XA
 BZG8LkENFKm7VD4XpxjLnc2JLn/j08cQqj0JZXaTnPh+JvDhC1+TznBdlTtxupzFHaYU
 gpOSSV38EjmIWqDclIifY01MUTO8FNtWN6bl1jKNIEkkD3mRJRKxSJT7FPjWmLNrz1wn
 idIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bohSFX1l++RtGX/SzC4HgfDL1CVVoHjCGwPOHLnV08I=;
 b=E2Jc2M4Bu49f+a5xuaSe0hJujkbfz8zzvaYIy0nvWxvw19jjAVh2iNa5XTUAOtqco2
 X5O8ykzYBV4YkvdBOZip6/ao5dyvyRpeY7sbxWtmLnuUBxCtYx07a5fFjdcHmydchk2I
 kFKCev0gT1EbCHOiPukXT1lysyipWtMCfI8+yTjWdu42LJtjrcOtCl0ScTU6T0TlvLJt
 b1vh/BxqXYCDtGEM35GU26y/zkKKLtECdgqhIz230+qqlflh28ZqnNCTkjr59n5tZeL/
 8JHjtnuTIijZiUJKlQjl8tm77+Au0kgAHkQg8cscNNxtQ2AUivbkkU5TK7N627h7LD1g
 kw5A==
X-Gm-Message-State: AHQUAuZTWQ9ItRx7aRfMZQvpwOPQemoeKdC9q+8vAbXPLAd5MY25ZxKc
 WqMkNcOfsH3Njn5w9zDbqRI=
X-Google-Smtp-Source: AHgI3IbvkHI8z7+rkzYw+0QcRf3Wx+2QccS2MFjpth5+eOo6amuKe3CqaP0bHv6NTmlJ/1j7JVjx5g==
X-Received: by 2002:a17:902:7b85:: with SMTP id
 w5mr16073456pll.288.1550420627046; 
 Sun, 17 Feb 2019 08:23:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id 27sm13317054pgn.56.2019.02.17.08.23.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 08:23:46 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: srinivas.kandagatla@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@bootlin.com, wens@csie.org
Subject: [PATCH 4/5] nvmem: sunxi-sid: add support for H6's SID controller
Date: Sun, 17 Feb 2019 11:23:15 -0500
Message-Id: <20190217162316.14111-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_082347_910513_C2AE762E 
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

Add support for H6's SID controller. It supports 4K-bit
EFUSE, bigger than before.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 036029e90921..8692b58d76ce 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -224,12 +224,18 @@ static const struct sunxi_sid_cfg sun50i_h5_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h6_cfg = {
+	.value_offset = 0x200,
+	.size = 0x200,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_h5_cfg },
+	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
