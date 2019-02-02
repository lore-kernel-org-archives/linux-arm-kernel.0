Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBEDC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438B120857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GjWVaIm7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ClL4zpG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438B120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eGlQt1ABYAZEv4Z6hSItctrz286ujvbSlUev759ZcN4=; b=GjWVaIm7if97TC
	Uikj2zBjJWF6z4HqORp+5ALfCQfDvsCbBlVpnHp0+o5lYUXD9Z3+YF7ED2kWEE3M8M32DLsD7G5F/
	sH0TfTq9xeEI3WwQQ5eN/WZC/uULEIQiM4Gm4vYZXOUTKIk83oxodu1Vps1e/YaAiPuPCGODwGRET
	CHxQIQphE6QDr1tS8QxVz9PPCrSB6KoqMNqQ3vY1uXLPAMRbnenyIcb68f2gur7GoG6UgX+pxnYSY
	TKiNiHGv9UA3q2YtOfnj4z4KyvGxZHhmW5Za0OHJhMlMqA9+meeQt+yemfa/nhG1R/LtSnH774L0N
	716NBBF4ah6ZfG4O4GQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpwsy-0007VS-05; Sat, 02 Feb 2019 15:07:12 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpwsu-0007UR-V1
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 15:07:10 +0000
Received: by mail-ed1-x542.google.com with SMTP id y20so7834994edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 07:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HTuz1kv5hrVTZloeZUxC4ImlEH8Sn0SI+O9nE40vblA=;
 b=ClL4zpG1RUvYF1MbcBdXUgWf7o38pjPhKnl8NZnm0QBANQS+GSWrBeRGLYinIvqkcd
 LK7R4MaJSZejqrY5AlJIzszpsoblAls7RnAGrYUXzVsLrwfnjmz1SH9RgCHrokTRYS/e
 XyhNoN2G0bRDvWB/00osd4dMOBMoAYHPkwLwnwv9P11J31qdZhZa30Ic5Y87D3NsHzGN
 853XCHW9C1ABx/tCz3kthwbyhJL7YCnZC6uOliMg9m+cVojFLrJ7AYBspjvPh4l9VkEi
 rEH4XV+NZMKW1G4xwb4ZRbiCFygEjFzD+cKfb9sTJ+9c71y3FoPCpKM606/+fohUsxLe
 7uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HTuz1kv5hrVTZloeZUxC4ImlEH8Sn0SI+O9nE40vblA=;
 b=eI4a2zu7KuHQtT8Mi7czgPTz+PAYGHOxIKT80zfupWKgEPar1nAFe45zVp4z8S0b/B
 Cn/fN/TS/24DqhxlM8yVxu/goxlkFl6A5k2+FzgQUlCc/bR+WBhfNJ9U6GHC/PwjZsQa
 eGJ9lnRjfhcnp6r59qOEZvjvAfIZsmcvz7bhomnQJFS8ZFwrN8idR87ftx0NND2w+FLw
 6yRt5jP8XaNmcYksj/SHr29tdu1IlpZHym8lOdWAWbXKTqUde8oXxgQALErzo/027HVQ
 YuqnM+cyc5Id+VT/RQPwrcrNz/lgXWd925QtZyyXO7UgKvTBuveiuV/LwcDs5sWCr5l9
 KqcA==
X-Gm-Message-State: AJcUukeQZOsT2tpyzh+SrBjcJdbzwXFVOSnTqrm0yWQfEX7kBod4Scaj
 X8lEkkailviZGC7JKl41vOWxFXHkXG0=
X-Google-Smtp-Source: ALg8bN7Zkrw4J1TBDFmsxz+x+ow/wRm7JHj6vOHsO+ZQN7DwJsGqCi8uwQvxDN2w8Hn6r0YG+IRX6w==
X-Received: by 2002:a17:906:3282:: with SMTP id
 2mr26979942ejw.68.1549120027265; 
 Sat, 02 Feb 2019 07:07:07 -0800 (PST)
Received: from xps.fosdem.net ([2001:67c:1810:f051:b8ff:4dac:8778:256f])
 by smtp.gmail.com with ESMTPSA id d15sm2753023edv.20.2019.02.02.07.07.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 07:07:06 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Date: Sat,  2 Feb 2019 15:06:38 +0000
Message-Id: <20190202150638.13672-3-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190202150638.13672-1-ccaione@baylibre.com>
References: <20190202150638.13672-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_070708_996336_3C58BADB 
X-CRM114-Status: GOOD (  11.04  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document the new compatible for the i.MX8MQ SoC.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 7a999a135e56..fec66e3b45c3 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -13,6 +13,7 @@ Required properties:
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	"fsl,imx7ulp-ocotp" (i.MX7ULP),
+	"fsl,imx8mq-ocotp" (i.MX8MQ),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
