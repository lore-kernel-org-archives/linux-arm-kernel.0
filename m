Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:46:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19F12147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DU5vpyhS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="jenRUwhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19F12147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ncentric.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=z5iCEnN2PPB4okf9ukAvgM1m3brTdFRiKKErmUEy6Fk=; b=DU5vpyhSq7ljBaQPeXvTDw70Zj
	Njq97ACV0BX83MC25Kdp/MHJezQ7tBR4XpFaxM6EH9nTKwypVPxlOFv1pEDWm+kOunMmtUMEV1iWU
	NL5UonALAuD/IyjaRduSqhs0COWl77QtsQ+CUz9OMra3mwaunhkwd4pUOtKt4WPDKRpt9n3XUtxND
	PV4pxOb7I2QBHL93zBi8q4ph38EaS+9MXCjYmy+HXAae6opBaxinnFJ+JrYh+Xu/Fpt0x87hEjuw7
	X6sKaSbeQLShLGuUgfPwhtXgUm7j2R0+2HVDf24UqyZkOq+pRfd0PoKsUmW+MqiVJ6hHO8hbOFnsM
	SdkEqtHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggVEK-00087a-AR; Mon, 07 Jan 2019 13:46:12 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggVE8-0007yc-0t
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 13:46:01 +0000
Received: by mail-ed1-x541.google.com with SMTP id h50so925276ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncentric-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b2DAOrsaqCpd7/c8SqsFrjOiq3UmHX0O+L9w4u3BsTM=;
 b=jenRUwhyHvUWELIvIH+8BYorQ0IClHpOHqijBtjNPwjd5zYHPLoxKBuyGMbWIXUuA+
 YDH+9xih6RaHmuPbHGYPQDqXvJLbCyo+Jruc8QGAW11FfjEcwfPeC28bhCgKDuQZtDuD
 lAnQwB1DcB4fs5ts/UB9RXYYQnb3liquKTJj4NTQOXVJChg8T4Cgk5GdUzKxwZmSRz4G
 8UzjOQ4exCXjo/bcCvK4rNAetCfLx/xDE1e5ldO69DqU0iJDCm3oj5LQT0DXkeGRcnvB
 Cc+SVqXwcLgkPq5gJKq2pbF1gcPb5eOwS+TyQScfS12yOuhzgMNSwXRawygQO/Ktq45w
 o4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b2DAOrsaqCpd7/c8SqsFrjOiq3UmHX0O+L9w4u3BsTM=;
 b=cjoFfKItbhdhbj37HQxIygsEc8sGDY0KD6q5rARqGD7VhSeyeR6LtrUwam/pq6OcHO
 6Ir6+5SHDfqa7lMDPCtf/OJAkl73QOeHOVTh9uJ36xWyPtJuuGJkxmvgW9nMhPs8fSLV
 Ithlh20luZtC+9k9x6FHinM6ay9HMn/rt9IvUnJZOu96hdCzmRZjwCtl+u7vdM1sRo9p
 PofI2Y+EBkBBTTG2xbS3mFLMej10KBqzKb4Gcvzm93puzRNS0cEYA5l6lKCt2Tlnnr+g
 URLGLDrml7xn1ooMYbyasfsUFG1hn28vMv9IxsPYh+S9LgWCP+oZzsSTuJm6sCR+yADn
 JW8A==
X-Gm-Message-State: AJcUukfBXNKhDXbsEJ2PRg8UmJX52jZDa19++6Y5wmD5xYE7WHeafyxU
 1l1hh+4Qgn7oE9jjESmzwpPav+dwTXA=
X-Google-Smtp-Source: ALg8bN6G5eKBh+PZUJ6qp7Q7aqCNOoPkrOuvt4eUW7pAr0qgzvCo5/nNidyT0WQ/OjRF1KxI+fq2fg==
X-Received: by 2002:a17:906:938e:: with SMTP id
 l14-v6mr11121227ejx.246.1546868755214; 
 Mon, 07 Jan 2019 05:45:55 -0800 (PST)
Received: from kvdp-BRIX.cmb.citymesh.com ([91.179.126.85])
 by smtp.gmail.com with ESMTPSA id n18-v6sm14017427ejy.17.2019.01.07.05.45.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 05:45:54 -0800 (PST)
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm: cns3xxx: use actual size reads for PCIe
Date: Mon,  7 Jan 2019 14:45:10 +0100
Message-Id: <20190107134510.32494-2-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_054600_061232_67E2DD75 
X-CRM114-Status: GOOD (  18.03  )
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
 linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Koen Vandeputte <koen.vandeputte@ncentric.com>,
 Olof Johansson <olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
reimplemented cns3xxx_pci_read_config() using pci_generic_config_read32(),
which preserved the property of only doing 32-bit reads.

It also replaced cns3xxx_pci_write_config() with pci_generic_config_write(),
so it changed writes from always being 32 bits to being the actual size,
which works just fine.

Due to:
- The documentation does not mention that only 32 bit access is allowed.
- Writes are already executed using the actual size
- Extensive testing shows that 8b, 16b and 32b reads work as intended

It makes perfectly sense to also swap 32 bit reading in favor of actual size.

Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
CC: Arnd Bergmann <arnd@arndb.de>
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
index 5e11ad3164e0..95a11d5b3587 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -93,7 +93,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	u32 mask = (0x1ull << (size * 8)) - 1;
 	int shift = (where % 4) * 8;
 
-	ret = pci_generic_config_read32(bus, devfn, where, size, val);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
 	if (ret == PCIBIOS_SUCCESSFUL && !bus->number && !devfn &&
 	    (where & 0xffc) == PCI_CLASS_REVISION)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
