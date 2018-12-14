Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED7C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:12:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6067420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jGS18/0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6067420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nnMFE1b3f8YpVGX7ZbpyQoX6lcfFuQOJ+sOa5n/BaGE=; b=jGS18/0L5+8eNJ
	ON70v1sNn2hlSCt/7dEtcp/z4qJPwMLN49CQHmy8v85qSnIxtZw9bYptmr4V18mjbnjeCN1uQLk6k
	8UIrwhX8a3ir3AA68YXcT54gcsdW538aLAuSLsFaJcALR2O8TNRpwomCvUFBAO9/o7J74q6G+XQYI
	7P5IDRc5Lz06tIALWi+BZKeZmb2beK6NsUtOTtp5AG1GdeBTz+eF1PmlnnYoP9m+k3jasjWAgfS8w
	h6/chhdEq224HatVyLcnuiwCdhu8R1Ydcjw7YtlOa6136umY5rqYRp5b5jukggQ1ZTIuf078gtl/Q
	7hF9tYz1K8RusW+hCf2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnG0-0000sr-OZ; Fri, 14 Dec 2018 13:11:56 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnFm-0000hw-9y
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:11:43 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5070771964F49;
 Fri, 14 Dec 2018 21:11:27 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 21:11:21 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 0/2] Support HiSilicon PCIe Transport Layer PMU
Date: Fri, 14 Dec 2018 21:10:53 +0800
Message-ID: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_051142_514869_B997CB54 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, Will Deacon <will.deacon@arm.com>,
 linuxarm@huawei.com, Keith Busch <keith.busch@intel.com>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a perf PMU driver to expose the hardware events for a HiSilicon
PCIe root port.

There are several reasons this is an RFC:

1. The binding to the PCIe port
2. There aren't any existing PCI Performance Monitoring Units (PMU),
   drivers that I can find, so new ground to break.

Taking these in turn.

Binding to the PCIe port
------------------------

The original PCIe port driver had a concept of vendor defined sub drivers but
that has been removed due to lack of users (it was still in the documentation
last time I checked).  This 'could' be used to support PMUs, and seems to
be a relatively elegant approach, representing that these are fundamentally
part of the PCIe port.

There are several ways the hardware interface for a PMU for a PCIe port
could have been implemented.
1) In PCIe config space (DVSEC) of root port.
2) As a 'platform device' on the host that has some known associate with
   the port.  This is the case we have here.

Note the current interface is a hack to illustrate the point.

The alternative is just to have this as an uncore PMU and perhaps use naming
to identify that it is associated with the PCIe port.  To my mind this is
an ugly solution and doesn't work if hardware using config space (option 1)
come along shortly.

It is worth noting that we can only make the association here because
the ACPI provide the resources to the PCIe device in DSDT.

A related question is where the driver should actualy go?

PCI Performance Monitoring Units
--------------------------------
There is no standard for performance monitoring of PCI transport layer
(or any other for that matter).  However, a lot of things being counted
are likely to be fairly consistent across different implementations.

To that end, it would be good to define naming of the events to be 'standard'
if possible!


Jonathan Cameron (2):
  pci/portdrv: Allow for vendor defined performance monitoring units.
  PCI/portdrv Hisilicon PCIe transport layer Port PMU driver.

 drivers/pci/pcie/Kconfig         |   9 +
 drivers/pci/pcie/Makefile        |   2 +
 drivers/pci/pcie/hisi_pcie_pmu.c | 528 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h       |   4 +-
 drivers/pci/pcie/portdrv_core.c  |   2 +
 include/linux/cpuhotplug.h       |   1 +
 6 files changed, 545 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/hisi_pcie_pmu.c

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
