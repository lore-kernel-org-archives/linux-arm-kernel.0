Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F52C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:44:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E69D218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y6s3a3C7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="snQN/t2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E69D218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sp27+kPOTWVdXOWOHaF1yA9yLWheoZ5usANdgcJ3UCE=; b=Y6s3a3C70pywx1
	FYVtW3TYesVUk7PoDqiFsu2Zq3VZs10JDELTRMkUnkYUYwgSF0kWKhciHRKyNWdNaaUF4kFPpcfFJ
	QNUgGZ+6uZhcOmhGoN3ld+CkltZsHCSSumcoahKW9+0M6XlE4KZy82zzXvIrpcfgXC4iXq1xDNYAx
	GQAWhwy9I4eR635CmHfRPhUCaswM8dkWFGj6X7OJqt16mLTGMXyE3ifTaCla2cVIJS4+GtnXjiPcL
	Nhxrc04AxZc0/57f8lTWDR8dyJOGEPJhdpG8pTPBsyJHnxCRgwMBA6luq86qI9kIQ/t6J8kGiBt4q
	vD5OL5zhI/KUyWqJxdtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga9rv-0002jV-22; Fri, 21 Dec 2018 01:44:51 +0000
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga9rr-0002iw-A2
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 01:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2hQA/aYd6cVTC4BrkCrILKKlnWveT/yCkOsYRJrbmA=;
 b=snQN/t2DogU4JRUdr6v2kdFsLdQDHYVBiN3GAyBRrQJoEYJhAEGjrkaYTvMPQ4273pwW1fGU/kwxeza3eqMYzUmj5UOyemwx+s21FFFYqP/2Dt/oJ9Gerv6lxx8pazcSQtrsylVVf6dXmqoDEPZQymz0lIOHnVec0KXiD/iaGI4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4465.eurprd04.prod.outlook.com (52.135.148.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 01:44:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 01:44:29 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: RE: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
Thread-Topic: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
Thread-Index: AQHUl69S+HgseDOVoEaFEXoCLLe+SaWGS2qAgADXyCCAAOU2gIAAY27w
Date: Fri, 21 Dec 2018 01:44:28 +0000
Message-ID: <AM0PR04MB4211F8786714DD6CCBB55F0A80B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
 <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
 <VI1PR04MB4222ABD43B82BD3C0B73404780BF0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <154533484105.79149.16225192496445475758@swboyd.mtv.corp.google.com>
In-Reply-To: <154533484105.79149.16225192496445475758@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4465;
 6:aijJLbJrV594lxxaUWsYh0uZGn1V5fKeuuM9ppXlw1w2rxQKpwOYb9wKoXE8Vxh581//JoTRe9N9WL4Guf892ytgUH2HetTCExciMtkDUmhwYdYv9jYqNBTgbKdGFnrt0KGrMHobh54YqaOCsCEarUagRVsydMG3awmBdKhzOhstMhtXaWjo6c/Emvtq5OtVGlN89pKy0Xr658Zh1FiQGn9QnI/y1BApnZnvkvWDwnTy5rupuT6IW3Q2mTtRqHeHCswpBIv5sa2lKjf6HSa/8a8/fkVeDqtBLnOj+2qiVXrUjVNn+p/nnSbETyKHggBe02mGFwawPqzDCETuyi2dVF4Sx3jduZHxrbt/huXkbIFVtlgDgI7mh1aaIru0p0DG6q5By1UVfViwnAN7uiFM40rmAU6Oq9icOuGFB4iNh2ufS0v57jTOXdBaWQG/DeOaw755M8cVdFqt26H4yG/9NQ==;
 5:Vreyjt8w0wVpLPV7DDWrBrD4+pcZUeHOi7Hn5kECf7iXiNIcgjU85DE87pmDYQjrIKbDsr2hLHWQpFXLDZYv2mUD9C5D9nYpnwr8F+tjUb3RThTc6QgTWCA3e2v9m0+U2mjcXke7Mi+3mQ+TdYa7egPRxbxgOXBmDGE9tkp7Fa0=;
 7:gQNyEf7pQPld+meWIqSrGHbLwPlxwFOowcz+wMpIYOrEmqkbxir5JSjDuuZx+1h8e5R26iQxUcryMz+oVZuUjsOgC6hoxeh13mB82tV8GwgEj70K0NAZ+Ku+FPUo5QAufvaOIfIsdHG4jCUVi7uc7g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc0f98d2-a849-454e-7921-08d666e5d8d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4465; 
x-ms-traffictypediagnostic: AM0PR04MB4465:
x-microsoft-antispam-prvs: <AM0PR04MB44657853F0058ED3B752908A80B80@AM0PR04MB4465.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4465; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4465; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(13464003)(14444005)(76176011)(256004)(7696005)(476003)(11346002)(68736007)(5660300001)(25786009)(486006)(44832011)(54906003)(6246003)(39060400002)(71190400001)(229853002)(110136005)(71200400001)(86362001)(93886005)(53936002)(2906002)(55016002)(9686003)(4326008)(316002)(2501003)(99286004)(105586002)(305945005)(74316002)(97736004)(7736002)(6116002)(14454004)(106356001)(3846002)(6436002)(66066001)(8936002)(81156014)(446003)(8676002)(33656002)(81166006)(478600001)(4001150100001)(26005)(186003)(53546011)(102836004)(6506007)(41533002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4465;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: izz7vx5alLWFwTHjEdERmTTlcdfwUtHjVT86/p4iv/wGYm78MfSKeghQcMaBDV1YOPJF4yIJwHoSB3r5fX2T67jq/FPHFpoxTXZYUcogdP9InhwuuI04CEFbmOPOuuvoRJlGrjkju86a+4hkGuChDbLv7lnM52zl9Lk8dSBdwA+emG+bdhCIFJxUiADtcgB7zlwJsBXGycm246uaCaJBuqQgupW/qmEw34PNvbHDQLqCG4A+Td+AzplPubEhSBeB+j8iEeLFXceyQ8LDsb3Qrv9xQuJNjkVqawVsDgEEYSDkShhj7cgmXV7Zz+y0ZhO7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0f98d2-a849-454e-7921-08d666e5d8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 01:44:28.9523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4465
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_174447_425301_7D27F04C 
X-CRM114-Status: GOOD (  26.47  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Quoting Aisheng Dong (2018-12-19 22:26:50)
> > > -----Original Message-----
> > > From: Fabio Estevam [mailto:festevam@gmail.com] Hi Aisheng,
> > >
> > > On Wed, Dec 19, 2018 at 1:29 PM Aisheng Dong
> <aisheng.dong@nxp.com>
> > > wrote:
> > > >
> > > > SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> > > > Let's make the name of clock ID generic to allow other SoCs to
> > > > reuse the common part.
> > > >
> > > > This patch only changes the clock id name and file name, so no
> > > > functional change.
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > >  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 146 +++++++--------
> > > >  drivers/clk/imx/clk-imx8qxp.c             | 152 ++++++++--------
> > > >  include/dt-bindings/clock/imx8-clock.h    | 289
> > > ++++++++++++++++++++++++++++++
> > > >  include/dt-bindings/clock/imx8qxp-clock.h | 289
> > > > ------------------------------
> > > >  4 files changed, 438 insertions(+), 438 deletions(-)
> > >
> > > This seems like unneeded churn. Just keep the existing naming and
> > > other SoCs can reuse it without problem.
> >
> > There's a reason.
> > We still need add some clock IDs which exist on MX8QM only (probably
> > more on future SoCs) Having them prefixed with 'IMX8QXP' may look
> strange.
> >
> > Besides that, as those clock IDs will also be used in devicetree, make
> > the name generic for different SoCs seems still better and less confusing.
> >
> 
> This looks like an integration problem. Is anyone using the defines that are
> merged through clk tree now? A grep of linux-next says no, but how can I be
> sure?

I'm sure no one is using it now.
The only user DTS (imx8qxp mek) is waiting for merge after 4.21-rc1 is out.
So it's a chance to update it. 

> 
> So can you leave around the header file with the deprecated define names and
> introduce another one that's a copy of the header file but with the non-SoC
> specific names?  Then you can wait for a release cycle and delete the old
> header file that nobody should be using in DT anymore.
> Unless you plan to make sure that nobody uses the deprecated defines
> somehow?
> 

Yes, the plan is to make sure nobody uses that.
Otherwise, it may be hard to send DTS patches using new CLK ID name through
different tree later.

> And please Cc DT mailing list and maintainers one all bindings patches.
> This includes include/dt-bindings/.

Sorry, I should have added Devicetree maintainer.
Copy Rob.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
