Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77F520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvSaCuOg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WYp4dBnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77F520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6DoUV/lyz7ICl+t8fH9YpK5L3aS7e8cfaQqWL4/uX5w=; b=cvSaCuOgX4v29d
	lPJXBOPoq2Q+eP0zBd36ze8FwnhT91grx6u1WeCCkb8bGo3ciuH4A1sdkct70+PiZFFAa5iViJd4E
	HiZ2+mj8TK0FBLHKVnDSWx03iSOqj4bGTzw2sDrlJ0gKnINd2uoJYKcEqKH7kA07MF8DmBL7IAXes
	mU4p67vJ+xddxXfvrSHWTknr0saq9lKmCz+LhoawJqfrjMGy/LpthJ3aj7v+TK2CdbOve4WeyBhom
	PaHKyc42QxfHxGGUXCqK0s9elyjRS+xvIs2hS3HNCBgJpwW1reBKz+NtWrd6Bt41n2b6H3FaXOeti
	/MIGUYWy6z+KPy5o6tBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlBG-0005WG-4p; Mon, 03 Dec 2018 10:10:22 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl97-0001Lj-BN
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:08:11 +0000
Received: by mail-wm1-x342.google.com with SMTP id r11-v6so5078267wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pZwHMdseiN89HEVSRgqoNt8QGqFQI8aSS6wIp4a9e3c=;
 b=WYp4dBnqnA6t8f4+3/r7Q81AkOf/D53JEKyfYAKWJED6IieqTZDwsiyXXmPKJHl1xZ
 /RjT7/ug/RPxhzKJPKHYNYqijoS9xqNrGjrvmsOWZH9G4OWsogzCYTTqJlJaQJNndrHy
 X2iaiTd7eBx3Cf+srP9C9KRZChXve5BWfRZUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pZwHMdseiN89HEVSRgqoNt8QGqFQI8aSS6wIp4a9e3c=;
 b=taHBt2rBxms4/HMNYp9ipprzjq9COtWtYjb9GvDFk87bWOaoGr7OHNzNbwaFUI0DMF
 DMfIIhd/9navarxlzh7tvhpDG0RyeJDet+Em0jHwyTI5H2z++/0CiiiAdJ1/jcaYJohZ
 o8I4zHkNr37p+iGTcEkRi/V/b1RB3mO6nUVlbJAYFqCJtICxx06DfKai7A99mqy17DKu
 /4b11I3Mx9J6zDHcnpSj3b+Pa7t16MEed7HxQxT/lYjfzZG8BZpNh6ukKGja0Mt47z0Z
 Ez/tUbh5ksyOYV8kc6CeF9zHz905vQy+9cz+AXTWAJYsJ4mcAF8QQKDZyhkxP9aKq89a
 MMSQ==
X-Gm-Message-State: AA+aEWY3tOK7q2hFMLmPtWaMPCobHgIx20ofPkXQQUDMIsyO8NSYg6HI
 tPnFgdUyy1GodfbqInBeKDln+w==
X-Google-Smtp-Source: AFSGD/XnbFNuiD20WI4SVXVx7wsH0dmxqBf/ID0DyAkKyFtb/MOGzGfmOYAWr2InYDDaGLbjQuGBFw==
X-Received: by 2002:a1c:307:: with SMTP id 7-v6mr7540895wmd.146.1543831677859; 
 Mon, 03 Dec 2018 02:07:57 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:07:57 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: media: sun6i: Add vcc-csi supply property
Date: Mon,  3 Dec 2018 15:37:44 +0530
Message-Id: <20181203100747.16442-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_020809_390330_703D8CAB 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Most of the Allwinner A64 CSI controllers are supply with
VCC-PE pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property as vcc-csi so-that the required
board can eable it via device tree.

Used vcc-csi instead of vcc-pe to have better naming convention
wrt other controller pin supplies.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index e78cf4f9bc8c..5fb6fd4e2c7d 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -18,6 +18,9 @@ Required properties:
   - clock-names: the clock names mentioned above
   - resets: phandles to the reset line driving the CSI
 
+Optional properties:
+  - vcc-csi-supply: the VCC-CSI power supply of the CSI PE group
+
 The CSI node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in
 Documentation/devicetree/bindings/media/video-interfaces.txt.
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
