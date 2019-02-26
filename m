Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4C22146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JH0mcd5k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wwiKy+0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4C22146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dNGBsmfjMfFdgq2/8USN9pE8rgqo9tHUlMsy/Y6kD/c=; b=JH0mcd5kkU1Bd9
	HHZGYw9e8GBlWcjk2QeCMluFKA2gWC9TtFEtfQc+I/JElT9+ez5bM2Jwnhkf416M8aVnIQf+aJutv
	122EbpWujPGluDxLgzLC5jKftYtBhrvsnuAwbnXf0FaaKQXUcFy+KSB1w4BjWiWnYqol5fMNptfFq
	G+94nBuxq5+3X1Ssym2e1RvcrWOdwTUNSEMCvtlCUt1lIRWPRNYgQZtajV5sywnGIN7cyYAsOhUwZ
	poJAkgcfbqonXGhD0i0QyHpt0daY6EJBZeJkFzkXVi+y0225Je+hfZBe6ZqOkadv8IyBRrRv1qlkW
	KdcWeReRI5MO0gAwtPwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyakZ-0002lx-8v; Tue, 26 Feb 2019 11:18:15 +0000
Received: from mail-eopbgr140080.outbound.protection.outlook.com
 ([40.107.14.80] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyakW-0002lV-04
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQQCxVEvcrBLDm38wVAHrYT5y4oaVzvDp6l/WjvZG9k=;
 b=wwiKy+0Ns4jKHzK9tap+5vk20K1uWn/dQ7YZfU2b6gokuMCCo5sk7zPFZTeA8kInLxzqcQx99ugcBMmV4VYFcbgsP/qBMS8lodkPKmv1dnfvw1EhmtuE0jwk4pEfx9XtCmu478tuXbdklPQFtogHG5eFxEgE7a5g3uLhTvffntA=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4879.eurprd04.prod.outlook.com (20.177.49.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Tue, 26 Feb 2019 11:18:08 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:18:08 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4CAA5A8AIABK8BQ
Date: Tue, 26 Feb 2019 11:18:08 +0000
Message-ID: <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
 <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
In-Reply-To: <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfedda09-20b5-426f-5aa7-08d69bdc1603
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4879; 
x-ms-traffictypediagnostic: VI1PR04MB4879:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0ODc5OzIzOlg4WkJTZEkvRFJES0NWTWgvc1JCaVVQL1NW?=
 =?utf-8?B?aXV5VzJVK3dRYlR0YUFQMmlMRGc2c0xKSURVc1d3Zzc1Mzg2OGg1KzdHcmo2?=
 =?utf-8?B?TktLRmhpM1FFUU13RUhaRzIvK01jcHJpSzk0UWhxVGZrUGJhZGh3akkwSU9s?=
 =?utf-8?B?VFpGbC9WbklLQ0E5OE5MbnhSb01oaFIySlhpcnhMSWJLVy9OeVRrKzhaWlN3?=
 =?utf-8?B?d1JZeXk0MjNEYUpFa09ZTkRaeWd0TWlGYUUwZFl5dUFtVjRKSjB3TVlNc1V6?=
 =?utf-8?B?QU92L251ZWE5eC9Lc05PMkNWQ1N4STN2QWFTYUhmb3hOa0pKQlJKbmtBV3JP?=
 =?utf-8?B?VnRtRkZSR0dEM3hISUlnVEFxUEZSczNkOTcrTkZMQTlKZGUyNW9zaElhUFNw?=
 =?utf-8?B?VkVZSi9QMnVYTGdENXdDVm4vb1BKUGo0Mm55cmxkdDM3S3F1QkUxTGhCR04z?=
 =?utf-8?B?d3NWc3ZmaFRPM20zK2NoQ3FHNDVCdFlSVmx1cHlzVm9MMEl6VFJ5NnRDaDRw?=
 =?utf-8?B?OEh1S0VzV1FWZDY5QUNOczJ0amltUGxia0dsUmdVUTNqWFd2Z1lCQTdIWVpN?=
 =?utf-8?B?R1VIVm5KUmd2NWNaWGdoSWcxSXlKM2dmNjFUbC82SDNGeGRzREx2cnZqdzJF?=
 =?utf-8?B?ZXJLZVV5dGhUYm9XTnRaZ3BlVFY1NnIxZzRLaGNNM2tqUTN3Zy9OcW5rdWpI?=
 =?utf-8?B?UU9NbkhUVFF0Tk1vd1lnenJYMmtGalB4WGs3N1NNRW00emI5eVFSSjZBd0Nm?=
 =?utf-8?B?WDNGZG4vQmVPUnVuWkl0eGgrekIwS0tIWGozaXBzeXRFd0paT2NSTnVnUnRZ?=
 =?utf-8?B?TC9kSGJNd0dSR0VTdWxnckRQR2R5T3U0MmxFWW9tQUxhTGxkc0FhM0JKRHl5?=
 =?utf-8?B?cFA5ZFZSYXFrSW4xQ1l3TDhWSFFJeEJJRC82UUdGSThLL2RtRGF5NVF2bmVI?=
 =?utf-8?B?dHVtU3FuZHVEdnh6LzRpVmdQOC92T2VPbHQwUW1ubTVpalp3OUorSWVObnRj?=
 =?utf-8?B?NXdzZ2RUa3JYYlBaMmFVTDE5c3E0Rk5LNk5RaTRzUDVadjR6ME5wOG1tZGdx?=
 =?utf-8?B?NDl1TXlMZFRSSFRXQWFsKzN1d285d1J4OEhPZTNlMlFEKzRPVVRNWnJraWp5?=
 =?utf-8?B?RHhwZUw2ZWx1UHhtTXR6Njk5Zm5kSlo2Q0U5WTBCL3BHbk5lV05BUzF0RE54?=
 =?utf-8?B?WUo1a3d6THhPVUc3TTE1Yk5wNGlsQ0NQODROSU1RK1licWloOFU0K0R4REJm?=
 =?utf-8?B?eHlLUmZXVDFCVWhuUlNUYk1xSmoxRHd5NTZzQXB6djRjUzZ2d3NORnZubUZS?=
 =?utf-8?B?OGhmU2cyZXZLZzRNQjJudERNUFdQellxbVJxN2lyMHpGMHE5M3FrWXRMKzdX?=
 =?utf-8?B?L29sc05qcEFKOGNQNXRiejM3S3FkZlFVT3ZjcVdoWmVMRXdzOEYrUVlzTFBl?=
 =?utf-8?B?STJaR0EzREgvbC8yRW5LWlpDZ0RuM3V5ZzhKY2NPR3Mwb0J5QUNZc3A0SzI4?=
 =?utf-8?B?MXdVR0JCcjhpKzR5YjJOUFRZNTRIOXJNU2pSNVlRUm16U2JCSmdqZGZUSGJu?=
 =?utf-8?B?TzJFc2ZRTnUvdFpWS1g2ci9qRko4QTM1NkhOUVVQVitpNTJCbEZoekMyWkht?=
 =?utf-8?B?NFZVbitYeHp0M1FnUTVLSTJwT2hvOEhRaURuNXByaTg1NmhEa3JDVmVHOVc2?=
 =?utf-8?B?QVF5TFZiaWFiQm5mb3BPQ2gvVFhiSG5uWG5UeW8rMjNVZ2hSdUVtNVgwZ2E3?=
 =?utf-8?Q?ZUzV5iZoaMhSS2IRuwndSOkej1eUY0rBa5oTI=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB48793A62C7C960620306F15B807B0@VI1PR04MB4879.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(51914003)(305945005)(99286004)(6436002)(76176011)(74316002)(5660300002)(6506007)(66066001)(53546011)(4326008)(9686003)(7696005)(55016002)(52536013)(53936002)(102836004)(14454004)(25786009)(7736002)(26005)(478600001)(86362001)(3846002)(6116002)(71190400001)(71200400001)(97736004)(2906002)(54906003)(44832011)(110136005)(106356001)(93886005)(68736007)(186003)(105586002)(486006)(33656002)(8676002)(6636002)(8936002)(316002)(446003)(256004)(229853002)(11346002)(6246003)(476003)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4879;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qEyuKWPyj3Fm+cBA3K0uZW1H0k8yvW2+/Zxl03GLH6zdBaxpseeOexbnx7oi8c6/hJU+8SzefnYePwMECXmTOaqg4k7zXJE3UR70CiDMZafyWEeLLXflwGSM/JyhppISmhbWj8gh6bYDFK1MI/ZfxPUMEi+UailkAoASo1HlgK11I1lZf3F5md+vFyo9LbAcdU5XdmfVgizLfp0604nvhpHqGjaI6TMNk+WYtsyqwQsJQVmN9TDi0MFvjzvJTPPv2NKTJ7LkluIXSWtO60IUEzwpowd+yAtuk6CcGs2ObjIdbU0WiUPo/YXyM77ztVABzjdw1y4ur+ROQl79fJ/O9ZJ8xZNRs6B/+K4Nv5O1mHsxHXCJoohUxVsIpb+8zoZKRk/LHfFGaebsU/GSSTmBbjgO3+PPmtDl9Rc9aTutTlU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfedda09-20b5-426f-5aa7-08d69bdc1603
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:18:08.2401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4879
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_031812_451149_886317E8 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, February 26, 2019 1:23 AM> 
> Quoting Abel Vesa (2019-02-23 02:58:14)
> > On 19-02-22 09:46:23, Stephen Boyd wrote:
> > > Quoting Abel Vesa (2019-02-22 09:07:32)
> > > > Make the entire combination of plls to be one single clock. The
> > > > parents used for bypasses are specified each as an index in the parents
> list.
> > > > The determine_rate does a lookup throughout all the possible
> > > > combinations for all the divs and returns the best possible
> > > > 'setup' which in turn is used by set_rate later to set up all the divs and
> bypasses.
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

This significantly simply the clock tree output.
Thanks for the work.

> > > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> > >
> > > I suspect these tested by and acked tags should have been dropped,
> > > unless you discussed and tested off-list?
> > >
> >
> > Oups, I forgot to drop them.
> 
> Ok. Can Lucas re-test?

Tested on clk-next by cherry-pick a few defconfig patches from imx tree.
So:
Tested-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
