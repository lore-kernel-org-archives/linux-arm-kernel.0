Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:11:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2CB20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cY1Rkf3T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yj4wgVXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2CB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SMpwAZnDOwrB1ZNz0IJ98fdHJXuKhanW78vYTifJxMw=; b=cY1Rkf3Tjz3/H8
	MVPasqBJm2vtEyhyaRxP7KhZXoACwqGpeAfEpvBG3c0G1U4dYoQ2FvLNfDZsLB4NNl+Oq4Jk2vwHg
	zjf3NQ3jF6898IPembtSJmWmLgDEw1VEiHiT5hxER/pqVxFMRp6PZuHQK10Sf41qWFPNUKWQ4qsf/
	sU3Bwq/x5wC1ndQ8tMr2HG6haWbM++Q59wEtqlIic/Kgb7OAlzEKShV2zjJsbrprxz8ctrnM4yxa2
	iM4ziwCKKbso4hIpcndNc4YNpYr95SU/+pUChh/QokWbwuTsTicf8Ntdeoz9k2wU466lIGHTuQOnH
	evWdqdpeN6en0x1BCgDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPF4-0007fF-AU; Fri, 18 Jan 2019 08:11:06 +0000
Received: from mail-am5eur03on061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::61c]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPF0-0007Tn-EA
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur541atvVjA3dzEvXFDTLojH2k7dUdBuXNPUHfRRIMc=;
 b=Yj4wgVXpxjil/JOsztDDseHRl7tWYSDJQ9ALtRn5BorefvEb0nuJ76ZSXbGj/7SiDlWLULSaxH/pKsUfLP/sZD2a/DRDFh0lrp37u76Lt1mcKXB43efOVjQb4uM1hHY4h3iHven12Oa0SmOHlZrkeumlXDSXtVJdbssWXDRXyHs=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB2688.eurprd04.prod.outlook.com (10.168.66.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Fri, 18 Jan 2019 08:10:56 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::78f9:21ec:83e4:bc72]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::78f9:21ec:83e4:bc72%3]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 08:10:56 +0000
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
Subject: RE: [v2, 3/5] dt-binding: ptp_qoriq: document "fsl,extts-fifo"
 property
Thread-Topic: [v2, 3/5] dt-binding: ptp_qoriq: document "fsl,extts-fifo"
 property
Thread-Index: AQHUrges8nJFxGWiSkK6p7Rwypn2yqW0P98AgAABSwCAAG0jkA==
Date: Fri, 18 Jan 2019 08:10:55 +0000
Message-ID: <VI1PR0401MB2237D239322218954C0C1CC1F89C0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
 <20190117014936.48117-4-yangbo.lu@nxp.com>
 <20190118013434.qwuiqi5iwo5gw2nk@localhost>
 <20190118013912.skj4x5wmkbouekfx@localhost>
In-Reply-To: <20190118013912.skj4x5wmkbouekfx@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2688;
 6:HxmzRt6/J6x4jxjVWdO1/k+CQXoGsJVwTVlAp7CBw6ZyAGf0PSj8+U3GgaXLS2H+B6WbhyfouEWkRDlz0PIJYxvm7bpShbJGTfRZWbdU6QbdMide0eb64iDj9Q8QIvWLzNQnUZ7QdEwNy+HNpVnwrq16b+nwWNNZpWmuXIL9q76kTAJ9/CBXXjaestbqXNqIW2Avp5t2mRk9NjkN07QdBr5Yg6owuHC3m93y974WMtXQzvXENtsmJYXY4TDwQ6HiNgAbusF8GHqeCtI8Ji3kf/YQ8KwZI+9tM5ZWb0zF8mUYEZq34XV2FDSudYwBvPOsn01HfRr8kWOQ/vpFvKFgXdSz761R6Be+ZYo4hUF//Ur/PDEvDP70ad6Htn8IYMgVbvkogR31/Ql80jAqwArZ4LiaLCOpEVkGHX90yGf2ijDMmVLUCGpAF0H1cwKqXwlbq4Pnh9Wgscm+3JSuz3G+BA==;
 5:S2V2s43Kwa1J5XJMtVfwuCU8RWbHAat/wrmmFJoM92evnshUBco1vcTpwYUARe04dUnFR8wkE/I60rDoXVEWvuYYklGEN1nMs+DuvSuZVPoPUqifHGZDe5k4bJp0FgElp/9Xp0DtMNqN6rYdDTkm/jfpDnl+oQiUmNm9mzoDIMjizhdHcUify4BeYH2thqn3AoDV4X+5dF3h8hzPpwUv0Q==;
 7:9yqBdnuiVPpFC4kjqmj2emvHzIH+tGFjoY/2BZl2ZaSRr8h33djUgEw5dz1v7o+EZbLTmrOSMvBBLUmgkDT89G6qxO8QKCt7Zlga78A992Ose8zWY5rqsStUaHo/Ov9zrtg+gMWEFF3VvcRMhrl3+g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46b9701b-3f8d-48f8-7c52-08d67d1c78f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2688; 
x-ms-traffictypediagnostic: VI1PR0401MB2688:
x-microsoft-antispam-prvs: <VI1PR0401MB26881373BCFA2842CF1AF9C0F89C0@VI1PR0401MB2688.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(13464003)(11346002)(7736002)(8936002)(81166006)(86362001)(8676002)(9686003)(81156014)(4326008)(74316002)(53936002)(71190400001)(71200400001)(6246003)(6116002)(1411001)(229853002)(66066001)(446003)(14454004)(33656002)(39060400002)(3846002)(476003)(25786009)(316002)(99286004)(486006)(97736004)(55016002)(478600001)(106356001)(256004)(105586002)(6436002)(6916009)(68736007)(5660300001)(6506007)(2906002)(305945005)(102836004)(7696005)(186003)(53546011)(76176011)(26005)(54906003)(93886005)(142933001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2688;
 H:VI1PR0401MB2237.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JJA50V0zAPd848hDSKzJfW7p4SGDzX1crz3IrJnDFWH36tnHs1CpsgATXcuNbX23kQgoxxAAyNjXHhc1OmOCpVg3vGjG4nkXq7F9eXfpqce2hWn65LSz4wYwKhSgiGCfE0aeZ06sE0HK/4CJ0LeW6gOm9NpkhlkOpp6lxtLiwkVpsFgY2ikRbgeP9rMeuGgpYNsrGbyx1NjBTl1BR8fWdBe4BiPuo4lLO95CFJ81tIlZ10Lt72TResxWZKVoZjWGD+hWDo29O3lq24YwQvC+1gyv75panlmcE8yVG0rMNwWB5+am22TdyyBxucHHK68w7DpgRPO1h8hHXwYnVPOD/hekx7WLy3ZYgNUrYpZLcIvvyTjWiSdCj09tBdM2dml8u81ErHZATJh209GLq8nW+BuzhSDalBJ3K8LanI6he5E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b9701b-3f8d-48f8-7c52-08d67d1c78f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 08:10:55.9836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2688
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_001102_482938_35E6771A 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Friday, January 18, 2019 9:39 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; David S . Miller <davem@davemloft.net>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>
> Subject: Re: [v2, 3/5] dt-binding: ptp_qoriq: document "fsl,extts-fifo" property
> 
> On Thu, Jan 17, 2019 at 05:34:34PM -0800, Richard Cochran wrote:
> > > @@ -17,6 +17,7 @@ Clock Properties:
> > >    - fsl,tmr-fiper1   Fixed interval period pulse generator.
> > >    - fsl,tmr-fiper2   Fixed interval period pulse generator.
> > >    - fsl,max-adj      Maximum frequency adjustment in parts per billion.
> > > +  - fsl,extts-fifo   Required if hardware uses external trigger stamp FIFO.
> >
> > Does this take a Boolean value?  Please explain the semantics.
> 
> How about this instead?
> 
> 	The presence of this property indicates hardware support for
> 	the external trigger stamp FIFO.

[Y.b. Lu] Yes. This is a Boolean value.
Thanks for good suggestion and I will use this instead.

> 
> 
> Thanks,
> Richard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
