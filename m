Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D98AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:49:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E201218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/yoxwHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E201218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8+OP+evTf8Otivzi9n4YuVbREOf4FYtjSswwZD3HVFA=; b=j/yoxwHeNJMuT5
	BD/um2mX7DTOeWskBSI8DFYdVCDCJRNIMLyrBMtLPbrccnAbWghNtmfCIRqrcjzwe+54SAnBeJsY6
	RXr9RMNOJkhv7cuHe9wlNcQZN5b4zpbKCmiTtcBitk24l0UrGN9OMxx9NQirOJxmwnMIclRcF7N5q
	6KAs5dCTVVsnGCzCmqth5uHuITRKbXWd5dzCDuk6xFBzVq/BEV2QqNQ1ndN9W5vh4PXhDVpbpM1hs
	tHQorREGqN659m3mZwM7lUwsnUO1+t4C3jOiI+LHanTinWBAxNruLhtmnfpBYKyWccZ6Dcaq/bxus
	GT4Jb5skteeNeSfn5lDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZe5t-0001Z0-1f; Wed, 19 Dec 2018 15:49:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZe5p-0001CC-6x
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:49:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68F0580D;
 Wed, 19 Dec 2018 07:48:54 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51CAC3F675;
 Wed, 19 Dec 2018 07:48:52 -0800 (PST)
Date: Wed, 19 Dec 2018 15:48:49 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v5 0/2] Add new UniPhier PCIe host driver
Message-ID: <20181219154849.GB25410@e107981-ln.cambridge.arm.com>
References: <1544143992-16385-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544143992-16385-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_074905_261632_CF53987E 
X-CRM114-Status: GOOD (  23.07  )
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
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 09:53:10AM +0900, Kunihiko Hayashi wrote:
> This series adds PCIe host controller driver for Socionext UniPhier SoCs.
> This controller is based on the DesignWare PCIe core. This driver
> supports LD20 and PXs3 SoCs.
> 
> v4: https://www.spinics.net/lists/linux-pci/msg78278.html
> 
> About legacy IRQ, it might be necessary to share common view from
> keystone driver that have been cleaned up[1].
> 
> [1] https://lore.kernel.org/patchwork/patch/989541/
> 
> Changes since v4:
> - fix an issue of using the wrong value to mask IRQ mask register
> 
> Changes since v3:
> - dt-bindings: fix INTX numbering of legacy interrupt map
> - change interrupts to level ones
> - remove .xlate function
> - merge uniphier_pcie_ltssm_disable() into uniphier_pcie_ltssm_enable()
> - remove an error message on uniphier_pcie_establish_link()
> - change the order between irq_domain_add_liniear() and
>   irq_set_chained_handler_and_data()
> - replace dummy_irq_chip with uniphier_pcie_irq_chip and its functions
> - add dependency on CONFIG_HAS_IOMEM
> - MAINTAINERS: add pcie-uniphier entry
> 
> Changes since v2:
> - dt-bindings: remove a comment that the node name isn't important
> - dt-bindings: remove "intx" interrupt
> - dt-bindings: define 'legacy-interrupt-controller' node and its properties
> - return an error value when link up fails
> - remove devm_request_irq() and a handler for MSI IRQ
> - use chained interrupt instead of devm_request_irq() for legacy IRQ
> - add unipher_pcie_config_legacy_irq() to get legacy IRQ from
>   'legacy-interrupt controller' node
> - replace 4 statments to handle INTX with for_each_set_bit()
> - remove initialization of pp->root_bus_nr
> - remove indivisual interrupt enable bit definitions
> - rename 'irq_domain' member to 'legacy_irq_domain' in private structure
> - use pci_irqd_intx_xlate() for irq_domain_ops.xlate function
> 
> Changes since v1:
> - follow capitalization conventions in the descriptions
> - use C style comments except for the SPDX line
> 
> Kunihiko Hayashi (2):
>   dt-bindings: PCI: Add UniPhier PCIe host controller description
>   PCI: uniphier: Add UniPhier PCIe host controller support
> 
>  .../devicetree/bindings/pci/uniphier-pcie.txt      |  81 ++++
>  MAINTAINERS                                        |   7 +
>  drivers/pci/controller/dwc/Kconfig                 |  10 +
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-uniphier.c         | 471 +++++++++++++++++++++
>  5 files changed, 570 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
>  create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

Applied to pci/uniphier, aiming for v4.21, thanks.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
