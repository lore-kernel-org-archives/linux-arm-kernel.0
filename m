Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB00C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:06:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA96E2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3/uyYD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA96E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OUaZc7P9moJQYbhxBOSF6GBBABp4IuKwJ5KLKVs4NSc=; b=M3/uyYD5/NpYO6
	jrns7qHKtRwV7vJ7wfs/FiFFv1HNxnHBLj4Tuo7IXhVlkGi+b8fPVYUfQhTjxb9XVoSjoIjkZRJ/e
	oIredyZ9VZT07WfnZPyooIaVq2/7LYFJwbTOEkGGg33nqoda6D1uUGI0jcWRpEZxpnRbaSxD6dJ/z
	XMg6Azu0PRPVNQTXpDpMp8eVeQs9MWB60ecRV0gfaMa+evbmjMbTXlk1uVuK327wnGDh/BFUS8V4p
	wD0CZsPJGl8ZlNdjhIYqDSUCHYuZV1cbepwjV2FfcN8CrbMcy14Y482RxBtvVmlWmuFuWwT1Fa+d5
	6Cwnhnbv9vVpq/VSWMEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIpn-0004rs-0f; Tue, 04 Dec 2018 22:06:27 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIpk-0004qx-4a
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:06:25 +0000
Received: by mail-oi1-f194.google.com with SMTP id u18so15726881oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 14:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=od9oqItzrIx6N8qhcUsce2UF97+Rcb6AAq1qNYdYUms=;
 b=IJRs1Lv68TS8RIE4/88iSCcEfoeFdNOcnDZ+i/mJcmlaMhx3yJ0LQO/iVSbE5RsRGO
 ZYeqCMDPll3EbuqVYqOZIIBcrAT/jkyWDelZ47eEVQor2IV7lhJ7cKo3pDvp8PIiwWwH
 hL79pMp915fpoW3D9H61uCxL8qJNZpdM9txFN7+SOPygjJhnrG5F37C7YXvqOgvI+DZV
 NBjZR3WJJPfwn/NuN2wWzXxXPfcl3e+DvCVhOt/U6rjDO350spwfjTkPo3gWfIAZD7oR
 Bdgf3g+PqBEz9/AWNZrCrzhgzUGpRCQI5hWeB0M1glO7NcfuRq8QxASTzAj4kSwfZWj0
 BQpg==
X-Gm-Message-State: AA+aEWaX96iuh0FamgXLGGzp+EP+CxfE2LiSiICHPd8qOo2hL17GdtpP
 a3c9i2klJ0h/j5LBKNEmrQ==
X-Google-Smtp-Source: AFSGD/WFRoAGzTQtbPEZRj9VxZdwqWdXKlYK5I/jF+u+lIfGPuL/upokUdvnnmaByUAIONIwAbc4Ew==
X-Received: by 2002:aca:ad14:: with SMTP id w20mr12901459oie.3.1543961173364; 
 Tue, 04 Dec 2018 14:06:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x4sm6353853otk.37.2018.12.04.14.06.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 14:06:12 -0800 (PST)
Date: Tue, 4 Dec 2018 16:06:12 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Message-ID: <20181204220612.GA640@bogus>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542412619-387-1-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_140624_179779_3D8165D5 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nava.manne@xilinx.com,
 michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 03:56:50PM -0800, Jolly Shah wrote:
> Base firmware node and clock child node binding are part of mainline kernel. This patchset adds documentation to describe rest of the firmware child node bindings. 
> Complete firmware DT node example is shown below for ease of understanding:

Shouldn't there be a fpga mgr node too? Called pcap IIRC.

> 
> firmware {
> 	zynqmp_firmware: zynqmp-firmware {
> 		compatible = "xlnx,zynqmp-firmware";
> 		method = "smc";
> 		#power-domain-cells = <1>;
> 		#reset-cells = <1>;
> 
> 		zynqmp_clk: clock-controller {
> 			#clock-cells = <1>;
> 			compatible = "xlnx,zynqmp-clk";
> 			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> 			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> 		};
> 
> 		zynqmp_power: zynqmp-power {
> 			compatible = "xlnx,zynqmp-power";
> 			interrupts = <0 35 4>;
> 		};
> 
> 		nvmem_firmware {
> 			compatible = "xlnx,zynqmp-nvmem-fw";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			/* Data cells */
> 			soc_revision: soc_revision {
> 				reg = <0x0 0x4>;
> 			};
> 		};
> 
> 		afi0: afi0 {
> 			compatible = "xlnx,afi-fpga";
> 			config-afi = <0 2>, <1 1>, <2 1>;
> 		};
> 
> 		qspi: spi@ff0f0000 {

Why is this under firmware node?

> 			compatible = "xlnx,zynqmp-qspi-1.0";
> 			clock-names = "ref_clk", "pclk";
> 			clocks = <&misc_clk &misc_clk>;
> 			interrupts = <0 15 4>;
> 			interrupt-parent = <&gic>;
> 			num-cs = <1>;
> 			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
> 		};
> 
> 		serdes: zynqmp_phy@fd400000 {

And this?

> 			compatible = "xlnx,zynqmp-psgtr";
> 			status = "okay";
> 			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>,
> 				<0x0 0xff5e0000 0x0 0x1000>;
> 			reg-names = "serdes", "siou", "lpd";
> 
> 			lane0: lane@0 {
> 				#phy-cells = <4>;
> 			};
> 			lane1: lane@1 {
> 				#phy-cells = <4>;
> 			};
> 			lane2: lane@2 {
> 				#phy-cells = <4>;
> 			};
> 			lane3: lane@3 {
> 				#phy-cells = <4>;
> 			};
> 		};
> 
> 		pinctrl_uart1_default: uart1-default {

This goes under a pinctrl node.

> 			mux {
> 				groups = "uart0_4_grp";
> 				function = "uart0";
> 			};
> 
> 			conf {
> 				groups = "uart0_4_grp";
> 				slew-rate = <SLEW_RATE_SLOW>;
> 				io-standard = <IO_STANDARD_LVCMOS18>;
> 			};
> 
> 			conf-rx {
> 				pins = "MIO18";
> 				bias-high-impedance;
> 			};
> 
> 			conf-tx {
> 				pins = "MIO19";
> 				bias-disable;
> 				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
> 			};
> 		};
> 		zynqmp-r5-remoteproc@0 {

Wrong unit-address and this doesn't belong here.

> 			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";

'remoteproc' is what the h/w block is called?

> 			reg = <0x0 0xFFE00000 0x0 0x10000>,
> 				<0x0 0xFFE20000 0x0 0x10000>,
> 				<0x0 0xff340000 0x0 0x100>;
> 			reg-names = "tcm_a", "tcm_b", "ipi";
> 			dma-ranges;
> 			core_conf = "split0";
> 			memory-region = <&rproc_0_fw_reserved>,
> 					<&rproc_0_dma_reserved>;
> 			tcm-pnode-id = <0xf>, <0x10>;
> 			rpu-pnode-id = <0x7>;
> 			interrupt-parent = <&gic>;
> 			interrupts = <0 29 4>;
> 		};
> 	};
> };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
