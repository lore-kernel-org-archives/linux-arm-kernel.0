Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A19C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626BF218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UrAc3mmy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY30Gfvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626BF218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q9yXzwhxSd9FO4owKcM1jwww3Z8OTZsTQ2lsFZOwkPQ=; b=UrAc3mmy1ueTJqRsUCOlrcD3hd
	RQUmJPwRwsNQKAyOMXOc7l8pis6GthHOECcS0sZvuoBfK+SL3KYhuF5VcPRUNbVpCIN5nYSK6uVe0
	V5tBE6oP7btJlCjEx2Myz9Bq/2dbO4Tk37R+qKwTPepOEVbkbLicTlHfcH4bxSsvXptXwPJNP7Lma
	WVPb9n/M1tq0unRf9C8ZZY8AwBCYfFjy+diGBhtnwN7iaWQqkdNldhQfIg+E+nSffAqNnLWeDPQ/o
	rLsFt74SsvP0VaiD+gdOJBpHib4z6ieneF2hZY3tTPvxKc51XsiA3BUBQ9B868F7saSVCPKs4mSB/
	wA9aAvYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga9ip-0000gS-56; Fri, 21 Dec 2018 01:35:27 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga9ic-0007hi-Q6
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 01:35:16 +0000
Received: by mail-pl1-x643.google.com with SMTP id g9so1712400plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d/H0IPCs/zGaOeUW7gjqD90ZTHLo9Q7AE+BJZps2hKg=;
 b=WY30GfvuyBfq9r8h3jaOWv6hOvMVh0LxBfm5BJ0gVLK6J1MjWGSIFVOUqRhvV5NIa+
 ZJcnm/A1Y1087wzjehsKOD+687Sqhr0syAC8al2gtV2sDCtVLhErpDDTIpOryuFBewkO
 pihEorgRPUPIwoqNGxe7fW1BXdUzXZ5iLdgSu9oCmdxEckwaYsz3gm5q/a4PyKELVhX2
 Sw1DbvVU2q6NmpHEz5kWoe1Sm1SNKy9U9Z6HqXbcOEI2rR77VeMt8shbj+DjeTZkeXoA
 W12gmnvCecHw08pogIK/uWnu7pm9BFevzI4hsJqPJMauMzXm+1N8l1sTiU0IbGL3gxm7
 ySQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d/H0IPCs/zGaOeUW7gjqD90ZTHLo9Q7AE+BJZps2hKg=;
 b=mFxTU7sk/Q7L+ShKA+D/tl2CZR94dGAd1/22XFBT+oXB+zvnoY1YvhqYgU8Nl7rY0+
 NFTte0CLTl3rqtOg230MBY5Gf1/s76lum+i3hX4KC443uFU3t+AEHP53uAJSrOdgsN7r
 Ujkeqxw7p/Nq4HUJo1v+7KmnPhqVEzxRgSmgTjqfYyJ5Og7zs6t+WhRrwE7BPw1uVGq1
 bzKmqcE0lQDraoUJus+okIluqltbs0PK7BbQ4yGFEEwrYjrshMx4MUDsEUja+X3LKrZz
 FaEoM6MCEO+cwG2tspaKZBtkssDminapbGcw7hfImh0hdXZHHyvUMmx8UK6bUN4GOvGp
 zPYQ==
X-Gm-Message-State: AJcUukdHWxP2W4AJJn6+cFLwy87Zpqkfckspa/4b2r+rLDdY1nVO+q8j
 v1X2X3xDwgUx3dqie2P+AaM=
X-Google-Smtp-Source: ALg8bN64papHktpfj87W+i23wbtCRwyA4c9Htd36K/BKTM4cM6EwvYHgaDX7FqMMcvVB14la8w6EMg==
X-Received: by 2002:a17:902:2dc3:: with SMTP id
 p61mr534475plb.166.1545356101975; 
 Thu, 20 Dec 2018 17:35:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id g70sm36590854pfg.98.2018.12.20.17.35.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 17:35:01 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB reset
 controller
Date: Thu, 20 Dec 2018 17:34:08 -0800
Message-Id: <20181221013409.14324-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221013409.14324-1-f.fainelli@gmail.com>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_173514_847284_662ED786 
X-CRM114-Status: GOOD (  13.88  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a binding document for the Broadcom STB reset controller, also known
as SW_INIT-style reset controller.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
new file mode 100644
index 000000000000..6e5341b4f891
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
@@ -0,0 +1,27 @@
+Broadcom STB SW_INIT-style reset controller
+===========================================
+
+Broadcom STB SoCs have a SW_INIT-style reset controller with separate
+SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
+reset lines.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: should be brcm,brcmstb-reset
+- reg: register base and length
+- #reset-cells: must be set to 1
+
+Example:
+
+	reset: reset-controller@8404318 {
+		compatible = "brcm,brcmstb-reset";
+		reg = <0x8404318 0x30>;
+		#reset-cells = <1>;
+	};
+
+	&ethernet_switch {
+		resets = <&reset>;
+		reset-names = "switch";
+	};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
