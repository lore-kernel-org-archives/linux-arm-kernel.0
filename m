Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:20:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69F6206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TQMDlEhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69F6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OKK9Eg6f/XPX1+RdFC2Wg5lXMMHPgEqt02aHUM55T8c=; b=TQMDlEhhmEkb/8
	dyjvaNMaSQY1DIH1ytZxa/ixPv3fb30CTnKgvevYIpSkMKZ1BAYG0XrkF9Dn5b29TFMgFB73SqcOf
	ooB9NoWCbOXwSEeKJVCjgsQPeLET8YuGsPftKJUALvpLQKuDAeK2GNhkmUXQ8YyPWbIieWPjBOk6Q
	36DbiyGEgDi8xPsLEMjLK+z5fd/C0vZmDdJcesY0Z+BNIDb7KVC+3miiw6ufn1lVAZ6UN8pRpRzMZ
	74WHPGeZfZVYXFi50tg8aApkzlfgSYsTNf0hyxWyKSZseSeBLhExoZ0CQCZP0BUghqe1GxnPBpcR2
	CbfBJZOT4nNmCaNhrwXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfXF-00053F-44; Wed, 05 Dec 2018 22:20:49 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfXC-000520-0H
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:20:47 +0000
Received: by mail-ot1-f68.google.com with SMTP id k98so20223132otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 14:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HhPdi+y+PxZsxr2Dncydj46LHKsX2ak15vIhUv+lItc=;
 b=heQXK9X9UzmhKHRYvvcO4HFQvfiqmqbaZx2GBbeu/oW0jLBtmjF/PbhBfixOlg0MII
 jt6xsYS63zUvm3yHWMX9coHImseKorJBbWfiInGhNJ/ksGbMVBr+jthWTQk6kKr/1I/Z
 EwJ1wPloS5wZr1UsQgpT9YG/UFnTdJ2fZ6m/8cTSHrKR1mR9iy43npTMGfmgqR6Wsypy
 swHPsP0gz9osybuFVFCkzZqUjopBIKUbtc3iVA8WmNlMmGkiz//5W5lMJaDN/ZGBpJ3S
 aE2OOfxnLN7P00PlhH/4EPns/t9QFtRfO/gkdRYPwyCkkdsy5+BWabMeLZLK2+4mr5cd
 q9jA==
X-Gm-Message-State: AA+aEWYnPaRrpnf7deRQIq2aBMyQdrh8+SbbxDhhzGQQZnjzXOU2Dgo2
 pxfjO2OZrhxDSKR/Yln+pg==
X-Google-Smtp-Source: AFSGD/UDpDV5DZVv/lre9oa+tGgJpJxtDhScU/QWJV2juRAyPI5q2oqBsYJDLG4sQUTHudV1y5dZow==
X-Received: by 2002:a9d:72e:: with SMTP id 43mr17153105ote.207.1544048433869; 
 Wed, 05 Dec 2018 14:20:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t8sm8925706otp.69.2018.12.05.14.20.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 14:20:32 -0800 (PST)
Date: Wed, 5 Dec 2018 16:20:32 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <JOLLYS@xilinx.com>
Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Message-ID: <20181205222032.GA810@bogus>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
 <20181204220612.GA640@bogus>
 <SN4PR0201MB3536E825E836337D1535B812B8A80@SN4PR0201MB3536.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN4PR0201MB3536E825E836337D1535B812B8A80@SN4PR0201MB3536.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_142046_047913_A268025B 
X-CRM114-Status: GOOD (  24.81  )
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
 Nava kishore Manne <navam@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rajan Vaja <RAJANV@xilinx.com>, Michal Simek <michals@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 08:29:36PM +0000, Jolly Shah wrote:
> Hi Rob,
> 
> Thanks for the review. Please find my responses inline.

You need to fix your mail client to wrap lines.
 
> Thanks,
> Jolly Shah
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Tuesday, December 04, 2018 2:06 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> > Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
> > 
> > On Fri, Nov 16, 2018 at 03:56:50PM -0800, Jolly Shah wrote:
> > > Base firmware node and clock child node binding are part of mainline kernel.
> > This patchset adds documentation to describe rest of the firmware child node
> > bindings.
> > > Complete firmware DT node example is shown below for ease of
> > understanding:
> > 
> > Shouldn't there be a fpga mgr node too? Called pcap IIRC.
> > 
> [Jolly] As you suggested, we only added child nodes if the 
> sub-functions have their own resources (clks, irqs, etc.). FPGA doesn't 
> have any resources so not added . Firmware driver would still register 
> it as mfd device to instantiate the driver.

Okay, but won't their need to be child devices for 


> 
> > >
> > > firmware {
> > > 	zynqmp_firmware: zynqmp-firmware {
> > > 		compatible = "xlnx,zynqmp-firmware";
> > > 		method = "smc";
> > > 		#power-domain-cells = <1>;
> > > 		#reset-cells = <1>;
> > >
> > > 		zynqmp_clk: clock-controller {
> > > 			#clock-cells = <1>;
> > > 			compatible = "xlnx,zynqmp-clk";
> > > 			clocks = <&pss_ref_clk>, <&video_clk>,
> > <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> > > 			clock-names = "pss_ref_clk", "video_clk",
> > "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> > > 		};
> > >
> > > 		zynqmp_power: zynqmp-power {
> > > 			compatible = "xlnx,zynqmp-power";
> > > 			interrupts = <0 35 4>;
> > > 		};
> > >
> > > 		nvmem_firmware {
> > > 			compatible = "xlnx,zynqmp-nvmem-fw";
> > > 			#address-cells = <1>;
> > > 			#size-cells = <1>;
> > >
> > > 			/* Data cells */
> > > 			soc_revision: soc_revision {
> > > 				reg = <0x0 0x4>;
> > > 			};
> > > 		};
> > >
> > > 		afi0: afi0 {
> > > 			compatible = "xlnx,afi-fpga";
> > > 			config-afi = <0 2>, <1 1>, <2 1>;
> > > 		};
> > >
> > > 		qspi: spi@ff0f0000 {
> > 
> > Why is this under firmware node?
> [Jolly] Qspi is a user of eemi API provided by firmware node to 
> perform privileged register writes. Alternatively, we can keep such 
> user nodes outside of firmware node and keep nodes which firmware is 
> provider for like clock, reset, pins and power.
> Please suggest.

Child nodes of the firmware should be providers, not consumers (of the 
firmware). If you had a firmware interface to that provided a SPI 
interface, then it would be here. But just having a special mechanism to 
access the registers. 

> > 
> > > 			compatible = "xlnx,zynqmp-qspi-1.0";

If this same block works with unprivileged accesses, then you will need 
some way to distinguish that.

> > > 			clock-names = "ref_clk", "pclk";
> > > 			clocks = <&misc_clk &misc_clk>;
> > > 			interrupts = <0 15 4>;
> > > 			interrupt-parent = <&gic>;
> > > 			num-cs = <1>;
> > > 			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000
> > 0x8000000>;
> > > 		};
> > >
> > > 		serdes: zynqmp_phy@fd400000 {
> > 
> > And this?
> 
> [Jolly] Same as above.
> 
> > 
> > > 			compatible = "xlnx,zynqmp-psgtr";
> > > 			status = "okay";
> > > 			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000
> > 0x0 0x1000>,
> > > 				<0x0 0xff5e0000 0x0 0x1000>;
> > > 			reg-names = "serdes", "siou", "lpd";
> > >
> > > 			lane0: lane@0 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 			lane1: lane@1 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 			lane2: lane@2 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 			lane3: lane@3 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 		};
> > >
> > > 		pinctrl_uart1_default: uart1-default {
> > 
> > This goes under a pinctrl node.
> [Jolly] Pincontrol node is not added as it doesn't have any 
> resources. As I understand, you suggest to still add pincontrol node 
> and this under pincontrol node.

These nodes are resources, so yes you should have a child here.
> 
> > 
> > > 			mux {
> > > 				groups = "uart0_4_grp";
> > > 				function = "uart0";
> > > 			};
> > >
> > > 			conf {
> > > 				groups = "uart0_4_grp";
> > > 				slew-rate = <SLEW_RATE_SLOW>;
> > > 				io-standard = <IO_STANDARD_LVCMOS18>;
> > > 			};
> > >
> > > 			conf-rx {
> > > 				pins = "MIO18";
> > > 				bias-high-impedance;
> > > 			};
> > >
> > > 			conf-tx {
> > > 				pins = "MIO19";
> > > 				bias-disable;
> > > 				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
> > > 			};
> > > 		};
> > > 		zynqmp-r5-remoteproc@0 {
> > 
> > Wrong unit-address and this doesn't belong here.
> [Jolly]  Again as it is one of the user of firmware APIs, its kept 
> here. Alternatively, we can keep such user nodes outside of firmware 
> node and keep nodes which firmware is provider for like clock, reset, 
> pins and power.
> Please suggest.

Yes, it should be outside this.

> > 
> > > 			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> > 
> > 'remoteproc' is what the h/w block is called?
> 
> [Jolly] The hw block is called rpu. 

Then call it that in the DT.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
