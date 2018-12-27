Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A316E214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZHmgdiQJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S5zyFKbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A316E214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b/JyOdh8Dc7Z6rj9q5qkTWuy/IxSTzZDTnMURxuaMyc=; b=ZHmgdiQJtcJhm2
	EfKdIG686q+mFX7gqhxMh+alRZwgiaVut9/1z7RMrUtdHYGHOdN5ARtvBL6Ow6V22t+P0RDr2VrUs
	dcDZXkd0xo2FLxo8UuQ7Vth0RxAJQfB7y7lF1gj28vLBjw0PpFcdiiUslIOTTydObZgow18GsTTbS
	jWdL/0n42bdvdBHVeKscn0X//852GjwkbYHhke8Bp3tIpBxfV1a3hAlWVF4frCrPYGnvxgLgPhjiw
	hRX8bIaFh7QgY57uBF7s6GfmtUVVk1EtBwF64gqasuFmNVfN9/liDNXn0A7cSCJrUyTolhS017U8d
	mY0ICiXK2dKr5WAs+yDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcOxT-00087c-8D; Thu, 27 Dec 2018 06:15:51 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcOvz-0005KT-QG
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 06:14:33 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6E2Ud077503;
 Thu, 27 Dec 2018 00:14:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545891242;
 bh=KotTqQfhijDOPactJyxRFTQKuKTL+hLoGVA66ru3C0w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=S5zyFKbvAdiWjuxDAOr4DgG2JkQdmzp8CPL3wLYwNxJcGkCvUoHxs3fBi1u6j4LJ2
 wnBjNXxKp4hJqpN0+1K25CDgg2fub0OOLxbvdHiayHM05nV3QlsrQY/2KBmSnY3QFz
 haI23X0S9jmbhrD0l9etkSWsaRYQG10ll6U4ErHM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6E2SH060161
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Dec 2018 00:14:02 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:14:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:14:01 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrF026064;
 Thu, 27 Dec 2018 00:13:58 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar
 <ssantosh@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>
Subject: [RFC PATCH v4 09/13] genirq/msi: Add support for .msi_unprepare
 callback
Date: Thu, 27 Dec 2018 11:43:09 +0530
Message-ID: <20181227061313.5451-9-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227061313.5451-1-lokeshvutla@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_221422_095262_744920ED 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an optional callback .msi_unprepare to struct msi_domain_ops.
This is used to clear any effect that is done by .msi_prepare callback.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 474490826f8c..f35dd19f6c69 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -239,6 +239,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*msi_unprepare)(struct irq_domain *domain, int nvec,
+					 void *data);
 	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
@@ -319,6 +321,7 @@ void platform_msi_domain_free_irqs(struct device *dev);
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *args);
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec, void *data);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb7459324113..1a1738690519 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -312,6 +312,16 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 	return ret;
 }
 
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec,
+			       void *data)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	if (ops->msi_unprepare)
+		ops->msi_unprepare(domain, nvec, data);
+}
+
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *arg)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
