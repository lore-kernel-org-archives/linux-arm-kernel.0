Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E1BC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE0E217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YXPzFqXI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BgYTI0Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE0E217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vbld8HjS1s8dr2T3wdjXEnBFtscoM1rvR2H7edGo4GU=; b=YXPzFqXI/VGKrN
	TUZ3Ge4oqyNmQJhKNJI2TdrOHeyjjAcdRf9PGxYsKMmut5y2+0uZ/bN7WRBvlQVIvqsjO81vSwJ6a
	St0euBLpyWVWZSiYeKzXc9QuihR9PCOUtcNfwfD68Dfr7eZUOeoluRlyZmyn9YzZ5cXgNlQSnzaYi
	3Df7HjOcq1tdEQV4XRBMo8VpRaarrbT7udsnAwSCPLuRayfBDat/T9EmhjbG9Rq7HcOPtbhK+IfvQ
	oYYd52cGS6f73GOYj2ohpLFNlxvufBrVXxcAqKeAyM4M4vRo4ny7CTD2Dxzb5Ena/+HrYcgWavnl7
	lryqYV/RoZQUOEiFoOiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybLT-00020e-0p; Tue, 26 Feb 2019 11:56:23 +0000
Received: from mail-db5eur03on0631.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::631]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybLK-0001zT-N2
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnGVBbfGWsMQG90dTksk/W4tpWkWIZ9cmSuCU38UY9o=;
 b=BgYTI0PwKBj+oO7bPJJ/dUGqDNNN4pK4I/f3AMJHDkROIfEBl20eb8QPb2Xd6ZUHbhRYGsRL60UoPr2Z3ktxu5hdg3cUAtrVInQOKHCWMeGUukaCHw7hdDDsJIm0FEtwKF94OKlPwqTv2XI8RAi+DIrTm4CiQQ7XHJ0Gxh78Yjg=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4445.eurprd04.prod.outlook.com (20.177.55.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 11:56:09 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:56:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Anson
 Huang <anson.huang@nxp.com>
Subject: RE: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Index: AQHUx1azZw5wqQrc00um4LsJoxWck6XsQYyAgAFkewCABF4ZIA==
Date: Tue, 26 Feb 2019 11:56:09 +0000
Message-ID: <VI1PR04MB422289A63E04FFC163265FEB807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
In-Reply-To: <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8bb120c-50d6-4d47-3df8-08d69be16582
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4445; 
x-ms-traffictypediagnostic: VI1PR04MB4445:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NDQ1OzIzOnJNNXhnS0VjNVJRV3NuRmJ6U3duZWZaUG1w?=
 =?utf-8?B?L0gwT1BvNmxDSUlRMEpWNlk3VDFZdlhvVXNXMnZtQmVCY3F6LzBDc2lWT1ps?=
 =?utf-8?B?TTBmcWVEWmNZQjBRK0ZHMzdES05xVWxwR3paVVdQWjdtUDVDTTBXbThCMm8r?=
 =?utf-8?B?WFNnenp1dW5wUFR1TnQ3SVJySWJYT2xCbDkvaVd4a2hWaThESmlVeFRoWHlB?=
 =?utf-8?B?STg5MVVIVmk0aW9TdlpkS3J1czJxSHFzOS9WMi9ybXpiMStsWTRJR21NbEpP?=
 =?utf-8?B?YjVockhGYlJSZUdrdkNob0NsdU9DZHJHNksybFYwdlA2NmRrRXlZVTFmSVds?=
 =?utf-8?B?cm9iSnZMY3VkaFlVTlNIbjBGTnBPTEtMWUhhamhUUVZ1aGdEcW1ZSytIcWxo?=
 =?utf-8?B?Z3hBdUthYTBJOUhhSVRBTHN4WUVOK3M5Wk1kdjRUQzluRXVlZ1RzeHl1TDlV?=
 =?utf-8?B?bURpT29YRUxnNEo2a2dabkZoc1ZWTGJmOWY4QnFDOTNtS2pnQWZFT0VDNzhK?=
 =?utf-8?B?bUJHT2VtYkJZdUFrNktMOUx1dDFNeUxha3Y4QStzSktlU0NBOURaM0ZHblFm?=
 =?utf-8?B?WFZOdVAvMjhPM042VVBsdDFlV2JDdDVTQy9iZ0dqNEYwaXByRDNPSlh2QXdG?=
 =?utf-8?B?TEw3Y2UxSXdCc21rLzhtYlhEL3ZwbUVtNGd5cmlqenBWdWVtc0lQUE5BRDNV?=
 =?utf-8?B?aFFVZE13U0hyNlNDNkN3aXZaOEhVQm9IMjZFY1I4d042VC9nd3Z2VUo1cyt1?=
 =?utf-8?B?cWlueUZMenh4UXpvK09qb1pWWTloNFJWTWl4MHUvUFNEck5uR3gvTWRQWTRz?=
 =?utf-8?B?Z0JiQ1dacDBKSUZrclR3OGNRUXpoTWFSaGVQUTQ1Rk5uTnhuamFTNE0vdEhT?=
 =?utf-8?B?bTBOVFdEV2RHSGY1c3dWd1VmVThDZloyR2NLbHJTYjJrbkN1OUNkK05NOVE0?=
 =?utf-8?B?bnhXWldlbGdZamhRNkdBbkRlVlZES2grSUgrYzJTWVd1OS9SdEwrOVBtSHhO?=
 =?utf-8?B?UWpuYWljbm5mbTZ6TEhicmx3cVZsTTFNaTNLN0NtcFlXa243V1R0K2tQWDlV?=
 =?utf-8?B?cEMvVmlRL3lxTDN5U1YxQlhKRVhBNHRWVlpmN0RTeE4wcXE0YnVxUWxaRVJC?=
 =?utf-8?B?cmZ5RUJsanZ0bnp1clVTUnJuTTBiQTNrZWhRM2dMc1pVVnljNHRnRWFNV2U4?=
 =?utf-8?B?N3Zwd3Z5TlhjUlBIazlNTWt5aTFqL21WRksvaGRNeHdKTHpGdWltdGk0YlBY?=
 =?utf-8?B?RmRCaUZvdkRDem1jVS9TNHk0UUtoeDFjU3FtTGhaUkpzMVhiTU9YekV1Wkl4?=
 =?utf-8?B?emQvTHFLdlZ5MHRDbE5tWU40eVZVYUNWUzEyZEJkeE94U1Q2MFhGNUtnVFRl?=
 =?utf-8?B?WkNUdlpadExzY05IY0tPN1c5clcrM1N4dkhHRXIwNzZnbUpCTGpMeVc5Z0Iy?=
 =?utf-8?B?UEJpSWRXMndvY2o1ZFZUWkJYR05aTG03eG16N0FJeEt0YkVIbXBCUkNCVEFN?=
 =?utf-8?B?NFJ6cHpGTGt2OUNXTUs1SWYzNGtDWnY3VFZkTjd2SEcxazNNVGR2ZG5SYU1G?=
 =?utf-8?B?M1NobStHZGJFQStZMFBMYm9UWlR0M2hQREFDVmY0UXk5TUR5TWdXK2QvaGZR?=
 =?utf-8?B?S0FxOXNKRFhBQktldFI0RVVDcjdoVjhaek9kb2hjUHpFOGRjQ2NScHFZVzlq?=
 =?utf-8?B?SmswYlV0TzJ5dENrM2hyclJVUTB3YWFNbUNsNTVtUGkyQVUzdWJCbzFvcDRD?=
 =?utf-8?B?L1A5L2taRFNMSkNjS0dDOVVobHRmRzVHbzlYWmZCcEpyU2JocGRPNFFIRWVU?=
 =?utf-8?B?OEhINlBhSHd5WERWUDZLWHFGSzQvR0RGOS9YNitnQ2dJSVE9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB444585638DC36419BF2497DD807B0@VI1PR04MB4445.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(52536013)(81156014)(86362001)(5660300002)(55016002)(26005)(6506007)(74316002)(68736007)(7736002)(99286004)(6346003)(6436002)(102836004)(8676002)(229853002)(14454004)(53936002)(8936002)(6636002)(53546011)(14444005)(256004)(6246003)(6116002)(81166006)(7696005)(2906002)(3846002)(7416002)(44832011)(486006)(110136005)(476003)(66066001)(446003)(11346002)(25786009)(54906003)(316002)(76176011)(9686003)(71200400001)(71190400001)(106356001)(105586002)(478600001)(186003)(4326008)(305945005)(93886005)(97736004)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4445;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: akvn/Xdg5gwPJ51w4I7bVtr+QsDdpSp0HzgAiJjeRJ/VZfX8BFG61VHykWt4XzSqRrqUUbmteG5ogDMIoL5Msy0U7cS9ONZMUHgEc3mQzOe59Rgta98i0bZPPEUH7mpyq7j9kUaCDO5wEha9Nkg8l8vHifKoIsYEmn67XBpmpRSqvNedza7VyOjwBCHlHTM21FHyiM5YjIFLHkn7Od8n/JpUmbvRZgbLEraqXcFEGaRDzaBg2cicCledik7GaOYAuuxu6tDY0a6uftRZXrkHSIql3LgzH5IBjrOeAnaOASZuPa3XFM8HdNpQgL93q+WW7/ncA4WiK22+QR9aaVnHAegdKM49f7vAcoNXbFs/ankUZoD/Qv1yEpNWyktDyeG9sQn3BQqBlZR7CXBAULyr6sT5O+XfEGpmg1IBpe4cn5Y=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bb120c-50d6-4d47-3df8-08d69be16582
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:56:09.0643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4445
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_035615_586390_AB1D78DB 
X-CRM114-Status: GOOD (  17.45  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck> 
> On 2/22/19 11:52 AM, Rob Herring wrote:
> > On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
> >> Add i.MX8QXP system controller watchdog binding.
> >>
> >> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >> ---
> >> Changes since V1:
> >> 	- update dts node name to "watchdog";
> >> ---
> >>   Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10
> ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >> index 4b79751..f388ec6 100644
> >> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >> @@ -136,6 +136,12 @@ Required properties:
> >>   			   resource id for thermal driver to get temperature via
> >>   			   SCU IPC.
> >>
> >> +Watchdog bindings based on SCU Message Protocol
> >> +------------------------------------------------------------
> >> +
> >> +Required properties:
> >> +- compatible: should be "fsl,imx8qxp-sc-wdt";
> >> +
> >>   Example (imx8qxp):
> >>   -------------
> >>   lsio_mu1: mailbox@5d1c0000 {
> >> @@ -188,6 +194,10 @@ firmware {
> >>   			tsens-num = <1>;
> >>   			#thermal-sensor-cells = <1>;
> >>   		};
> >> +
> >> +		watchdog: watchdog {
> >> +			compatible = "fsl,imx8qxp-sc-wdt";
> >
> > As-is, there's no reason for this to be in DT. The parent node's
> > driver can instantiate the wdog.
> >
> 
> As the driver is currently written, you are correct, since it doesn't accept
> watchdog timeout configuration through devicetree.
> 
> Question is if that is intended. Is it ?
> 

Per my understanding, if the protocol is unlike to change, it can be instantiated
by portent node's driver.

Hope Rob can help give a more general explanation.

Regards
Dong Aisheng

> Thanks,
> Guenter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
