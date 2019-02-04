Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:13:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFA0205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mKaTZ8C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFA0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BFfTSdH7BFrdJYzy/B4tCN9WvP5+c2kGankgQ4RxN4c=; b=mKaTZ8C8hzC5H1
	ukdyl0SdndXscPTi9CmsnZCt0uDOch2xWyo84VJKC/b87d0PfCow5wPtklZhrA3ERx0a6+pjd/2dY
	iYuOPbtdhQzpKN8MYMb5oRSfx/l7cm7kOK8n1s/X6xf3DjYO5g7ZEOZdkfxAai5IhEo8VlqsD5gAe
	fK82AEoTIoiPH3b1pidZvTSvS8BfCJ/7+yL8t+pFxjb3dyLmdM4pWX0SDGtSYrIUc8nikkcjtkaTs
	c2RlCc08lNA98iB4dYhwf0YgJ9OmGanI6A0vgiViMFi95O5BiqKkn/su0fPmbWBoKHnz25bCunNqf
	rLnV0mwSC4QAJ089JARg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgrv-0003Wr-DW; Mon, 04 Feb 2019 16:13:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgrs-0003WU-LG
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:13:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C08C080D;
 Mon,  4 Feb 2019 08:13:07 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1C43F589;
 Mon,  4 Feb 2019 08:13:04 -0800 (PST)
Date: Mon, 4 Feb 2019 16:13:03 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: Re: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20190204161303.GA18220@red-moon>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129113910.GA7467@e107981-ln.cambridge.arm.com>
 <CAFZiPx002HED+YH2GysS7a7uoEDQuHGjxa_CQtwb9nSDH-XNuA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFZiPx002HED+YH2GysS7a7uoEDQuHGjxa_CQtwb9nSDH-XNuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_081308_708952_B6E0E5CD 
X-CRM114-Status: GOOD (  23.39  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Z.q. Hou" <zhiqiang.hou@nxp.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 07:44:25PM +0530, Subrahmanya Lingappa wrote:
>    Bjorn,
>    My apologies, I was away for a while from this work.
>    I am starting to review now.

Hi,

I am not Bjorn and as I told you before you should not reply
with html context (ie use plain text, the public lists will
reject your emails otherwise) and top-post.

You are supposed to maintain this code, if you can't it is fine but I
should know because there are developers who are waiting for your
review, please understand.

Thanks,
Lorenzo

>    Thanks,
>    ~subbu
>    On Tue, Jan 29, 2019 at 5:09 PM Lorenzo Pieralisi
>    <lorenzo.pieralisi@arm.com> wrote:
> 
>      On Tue, Jan 29, 2019 at 08:08:28AM +0000, Z.q. Hou wrote:
>      > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>      >
>      > This patch set is aim to refactor the Mobiveil driver and add
>      > PCIe support for NXP Layerscape series SoCs integrated Mobiveil's
>      > PCIe Gen4 controller.
>      >
>      > Hou Zhiqiang (27):
>      >   PCI: mobiveil: uniform the register accessors
>      >   PCI: mobiveil: format the code without function change
>      >   PCI: mobiveil: correct the returned error number
>      >   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
>      >   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
>      >   PCI: mobiveil: replace the resource list iteration function
>      >   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
>      >   PCI: mobiveil: use the 1st inbound window for MEM inbound
>      transactions
>      >   PCI: mobiveil: correct inbound/outbound window setup routines
>      >   PCI: mobiveil: fix the INTx process error
>      >   PCI: mobiveil: only fix up the Class Code field
>      >   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
>      >   PCI: mobiveil: move irq chained handler setup out of DT parse
>      >   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
>      >   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to
>      optional
>      >   PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP driver
>      >   PCI: mobiveil: fix the checking of valid device
>      >   PCI: mobiveil: continue to initialize the host upon no PCIe link
>      >   PCI: mobiveil: disabled IB and OB windows set by bootloader
>      >   PCI: mobiveil: add Byte and Half-Word width register accessors
>      >   PCI: mobiveil: make mobiveil_host_init can be used to re-init host
>      >   dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4 controller
>      >   PCI: mobiveil: add PCIe Gen4 RC driver for NXP Layerscape SoCs
>      >   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
>      >   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
>      >   arm64: dts: freescale: lx2160a: add pcie DT nodes
>      >   arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4
> 
>      Subrahmanya,
> 
>      Either you review this series or I will have to drop you from
>      the MAINTAINERS list for this driver, I am sorry but I asked you
>      before to no avail.
> 
>      Thanks,
>      Lorenzo
> 
>      >  .../bindings/pci/layerscape-pci-gen4.txt      |  52 ++
>      >  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
>      >  MAINTAINERS                                   |  10 +-
>      >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++
>      >  arch/arm64/configs/defconfig                  |   1 +
>      >  drivers/pci/controller/Kconfig                |  11 +-
>      >  drivers/pci/controller/Makefile               |   2 +-
>      >  drivers/pci/controller/mobiveil/Kconfig       |  34 +
>      >  drivers/pci/controller/mobiveil/Makefile      |   5 +
>      >  .../controller/mobiveil/pci-layerscape-gen4.c | 306 +++++++
>      >  .../controller/mobiveil/pcie-mobiveil-host.c  | 640 +++++++++++++
>      >  .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
>      >  .../pci/controller/mobiveil/pcie-mobiveil.c   | 246 +++++
>      >  .../pci/controller/mobiveil/pcie-mobiveil.h   | 229 +++++
>      >  drivers/pci/controller/pcie-mobiveil.c        | 861
>      ------------------
>      >  15 files changed, 1743 insertions(+), 873 deletions(-)
>      >  create mode 100644
>      Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
>      >  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
>      >  create mode 100644 drivers/pci/controller/mobiveil/Makefile
>      >  create mode 100644
>      drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
>      >  create mode 100644
>      drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
>      >  create mode 100644
>      drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
>      >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
>      >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
>      >  delete mode 100644 drivers/pci/controller/pcie-mobiveil.c
>      >
>      > --
>      > 2.17.1
>      >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
