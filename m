Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2689BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:09:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD58E20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYDugbgP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uBdfEN6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD58E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OwuZDTtDgX5Ec0d4mMQXRc5t32gz2+UEx+D78VJSV7A=; b=GYDugbgPYBMqR0
	dpgGpmYqhE1vc9XSjf1xmThkqyIrt4h0oqyutmsx/cMbdzMeHr3IqwoMTpEk5d6woazuu/CnxgMNv
	jHKmhQir7eTjAOKbVDCgvubEHWigTfPnudImfu/Ktm0ZqPDRMtyUwg01vKXvqnw12M96cV1ohQpPi
	Ptw3tIIbYGtZLT1VwAVf/NYh+plv5FobDJ8mC1NCooAGFyrOvVC2YrmyZr/ImQyDSNDGaA63wDrXs
	Ryq6BeQMfZO//bPLdWTVTyGGUqb+YZpbPROLmKLXZqNbkcrmLTNIyBnP2TBktSUUWlrSLvAzFv3yr
	RmL9xlFu7qsMJ6MRw9vA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2lJ-00013J-V2; Thu, 06 Dec 2018 23:08:53 +0000
Received: from mail-bn3nam01on061f.outbound.protection.outlook.com
 ([2a01:111:f400:fe41::61f]
 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2lG-00012T-9E
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcVc/dyMZLe+/zvLHtN8rNVqY4rti0P3BJlT1eraADQ=;
 b=uBdfEN6VOwso4Co7tv5R03R13pwh6uuJQ361ptYXCnnl9paXjkIvXT6Z574F14nugRVrLpo1cZpxCEmRXC/oGViF+V8haWfpzGBB9T5bLZp7gBziaZ6uH/bZU1jR1dgQleyjiB8d2zCjT1F4xrDfWnIOpoL50d8KoZbSGVqvDHA=
Received: from DM5PR0201MB3525.namprd02.prod.outlook.com (10.167.106.13) by
 DM5PR0201MB3541.namprd02.prod.outlook.com (10.167.106.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Thu, 6 Dec 2018 23:08:34 +0000
Received: from DM5PR0201MB3525.namprd02.prod.outlook.com
 ([fe80::8571:d4a3:73e6:913]) by DM5PR0201MB3525.namprd02.prod.outlook.com
 ([fe80::8571:d4a3:73e6:913%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 23:08:33 +0000
From: Jolly Shah <JOLLYS@xilinx.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Thread-Topic: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Thread-Index: AQHUfggvkVKuttW8xEq5Oarr4c4vt6VvPxIAgAFr3pCAACp4AIABnj2A
Date: Thu, 6 Dec 2018 23:08:33 +0000
Message-ID: <DM5PR0201MB35254435007BB1A4272160A6B8A90@DM5PR0201MB3525.namprd02.prod.outlook.com>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
 <20181204220612.GA640@bogus>
 <SN4PR0201MB3536E825E836337D1535B812B8A80@SN4PR0201MB3536.namprd02.prod.outlook.com>
 <20181205222032.GA810@bogus>
In-Reply-To: <20181205222032.GA810@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR0201MB3541;
 6:aBUv9k/P51yp4JX0kcym+MLAgclBe/ZbIPbWPsFtp29OOWJ4oVEaLESCvgVc+uc7BufyUk1dPByDbVZKDbNc9LFQ3DhmOXhCjfq8ArrP8KPb0hBcuqTZRz9BD8D/d5OKL0zln0z40RFRBfUd0a6t6i6vQJ6fbOUen7bpP8E0vIZskesgLNMUkn2lP77/MWGgqVbbeEl8+nUIgzxKeQvZatpohgC49B9uml3hFMm+OLXhwy2YJYYz2tIMiY/bQ9LMmP1ECb0l0cRbvx/EDLdzRuMFaRDthJh3A1wKikx9GRVi4FmYk0XUnhipuE2CNurhD8d5y5WUnuqCl2cLA6tf7BfUqb4usQUYvf3PJtOV7D3Lpcm8SBta7pz0Ct70uYxgjSc4nI85EkekK7k/yMpjj+2W/GuW+ajw680pbxPzhkgrvJeznAcodK33HKJ2267oSnpdABoTqvfbwbaaOqETYw==;
 5:Rt5//uN+VKmVmBWTjxs6mP1TaxnUw5bf1wlQjcaFVaVebkpBR6YQdalUmKajzmwLj1R2nq/LdG9TKFT9vRgK3GlGw1UmngCRQ44wbas3rQ5uJHVrz/lJBxaTxN7kFQxkD3v26fYevx0JDXLQhst1CdF/li7yJ1qK+DvGSIeH7Tc=;
 7:fJH+LxKDaYROiI4upaR5b/xEeVqjDuAyc+oo4LAAiWyS1UTwERpKyBK8bA3li5ISIowNAs2UzfvW4STyh3/+bXABBb7C+Fel1lIro7Xi6fA53QoiDL4ku9JdByyen0bAMqCM6uynl/o7nHJ31g4cEw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(376002)(39840400004)(136003)(13464003)(199004)(189003)(51914003)(106356001)(105586002)(25786009)(478600001)(186003)(2906002)(14454004)(86362001)(6506007)(53546011)(76176011)(93886005)(26005)(97736004)(6246003)(7696005)(5660300001)(102836004)(99286004)(66066001)(53936002)(81166006)(3846002)(54906003)(81156014)(6116002)(8676002)(7736002)(4326008)(8936002)(74316002)(305945005)(256004)(68736007)(9686003)(575784001)(72206003)(33656002)(71200400001)(55016002)(71190400001)(316002)(6916009)(14444005)(229853002)(486006)(11346002)(6436002)(476003)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR0201MB3541;
 H:DM5PR0201MB3525.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-office365-filtering-correlation-id: ebaaffb2-f6ad-49aa-cf27-08d65bcfbed4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR0201MB3541; 
x-ms-traffictypediagnostic: DM5PR0201MB3541:
x-microsoft-antispam-prvs: <DM5PR0201MB354168877A779552278131F2B8A90@DM5PR0201MB3541.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:DM5PR0201MB3541; BCL:0; PCL:0; RULEID:; SRVR:DM5PR0201MB3541; 
x-forefront-prvs: 087894CD3C
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KsikKx/Szbcrao8KYr3zgKQNZZzYw3DA6gmXvwwSRwXw/llD5FZNy5jRekc21jAyEXdR6ONgl3uYYc1FRyutgNJTYV+rEQNE/qr1N/z0wMQYXNDoluLFu/GhAvAxACqnhqRQrrqaDBkqDcOCmTWlCCy4UwLnfc5FhxpjsVy5R0QMPDuTZLqHAHArInNzr4ZgTsl0kZ6xczZ0dr2QVr+Xio3CfKpnclXRU00gLrXRSL5ZoZSjNiLLqeDl55IryWt9Amk7jS2+xx6N4lz1BSlJsNxsAYHyaZf7GeXdZVYys26kqied2v7l9ZLJ+cLK5mfYPD4HjU6jaN9sn3ldmRVGfKts6S84A8xp9rsnEVOJSyU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaaffb2-f6ad-49aa-cf27-08d65bcfbed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 23:08:33.6073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3541
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_150850_526069_7235A3CD 
X-CRM114-Status: GOOD (  28.59  )
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

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, December 05, 2018 2:21 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: mark.rutland@arm.com; devicetree@vger.kernel.org; Nava kishore Manne
> <navam@xilinx.com>; linux-kernel@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Michal Simek <michals@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
> 
> On Wed, Dec 05, 2018 at 08:29:36PM +0000, Jolly Shah wrote:
> > Hi Rob,
> >
> > Thanks for the review. Please find my responses inline.
> 
> You need to fix your mail client to wrap lines.

Thanks I will.

> 
> > Thanks,
> > Jolly Shah
> >
> > > -----Original Message-----
> > > From: Rob Herring [mailto:robh@kernel.org]
> > > Sent: Tuesday, December 04, 2018 2:06 PM
> > > To: Jolly Shah <JOLLYS@xilinx.com>
> > > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; linux-
> arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> > > Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP
> core
> > >
> > > On Fri, Nov 16, 2018 at 03:56:50PM -0800, Jolly Shah wrote:
> > > > Base firmware node and clock child node binding are part of mainline
> kernel.
> > > This patchset adds documentation to describe rest of the firmware child
> node
> > > bindings.
> > > > Complete firmware DT node example is shown below for ease of
> > > understanding:
> > >
> > > Shouldn't there be a fpga mgr node too? Called pcap IIRC.
> > >
> > [Jolly] As you suggested, we only added child nodes if the
> > sub-functions have their own resources (clks, irqs, etc.). FPGA doesn't
> > have any resources so not added . Firmware driver would still register
> > it as mfd device to instantiate the driver.
> 
> Okay, but won't their need to be child devices for

There are no fpga child devices. Should it be moved out?

> 
> 
> >
> > > >
> > > > firmware {
> > > > 	zynqmp_firmware: zynqmp-firmware {
> > > > 		compatible = "xlnx,zynqmp-firmware";
> > > > 		method = "smc";
> > > > 		#power-domain-cells = <1>;
> > > > 		#reset-cells = <1>;
> > > >
> > > > 		zynqmp_clk: clock-controller {
> > > > 			#clock-cells = <1>;
> > > > 			compatible = "xlnx,zynqmp-clk";
> > > > 			clocks = <&pss_ref_clk>, <&video_clk>,
> > > <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> > > > 			clock-names = "pss_ref_clk", "video_clk",
> > > "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> > > > 		};
> > > >
> > > > 		zynqmp_power: zynqmp-power {
> > > > 			compatible = "xlnx,zynqmp-power";
> > > > 			interrupts = <0 35 4>;
> > > > 		};
> > > >
> > > > 		nvmem_firmware {
> > > > 			compatible = "xlnx,zynqmp-nvmem-fw";
> > > > 			#address-cells = <1>;
> > > > 			#size-cells = <1>;
> > > >
> > > > 			/* Data cells */
> > > > 			soc_revision: soc_revision {
> > > > 				reg = <0x0 0x4>;
> > > > 			};
> > > > 		};
> > > >
> > > > 		afi0: afi0 {
> > > > 			compatible = "xlnx,afi-fpga";
> > > > 			config-afi = <0 2>, <1 1>, <2 1>;
> > > > 		};
> > > >
> > > > 		qspi: spi@ff0f0000 {
> > >
> > > Why is this under firmware node?
> > [Jolly] Qspi is a user of eemi API provided by firmware node to
> > perform privileged register writes. Alternatively, we can keep such
> > user nodes outside of firmware node and keep nodes which firmware is
> > provider for like clock, reset, pins and power.
> > Please suggest.
> 
> Child nodes of the firmware should be providers, not consumers (of the
> firmware). If you had a firmware interface to that provided a SPI
> interface, then it would be here. But just having a special mechanism to
> access the registers.

Ok got it. So will move it out.

> 
> > >
> > > > 			compatible = "xlnx,zynqmp-qspi-1.0";
> 
> If this same block works with unprivileged accesses, then you will need
> some way to distinguish that.
> 
> > > > 			clock-names = "ref_clk", "pclk";
> > > > 			clocks = <&misc_clk &misc_clk>;
> > > > 			interrupts = <0 15 4>;
> > > > 			interrupt-parent = <&gic>;
> > > > 			num-cs = <1>;
> > > > 			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000
> > > 0x8000000>;
> > > > 		};
> > > >
> > > > 		serdes: zynqmp_phy@fd400000 {
> > >
> > > And this?
> >
> > [Jolly] Same as above.
> >
> > >
> > > > 			compatible = "xlnx,zynqmp-psgtr";
> > > > 			status = "okay";
> > > > 			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000
> > > 0x0 0x1000>,
> > > > 				<0x0 0xff5e0000 0x0 0x1000>;
> > > > 			reg-names = "serdes", "siou", "lpd";
> > > >
> > > > 			lane0: lane@0 {
> > > > 				#phy-cells = <4>;
> > > > 			};
> > > > 			lane1: lane@1 {
> > > > 				#phy-cells = <4>;
> > > > 			};
> > > > 			lane2: lane@2 {
> > > > 				#phy-cells = <4>;
> > > > 			};
> > > > 			lane3: lane@3 {
> > > > 				#phy-cells = <4>;
> > > > 			};
> > > > 		};
> > > >
> > > > 		pinctrl_uart1_default: uart1-default {
> > >
> > > This goes under a pinctrl node.
> > [Jolly] Pincontrol node is not added as it doesn't have any
> > resources. As I understand, you suggest to still add pincontrol node
> > and this under pincontrol node.
> 
> These nodes are resources, so yes you should have a child here.

Got it. Will add pinctrl node along with below resources.

> >
> > >
> > > > 			mux {
> > > > 				groups = "uart0_4_grp";
> > > > 				function = "uart0";
> > > > 			};
> > > >
> > > > 			conf {
> > > > 				groups = "uart0_4_grp";
> > > > 				slew-rate = <SLEW_RATE_SLOW>;
> > > > 				io-standard = <IO_STANDARD_LVCMOS18>;
> > > > 			};
> > > >
> > > > 			conf-rx {
> > > > 				pins = "MIO18";
> > > > 				bias-high-impedance;
> > > > 			};
> > > >
> > > > 			conf-tx {
> > > > 				pins = "MIO19";
> > > > 				bias-disable;
> > > > 				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
> > > > 			};
> > > > 		};
> > > > 		zynqmp-r5-remoteproc@0 {
> > >
> > > Wrong unit-address and this doesn't belong here.
> > [Jolly]  Again as it is one of the user of firmware APIs, its kept
> > here. Alternatively, we can keep such user nodes outside of firmware
> > node and keep nodes which firmware is provider for like clock, reset,
> > pins and power.
> > Please suggest.
> 
> Yes, it should be outside this.

Ok. 

> 
> > >
> > > > 			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> > >
> > > 'remoteproc' is what the h/w block is called?
> >
> > [Jolly] The hw block is called rpu.
> 
> Then call it that in the DT.

Ok.

Thanks,
Jolly Shah

> 
> Rob
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
