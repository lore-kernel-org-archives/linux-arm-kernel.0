Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D36C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E26218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hxe0JhR2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/fRFzCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E26218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nN1r8v5G19mfnYLPEElFB8z2wrdPxR3tWHdOy9TZees=; b=Hxe0JhR2bUmofA
	ImJKSbWxRneQ88a+acymLLDZbIhQCzKu5uBNSPzb/9OMIhH3x9WYCtcxEUdAI8i7A4y7/iaJ/IRvL
	bn16xYE7X0odtO+ykfUJhmLYZ4ppzu7wp6usacSTl83H2ozr1wBpJ7NJLevirNLD5OHVojF529mNo
	T2iKUe4byEcwHs/+ekaqkqULpNHB5+3Z/22MVakW2rxd2KSPXHMiztgW7mJY22L4Yk5HEw8jmquk7
	DBBToBDG+Adr/xx7mXTuZzZxffAVAS6URs6oF5kWPqNYWnvjyJoNSY3HiPq1k83cBwyzjbTGYM35f
	K55PB1JNLCSBpRF7S8Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNQ8-00083k-SR; Tue, 18 Dec 2018 22:00:56 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNPf-0007Yk-GK
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:00:29 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so4116428wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tpqz4ACGIOtLM4HqS4NAXeXkX30klbBq1A6Ib2bKOio=;
 b=i/fRFzCTgNABf8zdGWGdJ9qTQ/YRneT6VnI104ffcCY6zdAhclR4fP95jE555PBLps
 pRay398khSraRt1yZZ8zJ6habJBovOhERqypu2StNAVRl74nbo8PlIqYoNRzTCtohesr
 7ICA16Yva22BBhf51cb4PWBT/c3oexETyhDFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tpqz4ACGIOtLM4HqS4NAXeXkX30klbBq1A6Ib2bKOio=;
 b=GhJgxhFEXdWqPh8n2vQE/P0iwHr4tKqMORue0UA088efo92vv5fxhEV/jjGUFzZSVB
 f54Te5g0FeJ8yG+fE2QgwDTAN4DqnXKZS7riwt1oQFQOvUGJEx1nEyUtBrjVICnbD8xH
 sGKms/aQAcIPkrigX2Tw8MoIa7Sqs1kZVejQkgljVrexIvgxCy1qSqeDo/xGlT8UkLaO
 Azu+X2JeyCTYlLReSmwhkDL3/h74I9ljJZjAlob5riUG6hL2Rc7tmnXROrLvaAGEJ72Z
 BEWzcV1kRxP+A3e7Rzj4blAyf2cI9vW0YH860qHanU5lKRjGJZuBXCca/nKYjQwB43OO
 KfJQ==
X-Gm-Message-State: AA+aEWbI2/cRSjR/uTDKXR1AEoXI4RXdty37QDIEv37pGMTL144JIbHc
 xg3Z9+7IwltHJvW5COFa7tM4Iw==
X-Google-Smtp-Source: AFSGD/XGqQa/47C1JIyzz/90+j3qqZEISzVf1TBSTnjSwndxMV7uaEOwg/pYgvvJEWGxhsjQb7SPbw==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr4805082wmd.36.1545170413140; 
 Tue, 18 Dec 2018 14:00:13 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id x76sm7449158wmd.27.2018.12.18.14.00.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 14:00:12 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org,
	linux@armlinux.org.uk
Subject: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
Date: Tue, 18 Dec 2018 21:59:43 +0000
Message-Id: <20181218215944.2444-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181218215944.2444-1-mike.leach@linaro.org>
References: <20181218215944.2444-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_140027_541514_2BBD6C90 
X-CRM114-Status: GOOD (  19.41  )
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
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CoreSight specification (ARM IHI 0029E), updates the ID register
requirements for components on an AMBA bus, to cover both traditional
ARM Primecell type devices, and newer CoreSight and other components.

The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
cases to uniquely identify components. CoreSight components related to
a single function can share Peripheral ID values, and must be further
identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
PMU and Debug hardware of the A35 all share the same PID.

Bits 15:12 of the CID are defined to be the device class.
Class 0xF remains for PrimeCell and legacy components.
Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
at present.
Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.

The specification futher defines which classes of device use the standard
CID/PID pair, and when additional ID registers are required.

The patches provide an update of amba_device and matching code to handle
the additional registers required for the Class 0x9 (CoreSight) UCI.
The *data pointer in the amba_id is used by the driver to provide extended
ID register values for matching.

CoreSight components where PID/CID pair is currently sufficient for
unique identification need not provide this additional information.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/amba/bus.c       | 45 +++++++++++++++++++++++++++++++++-------
 include/linux/amba/bus.h | 32 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..524296a0eba0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -26,19 +26,36 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-static const struct amba_id *
-amba_lookup(const struct amba_id *table, struct amba_device *dev)
+/* called on periphid match and class 0x9 coresight device. */
+static int
+amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
+	struct amba_cs_uci_id *uci;
+
+	uci = table->data;
 
+	/* no table data - return match on periphid */
+	if (!uci)
+		return 1;
+
+	/* test against read devtype and masked devarch value */
+	ret = (dev->uci.devtype == uci->devtype) &&
+		((dev->uci.devarch & uci->devarch_mask) == uci->devarch);
+	return ret;
+}
+
+static const struct amba_id *
+amba_lookup(const struct amba_id *table, struct amba_device *dev)
+{
 	while (table->mask) {
-		ret = (dev->periphid & table->mask) == table->id;
-		if (ret)
-			break;
+		if (((dev->periphid & table->mask) == table->id) &&
+			((dev->cid != CORESIGHT_CID) ||
+			 (amba_cs_uci_id_match(table, dev))))
+			return table;
 		table++;
 	}
-
-	return ret ? table : NULL;
+	return NULL;
 }
 
 static int amba_match(struct device *dev, struct device_driver *drv)
@@ -399,10 +416,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
 				(i * 8);
 
+		if (cid == CORESIGHT_CID) {
+			/* set the base to the start of the last 4k block */
+			void __iomem *csbase = tmp + size - 4096;
+
+			dev->uci.devarch =
+				readl(csbase + UCI_REG_DEVARCH_OFFSET);
+			dev->uci.devtype =
+				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+		}
+
 		amba_put_disable_pclk(dev);
 
-		if (cid == AMBA_CID || cid == CORESIGHT_CID)
+		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
 			dev->periphid = pid;
+			dev->cid = cid;
+		}
 
 		if (!dev->periphid)
 			ret = -ENODEV;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index d143c13bed26..8c0f392e4da2 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -25,6 +25,36 @@
 #define AMBA_CID	0xb105f00d
 #define CORESIGHT_CID	0xb105900d
 
+/*
+ * CoreSight Architecture specification updates the ID specification
+ * for components on the AMBA bus. (ARM IHI 0029E)
+ *
+ * Bits 15:12 of the CID are the device class.
+ *
+ * Class 0xF remains for PrimeCell and legacy components. (AMBA_CID above)
+ * Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
+ * Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
+ * at present.
+ * Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
+ *
+ * Remaining CID bits stay as 0xb105-00d
+ */
+
+/*
+ * Class 0x9 components use additional values to form a Unique Component
+ * Identifier (UCI), where peripheral ID values are identical for different
+ * components. Passed to the amba bus code from the component driver via
+ * the amba_id->data pointer.
+ */
+struct amba_cs_uci_id {
+	unsigned int devarch;
+	unsigned int devarch_mask;
+	unsigned int devtype;
+};
+
+#define UCI_REG_DEVTYPE_OFFSET	0xFCC
+#define UCI_REG_DEVARCH_OFFSET	0xFBC
+
 struct clk;
 
 struct amba_device {
@@ -32,6 +62,8 @@ struct amba_device {
 	struct resource		res;
 	struct clk		*pclk;
 	unsigned int		periphid;
+	unsigned int		cid;
+	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
 	char			*driver_override;
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
