Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D37C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C4A2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="apxk9rVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C4A2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iGTEkk0RU0ldXvQWddDCzxoN+atozy8nqfvP+/kCLgU=; b=apxk9rVzTHd//q
	vUfo3iHSq104YPMXl2BOi7QbNXvubm5YU+Vro2UJ+Qo4JuXsxbYqL6ENmN5viZMdyJEErwtmICewI
	AnIHpLKTwkQAfKTelqRqqLvaNABfSHMK0VQ+lwBJ3a+2cW43Po+jZFdJEoySPfxE8WckUsoEnILA7
	NJnmFUJBzw2gXd7iNJ8TYX3USnx23ZGEoPJi1SgkI2VHgd7/NBNZCJ+E7nwyXx8VL5NkA1HmuBSQB
	LbAannGB3BtIBK+9TQFZXxUqdL7m1e6UVExxeiFCzB1boy6ANTtEdqZfcy/FqA8GsPLo5QloS2O1v
	zU6gtNdwYlULfvwMFlFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfETj-0002Bc-Ti; Fri, 04 Jan 2019 01:40:51 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfETg-0002B1-Dr; Fri, 04 Jan 2019 01:40:50 +0000
Received: by mail-qt1-f194.google.com with SMTP id t33so38978400qtt.4;
 Thu, 03 Jan 2019 17:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=wT9chDbjHabejsC31dm/LWr/Az0apw1XM1hEQNEg7GQ=;
 b=qzD7mq/IwSoECIDnR6uKV1RIUPuCCbEfzY5bAsIHupTPgmdsmdJ+ZsrtQhwPD8B2Ge
 AKtfe2yXQinHQKubyyklqravgGEoTXm9BFGx+zLEBY45KJFkx8wtzMACYxpExuPgh+VU
 4Jeb9lh2kuJBpA/Uvgb2UCnMa/ZMTOSl3UNrlVnnMTre3iSZ4hdtF29o02lO4MxhrDz1
 xY5+3ordArXLIlfSV9iWQPYf3N6A7a6R4dljfTnZDXhdx9T0R8rWRnxR6RNE2uCHLUZT
 LRXc9KKPAwoH3/nt2p0e5C0YuV1TJwM5Bb2oZ0+fSWk8vtlAQcqZwnwih5IiMFcyFX1v
 MK3A==
X-Gm-Message-State: AJcUukdwb18BuiZY3HyyD258Eytk+1/do88ok24vN/Obo15WCfsDmGpv
 xnweL6XT4nLFKHR9kOQuVDC/BdRR
X-Google-Smtp-Source: ALg8bN5VqXa/bLXMWeIuMaIsPlIKOYFrNEeOfPegytnjMSwQGZ2G8ZZMgvOeWWPVXiEWjFTYLQr0UA==
X-Received: by 2002:a0c:a90a:: with SMTP id y10mr47631078qva.232.1546566046602; 
 Thu, 03 Jan 2019 17:40:46 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
 by smtp.gmail.com with ESMTPSA id z207sm23662928qka.57.2019.01.03.17.40.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 17:40:45 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 03 Jan 2019 23:40:38 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: dts: rockchip: Add missing dma-names SPI support for
 rv1108
Date: Thu,  3 Jan 2019 23:40:20 -0200
Message-Id: <20190104014023.17973-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_174048_472959_829DA638 
X-CRM114-Status: GOOD (  14.05  )
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

Pass the 'dma-names' property to the SPI ports so that DMA can
be supported.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index d31370ff28f4..cb26d9d98c34 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -207,6 +207,7 @@
 		clocks = <&cru SCLK_SPI>, <&cru PCLK_SPI>;
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&pdma 8>, <&pdma 9>;
+		dma-names = "tx", "rx";
 		#dma-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
