Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12933C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:34:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78BD2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tcmzlnNM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuqVEzSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78BD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z2EwEoN5+3lF+5UrOUiBuEK1PbF2uLKXX0ryjr+r5ak=; b=tcmzlnNMltgq2P
	q0NTe1F5Mn/JgcXkAvkw+CJQKMVOFg0ovHbbrtodF4zOGv725iEb+HC6c+9TtqrPEEpqA4QDR0caJ
	RnwB5U5I9sBWnImLh3iTfFLGSqWaOYYIwZXdlkbbki4vXY/6OpIE+QSZZK5TzemzCU6QZlJ7QPrz4
	OgKGKfNYQdPlzop0CDzab+Iy9IKRt8b3IztyaCFx1FmTzy43ZnmxMLKRsYYoJka8FKSZpBdhwV21y
	C/31PHwed5bx7Sl/dnSs+H8S4qxWkP62o+njJbx5fp5dUOHCL2TsS6nuXRDxjYaOnNFTyIjtxtrKP
	PCUEMF7PViG4fxVmDpbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gort6-0005ZA-IT; Wed, 30 Jan 2019 15:34:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gort3-0005Yq-Nb
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:34:51 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E45A2084C;
 Wed, 30 Jan 2019 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548862489;
 bh=kE1XxCFEdT4aiygJ3Mqnrvvef9WFtqdWnimE3s8rvQs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RuqVEzSleYDIqdx+g7l46FZ31N/2ebfIdThZzTcUokAA3dwRqgEyKXVBFfBS2dYO7
 /G9ZHwHqHtpbN18cUqrEsiwl67HgvBZSqzaeMckIZhm9Auf+dGadt9VBT/cgzOV5Vg
 IF8oKJTeAOgOQLTm28OuHxr1QAW1hjara4pu1tzM=
Date: Wed, 30 Jan 2019 09:34:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20190130153447.GB229773@google.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_073449_805036_FE5BC459 
X-CRM114-Status: GOOD (  13.45  )
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
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 08:08:28AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is aim to refactor the Mobiveil driver and add
> PCIe support for NXP Layerscape series SoCs integrated Mobiveil's
> PCIe Gen4 controller.
> 
> Hou Zhiqiang (27):
>   PCI: mobiveil: uniform the register accessors
>   PCI: mobiveil: format the code without function change
>   PCI: mobiveil: correct the returned error number
>   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
>   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
>   PCI: mobiveil: replace the resource list iteration function
>   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
>   PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
>   PCI: mobiveil: correct inbound/outbound window setup routines
>   PCI: mobiveil: fix the INTx process error
>   PCI: mobiveil: only fix up the Class Code field
>   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
>   PCI: mobiveil: move irq chained handler setup out of DT parse
>   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
>   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
>   PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP driver
>   PCI: mobiveil: fix the checking of valid device
>   PCI: mobiveil: continue to initialize the host upon no PCIe link
>   PCI: mobiveil: disabled IB and OB windows set by bootloader
>   PCI: mobiveil: add Byte and Half-Word width register accessors
>   PCI: mobiveil: make mobiveil_host_init can be used to re-init host
>   dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4 controller
>   PCI: mobiveil: add PCIe Gen4 RC driver for NXP Layerscape SoCs
>   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
>   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
>   arm64: dts: freescale: lx2160a: add pcie DT nodes
>   arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4

If/when you repost this, please pay attention to the changelog
conventions, e.g., capitalize the first word of the sentence ("Remove
flag ...", "Correct PCI base address ...", etc), capitalize acronyms
like "PCI" and "IRQ", use parentheses after function names, etc.  You
can see the conventions by running "git log --oneline
drivers/pci/controller".

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
