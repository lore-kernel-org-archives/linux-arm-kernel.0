Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E298C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:19:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8F92081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VX0CUTpb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="KBfZMY9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8F92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8OVsN9zTFNVbiLwFlkQ25GBWe4RlXoWV5Lfxs3PAcEU=; b=VX0CUTpbX3avb0
	y4avppDPoMBKtSnoSyUicOYOwW/SWx3T2gvzTmWcFEDT0dqRLaEZwTnPrxtRJLjyU7wmWIXiO2Msy
	1yBPoR4l5pHBDAm82aW2B3rfqDJTqiPEI7czeJzLxJZhxv4AtQr+u+tMJU1WIZEQnxixCHS7Aa8/z
	ZBy5v4Nur+TpAlEypg0Kg7UTnCrNPAjG+fPbIpWXxO5nQ+SvVHLbYZ0jE2gaVcrp46T5eI9SjWU+O
	QMrojlGCbvQe62R0UpDUAs18PNM3za5GebKEEwjLKyU0rnZeI71hRHs/TdBMZ2wTibEHp3woJZqQL
	UzSY5rCh81gUATtmt4bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAkA-00088w-Ns; Fri, 08 Feb 2019 18:19:18 +0000
Received: from mail-eopbgr740139.outbound.protection.outlook.com
 ([40.107.74.139] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAk7-00088X-Cm
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 18:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xUwBka5aoxFfXJdsqr3asEklvZXJqAZrsstupmg8hk=;
 b=KBfZMY9nvdPh18d4eTZDBP8+CjS1Z/fRY07aQxrBxuY3H1HW3bilnZESIiJNMK0S+bq6lb7DNvAa1kWYVhJUARpg26Jp4NOv9r3hyeYXA2TLI2a510RLUUxcaBFOmLHYauP26nHx9MdFgG1A5vH2nd5RsD/MCSVgBy+qxJquTic=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3690.namprd06.prod.outlook.com (10.167.236.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 18:19:10 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:19:10 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Topic: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Index: AQHUvOg1I9SIwv2NIEC65G+x/YIYY6XUSEwAgABgM4CAAQzVAIAAhmyA
Date: Fri, 8 Feb 2019 18:19:10 +0000
Message-ID: <1549649949.3075.79.camel@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
 <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
 <1549563351.3075.49.camel@impinj.com>
 <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2818d3f9-dd59-4345-0552-08d68df1ec07
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3690; 
x-ms-traffictypediagnostic: MWHPR0601MB3690:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjA2MDFNQjM2OTA7MjM6RWpVeEovZGJGNEhrOGU2bFBLY1g2dEFL?=
 =?utf-8?B?dGFWUGFqdjU2ZVNQUy9TckNmemdJaXZEb01vMTRoN2RtZnc3U01GVHdRQmxP?=
 =?utf-8?B?Y1UvMy9QR05JWTZjWDFLay9ZNU9DUEZ1Q0VIVlBhdC9hVThjNW15dWhIeEZt?=
 =?utf-8?B?akRYQ0cyazhSZDlkd2pMVGRteDF4Y1MwZDc4Q3VobXFoRFRObGRnRjhTQmVH?=
 =?utf-8?B?WWJQNmhNV2NzU1cyWVV0UzZ6SmtnOHRrUlRmaENCU1F2T1hxYXZrNCtkNHA1?=
 =?utf-8?B?byswWU1kckkyd1JvOWdFenE3Rld6SjhFUlQ5bU9oNTUzK3NRVWtMVXd4UmxQ?=
 =?utf-8?B?bDNrakZ0WlVXbi9YYXRHUFozaEQzN3dYbUQ5ZWE0TTVjSUZMQ1lmTmM0NnZj?=
 =?utf-8?B?anhWWktxcFdFeUxvbmJNVlo3dnpWWHRsSXJmczhNVWdER2hwcFp0Y0JQeDBQ?=
 =?utf-8?B?cDc5dmxINlcybVBNREVUYWlYVStXNmlrNjR1MURKWmcvWE5WUXhZa2QydjJk?=
 =?utf-8?B?MHBVaTJCeTZtZkg3RXlkQy9lQi9JZUo5UCsvakwrNE96dzBDZFVRSmJKYVdl?=
 =?utf-8?B?SzVORDA5MnJWR1pNamk4WDdBZmRVQVI4WERPWmNvR0VqMk9GU0FNZ2NTenNz?=
 =?utf-8?B?QThzSWVIallEcHRhZ043clk4TW9jZjR4UjljR09JeHNEdVJGU0VHTTlVNHJp?=
 =?utf-8?B?aWU5ZXE1QUs1S2NUQzlxSk1tNVljaDNNN20yNHFzcVpxRUoxK2x5Tk5HWFha?=
 =?utf-8?B?aEZRdkMwWEtUMThWZHJNY0JwQ2p3dUM4NDdPMlZLWXpobzhiNCsxNFFNUUlt?=
 =?utf-8?B?VkZwRFBhZ25QTndKSUZzZWE1Yi9yK1RYVEFqQlNVdDZrMVFRWlJpOGh0R04y?=
 =?utf-8?B?UUMrN0h5VHBqeUhVVC82cmt6SSthUDVyaE5sMWVnd3JQaEpsNEdmbVVHRnV5?=
 =?utf-8?B?TDUyZjBjYW1VOUpZK094YmFtOXN1cVArUmtia2gyL2QwMW82MkV5ek1Qa1BK?=
 =?utf-8?B?TFhQUHZ6RjB5YXRYSkFTSnNBUElNQnRUV05WSWVldUNhZFB0dlBRbjZ2OHV0?=
 =?utf-8?B?V29XUldleDYzYlZIZjE2d0hsWlpwSk8zQ2ljb2NOVDloeWF2dTNBcWhZM3FV?=
 =?utf-8?B?RGM0VnBiQ083NDZ0QTBrcEFUV0JMejhmbmd4NUN2RDZ3UVh0eXQwRWFTeVd5?=
 =?utf-8?B?K25OcFNSaTR4YnpjK1J6WFlQL1U4QkgzNFhtMFRMbkZBMER1ZDI4clFWZnJt?=
 =?utf-8?B?Qmk3S29TYUhnUWFDS0ZaKzFsK0NOcFRuZ1l0ZDBpS0laUmozUytnRDZiUUJS?=
 =?utf-8?B?T3NWNFFIaEpNQ2h4alBEdS9YNmkzOEFNQUJ3T2JMblVZNXVRckl0QTFIMzhU?=
 =?utf-8?B?UjNJWFJlaHdCb3BKcXJvWW44MCtMeC9HUllQaC9HbWs2STJhbmplMm1TZ2wv?=
 =?utf-8?B?eDRxMjZPNGlvSlRJaC92SW9ncEpSNWRsK2hrang3aEJ5eU5FaHhWSWliZ1JJ?=
 =?utf-8?B?cHpVTEh0WnpkVEovcWgwMnBYc3NZWEQrN21IZ1h2RERRTGI5RHZvNW40TW1N?=
 =?utf-8?B?WUJTdXRBam85WFM2UXJsZlZLVjgyN0Z4b0JoYlo4WXVWeEtXNkhWVVo0b0JV?=
 =?utf-8?B?aTRBdUdFZ0JQbkhmUVFONkxSRE1Ga1l0WWNPMWw4aVlOL1MvSGxtcWxFY0Iz?=
 =?utf-8?Q?VIbNNGfhVyr3b60YAmS4NR30BVkWiUzj+F9cnj148?=
x-microsoft-antispam-prvs: <MWHPR0601MB36902F5FE8A7C3536B5CED32D3690@MWHPR0601MB3690.namprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(136003)(376002)(346002)(189003)(199004)(4326008)(14454004)(476003)(6916009)(229853002)(2616005)(446003)(71190400001)(71200400001)(14444005)(256004)(99286004)(11346002)(478600001)(316002)(76176011)(54906003)(53936002)(86362001)(6116002)(3846002)(305945005)(6512007)(106356001)(6246003)(68736007)(6486002)(7736002)(486006)(105586002)(2351001)(66066001)(81166006)(81156014)(8676002)(103116003)(8936002)(2501003)(102836004)(2906002)(6506007)(6436002)(186003)(36756003)(97736004)(5640700003)(25786009)(93886005)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3690;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VsjXEY+9gYKov4nJAMFoko9KomAJbXQQ7PlOK+JJPpIoqVy7sD6gbGdXYiHrdr9CgHYTUmi93ofmQsaWTQq4WpPNNe5e9zJC1vYpzEfZQeSXc8aJu8mGpp1VFH4m50v8tzXbOT0zYwK95SnjQDPUwYRhB4FTgtepT7SBtMgzEURRAUcJfc0+ZPMsHk/KSuMr+qnbHfUkR6SIZw1yHVmJZlnzbGICQw66NQRsWtC565GOSAHCTtVgHKoexH1zrG+yNPYKKvjEZ5/7vKXPwvMvoUfYzB6p3DGysJKvpYYR7pNnQ+OmvMQULzD4+Ar3vnN9BNJeNiE6rZEIBlaHHw54nnfKsBOywGCiSLABlEEQMimG+cAy+wjhzlyzhVQP5o2yxXfv3EXCjM3lWjUkZaLzP0zL3j3XOAvx5CJLrDqdBmA=
Content-ID: <669587A004D0E341ACDFDB49D1119D85@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2818d3f9-dd59-4345-0552-08d68df1ec07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:19:10.4130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_101915_496685_A3633828 
X-CRM114-Status: GOOD (  18.31  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-08 at 10:18 +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 07, 2019 at 06:15:52PM +0000, Trent Piepho wrote:
> > On Thu, 2019-02-07 at 12:31 +0000, Lorenzo Pieralisi wrote:
> > > +			/* De-assert DCC_FB_EN */
> > > > +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > > > +			/* Assert RX_EQS and RX_EQS_SEL */
> > > > +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > > > +				| PCIE_PHY_CMN_REG24_RX_EQ,
> > > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > > > +			/* Assert ATT_MODE */
> > > > +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > > > +		} else {
> > > > +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");
> > > 
> > > It is a nit but the warning log is not necessarily true ie you may not
> > > have a mapped address for other reasons as well. It is up to you but I
> > > would change the log message.
> > 
> > True, but I hardly want to enumerate every possible failure point in a
> > log message.  How about:
> > 
> > Unable to apply ERR010728 workaround.  DT lacks imx7d-pcie-phy?
> 
> I would just log "Unable to apply ERR010728 workaround" but it is up
> to you. I can make the change myself with no need for reposting.

I was following Lucas's comment on the v1 version:

   the user. It would be better to have something like "No access to
   PHY registers, can't apply workaround for ERR010728." Maybe even
   with a hint to update the DT.

I think the pretty much the only way any of the errors conditions will
get hit, is when someone with an old DT runs a new kernel.  So the hint
about the DT change might be actually useful to some users.

But it's not a big deal so just change it to whatever when applying the
patch.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
