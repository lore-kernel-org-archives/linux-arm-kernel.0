Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835DFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:48:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55241218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGMFQTyK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XbdXCbJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55241218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pZ9DSaJGPej5/1Tt9a1WcozIqoaCjExo4yvdL9iqnlQ=; b=iGMFQTyKvHSkMX
	51dEBZCSpkWUTxMouuUKBlc3YDykyQ8wHur+cKg0n+Ex9pm/4fTYHkJssbwmyzeR3c0+EqGQ9mIiq
	XCXi09oaUTg2la7eyhPwtAEewCHv34Kp/bRrTxhFPRlJosOqPBtF7njYldzkICc29r19X5VmdjXY0
	34tMMzU24fwFIwQK8HT77D+klQ3XWY8ZBn5Baq+3G3pu5Gq2lnKnlY2DDxVqzcTrh3kMLTSS88KDN
	6cYcf8NXwnJqd1Qvkl2WGXta96gnEiNWcZZNdxVZceUA5jnzddSIluMLfAGc8zERRdK1ZuHwg9/lk
	LPLF+NF1Dcb0DAASLr+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyt0n-0005of-Sn; Wed, 27 Feb 2019 06:48:13 +0000
Received: from mail-eopbgr810040.outbound.protection.outlook.com
 ([40.107.81.40] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyt0k-0005o1-Ac
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 06:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXqpwuGBKPbn19AMnfH0ZEaTvpyCjs2JI0X+1t/YMQg=;
 b=XbdXCbJ/WgvzuLbGORKFVo3cVaKZffbWVpmem8f5fVAE29Xnfb2zfcuxmeVUAIZo0c34XJXtK5u6Kv+PYewzaW/XT28vz2zXcgw2Rt6X0eVquO7LCvj4PzfBWHRv57vVIcQaDPw4XCv4GeV7Hs+ehwrRPPPR4fNg9B2wGQlWxno=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4102.namprd03.prod.outlook.com (20.177.184.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 06:48:07 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:48:07 +0000
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/5] PCI: dwc: support remove
Thread-Topic: [PATCH 0/5] PCI: dwc: support remove
Thread-Index: AQHUzcoXCJUfCkpNIEa0Hsr7++V4qaXyk/uAgACfQAA=
Date: Wed, 27 Feb 2019 06:48:07 +0000
Message-ID: <20190227144102.40d52f11@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
 <CAErSpo4uC6WMt-RNxn6_XG9Lcy+jA0X2bLF3cpVDWC9Sh6AbaA@mail.gmail.com>
In-Reply-To: <CAErSpo4uC6WMt-RNxn6_XG9Lcy+jA0X2bLF3cpVDWC9Sh6AbaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:404:a6::20) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a14d1dcb-10a5-43ec-d3ba-08d69c7f87b3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR03MB4102; 
x-ms-traffictypediagnostic: BYAPR03MB4102:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; BYAPR03MB4102;
 23:CSXcrprNpJsEj4tUmYYH1IXoeEgzRqSPMAS6i1mYH?=
 =?us-ascii?Q?sOLa5J4nW39FR0uWsmT412jeuLEOfw3/31oQQrEluKvVVU4efK9g7FQWuDuA?=
 =?us-ascii?Q?3LXiZcf8Ll9LzWAKBTwZeJJYz2cOLwTr0Wtv/DYqzUwXS2VIf+M7ycT2+veU?=
 =?us-ascii?Q?0E9JwrBcYrWor6gCt3CgluZqINoC3RR4jo4RnPCEU7M/JhQpDWsX9eVHh1YS?=
 =?us-ascii?Q?ei8ZDdLxFzfFDFn41xHmgQGamIsRx7/3D1EFm55HDzsME90WzmscagOVnRRx?=
 =?us-ascii?Q?OQGxtyhuapoTYNndU0cv656O7t3RT7e7dC1kGigddI7QVKj7RVBGzCeuZt8h?=
 =?us-ascii?Q?oTD4mUP8eaLXeL8dZmd6lbqdH1A3yhHgMa5PTr1KukLq8vy2pk2uS6jmmCNh?=
 =?us-ascii?Q?nWexdHF/OVz+EIc4EQG0uM1nPrkEn+ihAeXayzcP8xZsF9ExuCk4OrZbCHZt?=
 =?us-ascii?Q?tQaHctglTehp+MGCdmO9EzfVg3Q+pg1JppKdG2IK9awixQ95HR0vg4ryLsgP?=
 =?us-ascii?Q?EZB13XJKGm3+HEq7EFWAebrmgArHsDHufurweQkY9cb6lFGkS/6oYuSGU4AF?=
 =?us-ascii?Q?CdhccT+ifec5+yXYP14OWicgYPQp7EKgda2BsldrB3E/rtzhuqFMXPjdSD+a?=
 =?us-ascii?Q?28kwqp7ooZCk277Y7ueJg+fxPcqevT8qK0BiNacatMISaL2TsCTPMtfGWplt?=
 =?us-ascii?Q?XzA2t8ulSO8fF3A/FUo0eh2CcapbRF63DSRFQF34hfrsxhsHwny7vQjA2v1D?=
 =?us-ascii?Q?e9uirDFywIHI0GwxtdP5nUL5u1iKjdzS9u9NRIOm+4satmCsFCakNxBHNBoF?=
 =?us-ascii?Q?57Fkk5AYZUq1gYcID6Y64Rz5fYN1xuOBAc4utlUYQ5yvZFs4ifkAyEJZFnW+?=
 =?us-ascii?Q?1akpbAvSPw6UhDKsmUwuMQQ/I2AyMEtd9Xnnk3stpgUJaNrEQw3Ur2eOqaiK?=
 =?us-ascii?Q?mhZpHVkCyRDvk8apcqIo+aP59uk8i3974FW6KfB7aDIsSaxi32svYhboq3rq?=
 =?us-ascii?Q?v9jG6skCt5CjMA+iDsr8dYj31G1qr1kqnvTjJHd6SGp+xyHDNB27+RUP9xhC?=
 =?us-ascii?Q?je5FOJ/pNeKhNj3iR1Eu8Yo4kbMm6Iqe6oeWF7+mFSZkA8aJdl8Oz7sE67io?=
 =?us-ascii?Q?yqf+BELH5dCbhBrXHMkjkiEHb8AO/bAd1ScJbkA1YnAKsiQirjnZ3xbGuwbc?=
 =?us-ascii?Q?9PZYZMj1ryJgRnPCMn/+VrUFC2Xq4fPP68V6O//bnRPKut7sY5WhVujoC9kf?=
 =?us-ascii?Q?R7UhA/P51uM1meRKpiwA7w/HbC+gjKZ0ZxwULvJ8pFmVwBi2xeZNpRCyNWvZ?=
 =?us-ascii?Q?DChR6jZEVSPN2y12RxOEZQUPKYoDVFfpsuVuGnQLfr4?=
x-microsoft-antispam-prvs: <BYAPR03MB4102214B58EE5E028C9C6B46ED740@BYAPR03MB4102.namprd03.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(51914003)(199004)(189003)(6506007)(8676002)(106356001)(105586002)(11346002)(102836004)(26005)(316002)(81156014)(81166006)(229853002)(6486002)(54906003)(71200400001)(6436002)(256004)(71190400001)(186003)(478600001)(14454004)(72206003)(68736007)(7736002)(99286004)(4744005)(446003)(486006)(6916009)(53936002)(52116002)(305945005)(6116002)(97736004)(1076003)(9686003)(53546011)(6246003)(476003)(86362001)(50226002)(5660300002)(25786009)(76176011)(2906002)(4326008)(3846002)(8936002)(386003)(6512007)(66066001)(39210200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR03MB4102;
 H:BYAPR03MB4773.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3si6A1m2GIEhihCtXC1IffMVjtR6Oat/sEe8ecLtflenGroBhivDk4fRA7aXVqmX9tghmg89QYTJP1YZHLdPUVqo9XUNEhxFp+CvAUB8cKfQaZdkL2DsJVtSLE0Ra38/cEIX2ijnuilHVuYwdelEImhuuG+l1d7T4TLQQimIp1i0+C+9Hi94MaP84skXUXhUrz+ZSZt+TG4Ok7otTW/JK5qxJA6Ay9v/caKod3fsrMaNIwlBl/ZIgXMOelIIY/0GGMP0E+ClRRSh+D6f23YLSo6CaHRVnoS16LEPbGYoi1fMcYb0YeEWRkVtasTErm8NDeU/xibUuiPYlBrHLnix3mFUZpFHOR2DeUU9LogPB3T+3HJRin0hq/AjWw51uyQgTVd/m6IHUCy8hn7oAePrwyDCkExDMh9KolAp6OSP4qw=
Content-ID: <EFF2C701EA8CBC48AE6FF1926A402813@namprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14d1dcb-10a5-43ec-d3ba-08d69c7f87b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:48:05.0428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_224810_422610_504A061B 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 15:11:03 -0600 Bjorn Helgaas wrote:

> 
> 
> On Tue, Feb 26, 2019 at 5:55 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Currently, the PCI dwc host users don't support the remove, but nothing
> > prevent us from supporting it. To achieve this goal, we need to ensure
> > we can do necessary clean up work.
> >
> > Jisheng Zhang (5):
> >   PCI: dwc: fix dw_pcie_free_msi() if msi_irq is invalid
> >   PCI: dwc: free the page for MSI irq in dw_pcie_free_msi()
> >   PCI: dwc: free msi in the error code path of dw_pcie_host_init()
> >   PCI: dwc: use devm_pci_alloc_host_bridge() to simplify the code
> >   PCI: dwc: save root bus for driver remove  
> 
> If you post a v2 of this series, please:
> 
> Capitalize the first word of each subject, e.g., "PCI: dwc: Fix
> dw_pcie_free_msi() if msi_irq is invalid"
> s/irq/IRQ/
> s/msi/MSI/

Thanks for the review. Will do when post a v2. I'm still trying to
collect more code review comments.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
