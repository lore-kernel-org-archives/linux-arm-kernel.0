Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FFCC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:49:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BF72087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bdyf3A9X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZtcjWnl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BF72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j9u+zzD7BiAdePu8VycnDheYqwI4edzcntePISkPWlk=; b=Bdyf3A9XOgh5+p
	0TbAO/9BpXZQrGOmDk2Vr88zBJ2Yd13MwbJ9yebtgPEllR9e71DjCtXUqxgp3UCNqGoZ1K76BPbBV
	RPVZZj8Ltv70WloJJRwC8hW39cGnQ/qQOFojFLiR8D5xuIE2NEDPzEAfM5Ip+8+7grrLXCZ3KtAZQ
	c+QglFCEe1XWNAC8SaMybd3MEs2nuaJLuq5+JNLzGpkQacTHycopqRwJoaolGKcCJNkdFWxmCLrzc
	80pyfD1US8joZTky2dIl6Y5w4afDcwS/RNsQUbtCsGgidPcLGbHqoOnkl3McVUlioL59xJ10y+nux
	oolA/WIRoCM5A0isFwDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotz3-0003zN-Og; Wed, 30 Jan 2019 17:49:09 +0000
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotyh-0003hd-D0
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:48:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OGfxd5HBKlFs191917qkmtqiX9eAIoiH+V0KIfF/PU=;
 b=ZtcjWnl4n/qTVYpMUnVcriJCsOn5AzA5lq9szxbnv4Y+jgEzV1o7BpB1UPALIplogArbCZvMhR09mqFQEMR/+uWPdb414B+HJnch1g2PlLONtAwX3ESG0TWJK+eodTVta3edKTLU+3C9ezaW+v3HmsLoDH+4Z3l8X9C7hMPHrWQ=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB5877.eurprd04.prod.outlook.com (20.179.3.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 17:48:41 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1558.025; Wed, 30 Jan 2019
 17:48:41 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Subject: RE: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUfNxsajYtnIAKbkGB1ox72RwWdqXIEDkQgAB6BRA=
Date: Wed, 30 Jan 2019 17:48:41 +0000
Message-ID: <AM6PR04MB5863648E02C47B5E706CC26A8F900@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20181115173752.22482-1-pankaj.bansal@nxp.com>
 <VI1PR0401MB24968C7FA8CE3CEB291FDC94F1900@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24968C7FA8CE3CEB291FDC94F1900@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5877;
 6:lfkkus7a49xIPrNnW3YNg2Rflh+dA7rMTjoINXAQxw3S6XF72EyXjJ+h9Yp6i9DIoRanbPy3VDoXH4LyIsw/TFP/yLLnM8G3kHWZfiZzZhC24+c/jZfDBpkZtu/zmKx967FQpyQxVav2eZMeoveCN+3hptkfUZZJX2n/1N1RHzSBiMsJkzsrh5pLASNG5AXWoI4rS4O7yMZvMpzOoaK3O235tanTl+ju9TKCSyrpxqrMH5s/9QU+s32KbA6Ky8II1KABhhXH8kz87zOTQF7R9E3uYeX9O7qiNRek7Tbvew49ecpTThtozql5mcMMsgSzAe1XSGb/Kx1bIKx7KC2V+cMglaRg/GxernJ7O3b1CZZaifRAmnxfUKTJAu/rhsPE8pYZ2LolGPPX1YioImtjmqCR/CLtSL2HC6MdsoWYecrfB5CjLZTuWfbee94CGEbHG/hpXUW6CjbPP9p5Q1Ja8g==;
 5:oyUgpQ7Vgdx7eG56AYxi8u8uoTH5bDAf+umSGJ2xcjxuALP8HLZEl97R527iFBqz+kJ6XH98QY38z+ehe4lptPIQLga4MchQ3x6v6l427QGx8Z5lVAmWP7ebDzBZTL9MkkZ4YnpmsT9OtK6+DQgSQvvqS7xecMLVj6ODkPsviLizLd0H3y0yGzdMBRSVaRJ7vleVx17Zu8DQpjeuPqaaWw==;
 7:vHeTEblRuSA8umrAI0K1faFuAkFVnBfbHKk8jd7JTH6hCI6jUWhRrrc49Ju4WS+0xEucoHfssfivy9QRdcVe+z7o5lXt99Bp02f7nRlA+Dq3ihDuq/aXHzx88b3u3Ocw7xyapz6Apixez7uklz2tGg==
x-ms-office365-filtering-correlation-id: 62e50e75-581e-4b27-5dbb-08d686db2bf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5877; 
x-ms-traffictypediagnostic: AM6PR04MB5877:
x-microsoft-antispam-prvs: <AM6PR04MB58778B1ECB083E3E775403248F900@AM6PR04MB5877.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(13464003)(8676002)(6306002)(8936002)(81156014)(99286004)(81166006)(105586002)(9686003)(6436002)(68736007)(71190400001)(33656002)(76176011)(7696005)(256004)(55016002)(446003)(102836004)(486006)(6246003)(106356001)(71200400001)(39060400002)(11346002)(476003)(26005)(186003)(229853002)(6506007)(3846002)(53936002)(6116002)(53546011)(2906002)(25786009)(316002)(66066001)(110136005)(4326008)(7736002)(97736004)(74316002)(54906003)(305945005)(478600001)(14454004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5877;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fwJu8SnWwZ63Tn0IJP1WdmBjfvOXpcWBMWSDoQNDX2+qE9YBF5qTXK7zeZlqSwJg9lDb3VzU99Pnc7Mzg/VAy4CaXi+SQdm9/uoqGk85hA6PzFbfcuv6OhHfaNdGXtlmAcsr/JQWmiCxFhrxsk3xtDkVrhB2gougJlllXC2fJHY8NJABPDNSXNZgNaPzcaNT0NrB/+2z9tkfb3ZoBENgwtGLylXiZ/ULjmskji8bVoUTZYS1o+Hw5ntfMjg1TzQvWvKiRraQTtVZyTzl2rGw9ump5ibRnXfkzWHOdkfn5ehO8esCfWSheWhyYy3elxOU4omB7MWsTQM6tWBTsT9nu7x2IVnCbkX3FpoCsyKAkyHkjFNTbOJcdyWQkeWVkYRL3B27+vLx6/jxDZxUylMxY6xSmsyRjjNil3n8xpM8Zmo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e50e75-581e-4b27-5dbb-08d686db2bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 17:48:41.2067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5877
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_094847_508001_4768FFD2 
X-CRM114-Status: GOOD (  20.29  )
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Pankaj Bansal
> Sent: Wednesday, January 30, 2019 4:37 AM
> To: Pankaj Bansal <pankaj.bansal@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Andrew Lunn
> <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> HI Shawn/Leo,
> 
> Can you please review this patch and include it in your tree ?
> 
> Regards,
> Pankaj Bansal
> 
> -----Original Message-----
> From: Pankaj Bansal [mailto:pankaj.bansal@nxp.com]
> Sent: Thursday, 15 November, 2018 05:42 PM
> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Pankaj
> Bansal <pankaj.bansal@nxp.com>
> Subject: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> The two external MDIO buses used to communicate with phy devices that
> are external to SOC are muxed in LX2160AQDS board.
> 
> These buses can be routed to any one of the eight IO slots on LX2160AQDS
> board depending on value in fpga register 0x54.
> 
> Additionally the external MDIO1 is used to communicate to the onboard
> RGMII phy devices.
> 
> The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is controlled by
> bits 0-3 of fpga register.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
> 
> Notes:
>     This patch depends on following patches:
>     [1]https://patchwork.kernel.org/cover/10658863/
>     [2]https://patchwork.codeaurora.org/patch/637861/
> 
>  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 116 +++++++++++++++++
>  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  23 ++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 8a0305a2b778..39aa2731ddfa 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -54,6 +54,121 @@
>  &i2c0 {
>  	status = "okay";
> 
> +	fpga@66 {
> +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> +		reg = <0x66>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mdio-mux-1@54 {

No compatible for this node?  What is the binding used with this node?

> +			mdio-parent-bus = <&emdio1>;
> +			reg = <0x54>;		 /* BRDCFG4 */
> +			mux-mask = <0xf8>;      /* EMI1_MDIO */
> +			#address-cells=<1>;
> +			#size-cells = <0>;
> +
> +			mdio@0 {
> +				reg = <0x00>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@40 {
> +				reg = <0x40>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@c0 {
> +				reg = <0xc0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@c8 {
> +				reg = <0xc8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@d0 {
> +				reg = <0xd0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@d8 {
> +				reg = <0xd8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@e0 {
> +				reg = <0xe0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@e8 {
> +				reg = <0xe8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@f0 {
> +				reg = <0xf0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@f8 {
> +				reg = <0xf8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		mdio-mux-2@54 {

Same comment as the previous one.

> +			mdio-parent-bus = <&emdio2>;
> +			reg = <0x54>;		 /* BRDCFG4 */
> +			mux-mask = <0x07>;      /* EMI2_MDIO */
> +			#address-cells=<1>;
> +			#size-cells = <0>;
> +
> +			mdio@0 {
> +				reg = <0x00>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@1 {
> +				reg = <0x01>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@2 {
> +				reg = <0x02>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@3 {
> +				reg = <0x03>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@4 {
> +				reg = <0x04>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@5 {
> +				reg = <0x05>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@6 {
> +				reg = <0x06>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@7 {
> +				reg = <0x07>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +
>  	i2c-mux@77 {
>  		compatible = "nxp,pca9547";
>  		reg = <0x77>;
> @@ -118,3 +233,4 @@
>  &usb1 {
>  	status = "okay";
>  };
> +

No need to add this new line.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 6ce0677c3096..518882b05f03 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -780,5 +780,28 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +		/* TODO: WRIOP (CCSR?) */

What is this TODO?  Can we address it now?

> +		/* WRIOP0: 0x8B8_0000, E-MDIO1: 0x1_6000 */
> +		emdio1: mdio@0x8B96000 {
> +			compatible = "fsl,fman-memac-mdio";

This node doesn't actually match the binding Documentation/devicetree/bindings/net/fsl-fman.txt

> +			reg = <0x0 0x8B96000 0x0 0x1000>;
> +			device_type = "mdio";	/* TODO: is this necessary? */

Not needed

> +			little-endian;	/* force the driver in LE mode */
> +
> +			/* Not necessary on the QDS, but needed on the
> RDB*/

Why?  And we shouldn't discuss boards in the soc dtsi file.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		/* WRIOP0: 0x8B8_0000, E-MDIO2: 0x1_7000 */
> +		emdio2: mdio@0x8B97000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8B97000 0x0 0x1000>;
> +			device_type = "mdio";	/* TODO: is this necessary? */
> +			little-endian;	/* force the driver in LE mode */
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
>  	};
>  };
> +
> --
> 2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
