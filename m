Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:19:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F93B2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CgkGPat8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ncentric.com header.i=@ncentric.com header.b="URdfapA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F93B2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ncentric.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=3SmSeXSUc6SnL/CQ03FsKZHpmxyGfnun3dKnmiaJd40=; b=Cgk
	GPat8pyCN79iB/CVkqZfUFiSBzB+R+bpP0se6ohc+0AOPZRbY/euEEvpn0KFh6bqQSaIpAKyKNw8i
	H6HSrJHsicNNU+auHwczO2mLw4A/ZTHhObnO02PSh03uE03sbtVxMGuWsrpOe/gTkQdxTw/We8YKI
	4JJAfurys/eW1N0QpWJVfhmnDbhsJnJ1d3lmQ6dwAwXv8ScGThW1dBnDTJLSml+u5CK6DNFbvFWLP
	/PLYiJWnPkueO3DS8piR2DCjWtc3SAzEj/JTgxe4CswlwxgoTb6JP+7YsGWsQOyLQg0dHP1x7Sg9q
	sykcflC7N2dfr+OLesiuIQ7rCx6qNsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDPU-0001wq-He; Tue, 18 Dec 2018 11:19:36 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDPQ-0001Pb-Gj
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:19:34 +0000
Received: by mail-ed1-x544.google.com with SMTP id y20so7400058edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncentric.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WccfuiIQn7rI3zDEnjsIXhThwrpIFvI5yb/FbJQAKl0=;
 b=URdfapA4W5d/UCB3fyrGMSG4U77ysqpiU4Ojsg5XdJt+/gsUROTUmWBFkWMzMnJRce
 CNZ5ETp8LHIyuEwWOEGakKVlxI65qT7RTZIHdtS4TOnG2dDjc4S/ONi5QLrjc25POp6I
 9aIWu1fBGuW3M64Ipj05GXlPRtkCBHjoezgxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WccfuiIQn7rI3zDEnjsIXhThwrpIFvI5yb/FbJQAKl0=;
 b=n9Rtc/Lv5Q63jPEDpM96qPhdkRJMUPw+D1y99GpwhVQBezjZZdko0C/3tVoa+6Htzb
 khPBXXugGybB6CBt3E9GWCnZXvZoSluN+viE6saEqPH3n8/YmJiXI8zulE84qQBeMlK7
 MrAiSWFhPMdz7yo1oV2qiDh4SsT4LugmuAigLzU3J1wzSWZkTHuppXE+BeGlUCQlzgnW
 +0ym9TUQvAnp6fo2gMPIjIanPt67VgfgLuwT4cqKOAaEL39GlT7YIB9wEHBUhaNLy96n
 nHGLxkvzomBUb9jtxuZDZRvCdHQFf+QphJafTBE572p3kDPnm7+NC3vK/YT00AFoSU4I
 nKzQ==
X-Gm-Message-State: AA+aEWY2/0EapZb8D/D4sh6wE1EI76DmplOEpFXBn7SsgYDPpNerW+W8
 a9ltL6uCRaU7eywBlC3oZHk0xYBjQVo=
X-Google-Smtp-Source: AFSGD/U4DvPQP8styCFHhrtDoYeDGRMyd11pYDkxG/KnpBL4ZgOOSnpHZYhD5A2R0i8icHiNCdQLkQ==
X-Received: by 2002:a17:906:351a:: with SMTP id
 r26-v6mr12795356eja.193.1545131957664; 
 Tue, 18 Dec 2018 03:19:17 -0800 (PST)
Received: from kvdp-BRIX.cmb.citymesh.com ([91.179.126.85])
 by smtp.googlemail.com with ESMTPSA id g37sm4550086edb.85.2018.12.18.03.19.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 03:19:16 -0800 (PST)
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Date: Tue, 18 Dec 2018 12:17:43 +0100
Message-Id: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_031932_705954_AE30C957 
X-CRM114-Status: GOOD (  19.02  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Robin Leblon <robin.leblon@ncentric.com>,
 Olof Johansson <olof@lixom.net>, Krzysztof Halasa <khalasa@piap.pl>,
 Koen Vandeputte <koen.vandeputte@ncentric.com>,
 Bjorn Helgaas <bhelgaas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Originally, cns3xxx used it's own functions for mapping, reading and writing registers.

Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
removed the internal PCI config write function in favor of the generic one:

cns3xxx_pci_write_config() --> pci_generic_config_write()

cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
while the generic one pci_generic_config_write() actually expects the real address
as both the function and hardware are capable of byte-aligned writes.

This currently leads to pci_generic_config_write() writing
to the wrong registers on some ocasions.

First issue seen due to this:

- driver ath9k gets loaded
- The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
- cns3xxx_pci_map_bus() aligns the address to 0x0C
- pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)

This seems to cause some slight instability when certain PCI devices are used.

Another issue example caused by this this is the PCI bus numbering,
where the primary bus is higher than the secondary, which is impossible.

Before:

00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 255
    Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0

After fix:

00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 255
    Bus: primary=00, secondary=01, subordinate=02, sec-latency=0

And very likely some more ..

Fix all by omitting the alignment being done in the mapping function.

Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Krzysztof Halasa <khalasa@piap.pl>
CC: Olof Johansson <olof@lixom.net>
CC: Robin Leblon <robin.leblon@ncentric.com>
CC: Rob Herring <robh@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
CC: Tim Harvey <tharvey@gateworks.com>
CC: stable@vger.kernel.org # v4.0+
---
 arch/arm/mach-cns3xxx/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 318394ed5c7a..5e11ad3164e0 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
 	} else /* remote PCI bus */
 		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
 
-	return base + (where & 0xffc) + (devfn << 12);
+	return base + where + (devfn << 12);
 }
 
 static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
