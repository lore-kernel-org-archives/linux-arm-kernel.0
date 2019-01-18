Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC45C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF9E2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VWII8tOX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EAJcrhwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF9E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C/T0JxPBjAl9gm0FNXeteieN8LAKBdJOy8DWLMEatX4=; b=VWII8tOXHsIftC
	SepdLTA7yGMqMRo7f3eQgHrJfPqk6fXhR2MoQEnVLLc7wlOX71wGQIo+ZXCULuhIrDZnVzGCt9KLx
	EQFEwP5iqOz6vWxDZJrJkXx284nzgmYTxGGOXOUD2ToE218aC657p9FQvCy0rE+2665fN/bAsV17i
	fw5FY+pyEqfMQ8UG1Pvblk96vVi1o/jWcq6y3Y1js3t1Ka97KAn5Rx/in6iTHDgIPg4V8XKZY0t29
	Dn9rjvr44NsXEobPCUQwb0k+ap8uJwt8gDZcG6yFu/areUg7YzBsJ9EYeQgMTetSGFZV3G2CKxThN
	gFHYK2TbMK60Te7KYR7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPG4-00081Z-HT; Fri, 18 Jan 2019 08:12:08 +0000
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPG1-000812-0T
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:12:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N/VuJM3SDIYE+/swSF2vdJqyRZbz4AbRBQb9bLBQlI=;
 b=EAJcrhwaifpT4ZhVwQcZKatJXSJ+zj7HLdQVurmTHIEl4uTDbScNLbCE9GW4T80Rz7NCeqPEt1Q6cAf5hCa3ishwD94+wuFpTsMkbHTI0td534nTwH08to4QKwOlv+QDlDH/Q/IfDmYfkIjHD/B7EjlN+k8Ve/1CVASnTwQ+tqw=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB1741.eurprd04.prod.outlook.com (10.165.234.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 08:11:59 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::78f9:21ec:83e4:bc72]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::78f9:21ec:83e4:bc72%3]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 08:11:58 +0000
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
Subject: RE: [v2, 5/5] ptp_qoriq: add fiper pulse loopback support
Thread-Topic: [v2, 5/5] ptp_qoriq: add fiper pulse loopback support
Thread-Index: AQHUrges4CETkyws8UCdTx/+7Hi2GaW0QpkAgABsEsA=
Date: Fri, 18 Jan 2019 08:11:58 +0000
Message-ID: <VI1PR0401MB2237C5DAA0FE89689B470751F89C0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
 <20190117014936.48117-6-yangbo.lu@nxp.com>
 <20190118014420.rlyk36477cqj6yb7@localhost>
In-Reply-To: <20190118014420.rlyk36477cqj6yb7@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB1741;
 6:3vgwIF/ee6RXvK96yENg/dWnIqpxDELZ5I88XdaYiawi0eY92osrIJVzw6ITxMpgECqd1wfuOVbSsqtXa9f8SabqKghtM5iet5uZdIej3/QcDolpmBehTNgD3Bavso1Y9/aquXagogg9R3WNQwO5VsHVxdr18FQi+M7becZlYfaZNjn/A+yuPyYHmQGsi/RGyYO+5r6Jkwhscv9PoxlCoM28J7Tyaqwgut/3rY1F5j4qph7THssUAJ9tgpl7QUetfzINOEhtC+nyW4Vujh4L7luWGBWeuPh1rZBjUwoEaQOeogvtQsPiJwjN32PXeyzZxeO4mZmoSwk9q5qZXtkvfYg/w/eUJydDMW8qgUMVGcjadgc05UGDdK2z7Ns52B3EMbUKK2yXNxebTvHCunZLBXlP8f3phWKdg76yVhXKvTTDj1Eb02L2wFpD6ZTr2XEAGKZYlzjDRgGKZQBenxhjkw==;
 5:DyUvrIq6Wmwgz3qO5QZshM0t//27oprZtc6hXGPmjFf7jK6w5YYuXYEgRwzilLpvFBsl74h/irdouZZJ8+kEs+JFd0AhUb7wwos4KlAQWJHE65zgz4BnDuLLP8+7hF9/RhUMFXTtEInw6iXf2xx2DViJuSR1ly1CSqB170Gs6EUsUzdQb82Zt/w/0K6mbXpAAGoS8rW8HSglSDjJc8ZiMA==;
 7:nhqpMRUeTJSiWj3JGxBItCzwzcrRkxAxmeflmtP0kjTWXP+HSE2rKfSYAYUiq9ROnBDWgce66rZjqC64J3TOjySFPrykeJjkrtTlszw9a7xIRG1SJ7sqhhCLH4DSSiT9VQeg7f2ASRXOFCOogI1bOw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 247b3f2a-6e73-4c08-f34a-08d67d1c9e67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB1741; 
x-ms-traffictypediagnostic: VI1PR0401MB1741:
x-microsoft-antispam-prvs: <VI1PR0401MB1741FCAE1E1E37F1364FC7CDF89C0@VI1PR0401MB1741.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(13464003)(199004)(189003)(97736004)(74316002)(3846002)(5660300001)(478600001)(86362001)(6916009)(446003)(14454004)(476003)(7736002)(11346002)(14444005)(486006)(102836004)(6506007)(106356001)(1411001)(105586002)(26005)(53546011)(256004)(33656002)(186003)(305945005)(55016002)(76176011)(53936002)(99286004)(6116002)(71200400001)(71190400001)(6436002)(2906002)(229853002)(81166006)(4326008)(9686003)(6246003)(66066001)(25786009)(8936002)(39060400002)(7696005)(68736007)(316002)(54906003)(8676002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB1741;
 H:VI1PR0401MB2237.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D8VWuq86yCoZB/GcuqCsGAnrlpvdXU+kTEJ2+DlnOsfthboav4VtPeBsqJIEqZAGh6flIOOhnFUWsk1AtIORObxUaf7Tzi+y++R046riytHbHQHi836I+0n5U1DPxwmoDt7OiDnG8teYGkvxHyc55kAfD885fVdlF7uRwqC6ZB8HnIuj6q2lvEjeGq1wO4JdfUasNgZizVbzTSAAdK3o2R8X7vU+aF4nKPNUBYDkTndzX/opsihp9/NExjLwPXV39bOR3VbS++QerdXkHXyKSOXSLaMSnPcz8IONjJFccibUM85qM0Y++TPdbViOgjUMbCi27ocy4oGWUl6S8OylTvfvIbfsSuwvt+Rpy8zp4s8Ot5+nEj0Gcdb18nubIEaMqeAnONmcwFILc8dUzKoWM5vaJxt+K5GZY7HpjLZBZYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247b3f2a-6e73-4c08-f34a-08d67d1c9e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 08:11:58.8422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1741
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_001205_054041_87901E5B 
X-CRM114-Status: GOOD (  12.77  )
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
> Sent: Friday, January 18, 2019 9:44 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; David S . Miller <davem@davemloft.net>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>
> Subject: Re: [v2, 5/5] ptp_qoriq: add fiper pulse loopback support
> 
> On Thu, Jan 17, 2019 at 09:49:36AM +0800, Yangbo Lu wrote:
> > This patch is to add Kconfig options to support fiper pulse loopback
> > mode. This is very useful for validating hardware and driver without
> > external hardware.
> 
> To me this feature makes more sense as a debugf-fs option.

[Y.b. Lu] Let me try debug-fs and update the patch-set.
Thanks for your suggestion.

> 
> Thanks,
> Richard


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
