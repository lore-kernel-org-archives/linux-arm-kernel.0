Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F4AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:48:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A383620872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDMlwc+n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6PBiKwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A383620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnkV8PvSenh8OKbCeuTq67j1k8Jq8GFFY1xRKiW8Avo=; b=LDMlwc+nS2rJEp
	26svdsB8ojQBbEVrSEtwOvIAaEa1Vjq5gnQEuQ2X/XpigRcukz4WGJL+e18/kXuu93Ja/ZwQJD7Ij
	6TOIBhzRByZGI5PcvZwuLYT8law5mSQ/X2hB4G4HIXmuFjyKOBmSk86BK6Oc/lPeZKo1x1t1i4uOj
	VXK5HMYjvG5/JfvXD2r2sV0kMXjq2LFnVr0BlGAQN+KtzEZYBoNCk2EVXnnWGjObkwqpGu9W/iaUT
	x+PZDgsC+gM8tn3xmizuBA4RxvBtf12Wtz0po5WbV2MeWcJyk4swlnb2y6aVoL/T3udf1nK4lgqWA
	QvpWJGWWBs3xA4YisLTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuMX-0008NQ-Ek; Fri, 11 Jan 2019 10:48:29 +0000
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuMT-0008Mw-C9
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U+d8Y8idsgk6ylvpqOXwfi/cn+QLPWzdSaEfqXdUtU=;
 b=S6PBiKwl2LD4w8iNFz166Sdr6n8waV4AZ3/UCrqxJWve8ViqQ7gUBXcu/HQh38N1dI2jLpNFMNkUiMuhHTsk8SHZWkCcIjpZBpKi8gCnUuXLHUm2t3w37Io+wr34Idmq4m4NUQBIltwaO+V+/lOEW/4NtAwZeuLfo5nmzU4c3Rs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5172.eurprd04.prod.outlook.com (20.177.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 10:48:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 10:48:21 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible string
 for power domain
Thread-Topic: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for power domain
Thread-Index: AQHUlurqutx971slw0Wkld4RueG9XaWp6keAgAAB4oCAABhkoA==
Date: Fri, 11 Jan 2019 10:48:21 +0000
Message-ID: <AM0PR04MB42119B411244F0B1BB829D9F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
 <20190111090009.GG32649@dragon> <20190111090653.GH32649@dragon>
In-Reply-To: <20190111090653.GH32649@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5172;
 6:Dd095TJhD7LM0WlM9AIgwUAhTdAdaHCViKc22WKYIN9b1yZheQbHfYmzodbmO+F+JWkk+smSn3J92jeAjSNIcQgL6HHqT7mkJFGOrTzazpo003LrLX18n4uHIfwK2rtchShjAF+mxfqduOo7ZRqvYa6cQmi2JQMnRjp7r4LeafqXGgWKNDv55Ef8d0zyyaz0z3FAGYTO9xSnh1ekAmTHu4SPIhor1bBt7xar9drbIV2IatMcK3GZLOk1J2qJsDwy+DdCbbxmvuHIgQMYtJMhrWgmp3hOv7cSVef5N0nsA/O9IzkABq9SgPHNol6wJaznzRdeRXWeQjpPnELDlGTfT3cvqQcuF+Whd6CWIJkJGjpY5mWtGl+dHOOL0ovHI8OEZGZ780JIhk7NH2E741MWDbbMnDvUVNBPwM/KB+7OjEQPlx1GDyEnE83iNFSJwTPRWuJ6mafIAbwHo3LbLNXROw==;
 5:vAkWj3AwPBByqdLIuEL3BU71IzPTdVOO67h/qFEr0lfDmGeRJZxDblUZWR9Ghz5xgBp7GtkXNJAf9ZxtP+2GvsLcJOrEA8kDNtSk/wRBROjPkgmvi9KzDpQrrGi4zn20Vo95Lph4Nlp1lRI+5ungJRm0QP5VehG7mFVDNPAd0D/6exfjLcUEZYDmExypull/GLt+AuGJU0FeCU+5RugSjg==;
 7:AZKrYDJIm8/HmfTzdcG8gDh86N8ic1Rx7vlRKPeRysV86KXD+d3gProp/iwmelvtxbUmcPAV7JypYdsArHlNLixyPineUJoJiUxB4VrfqP+zGGRMR9CS7dmqwOlef7p4kasQZyJiQXFy7EAAgNOxyA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 462982e9-353a-4154-26bb-08d677b24e2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5172; 
x-ms-traffictypediagnostic: AM0PR04MB5172:
x-microsoft-antispam-prvs: <AM0PR04MB517292A5C92CD99AE672B55D80850@AM0PR04MB5172.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(13464003)(93886005)(11346002)(316002)(229853002)(7416002)(5660300001)(54906003)(53936002)(6246003)(86362001)(9686003)(6306002)(6436002)(39060400002)(4326008)(3846002)(6116002)(99286004)(76176011)(7696005)(25786009)(6916009)(478600001)(6506007)(186003)(55016002)(26005)(102836004)(105586002)(966005)(66066001)(81166006)(8676002)(476003)(486006)(44832011)(106356001)(97736004)(7736002)(8936002)(81156014)(71190400001)(256004)(446003)(71200400001)(33656002)(305945005)(14454004)(2906002)(68736007)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5172;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: slhzkpIhO3UQ8y1Pc6yvGctXE3I3X3MBMg5O2nmrL/z4lxQkq7eYCWyVRHWc/RwlYOE6wBQ0Q3TxkjNOOmEvGctz0Vpo1Ftcnol8bE5UFqFxw9yq0aQLiGnvaH2AFJSm4ijghXRFHFFfsjB3ZmaOiLWPqDLEQS9vaPL5XjPi1T38c+WVmny2I+akBELqLjWlalKWQi5+LaFpttm0qkPn9drfWzIibERcZzpdrV+RvihPO5cjhJc/8WiNKjE3DyCHvFjN5MJ0TbvPLxPqxr63g12LsUzFs5m3ceTjLa2k+1A3UQlit27XUJex4ljGXMThZQXcHIhKN/dLLKFy6jaNkay+2fCvJnBLP943vM3mJ0dUH5ErkP2RP/R8hDRTBSSsa4z8PS8R2o3bKa6zJACHNQNaCyeaivfurg08B21ho24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462982e9-353a-4154-26bb-08d677b24e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 10:48:21.8680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5172
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_024825_415128_A9D4A31E 
X-CRM114-Status: GOOD (  18.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, January 11, 2019 5:07 PM
> 
> On Fri, Jan 11, 2019 at 05:00:11PM +0800, Shawn Guo wrote:
> > On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> > > SCU power domain can be used in the same way by IMX8QXP and
> IMX8QM SoCs.
> > > Let's add a "fsl,scu-pd" fallback compatible string to allow other
> > > SoCs to reuse the common part.
> >
> > This is not the practice we used to match devices with
> > compatibilities, i.e. coding the compatible string with the SoC name
> > that firstly introduces the device, and use the compatible as fallback for new
> SoCs.
> 

This is suggested by Rob that if the future SoCs are likely to be compatible.
Then we can use a general fallback compatible string like "fsl,scu-pd".
https://patchwork.kernel.org/patch/10644815/

From SCU HW protocol point of view, they're indeed compatible.
Just varies a bit on the domains numbers. 
That's why we introduce "fsl,scu-pd".
But still keep SoC specific compatible string in case any special tricks
to ensure the ABI stability.

How do you think?

Regards
Dong Aisheng

> For example, in imx8qm device tree, we can use compatible below to get it
> work without change on kernel driver, while we still need to document the
> compatible "fsl,imx8qm-scu-pd".
> 
> 	compatible = "fsl,imx8qm-scu-pd", "fsl,imx8qxp-scu-pd";
> 
> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
