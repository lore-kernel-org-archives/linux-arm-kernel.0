Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00762C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:24:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D0820863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m2mix+Jy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkX4vG0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D0820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fjM9HCBqZW27BJI/ZlUmHuzYEaJ5upimOYuLYedthzA=; b=m2mix+Jyq5pxxrswnHGTHZjpww
	23To47eHI2X8IOLqF3JPUPAd9BkkNtnt6AAJUYO+8DW8Crc5JirwU3AuSYlYkjN+MwGDDGXeoG8og
	Qf218RzEA9LvLTWzFl76rtneZ9pWXqwNrQhkxdX6Yyiv6wkCpLlG97/C3bXzVsKH+sNCoQkmf3/Ub
	0XMyqUYU/fbfVLJw87IpA2WPRvNuQbZsKBDRWCRdBDjWBb1jiKBsae4g2QfxUIKLgDi6sTNMm6ZKN
	0mrwcOJAi3szVhMfdx8xdTAeZxvn+Y3hcYJh2BcncmynxrFSvsQLBXMojHhTsM10BotD7EpVSCSkR
	WnuF7fSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7p6-00015T-0y; Mon, 11 Feb 2019 09:24:20 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mp-0007ha-Dk
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:22:05 +0000
Received: by mail-wm1-x341.google.com with SMTP id x7so296361wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lIYeZisgInqCOZpWT0d/hZqmxdLdiRL0RmR52VTtRjA=;
 b=CkX4vG0Cf9MIFPB0r0biBCJp7uoat+QwA097brWM6ScCKl4BT3GVi8GEuUEaW19elo
 ndLUpJZ+7IZDWLr1mx4AmIU1LzoEcxn/+b+NUs2tydpQoOc4MTLFyqWJ9QdUn9MVdCgk
 RXUeW5B3O7Um5IrnlJt9so2xIFHljU72hhUvrW2r5WseWu5+wIDqNsT0nFUv+CkJrqU4
 jHnq7gugqCTYnyBIdrOwZvYApZsUWqDKaCuuq2huAXgVS3yGuP3r20yAINq4+8B2WZEX
 K3FFAjYEub/jDQo7UEZ2c1iKdET8pDPxGfw6ZpJKRCTk09Wh8kPHsLSR2q0rBqM6IH7G
 Vf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lIYeZisgInqCOZpWT0d/hZqmxdLdiRL0RmR52VTtRjA=;
 b=CeZLBwfyIMB4NiztwdlDlwWiNH8On0krb+eLh2jlwWeK4xjZwWok4V06o4xcFYdDYS
 4xzGWAPGEQRNHa/oymyFpOC5OpbCiO/DDh9KIU2Cf1GrcxwLTRUYsDArTAY1yLOD5WVn
 +RIcAD73J8Welr7CX91ix/GZ98YNktZkq3CMsCL/wp5EdW2twnHksxBL/bC+jX4l+3gQ
 B85V0brxYwlXkJ4M7Bh9vFVMjtl0tS91cNJSaiTmDHImpRdr8cn3e2GjC/AdaJ0CqnVh
 ciNaqSj67nlr1+hdOeBaYBD4fsseC94RXBoJDtudeJn7lDi1dFpjtz1vtjfQg88a0nVd
 bDdw==
X-Gm-Message-State: AHQUAubzHiAaLbKD4ZregxhUfBK/IyEpjChWLMpI0+F7T6rOFlAZ5S97
 iRKjUedBb/4kWlqAdWSAaxU=
X-Google-Smtp-Source: AHgI3IZ3YDqNq/2AQaMYe1kJv8UXjv+MSl9KMteeI+5/4URxr44WhcfQlK15lXqYlYzWYBQFLK1FQQ==
X-Received: by 2002:adf:de83:: with SMTP id w3mr5951635wrl.56.1549876916755;
 Mon, 11 Feb 2019 01:21:56 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:56 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 7/7] ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano
Date: Mon, 11 Feb 2019 12:21:13 +0300
Message-Id: <02be41b6187d4d1fe09bff24cb93c2400a166803.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012200_491398_42273217 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Lichee Pi Nano board has a Winbond W25Q128FVSIQ 128Mbit SPI NOR flash
connected to the SPI0 controller of F1C100s SoC, via the pinmux group at
PC bank; so it's bootable.

Enable this SPI flash.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index a1154e6..52a29be 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -24,3 +24,16 @@
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pc_pins>;
+	status = "okay";
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
