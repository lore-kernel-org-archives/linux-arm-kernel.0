Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70283C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301F82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O94ZXLzJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5QwWQtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bGvBqgrbMyv3VUTGouMujPzclQy0eJxOFe032harC9k=; b=O94ZXLzJwa8Pse
	nmjggGn9h3KiVtcITXCVSLwg2MEDUokdYFMloutBjm0uq0kDtiYzBk8g+uETHFeaXytzS4slKI907
	sa7B3Vv6hLfbk9Fa/wracycEahILHvr9zvzNHJKv0zVvOXeifWHIlmHsqS19GHLVu8kMN58kI5iF5
	52N/8994Zn/zh/jQpMjPmWsVMyvcZ+xZ+Vuf0ukj5jPuowgUzo7+ykjpLSAPqfEAhVEBv7Ycjg7Qy
	VO3XLX0lsLP/kdPF8dHq+hdZVvx5spHjaMFjDQilS5UV9LF5Rx/RAvvemv4TOFeHGRFKNgcm1bJLy
	dCTXZoRq5tkh+uduuI0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXYV-0000RW-BN; Fri, 18 Jan 2019 17:03:43 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXb-00088d-Oz
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:02:49 +0000
Received: by mail-pf1-x444.google.com with SMTP id i12so6873555pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=d2rQCukECTJQilTnrmqyIouQcxujlVs0VqTurP7Vfgw=;
 b=A5QwWQtkeb+gp7/yUDs3PgOjwdsSvVocZkMnIO6pMCwJ5rIogQA2WynHjNSJybVTpv
 fGaNbgySGaTW9HkRagV5mvKiUc/us/gswoj0v3zFk4ck/dfgA+gPKH9HR8oPewgohIVw
 sXhMOVgKNLmNLYBd5aoC1exj1/60VA0sVzRrgBeKi3I9mJZyar7u1PxiRrNF38BB5aXz
 s9H250UhEBbnO7vq5O/91k5wbMwYdp836OntanmubH3y8xaQ9z1+qRdIPG6TwK2SD3m8
 bxoVb8Ssqt8IlA8NBxcI2C6bP2kC167TgSk6tbvYj65dFeH1pK0nLPXtp/DFFVDI4h+7
 ppRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d2rQCukECTJQilTnrmqyIouQcxujlVs0VqTurP7Vfgw=;
 b=pYg0DJ/UoiaR3dWoJwD/ibnanoz/cWdhlD7J0OpvqJlXJnAGqxIFvs8FsV8MHUKZrV
 4eQkMGz5nRsEvmzZ4S/aaiTv2fTKacw3Te2W2i6AeQKUMr1xKnDZnNHl2u6oWYrGZ5Gr
 qgqOrFfVM/J9pc7MwU8qwg1KaoJKB/LLzMc8Z29NKmFPsT7DQzoQkspd/BHS/ShEwTy5
 Lg0W/cNC33Z1OMI8CMiDSVR8ASyrbhAiPhheYaM788/vSeUVNDLtt8YXisQEs11osTEg
 TzWmF/edZD0LqmiHXKhn+vf3DHVk4VHe7Qx8HZkh/sl+7PyhiZzO8n/7bKkzwFDeuePU
 6XJg==
X-Gm-Message-State: AJcUukfmnBrFfr0y7Y8M02/mAT3Uvj8rzUDAfxMhPAtL4/sO9XzadZKx
 4l+WQH7pH17t13Jr1Q7fRlc=
X-Google-Smtp-Source: ALg8bN6nIPP2MNX0kxfvTje18iThnYwjws4PFr2ea4/zP2x8dsfJDv2hBo/BuhJSO8QS/crgw7j5kg==
X-Received: by 2002:a62:1212:: with SMTP id a18mr20702116pfj.217.1547830967166; 
 Fri, 18 Jan 2019 09:02:47 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:46 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
Date: Fri, 18 Jan 2019 09:02:27 -0800
Message-Id: <20190118170232.16142-4-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090247_806724_F9EFE08A 
X-CRM114-Status: GOOD (  13.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add binding document for bluetooth part of RTL8723BS/RTL8723CS

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
new file mode 100644
index 000000000000..8357f242ae4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
@@ -0,0 +1,35 @@
+RTL8723BS/RTL8723CS Bluetooth
+---------------------
+
+RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
+BT is connected over serial. It speaks H5 protocol with few extra commands
+to upload firmware and change module speed.
+
+Required properties:
+
+ - compatible: should be one of the following:
+   * "realtek,rtl8723bs-bt"
+   * "realtek,rtl8723cs-bt"
+Optional properties:
+
+ - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
+ - enable-gpios: GPIO specifier, used to enable the BT module (active high)
+ - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
+ - firmware-postfix: firmware postfix to be used for firmware config
+ - reset-gpios: GPIO specifier, used to reset the BT module (active high)
+
+Example:
+
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+       status = "okay";
+
+       bluetooth {
+               compatible = "realtek,rtl8723bs-bt";
+               reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+               device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+               host-wakeup-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+               firmware-postfix="pine64";
+       };
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
