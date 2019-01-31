Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C74C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:47:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F712218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Il53+/9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F712218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZZyxKCw0MkaunTRIUwD9Ay6jiWsrsEWi63cdWVTDyEk=; b=Il53+/9nrQavat
	eE8s4HgQFdjoNLiAkMB4WJC5y0waoxNuBPjCB3xSECp0VfSx7tZIhCG+qLgEUPkbR1h/Rql3C+jNJ
	1YYQncpUCr7bOZtTjlcAVDUSSDJLYJk2q2H6zNoYdonl6nHTpaFl/IHKcB3sCVtS/OXEkmrjhrhN1
	fxusHm+Noo14x7fRL0nsXD2mRy7F/iPzzfSWev9aDTIJw0yQmT+kI8q8vZacyhZMQlPTiI1V8LTE1
	l8ivZqjICL8Xt8Y6uzqDiFGL6tQ4g4/4fxl4j7FB7LrRV2yHhStJlFOBtFGfuFNZLR62xDWdekt5s
	ffDP6wlIEF4fCLMmZsJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpEYc-0006kf-JH; Thu, 31 Jan 2019 15:47:14 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpEYX-0006jw-AY
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:47:12 +0000
X-Originating-IP: 90.88.147.226
Received: from windsurf (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ED8BBE000E;
 Thu, 31 Jan 2019 15:46:54 +0000 (UTC)
Date: Thu, 31 Jan 2019 16:46:53 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190131164653.2599d6e7@windsurf>
In-Reply-To: <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
 <20190129155913.163f1e98@windsurf>
 <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
 <20190129163117.0af2ebb3@windsurf>
 <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_074709_516815_BE93375A 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Leigh,

On Tue, 29 Jan 2019 15:36:56 +0000
Leigh Brown <leigh@solinno.co.uk> wrote:

> Apologies, I use webmail.  I have attached two files with the results
> from running lspci -vvv -xxx

Thanks, that was very useful. I believe the issue comes from the fact
that your PCIe device has prefetchable BARs, while none of the 5 PCIe
devices I have here has prefetchable BARs. The pci-mvebu driver doesn't
support such BARs, but the change to the common PCI bridge emulation
logic made the prefetchable memory base / limit register read-write
while they were read-only before.

To verify this hypothesis, could you apply the following patch (on top
of 4.20), and see if it solves the problem ? Thanks!

This is probably not the right/correct fix, but it will at least allow
to verify that the problem is understood correctly.

Thomas

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 129738362d90..f99b80c19809 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -142,11 +142,7 @@ const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
        },
 
        [PCI_PREF_MEMORY_BASE / 4] = {
-               /* The high 12-bits of pref mem base/limit are RW */
-               .rw = GENMASK(31, 20) | GENMASK(15, 4),
-
-               /* The low four bits of pref mem base/limit are RO */
-               .ro = GENMASK(19, 16) | GENMASK(3, 0),
+               .ro = ~0,
        },
 
        [PCI_PREF_BASE_UPPER32 / 4] = {


-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
