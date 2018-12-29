Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499720828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t+8HBhWQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1sUBtnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EWuTQNp4Vd0gVzl2oRsVx9eMMlKT9fro4h4RuL6GV/0=; b=t+8HBhWQXWnCIL+F+QpJ2HA4E1
	4Nrk7TEwFcBMd/TUu2fGZ/bNqivWTOsnVx2Hav+vVvfii8PHQwvEVU+AOHmo2kZmx5HCGthCXDyxa
	o5bSuB6wgJwq5C7gnxkpiW59TkWGPC9nrxadBqTgZqtQF2J+mwraCSAQpV0VvmnDIvKc4VC6LKYsL
	fJgbkhQjPtU4KkhLa3mn9SN2lgpgLlJRZ4oiiawjNPYp1UZmzEOdKHfwMWndfhvpbbWd27q9cqaxU
	Lin+z7skrBHscUGvURCQ9jrVscgI1JelXdj+CsZOlkMocnSpz4X3K7HFz2CvzSny0V7f0ZQp/6+7K
	R+tnxbOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdEkY-0005aP-0X; Sat, 29 Dec 2018 13:33:58 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEkL-0005P6-8q; Sat, 29 Dec 2018 13:33:46 +0000
Received: by mail-ed1-x542.google.com with SMTP id h50so19477918ede.5;
 Sat, 29 Dec 2018 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A9CGCUXo0DL9xsxniBKUOUCc5uB50j5v6oJSc35/j3E=;
 b=d1sUBtnvZbhwSsMdxCL4lC6uoFj6Y4yvmcOoT6TGqGT70UZa28DLMX0FNrnBH6ZTNY
 Qx25Ba0DCE6Hyz6OcyNBnQgc2XypBNqiMSaHCT8WktOs+WV81KFeYUPrYWe9EX9awzMs
 uQrluLqSAJPrZ80IaEMu27clTfAj9WkJ/BWSxLdOkV5jN16K7vlot5HtR13DHNU1TbpL
 xNlNzMLLhCgAsDBQu6tpqAluJ4nFjsfFYbEX5Nb37cj6O1rxLmaa+Vdo+E9vBoOBTCcp
 jXGFUn0YTyLomDUI0J2U0bcjLVBNt5NpPThFC1BmhKuW9vk+vNF2vJhZ/Ofo8JLIPrkS
 gy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=A9CGCUXo0DL9xsxniBKUOUCc5uB50j5v6oJSc35/j3E=;
 b=b6b+jWTmR8mDvKO4Cj7nOOfSFS6T3uuVcKqEvW62xDu8uV04ksit761CxFUlnAofV7
 /GINmBPyAtoz9ELXbIf+3ANRWT+JMP0ed/kZDEFhlwAg9lbLMn4+UHPK0164O72poEw2
 PHeGUXctCd+A3jUYB8/q4KMrtMjPdFWp3PWcp2fWrpQ3DBoeJmbflS5GC0XZMJ5f33Wg
 41CUQWpmgygowRqOXA/E9vkNTCr/h2rNPRZSDl6NYtwCZNYc0cNzE0iwU7zHMxTk9p//
 CRWJmhOAGTlMFS3BlsdLQnTKvjf1d1LPbH3LHkh/Jy+tivTw9pstHgz4qysCELu8B1P5
 COiw==
X-Gm-Message-State: AA+aEWYFXlRBG6iTvtPREGnhjUY9UWK38f1aBuA8XZ/KNZbA+KKVbfHD
 xbeY6dLOgSVKt96wY+JcEoc=
X-Google-Smtp-Source: AFSGD/Uwcm3TMhLtnB59jHhd8zvYH64jpys9HBxCmf/3/kLuH/vCaqOysmjHPT31yrel0zX9Dic6CQ==
X-Received: by 2002:a50:b964:: with SMTP id m91mr25927173ede.184.1546090413886; 
 Sat, 29 Dec 2018 05:33:33 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 05:33:33 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 1/7] ARM: dts: rockchip: rk3066: add HCLK_HDMI to pmu node
Date: Sat, 29 Dec 2018 14:33:12 +0100
Message-Id: <20181229133318.18128-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_053345_314866_F5201C3C 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A MK808 TV stick with rk3066 processor
boots normal with logo and console,
but after booting the monitor remains black.
This patch fixes a vblank wait time out
by adding HCLK_HDMI to the pmu node.
The HCLK_HDMI clock is now part of the logic
that enables the RK3066_PD_VIO power domain.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 30dc8af0b..b6b3a77da 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -669,6 +669,7 @@
 				 <&cru SCLK_CIF0>,
 				 <&cru ACLK_CIF0>,
 				 <&cru HCLK_CIF0>,
+				 <&cru HCLK_HDMI>,
 				 <&cru ACLK_IPP>,
 				 <&cru HCLK_IPP>,
 				 <&cru ACLK_RGA>,
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
