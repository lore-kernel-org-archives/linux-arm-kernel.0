Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B8C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705E12184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lr08pj1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705E12184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8p3pJ6/ElF18On2XVocLlQfL7X/B1sZ6fS7KKzmebsk=; b=Lr08pj1T6Z4aAO
	ZOM1W3b5UvLuCCjO14ssMhRyDFSDRFdD3KQsdjgoJEIhguDAdxbncLcuPSlgXKovglW5vMFV9r/eg
	qpvtubMXqILvOaQzaU2V5uiGvCA4YQikKQWfDKzS6l55TQilVtdiGZ+EiOtv7N3mZ5ppbwMToz3zT
	bn/hctXhIRyUZN+6CGiS+DiL3IcKUEr/psdQnHL6yQgM2ED3Sp6dOU0/SvMqzDJjsftbxYvFNt0FZ
	YggyU5uoplBKKU3jJ2YJcm39ftoWdIiD3cr3L7zMsaH8PAm1YGA5uMYarJfQRYj93fQir1fWHkK+a
	28xbjJQoF0o4MxSeJS2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfETv-0002NZ-Gd; Fri, 04 Jan 2019 01:41:03 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfETn-0002EL-Ie; Fri, 04 Jan 2019 01:41:00 +0000
Received: by mail-qk1-f195.google.com with SMTP id a1so20772236qkc.5;
 Thu, 03 Jan 2019 17:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=LksFObJE0mBLcVa6R9U5mgdf0LK5awzANil+vII+HXM=;
 b=GWO/UjehMV75/8fqe9nEc1vQfIq9O5ktKj+Azlk9SzZBCJVw3EnOY0Cls4/9v35ApP
 4CP3625nYCctAGUrF2ZezmRfl8HtSf13vl3TiTXCEUsm7Fjw+PoH8wGGi0/ptBI7jFV6
 ioIXg8NgNm/oXWM/eYsxClxDiK65OcDF18XiPUQ4/lJNv2pZ31TtkMdzPt1w16AlOzyt
 HoQ4vcTRgV4aAVXRbgud3riyK34k3iZJ+VTSI05NeklNUiZj4Ezo/0mxI9XwYr1s+o34
 6tL6LSrRKTWTlGxs+FgB5H033xx7L1whl8tVFPJ5Gz78xKDalQAL7w/A1dx85JsVlpX3
 zHrg==
X-Gm-Message-State: AJcUukdW9fg20ETCYTn9X+T6nXoa51afZaaIiokZpIBBc5CGKcs0pnzU
 TWBCsL2LSG7mynZ/rtRVccnWcOMh
X-Google-Smtp-Source: ALg8bN7xcR468FeHnzVMB+JK0tGKz071m+pbAcx+a1Q/uo9unYcK672F3Vw5wL+RUldjnBzJbEu+hA==
X-Received: by 2002:a37:34f:: with SMTP id 76mr46283480qkd.347.1546566054011; 
 Thu, 03 Jan 2019 17:40:54 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
 by smtp.gmail.com with ESMTPSA id k6sm45300385qkk.60.2019.01.03.17.40.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 17:40:53 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 03 Jan 2019 23:40:47 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: rockchip: rv1108: Add spim0 and spim1 pinctrl
 groups
Date: Thu,  3 Jan 2019 23:40:21 -0200
Message-Id: <20190104014023.17973-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104014023.17973-1-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_174056_021992_089072BE 
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Otavio Salvador <otavio@ossystems.com.br>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Vicent Chi <vicent.chi@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the pin settings for the SPI pins so they can be used across
multiple boards.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index cb26d9d98c34..f47ac86d2852 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -834,6 +834,42 @@
 			};
 		};
 
+		spim0 {
+			spim0_clk: spim0-clk {
+				rockchip,pins = <1 RK_PD0 RK_FUNC_2 &pcfg_pull_up>;
+			};
+
+			spim0_cs0: spim0-cs0 {
+				rockchip,pins = <1 RK_PD1 RK_FUNC_2 &pcfg_pull_up>;
+			};
+
+			spim0_tx: spim0-tx {
+				rockchip,pins = <1 RK_PD3 RK_FUNC_2 &pcfg_pull_up>;
+			};
+
+			spim0_rx: spim0-rx {
+				rockchip,pins = <1 RK_PD2 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
+		spim1 {
+			spim1_clk: spim1-clk {
+				rockchip,pins = <0 RK_PA3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			spim1_cs0: spim1-cs0 {
+				rockchip,pins = <0 RK_PA4 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			spim1_rx: spim1-rx {
+				rockchip,pins = <0 RK_PB0 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			spim1_tx: spim1-tx {
+				rockchip,pins = <0 RK_PA7 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
 		tsadc {
 			otp_out: otp-out {
 				rockchip,pins = <0 RK_PB7 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
