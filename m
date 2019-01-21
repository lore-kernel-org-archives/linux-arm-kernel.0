Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6FC37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B341520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pea6M6ZN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ev3vvwK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B341520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TTX74qZLdD5cLxP2axH2opl1qEGYIdczuQGRCdSTiWs=; b=Pea6M6ZNBvVaRj
	Aq7/a+ivppSEK/KYq07q/Jklkg6NA0r4To/aDAzeuhzGUqlandb3ozYLmIuRauICag9bCIrxlz/ci
	uz5Bsr5gX9muYjZv4jHD9q7LpxElLtTeLWauM4Tao/Oa4XSTcEOKLZ8/6p9vblESh9vP7CnN97lX2
	dza2ZFqSDh5AeeRA9phyEMxM7mk2XyVO5PIPUnwn/hImDaaf3EOk71Eldifm273khsdM2V0Q7Ifs3
	mPK3rgyn5ntLTMI6HRFVQjMNtMLHOSvFYpQtR4lnR8f6Pup8q59zTIPTFYNDaaYfG0YtPGSieW4gR
	UcMGmOe4laNgvOeSJ4Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgsG-0001Jd-If; Mon, 21 Jan 2019 21:12:52 +0000
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgsD-0001JE-5s
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 21:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcZAOGlYiU5mS3IIMGdXGN0aWrekOX5GpIl6QhncXUA=;
 b=ev3vvwK1LFx2VQR8Y7GGcJKG2fgaAMj/39vblKmNbfFFFnMn9X1Fc7syy/kfeaVIBo/HKNQxyaNmM2KDLW0cn0IrIWrM39pbsm6OkPqWWyibti5E8LhJyXhIg7aRcAT65gcCQVEKoAnJ36BGsQ4K9phIw+QSNIlnU7oRDsAvMEY=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4927.eurprd04.prod.outlook.com (20.177.49.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 21:12:45 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 21:12:45 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Lukas F.Hartmann <lukas@mntmn.com>
Subject: Re: Linux Kernel Regression in Commit
 3f7cceeab895fcc17ac8db0d9a5e8ca2954b4661 on i.MX6QP
Thread-Topic: Linux Kernel Regression in Commit
 3f7cceeab895fcc17ac8db0d9a5e8ca2954b4661 on i.MX6QP
Thread-Index: AQHUscI+oaCSJWQ4RkinV/+YiQ9XIQ==
Date: Mon, 21 Jan 2019 21:12:45 +0000
Message-ID: <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <87r2d5yepy.fsf@mntmn.com> <87o989ydc3.fsf@mntmn.com>
 <87lg3dycku.fsf@mntmn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4927;
 6:ukPGHfNa6naziCOL9gtclCFJI9uA/ahmEfk8cu/WlRWylu09lDNOKwmt2mal6/Lg7QmQ0fVnC4wkZQGtT6k5izx0YhESQKxNe04GrY1iA5wboDkK7h4GacAGoNlWaOseDTN+tFtbHrB4smPSTIq4NGT4MfbKOkGcrKtujTklIyrnB0fUCsNJIaUtvC+CGVcbaDDSnUvo9wPAeXs2eHFIJ8Vvn00JMmAOiA9yskf4sB9y8I8h4MkqQs5W8RQj2Klsj7PbrKXjSD5XDmVNF+oBouHg2Oy57yrblArarxAt34s6ATGsG1pN8+fl+4fOBqHMiaTVpyXeEDTshhOxeWsg30uwW51f/vuW2Z0C8YPiiNHfWJ1qFq19aQ/4uK+RyIfDWiJur5hu3s9vFWG0GYyL1C/wukC15buu7BDtplsN/BdLLIFC+gs/z5YvRP+3gqad5stJrmfiMisg8iWEssX3Sg==;
 5:gJ3ohE48ssHGVnKmHOH1o1g8l99jg9dHl6Nw6DpivILwEVk0vBqj/Em9d5gz4cAu8VYM7G8fr9wuuRc1rjvOXlIvZvG7ruDL1AS1PpxI3oq6xYGP6lKl8eywlJVHWYsZi2mu8bWksI8mrdkJk+bZQPdARaKhiSDarnR3WjPxT2xbi4cn3nMeUymYgbYd0znhWoEM1hyTQmsyaeZ1q0AOAA==;
 7:8FQ28QygLpFW/jypdYRe12fS5U1wxdQUkYB6W61yqUCk7fC1DGQDiG/QuDrjMEMwELZqtSSDHlEsS2r8CWynUNHqcI0YPedsXi8q/1uROQenccpFxjDvAV3osUl7W4BElkz3ASR3+3GshcRUblS2Ag==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a53240a8-5947-48b4-00fd-08d67fe5302d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4927; 
x-ms-traffictypediagnostic: VI1PR04MB4927:
x-microsoft-antispam-prvs: <VI1PR04MB49274E64F49695C2AE66E38BEE9F0@VI1PR04MB4927.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(105586002)(6246003)(9686003)(446003)(229853002)(25786009)(476003)(53936002)(54906003)(4326008)(316002)(106356001)(71200400001)(6436002)(99286004)(2906002)(186003)(71190400001)(53546011)(26005)(6916009)(7736002)(74316002)(478600001)(33656002)(76176011)(66066001)(7696005)(102836004)(86362001)(8676002)(6116002)(3846002)(68736007)(81166006)(8936002)(55016002)(14454004)(256004)(5024004)(97736004)(81156014)(14444005)(44832011)(486006)(6506007)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4927;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KbeOjTgdzvJJRUKmRjT5/FdZ1NvgjlPQi0EoLyoDGCKJRhB3TovMHH+I2dkLvACPgw5Eqppd9G3feHDxSk/vW40MAzoFLzIHh8z4DcF6UPLdcg9PInTE3dTfxOj/x8cdNDBmFcdpVaY/l8+L/sgOQZZGxlgGtT/XvkecZMk7MCyTzBPtft570thsh7NkOg9oMJEFZwzZbD8mgRnZbj04pWahWVJRQIJHJxB4XQCUmN2zP+u5DdBBu1HT7u+sRpS4eudms+xo68L3fDEvMEtAOa7QuZY44w1bMg523vEcPiWPc9IkSt8tFI0lWqKO9exZAFA/MGYugx9f6p5vN48IMsMkIgdAYg5vh+LZJ/Fo9DGx9wmHJNGzMoGU+4Ibc/I/zFSoeGs6ZRb4FbsL1n0CISnMDxGjz+qD7FtIIAOk+0E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53240a8-5947-48b4-00fd-08d67fe5302d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 21:12:45.1147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4927
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_131249_216188_66DE1435 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/21/2019 10:34 PM, Lukas F.Hartmann wrote:
> Removing the return(ret) line after the imx6_pcie_attach_pd(dev) call
> fixes the problems for me. I am under the impression that the
> imx6_add_pcie_port still should be called even if there was an error
> attaching the power domain?

The intent was that imx6_pcie_attach_pd does nothing if no PD is defined 
in DT but it returns an error instead and causes a probe failure.

Can you please try the following:

--- drivers/pci/controller/dwc/pci-imx6.c
+++ drivers/pci/controller/dwc/pci-imx6.c
@@ -310,6 +310,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
         imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
         if (IS_ERR(imx6_pcie->pd_pcie))
                 return PTR_ERR(imx6_pcie->pd_pcie);
+       /* Do nothing when power domain missing */
+       if (!imx6_pcie->pd_pcie)
+               return 0;
         link = device_link_add(dev, imx6_pcie->pd_pcie,
                         DL_FLAG_STATELESS |
                         DL_FLAG_PM_RUNTIME |

This fix is for PCI, it's not clear why it would also affect USB in your 
case.

Thanks for reporting!

--
Regards,
Leonard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
