Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1ABC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:53:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE0B2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HLaTU2FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE0B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A7gs6blsl2johCCJqLGGWfkDJw8myBkdbjR+qiTKvkw=; b=HLaTU2FWQ7HzK3
	YwezOkK/jR2CVO0EYS42pndRr5uKVY9/Bm6FgVkYx6btjmw+BzPjP37//bXeZFcCFxlJ1+6gHjhRz
	Uc1GVBW62x5arAK/tsgK7Oqp7bwevoBHFikDWyZ0+Qt8r6/qC1f3ATsB4A0HPpqlpMmkHaYbAjwH/
	XgPO6EHZxzdKBF0iTo27UKxzT0MMtjEU6c3R6r0FJaVfH2cwaAvFz466E9xofAFOhVS3WcbFrDzt7
	9OPyivANQ4Bdvk1f9wnZW1XI6abY/UI0CkFpx5tO4Kdq3i0lfJITc/EAEaVM8RwetsJwYp4iUiaeF
	wW/JpwaM/sjO8cz6LjDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSXzR-0000l2-F2; Fri, 30 Nov 2018 01:53:09 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXzN-0000ke-UW
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 01:53:07 +0000
Received: by mail-ot1-f67.google.com with SMTP id v23so3720423otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 17:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uJUqz58s799CBzh2ovgyr4IApyWOepMYO5pBXpfJtiw=;
 b=KStNAxnGMTUqDNO31zL7pg9JVOBCCca/t9Y5KWRwOZPj4e8uSpV1ytfweQpT66zLCK
 SpuwfCCrOzK8pzIVx+oo5qEZW0JIfCBrSy6DEXFZkMZvq8nw2N6uOEdBG5/tVlpvoYsb
 wyyViN+FN2FHKZNA8AU00rd/rUm157XW/6mBsXwv1LhoHmkwobquOYhEwWcpHl+9/eR4
 d0gl6NbLDk584kPpTrW5N76bHBXZsjhBFf1U2QDaLcMui41heEOV38DXszGgfoY7Hgt/
 fDp094gMYywA64ZLhV8BbnOCnLNYfaaTQuN1nnsnUW+eF6Bq6Xof3X5cQObgvwvbM6hS
 2/wQ==
X-Gm-Message-State: AA+aEWZ2voseMojOYwtSluZEQRLQa1+Vp1PwkDyFSu6s0FnamfcwcwcI
 xyhitKmiVFhbxxWBmaikqA==
X-Google-Smtp-Source: AFSGD/W+7nc6TZUYaapAOh62LGuGuZRNuI8NO1iIWyYJPAtIfFi5preuxp9AMU7bkP2e3v9Xhp21gQ==
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr1122671otf.124.1543542773349; 
 Thu, 29 Nov 2018 17:52:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id g38sm1320736otb.77.2018.11.29.17.52.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 17:52:52 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: arm@kernel.org, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] ARM: dts: aspeed: add missing memory unit-address
Date: Thu, 29 Nov 2018 19:52:51 -0600
Message-Id: <20181130015251.20754-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_175305_985516_A8B767B8 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The base aspeed-g5.dtsi already defines a '/memory@80000000' node, so
'/memory' in the board files create a duplicate node. We're probably
getting lucky that the bootloader fixes up the memory node that the
kernel ends up using. Add the unit-address so it's merged with the base
node.

Found with DT json-schema checks.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Might be better to just remove the node altogether from the SoC dtsi 
file. It's only saving the device_type definition.

 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts       | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts         | 3 +--
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts    | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
index df1227613d48..c2ece0b91885 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
@@ -13,7 +13,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
index 7a291de02543..22dade6393d0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
@@ -13,7 +13,7 @@
 		bootargs = "earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index d598b6391362..024e52a6cd0f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -14,7 +14,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
@@ -322,4 +322,3 @@
 &adc {
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
index 43ed13963d35..33d704541de6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
@@ -17,7 +17,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
