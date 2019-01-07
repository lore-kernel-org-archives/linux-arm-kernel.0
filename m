Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90826C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:46:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533402147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bTkCu7W+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="X3zuFDeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533402147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ncentric.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7RxaHc5Om4dX97Z42wsZEE2gOKJpitJr7wAKwT6KMd4=; b=bTk
	Cu7W+XHKlFWtH2+I2WnV+iAZzYx7HhwjEPDtkwvyKzOgU1ESOq1JOL5QFJQAoAFRXJ4QiC42ytGiQ
	oS/uEuWNcEDtRHivT/LPgbXkMscOTppBUYB6xZSlD+eeDNLEoUO7YgV3E6WLsoCBJj/EtoLY9bEfF
	Rt5UC1GNOt3SLiVdus97IpdBWUfZ/NwBy3XuCIQau5npOtzcKHWXjFJPJEahAHa1shdnULxJZPPzG
	VAR4keZKQL6iksrLcLuphC4jaVBkrf5HInqvxNfuSCj/vlZ4chhonBNsst5xCgmW215vCAVfRCk/9
	UAVI1OWVDauymLwgF+ifrfUIn1b+IDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggVEA-000800-Mh; Mon, 07 Jan 2019 13:46:02 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggVE5-0007ya-VL
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 13:46:00 +0000
Received: by mail-ed1-x543.google.com with SMTP id o10so884662edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncentric-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=H/7doH88Idi5Mj1ZDeX/jUMyy4ALq/yqhRpTL/yV0ko=;
 b=X3zuFDeWy+8epsUMtjXM9hyLwipEBvOZq9Yv7HdvSQ8JaFkuqWw0XtMMk/sqscOvc8
 fUdl8WnNSeC74T+J1wGDth2G7WEBglanCYsJCly2uKJyctNTuJQpyQwS2XituqayDEX8
 XFfQJv+HqdUBXfI4wO7YZjaAwYjlh+owvmMa/nRgD+0L754LBIg+2AzjY4UfB+JJg06k
 QvvgZ42stTXp3hl7t0OWUfYUWDDYxHmzn8dyyva5wl1SOG2bhLaEwU1QHDiEJ8dBc05m
 LpgvFk+SH+20RpSoWtjz4iYPnOV7/b3BqcCVghJKrtPM4hme+KHrF1OP+dRVyoCn36ef
 jv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=H/7doH88Idi5Mj1ZDeX/jUMyy4ALq/yqhRpTL/yV0ko=;
 b=MyCGqPFEvp87L9kAy/To/WIb8tF9GCiNrWsdW3RN32gFj1NBfxjHsE1uFR1iYqgGqh
 nD6dyRK7eQGSGEwRqgPtT9Z3MfGvVM+0TpUq5aTWhETx9zz2nJ6mxpn/V2DU56laHMD8
 AGyJqAQsLbfjroJbvXqVZdA5eL1YejzkOM0CUYmeGHU5409YnkNyWOD/06QFC63E8nBu
 NLCnhfR4MID65hmMuTXY4vWZJyDwyFGyH/bLj2ZlTX8y3ftmWo6RJl2/A+Ke7Yosw4YJ
 hO2iAsiMHLIKxGKvBhSYUafYy7FkniXKWDErYlWe1/wINqqxx4teee5F8p0Y7WTIVHUN
 +jNw==
X-Gm-Message-State: AA+aEWZs3UN4L0Jswt3n/Py/Vk96vDdbhzod3YGl3NO0xp/gr4edJd1C
 ucvJCtiPNwK/d7yB7SPGhpg2HQRJyyA=
X-Google-Smtp-Source: AFSGD/W6sdmsvnX/mA+E2rLxIhpNqS/0Tjf68WiZjIhzptzxG32xwbWNXXyNmcZu6bR4as/hM2KB4A==
X-Received: by 2002:aa7:dc51:: with SMTP id g17mr54978919edu.115.1546868754215; 
 Mon, 07 Jan 2019 05:45:54 -0800 (PST)
Received: from kvdp-BRIX.cmb.citymesh.com ([91.179.126.85])
 by smtp.gmail.com with ESMTPSA id n18-v6sm14017427ejy.17.2019.01.07.05.45.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 05:45:53 -0800 (PST)
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Date: Mon,  7 Jan 2019 14:45:09 +0100
Message-Id: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_054558_150900_FE0ACA33 
X-CRM114-Status: GOOD (  18.28  )
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
 linux-pci@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Robin Leblon <robin.leblon@ncentric.com>,
 Olof Johansson <olof@lixom.net>,
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
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Olof Johansson <olof@lixom.net>
CC: Robin Leblon <robin.leblon@ncentric.com>
CC: Rob Herring <robh@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
CC: stable@vger.kernel.org # v4.0+
---
 arch/arm/mach-cns3xxx/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


V2:
--> resend to be in sync with new second patch
--> added acked-by's based on patch comments

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
