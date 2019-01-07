Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77CCC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AC120859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exPdpqoe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LIEitCVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AC120859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fcUpij7WgtxCQkQGrv7FaXTBI+batHgDs6ZVU9orE7g=; b=exPdpqoejXXYbl
	O+4Z+RjFlshMXK2atv/uAaSi9Il/IH/YIpejdj239ZrhhqwumBXmV9D1jXhOUmCMicsY7CQ0ziDS0
	aPwclql+FrisZ2bzSiWufnhVbMFnt3UzyKpA0IBj8mqKTmKXgTRbqG69S4ItJJfBPshx4Q8YiuRuJ
	4vQXRPFz9Fm/CstL54gbLx8tW+RAQYLFWsMXQUSbyx8KnzqEP6jNjJBQCF8PHZqujYB7FKFAZbiWn
	H8OqMw5P1bxW0RDgrjtFWiOMZIxbueP+p++j8BUgJyFHNjqfhPDbBZoJzXzwbqa03b5SZC/gI13i/
	kqIcRlrllsS+bbgjtMrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRb1-0000Gb-Qu; Mon, 07 Jan 2019 09:53:23 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRaw-0000EN-M4
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:53:21 +0000
Received: by mail-ed1-x543.google.com with SMTP id f9so233709eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TwNcnlR2Zn4hx3zkp8zOAgTjAGZi9ae85weLFJBkyP0=;
 b=LIEitCVzeGyNf86Fl8b2Vwm+G6NGMcmlBiGs+LsMCMl6c66/sSyIERhJbRxiuYP0DV
 jvd2cWiEqyWr+OEJQSUoj37pyx5SK7qkY0geSbCun+Mtp7Fi35MYq/sN36iLHFg/cTs2
 v+0bLqvRNTdgXblglg4JG4qbUOIBFK/DmmCxfX6IGBdMlTBMJpZcBwM4epwd4sv0luot
 FEzhXEx3kFdfnA1IrathqKohc2wLS/CMAL+QModrrApmv2EK1hMr5M9lJR0QJoUKkS9A
 ovWp3vS+6VbVtweR9c2wPvUNJWmUSBgNQjOnLIrb7qH9W2gC0u49bF2LFCf+wB92BSrA
 hdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TwNcnlR2Zn4hx3zkp8zOAgTjAGZi9ae85weLFJBkyP0=;
 b=ZAk9x09Gwwl1rldyuiDg2WaFprqkCx7/wYZMIhBZVND0hRN5c6reoxSXwZcdQvkUp9
 rOKe7/C2Sk/jz7PSrTG9Uev4QA7Ym1g5Ll/qGI+JvdtXM7+UBBHsut7UTh9a2cF/LGmx
 gYxsogTCB+QYH5fcU5SAhr8x+EVG5dosD4S3g2zLCQFA9urhctBexNH3EFo4M16SFkXB
 qNX1jBaPpNH12yW6xme3Agj2BeeOLlqvr+I3ngXDVmZilGSMVpUAhyhneqisDKJz3mon
 XWw27Eu72UA2GWBe8IpELsKkp3EnWx8rFOdNrYmpqtM/7UVL0vq40BX5bl1ADTur8gIX
 DBaA==
X-Gm-Message-State: AA+aEWZYYcaM7fSCucPbtEXn0LBnQH8cGp/ZxyIA7puc8vsBwMV6w83a
 d4WbrstV+4dMGxtO0si8K/dvfw==
X-Google-Smtp-Source: AFSGD/XJ8bv6nFQ7jL654BoGNZYlp7hkrUW5waa2vPSjfYe3uWQgHBULUvUIEI28oqmrSyj8rtJiag==
X-Received: by 2002:a50:a642:: with SMTP id d60mr56230877edc.290.1546854796428; 
 Mon, 07 Jan 2019 01:53:16 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id f6sm35737049ede.53.2019.01.07.01.53.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 01:53:15 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: meson: add simple-framebuffer nodes
Date: Mon,  7 Jan 2019 10:53:05 +0100
Message-Id: <20190107095307.15233-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_015318_783179_3144CBA2 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, Rob Herring <robh@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for simplefb for the GXBB and GXL chips.

simple-framebuffer allows sharing a framebuffer already setup by the
firmware to the kernel for a seamless boot transition.

It goes along with a u-boot patch series adding display support to
GXBB & GXL that is not sent yet.

Changes since v1 [1]:
 - added cover letter
 - added simple-framebuffer compatible fallback to the bindings
 - Updated node names and removed the unit-address
 - Consolidated base nodes in meson-gx.dtsi
 
[1] https://patchwork.kernel.org/patch/10720879/

Maxime Jourdan (2):
  dt-bindings: meson: add specific simplefb bindings
  arm64: dts: meson-gx: add support for simplefb

 .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 22 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  6 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  6 ++++
 4 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
