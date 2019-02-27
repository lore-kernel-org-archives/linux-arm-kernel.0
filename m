Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B953C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB50218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxkKi8K6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wrI4lwFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB50218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uTlopGEB/vrMW+UUT97Cy3+HCkQEXoT7xYby9PzDT+w=; b=kxkKi8K6FfTWU9
	YXeb+NYJMyFgo2R2V+AnsN68HPyxYO6M795V4tw49xtYJQCR0xdz7P08uc0aAh8jX51CuoipqY698
	4pf9d+ovUx3D1J+35tOl2UuRciGqEcM2bQz4JVBkpTw/uVG0munZz0GaL7EsSjszxrb2PqHXZkzaq
	SJp5G/XwdPcrtCQr9QM1RMpfHW8up2IMbpf2Qb8CpjOQu+GLcVgBjceZV56TrBCbRTbVFTv3poBFD
	Qu5NP0m/n3SdOqyBYFU/reY+44opM1cpzMLEzSJKo2gRtBWwM7GBnsKWj8Ih5clTXqxoYGrSthIHc
	cqCC3mSFu+IMju1no4ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyumM-0006OF-VB; Wed, 27 Feb 2019 08:41:26 +0000
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyumI-0006Mv-Ct
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 08:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjIRcqc0c0z/rbI3ka1un2Krx+aSo6oh3hTNEq5Cm4=;
 b=wrI4lwFNgGNDVxznQ7TzUnbsd5a4pqW9kU7WplGicy8CzJqP0rEFpi6+bEXkV4VsjLmdP97+iROO98tXhCwOF+5ea5wSlOaV20xltxLp12RX5PI8SX81KydTHiEbHUCyvv+X1kbWpLwVkBYka2K0JXcj8VRan+W0EgNDB78TXDY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6291.eurprd04.prod.outlook.com (20.179.33.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 08:41:17 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 08:41:17 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUzcGB6LodUxnT8UyD0+K7eGuy3qXyFIYAgAFAXgA=
Date: Wed, 27 Feb 2019 08:41:17 +0000
Message-ID: <20190227084116.42yrs26i5xlkppgl@fsr-ub1664-175>
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
 <dff8a3aa9dd6501280300654f085f07c87d4cd23.camel@nxp.com>
In-Reply-To: <dff8a3aa9dd6501280300654f085f07c87d4cd23.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 698588bb-bb47-414f-3d22-08d69c8f573a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6291; 
x-ms-traffictypediagnostic: AM0PR04MB6291:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM0PR04MB6291;
 23:HJnRHuQIfGzvptHgw0J6i6kOVpbHdd59qTMndXFzb?=
 =?us-ascii?Q?GPRzX/k5MHi9fyjUs6YiwqumvehlYIFLezPWjU+I6wJIUQ1ry4YxFWfMu9Yt?=
 =?us-ascii?Q?L731ipEjpE0a8geOe/O261lb/d3oqCwwz9FNcm6fBSD9FE0z/QejJu3d/HmR?=
 =?us-ascii?Q?jEuOAMhY15D2c9WhsZC/aDHsp3y3RudbDmzyzhLl/YpyC5qZsVo0dzGCq69Q?=
 =?us-ascii?Q?CMzZkh/b49OSJ5Hg1JoEyK1vjV68qR3CaRkOaHl4W3ALmp2hZBeFKbkZgNS/?=
 =?us-ascii?Q?/n+XzS3krBPrUjQoSbZfx1E8lsW144zMDz8Us7Si+SEufe7hbvhwc6KYUYv0?=
 =?us-ascii?Q?4VDEImq0BKO6+m/PcWPyB5wpNM3e7iMh8v5EUQxOAcNxZ8G1V18Aq4c/Vn93?=
 =?us-ascii?Q?3NVH0aJkMc5z3Tkuk7ZD9aPjvkmkx2rzJI9b9bj1eDWfJYRJ0yOYdgD973KH?=
 =?us-ascii?Q?/POGR0PdabPQPrx6MALe17beDZJNVEY4LTK/uBSXNQk1zSjI6I3119NgoMUp?=
 =?us-ascii?Q?flgwTOwO4wYdIBFMI2lQ51O4XjW4eELOC+NK4NXJpi0fj0ci30MnVtvCaNy4?=
 =?us-ascii?Q?wsMXpjlb55jHHTo8/WB9YVK4g+ytPQpMUx4XvZq6+u8d2keKB3pPh8PA9Yvr?=
 =?us-ascii?Q?1mfnsFnnfNfRpSXDrdBT0FSPnM/YOcmb/Pf38KaIhSZPraRjDeVVvtF0s9nb?=
 =?us-ascii?Q?1MdPRIGcwrGjol32PDeSz0PjuYYRuwEpjvdg9BPtElhLkN3dvAh6RpdcPgKv?=
 =?us-ascii?Q?9n++eCPEE90yLgWY8awlwQIEfwT/7IqNXduSgPKwg5ESJZzpE6NKPrgC69Mr?=
 =?us-ascii?Q?nmTf8EmeTZKEb+79o2KLWxvxtLvkOH6K5QpAH44UsaulE/UarLUZ5fd9B4Bl?=
 =?us-ascii?Q?upUOzBXL6t38emvyt3MXWHu77sfVm7iucBL+emknHqHSdWls9+55vVn1mGXw?=
 =?us-ascii?Q?q8/iVo/gRM/ZUzImZWHtQKet/R+ixTE6fd9Clqr9KO6YVYd9coedfvNfM4u7?=
 =?us-ascii?Q?MQsIxYw7ByJEQm71B9LXkvwId8S8o/k+DK8bCDBNHbLbHQjbXE0qlyvg+zAS?=
 =?us-ascii?Q?l7sFKu+ule2Xiv22UoZOvQsSBXAsu6NAVoaYvb/eCdPXh2PoXb/k8AsD43YE?=
 =?us-ascii?Q?3qVXdhCXJ00mTQETTZHFnXcG074OiG+q0RzwNRnwTuWCW82DIbxDPeU3Qizt?=
 =?us-ascii?Q?F8dX5AiY4nH3UnPofi/GZlh2PHEVghub24tMXI16jHTq2tayNxrVCQiOggzb?=
 =?us-ascii?Q?YmUqGZn5oN5QIiQxwOdpILfYRoVRJjnx6aX2a7Bf8gYKdqGQf8wjH0172adr?=
 =?us-ascii?Q?QbhfTqjcPcpXUeC+5nSTYA=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB62918D1CE12F2247F728D6C2F6740@AM0PR04MB6291.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(52314003)(33716001)(97736004)(6636002)(76176011)(476003)(486006)(99286004)(26005)(44832011)(186003)(316002)(11346002)(446003)(86362001)(6246003)(6436002)(54906003)(106356001)(6506007)(6486002)(6862004)(5660300002)(478600001)(9686003)(3846002)(6116002)(105586002)(53936002)(305945005)(8676002)(2906002)(102836004)(66066001)(7736002)(256004)(81156014)(81166006)(229853002)(25786009)(53546011)(8936002)(68736007)(1076003)(14454004)(71200400001)(6512007)(4326008)(71190400001)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6291;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vh8w70H9mJFobceIPVxa2AhndLOMvFNw20kY7bvdUhfl7jWgKSHX0R9jYfYZ8CHkGXxgJ/BXAI7jNMTim66186NPhRTxZgooOk4QMxwCK+mzUTu9qNnYMoX5BZtzMdYs/hq7Ev/Xut7+2POFzLrpAHIIlCIahoEPFGg8sdAFv9E/eQQ8/XL1UdigtDGCoho+Ng3ZZl5dLnk1gTm6h1EyDNnLaVjSBZesgXcl4hPL2m6A4F8zU9eW9i9a+9/gqRcO0peEmSENwxsmC/WJ1sOuxSpUw+9wTFh1n90CXDFASKu0yvnYUCtzaMmwZcJnWDxMn4M667LJ5sALbsrud4NYK30KJj1fSa98m3vt/LPrtE/ks7DWW/xdr3xA2dYnIK2Wr76evgx9I57KRqOlmEcLtYazPgANLRg0NK+i++6CKIE=
Content-ID: <B103584CADFEFC4787F4B5784990AE2F@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698588bb-bb47-414f-3d22-08d69c8f573a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 08:41:17.5653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6291
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_004122_449237_8925D14A 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, "spencercw@gmail.com" <spencercw@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "abelvesa@linux.com" <abelvesa@linux.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-02-26 13:34:52, Leonard Crestez wrote:
> On Tue, 2019-02-26 at 10:53 +0000, Abel Vesa wrote:
> > Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> > For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
> > revision it will print 'unknown'.
> > 
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> > +	if (!np)
> > +		goto out;
> > +
> > +	ocotp_base = of_iomap(np, 0);
> > +	WARN_ON(!ocotp_base);
> > +
> > +	magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> > +	if (magic == IMX8MQ_SW_MAGIC_B1)
> > +		rev = REV_B1;
> 
> Turns out that imx8mq version determination is uniquely messy. I think
> we should try to print the revision number even for older chips so that
> we know how old they are, but this code can be enhanced in later
> patches.
> 

Fair enough. I believe we should stick to B1 only for now though.

> In the vendor tree we handle this with a SIP call to ATF, it's not
> clear why we shouldn't just upstream that (in both ATF and Linux).
> 

Question here is: do we need to go through psci for things like revision ?
I believe the cost is not worth it.

> Also, there are some imx soc revision declarations in
> include/soc/imx/revision.h. Those are implemented in arch/arm/mach-imx
> for older chips, would it make sense for soc-imx8 to define
> imx_get_soc_revision?
> 

I'm totally against the use of imx_get_soc_revision everywhere. Plus,
according to our internal tree there doens't seem to indicate a need for
such a thing for imx8. Anyway, that can be added later on if necessary.

> --
> Regards,
> Leonard
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
