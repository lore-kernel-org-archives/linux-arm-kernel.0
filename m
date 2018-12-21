Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:03:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9357206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HV8MiGH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9357206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7hNvWMOnrh1Ofk01wGk10DSntVBf4kV7zVDshFfkSc0=; b=HV8MiGH36oYki6
	tTjXfIn2n5iA2SmRKo4E6nHgNLd/s3PrVZGkCYoBSMatBMKxBcsqHXVA0+Do4FLgpodeJ5OVrKNum
	1OAAQ69F0izmORf+rRN2IV6Hmb+OwI5EEdNI6UIuN9mOnG5E3DPxF2/vdgsxUZ30FYG2EHd6hCpLL
	zaHC91O/0XQXbjQYD/flrtILZan8Aboo5hjrhfDybHuuCJNOFEpnp1AHXu+SCoR5Jtfni4sOtLDbY
	pi+kIQfKvDlv4nGZwDD6Pu6D8bDeQexQGmMUBeSyubvI6oY/hMVoR+IKQf1jqZXCzwUTxVYSwGZeZ
	MJ6E01SsILapjeyuWmqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIaE-0004lA-Dy; Fri, 21 Dec 2018 11:03:10 +0000
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIaB-0004E0-4a
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 11:03:08 +0000
Received: from macchiato.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MRocn-1gyjJu2X85-00Syg4; Fri, 21
 Dec 2018 12:02:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/1] arm64: dts: marvell: mcbin: reserve PSCI area
Date: Fri, 21 Dec 2018 12:02:33 +0100
Message-Id: <20181221110233.6074-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Provags-ID: V03:K1:zRyIB963pI6upUvrodlqGvwwiPZivxiQcJKpCvOeDc5E1GeN502
 L4tENX1yShBjFgFeof4iM9XDwAD6YkCLzvY0IxGx2rIQo0kls4Lv95uRHpv9MW3sSK0vh0S
 /8CMfMwzlGI2xxELF4q3pY7esBkoXLQpFNJXDcgKpJ52kfVd2kCKSMwKtyl6DrJ9HQqcs20
 mCYu7lLjd/Hdps8AzWajg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzCKXG/0C1E=:ztKAwScMcAlYBo0Be+EsUQ
 zi/5awDiHLHe6cV5fESMSM8eQg9py8X3u9nAaZYsI81HnfRxzEomxFmigqk6FJdvlrEPgh8wn
 jfB5wMOrW/mqrTBWz6im+AZaDPv1TV1c52L7dYEFxuxG+c7FwSNH+wcRCTME0ci0LXuoEAWPo
 +Xbzf5+4Eo6Q6I/aTxZkqkXxnJqZAWD+L+b34XsmQk0H4J6sKF99lOpzuJ3acRvhwCXBJ+ahp
 0o6yxZhrtvULh0+IYsCw1vyUnxax7XhVMEd6IaghAZpqYhOiBvpxTqcemdFcbwj2crAivGcvB
 /c5q8IgTOXfTVEs0LnUsUmkLmfiSsyOLYsj9a6adkDM6cToQWTIAMdg3+4tnGAsElB8UwbPfL
 hDCNYVqxR9jlVhyi+DnAfhjkyy66ljyEn4QcxdKxBXpBBw4pIJqfutEiWfB7hlEeQJOrdJGk/
 x04/QKaXDszitRgiXtzsTKyHsR0vgV5gqiSWxEbYfhiPj4IPc3UfcmK1ztIGQs53XIs65LTDS
 43GdfxYGOBk60VVnwNFnLCz3u8nJZ58YD2RzWTSPkIoGIWMH2V/b28FeEv/WkVYFsFvgurHn1
 MQj3JWpB0ZgkOauwQdWWY172gYjn6UYi38eDQ499UuH/ap4BaaOwNuQJWP1U0erkClUGp1UY6
 rVS8cEBDwshDHJ3VeUW0gGwsL4zPrr1qthVkT/g9yuHhUXjISwXopfWBWjbEXl7rOytmgGF52
 sl/HArBgj7Dc512c4D1jlichHN+/502y9m4Q4to7lMOZ5Y6Is9HJeUaJdO/SlcqS8cBrYWE2X
 I9fzOhhvb0EnNX4+ywyZERP/XRFhc4Knjgxc7hXaXgxXIuB9FNN0hPgecaHyIudyF8PVao3yr
 nRL97Gfq7Uf5A0qNA5lVcQH87PTZ4XzwChWdFddcw8oF+psHtOS3D5gUh1c++s
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_030307_489778_42C551DF 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 56fa44860909..18df1a321b52 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -23,6 +23,17 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		psci_reserved: psci-area@4000000 {
+		reg = <0x0 0x4000000 0x0 0x200000>;
+		no-map;
+		};
+	};
+
 	aliases {
 		ethernet0 = &cp0_eth0;
 		ethernet1 = &cp1_eth0;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
