Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FBFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E5020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jgMevU+U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dnMTKRLu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1fie8BrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E5020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iLwbnUSzR3fcgl4V9N4a7wTiYzM9LIxqH2ftX9E7qdo=; b=jgMevU+Uh0Nvwk
	FCke+4rwwCAEg/3g00Z3BbPUxFYuoRDN9m1P8z3fQGh5N5btIHsg/1AfpajUmvITg5k5NiypC96Fv
	Xj3Smhkm9/+RBfu8C/n0J3lL3CjsQZyStUx9nWKiaYd4JDW9nTAJnOLyWi8iCA3DD04n/o2ZUPT7t
	rwhPcYktq/jBR4r987QfPy0E9AHcTUNQCnGDE2CbJICtBl7od7JhfktjDVCIvMjlbVlF8F5guPLJ4
	TmNtm+3xzggg8h9b6rSI/3LEmes7ssmzBTkv7yW9/v+K//RSJIii6xfiq1kt3bSc7jWS4gsOBu2vz
	iTuHIf24iXS4N6qETtbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotZ5-0005hQ-KY; Wed, 30 Jan 2019 17:22:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotZ0-0005XJ-Ar; Wed, 30 Jan 2019 17:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iRpEHgbAXrDBhaJig2YEqSuQEt6eXPV5nIqbQpbADcc=; b=dnMTKRLuo28TbMW8sWNgMXxBS
 Evy5J5EBkqLDwcm3YK78BPYBjrfBzdivEo4FqthFCPZ5vmd3P0KiPQns+g0afnl7Q1m+kMf0gou0g
 SuA/oh5PSgL7xzNZjk7tZQJBcNNWO3EIGboBYN4bE45YJKX4ZNniDgkFQ4lRc3/DxepGPyW7VMO9k
 qlcxTwTeLq/dSFQZ5oRY65knNXMPeF1J8pRiMMMwAIsIa2LtZ4Zj48UiiaS65jPWeZnmNGdEVYPvE
 8vabaKnUQso+/yDiB/+XYH8maOTVAmJlj2BluiqB2jH3eAb0gt1SVOFHhrMBBpyFBPdnAgtKeZ1at
 X3xAror9g==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotJf-0007vs-KU; Wed, 30 Jan 2019 17:06:29 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 381DD20989;
 Wed, 30 Jan 2019 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548867980;
 bh=iJCfhl4idjAo8RareOx2BQFx3jKZU6evYVhqWFVbUFc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1fie8BrC5rjM3TNwbOPhnuVOvfrum0Ulwq+aPQ8jvn9BMUjupGVgSDVd/70dbbhTx
 O8Rx/nuRvjRzaR3K2K8oDY6r0Z13Dsf/fWpvz+wVEQYvbQmW+HXezZ+2mUrRwIIdfN
 lqsgGAkfwtKsJxLjdn9finik1eRF36DLwxUWVPdI=
Date: Wed, 30 Jan 2019 11:06:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v9 2/9] PCI: Using PCI configuration space header type
 instead of class type to assign resource
Message-ID: <20190130170612.GH229773@google.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
 <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_170624_066536_9E5430B2 
X-CRM114-Status: GOOD (  19.44  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 matthias.bgg@gmail.com, ryder.lee@mediatek.com,
 linux-mediatek@lists.infradead.org, yt.shen@mediatek.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Oct 16, 2018 at 06:44:43PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The PCI configuration space header type defines the layout of the rest
> of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9) while the
> resource assignment is based on the configuration space layout instead
> of its class type. Using configuration space header type instead of
> class type for the resource assignment.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>

I applied the patch below to pci/enumeration for v5.1.

I dropped the hunk that removed the PCI_CLASS_BRIDGE_HOST check per
Lorenzo's concern.  Let me know if you have any other concerns.


commit b2fb5cc57469
Author: Honghui Zhang <honghui.zhang@mediatek.com>
Date:   Tue Oct 16 18:44:43 2018 +0800

    PCI: Rely on config space header type, not class code
    
    The PCI configuration space header type tells us whether the device is a
    bridge, a CardBus bridge, or a normal device, and defines the layout of the
    rest of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9).
    
    When we rely on the header format, e.g., when we're dealing with bridge
    windows, we should check the header type, not the class code.  The class
    code is loosely related to the header type, but is often incorrect and the
    spec doesn't actually require it to be related to the header format.
    
    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
    [bhelgaas: changelog, keep the PCI_CLASS_BRIDGE_HOST check]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..e9d938e14ba8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6000,8 +6000,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	 * to enable the kernel to reassign new resource
 	 * window later on.
 	 */
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
-	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
 			r = &dev->resource[i];
 			if (!(r->flags & IORESOURCE_MEM))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e2e4154cdd9..128459a0ffba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1779,9 +1779,6 @@ int pci_setup_device(struct pci_dev *dev)
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
-		if (class != PCI_CLASS_BRIDGE_PCI)
-			goto bad;
-
 		/*
 		 * The PCI-to-PCI bridge spec requires that subtractive
 		 * decoding (i.e. transparent) bridge must have programming
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1941bb0a6c13..ec44a0f3a7ac 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1186,12 +1186,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (!b)
 			continue;
 
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_CARDBUS:
+		switch (dev->hdr_type) {
+		case PCI_HEADER_TYPE_CARDBUS:
 			pci_bus_size_cardbus(b, realloc_head);
 			break;
 
-		case PCI_CLASS_BRIDGE_PCI:
+		case PCI_HEADER_TYPE_BRIDGE:
 		default:
 			__pci_bus_size_bridges(b, realloc_head);
 			break;
@@ -1202,12 +1202,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	if (pci_is_root_bus(bus))
 		return;
 
-	switch (bus->self->class >> 8) {
-	case PCI_CLASS_BRIDGE_CARDBUS:
+	switch (bus->self->hdr_type) {
+	case PCI_HEADER_TYPE_CARDBUS:
 		/* don't size cardbuses yet. */
 		break;
 
-	case PCI_CLASS_BRIDGE_PCI:
+	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
@@ -1356,13 +1356,13 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 		__pci_bus_assign_resources(b, realloc_head, fail_head);
 
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
+		switch (dev->hdr_type) {
+		case PCI_HEADER_TYPE_BRIDGE:
 			if (!pci_is_enabled(dev))
 				pci_setup_bridge(b);
 			break;
 
-		case PCI_CLASS_BRIDGE_CARDBUS:
+		case PCI_HEADER_TYPE_CARDBUS:
 			pci_setup_cardbus(b);
 			break;
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
