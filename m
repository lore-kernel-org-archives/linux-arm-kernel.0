Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67140C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F07F20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V/YS6gVs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fSU3tUEV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x62GVg5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F07F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LsStXSQ+rgrfGNxyH0k47mThLrKapDYtXhprJ1+Smzo=; b=V/YS6gVsgvWR3S
	JrXnLblO7PijerIzYWOsV5uJN4k01485JceO0MmLKi3FXuTZl2YG5UEO1me7D8Zubp/J5e8ZbIbVc
	/LXlgWhTmFzMFCM/BSym1+SqPg1yo5AptDjXSlqWCxXIJEtX00ft6SaH4gJEsSPnx8/ub6BVgOdBg
	3Zj0av/tDBTUfeUQwjoHh1pphKIpgUSIUAIMyTNN6Vo4K5iAlvk80c355f+b9DnMaEA4jrIWSJIHl
	/kXaofm4JyY+lmv2uonLdOSbthWmTvZST0lP+uhWpYNRGVUPEHuBqbDWHfIQroYGC9b01GkLNV+lB
	0HfVo0YeVrbM/kDcbOKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2x6-0000m1-PJ; Mon, 14 Jan 2019 14:10:56 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2wu-0000Zz-Vm
 for linux-arm-kernel@bombadil.infradead.org; Mon, 14 Jan 2019 14:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRUr73ZiS5aNXYVmbXRtJ0JSqktNkC+89EIMn+yRODs=; b=fSU3tUEVzGSYkxkYj7Y/4QtMD
 6vohj+rHGfV3IQwx1xFWbF9KmQjhAdBz3/kV0ak5i4Im4KNhIIxpzVCunv+1z4hDAwaGthJzQiw/L
 KlfgV7kYx7Evk5CbNZpVPFsnNRz/jyvg3fVXd4xhdIBNHHzaGRR9R5m/7Go4sjD8w9zFRPOeI3YDg
 l8dZF3zJRnhYrqZbhhxK4PKnu0cpdMma6lgXB4xp4NPn/7/dr9AYgZNL3x2WL7xwm07UNVFMDiG/H
 seFmUmGc+Pg/1U9/qDaqmzSkr2F35yytvj5uxO/UEzZDozXeCoBOJne570hYm3WXliBcpWE016U3g
 Y6lo8nBZw==;
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Gb-0005G6-RR
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:27:05 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDQqpT098392;
 Mon, 14 Jan 2019 07:26:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472412;
 bh=yRUr73ZiS5aNXYVmbXRtJ0JSqktNkC+89EIMn+yRODs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=x62GVg5YvVaKS6/uQKvz32FziutO1EpLH1sHg6A/rpxXMq3mevZ1inmhKQVsln9/T
 zFWfOSPhII8wq3ipSpFNcWpkF1tuA5CniQ+QisLkL2tmYtu7bfsoCLQSabBooIlHQc
 Hw2bPkVvwVqx8Aq3vY5VNoXGdx96oEqWf/bcJGJQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDQqKK057603
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:26:52 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:26:52 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:26:51 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWk028516;
 Mon, 14 Jan 2019 07:26:48 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 24/24] misc: pci_endpoint_test: Fix test_reg_bar to be updated
 in pci_endpoint_test
Date: Mon, 14 Jan 2019 18:54:24 +0530
Message-ID: <20190114132424.6445-25-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082701_993070_01903982 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

commit 834b9051992580ac8fd3966d023b ("misc: pci_endpoint_test: Add support
for PCI_ENDPOINT_TEST regs to be mapped to any BAR") while adding
test_reg_bar in order to map PCI_ENDPOINT_TEST regs to be mapped to any
BAR failed to update test_reg_bar in pci_endpoint_test. This results in
test_reg_bar having invalid value when used outside probe. Fix it here.

Fixes: 834b9051992580ac8fd3966d023b ("misc: pci_endpoint_test: Add support
for PCI_ENDPOINT_TEST regs to be mapped to any BAR")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 6dfaeeaeec0a..46788fe854e4 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -670,6 +670,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
+		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
 		irq_type = data->irq_type;
 	}
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
