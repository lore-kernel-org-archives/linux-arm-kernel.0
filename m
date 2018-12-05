Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1FAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:39:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3805E20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U60Mex9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3805E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Thkl16hXIomEv6Mbh6VHbl+dVissyMUhGh8CM9ZiwR8=; b=U60Mex9dLzGhqI
	cAv7GOgbjXHu/rgmU0wnM0SWPfFxt3Pzbigum0/cIN3SXMR+/hebgMvmIObrJn0rN+phZXLFMl2NM
	VdUwkUVxpneDNtZg7+x6w1XHBckXCNkeY6RofXtAobng0Zc8JHuP1u6ijUwfI+aDBkXtt8CO7/KqT
	MU+z3uJ+nrucD3NMjilsDkmyTqsX0hjirZ8W0LEOcBRQGZ7R4mpIYgbjek018/rGPfJO9ckW6AAwp
	7rvFrgHo9mV1YVCxIbuaCS3sX1QfC0bNkayj7C81bM1eVkneIIdzyR3RRrqmhVD4iwwYDayMxzo1t
	5DWU4TY9ttW0hpTamp6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfop-0003G2-OK; Wed, 05 Dec 2018 22:38:59 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfol-00032D-Sw
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:38:57 +0000
Received: by mail-ot1-f65.google.com with SMTP id n8so16375872otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 14:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6DfVtxcb7yKOs0ymB/s1S2dtFE6SR0aOXu/Nu1wH+9Y=;
 b=LUNX3mOOHZBDLjDVGn2iO5WyF06dCRPeQ5bI3Vn3zOK1X+Qevpbrx9v+vO/6rW8EpS
 4TeBR0MZkh5yj2zLJ5AVwz/CQzSQmAWboS+XGO8lfZxPBOoo/GMlOoBeLNnMfFLsIDTu
 l3EpjaZMy2a9NaWjVKbZhEd76hvWHam+2TDmyVSui+3SD9CtWKSId8DoD47ijZdWRrJB
 Q3Nw0PC8M7nuHSs8wcyEUr80L6XXqHxUkpqBch4DEHtUpY62He+Ns2wud1nYFR+lIC7w
 3weoLejf+JqeOv7SK1RAMJzDMi6+dsIWzS9tcTbcy7wdLvKUSS7hv5wBDWE5eXPzpYpv
 hpAg==
X-Gm-Message-State: AA+aEWYlwb+7v/rHTRVErBYAgUVPa6o5/hpq1vNzHvIEVwCZw4M2+VCO
 UNiPRS5YUjhcmBJtVHjyYw==
X-Google-Smtp-Source: AFSGD/WDDecIb+q9aolSGSwRUAp+lEo6GEW2NXmnTJsp30evnvfZoqJebttDyPzch1QX8gnqwwz0hw==
X-Received: by 2002:a9d:3662:: with SMTP id w89mr17192742otb.55.1544049524558; 
 Wed, 05 Dec 2018 14:38:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s66sm22074407oia.55.2018.12.05.14.38.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 14:38:43 -0800 (PST)
Date: Wed, 5 Dec 2018 16:38:43 -0600
From: Rob Herring <robh@kernel.org>
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Message-ID: <20181205223843.GA2125@bogus>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_143856_039193_656033F5 
X-CRM114-Status: GOOD (  21.67  )
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
 Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 20, 2018 at 09:27:51AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Change to use the layerscape-pci.txt for PCIe Gen4 controller
>    dt-bindings

Sorry someone suggested this, but it seems there's no point in having 
these in the same file. New IP block, do a new file.

> 
>  .../bindings/pci/layerscape-pci.txt           | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e81e0b8..3ef8836b6e97 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -1,4 +1,6 @@
> +====================================
>  Freescale Layerscape PCIe controller
> +====================================
>  
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
> @@ -58,3 +60,58 @@ Example:
>  				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>  				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +===================================
> +NXP Layerscape PCIe Gen4 controller
> +===================================
> +
> +This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
> +the common properties defined in mobiveil-pcie.txt.
> +
> +Required properties:
> +- compatible: should contain the platform identifier such as:
> +  "fsl,lx2160a-pcie"
> +- reg: base addresses and lengths of the PCIe controller register blocks.
> +  "config_axi_slave": PCIe controller registers
> +  "csr_axi_slave": Bridge config registers

Wouldn't 'config' and 'csr' be sufficient? And these should be listed 
under reg-names.

> +- interrupts: A list of interrupt outputs of the controller. Must contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: It could include the following entries:
> +  "intr": The interrupt that is asserted for controller interrupts
> +  "aer": Asserted for aer interrupt when chip support the aer interrupt with
> +	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
> +  "pme": Asserted for pme interrupt when chip support the pme interrupt with
> +	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
> +- dma-coherent: Indicates that the hardware IP block can ensure the coherency
> +  of the data transferred from/to the IP block. This can avoid the software
> +  cache flush/invalid actions, and improve the performance significantly.
> +- msi-parent : See the generic MSI binding described in
> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +Example:
> +
> +	pcie@3400000 {
> +		compatible = "fsl,lx2160a-pcie";
> +		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
> +		reg-names = "csr_axi_slave", "config_axi_slave";

The order should match what's defined above.

Also, normally the config space would be the bigger region unless config 
accesses are windowed.

> +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +		interrupt-names = "aer", "pme", "intr";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		apio-wins = <8>;
> +		ppio-wins = <8>;

If these have specific values on your h/w, please specify above.

> +		dma-coherent;
> +		bus-range = <0x0 0xff>;
> +		msi-parent = <&its>;
> +		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +	};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
