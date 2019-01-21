Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59231C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:38:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A49217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pA8lBDaR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nRbMqtf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A49217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JDkfVqwBAlAaAVeND4QGOt7cIQrPJzq5cd3Ur4LjGgg=; b=pA8lBDaR5XIM2o
	cLrqAeSbwhk2s6rkGbjVIb/7b6ZFpQ8APk2/Dj8AytEoj69aZNfwLAR/L+h3JwBGKcs77gSGDCZm+
	kjX8WGimUY7WXvio9jQ3gKWWUSFOclK/kIisoqXPtqykIWhe3kixb5orRSC46zsnLITlDP+6dDd3v
	cxYGcBf8z36ziFO1C74YKJYiIoRM4ajrtXX6tDYsXy8q/VgVzzOS6dsj8G1FNj6nmcVYiefEpPjr/
	MPhwyhgkgla72RE13NdVQ5Ji7O0JAaeuZMMD6kCKM+mjaJypVjYWrTWcFoi2XhAsvfQ+4/PlJQ05O
	Yg7lA9SkheloqJvj4aBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glRML-00013P-T3; Mon, 21 Jan 2019 04:38:53 +0000
Received: from mail-eopbgr800123.outbound.protection.outlook.com
 ([40.107.80.123] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glRMH-00012s-Uy
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 04:38:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQv7JthSMTjrqEZ1WlF5HyVOEVSCMeK8YzxLTv2G7dM=;
 b=nRbMqtf3ju2nC4Y7W9HJLNVTVb8XkYy6e9HYg4yW42H4eAb7+Pyd0kaFx1sRH0NpOWMrCELiQLx3PqywjPOreuLZ1U2hx1UJnwKFyH/IsMAbji0FyGtRaELAKyjl49z0HRq6hGIptc4d0dXVixhB5mS6XdTAV7ITMvSgQfI8Lzk=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.4; Mon, 21 Jan 2019 04:38:44 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461%7]) with mapi id 15.20.1580.003; Mon, 21 Jan 2019
 04:38:44 +0000
From: Michael Kelley <mikelley@microsoft.com>
To: Michael Kelley <mikelley@microsoft.com>, Marc Zyngier
 <marc.zyngier@arm.com>, KY Srinivasan <kys@microsoft.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Stephen Hemminger <sthemmin@microsoft.com>, vkuznets
 <vkuznets@redhat.com>
Subject: RE: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a hypervisor
Thread-Topic: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Index: AQHUghEnmAHBKrXmHkmtduFUzC9VJqVzciwAgAb8qWCAAjmMgIAX6uiAgCTrELA=
Date: Mon, 21 Jan 2019 04:38:44 +0000
Message-ID: <CY4PR21MB07733F173EDDEA6B83458EFED79F0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
 <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
 <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
 <CY4PR21MB077301ECE13325F8C75EE941D78E0@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB077301ECE13325F8C75EE941D78E0@CY4PR21MB0773.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-04T20:05:07.5544968Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR21MB0821;
 6:OyrIvhOXEaBJSkqHb76wro9m/mF9x1JCMMCHPb8/goG9NXhi1Ac3C8v25XEppvTUeuZGlUVy7oFjf5CTdx1VZIPriyxpbMXBNXNe050b8mNgWJR1eHnxkCDDSACEvr+fMb2cwV2/BysWPBsJlP3xIMGKd4McyY2BYrdeeo2rmox7POyj+k/++YA63qB8mwnhHI9MSJ0WQ4l6KiGi1m9kS8CCFGQfkU/0g8/Sd6HqZx1IWvbwmejgHbCUUMqknulkDLXBQIFIUoP4WYnzX6f83c6QyDetUcFSlmnQRsAtsUM3UET05wqLkG3vFZA5YmP20GHN8X6+2Fd5eRm+D7N0el3rkbwxhkSplzr4rMsBWJaNW1IG5AZK6vMIuRDurYdtUaDVKS+K564B0583ILERxFjnKR3oAWipz387TmoMvgt6ulCvgyQeV2UHiDqXGwHEuFxVyW1ZgnLdC0RtI1xqiA==;
 5:/f+PAznvQGQ1cIltTz6yS5F/rfWHZjj5SXx3yT1d9er1I8K1iHq6X+ao//pdwlwYlOlQaVDebQhvENXD4IhaoSLzzUejNsvLzBApsJU/CYEg8H3dwv9bvblxtK6d8MYxoOxVA7mgthIRczYfepMQ9V55GSAjYCy8vr2rwN5TXXz3/q1dRT68JN8lNghKDbtfK91+OQZMnS8nDf0lNZEVrg==;
 7:QYRDaVlKl44rcYaxerlQZLF9gHlObEBeBaJUkDzlILIk09tRkei6iB7gYDtGAvYd0oxkOol2H6aeG8jXGmCVCrovubzeu81Ucyefwi/pBQjdbyiHiQ4RHzU3JhgDf2UhC6ai+W6i0pA77HDZhfsjzg==
x-ms-office365-filtering-correlation-id: 299e930d-757e-473f-8a2d-08d67f5a5384
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);
 SRVR:CY4PR21MB0821; 
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0821D3BD8C1E4020959E40BFD79F0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(14454004)(9686003)(26005)(6346003)(186003)(7416002)(74316002)(6246003)(81166006)(81156014)(2201001)(53936002)(14444005)(8936002)(86612001)(7696005)(256004)(76176011)(2906002)(305945005)(2501003)(86362001)(105586002)(106356001)(486006)(1511001)(93886005)(11346002)(316002)(25786009)(97736004)(476003)(110136005)(6116002)(6506007)(102836004)(71200400001)(22452003)(6436002)(71190400001)(7736002)(68736007)(10290500003)(478600001)(8990500004)(99286004)(8676002)(66066001)(3846002)(55016002)(446003)(229853002)(33656002)(10090500001)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0821;
 H:CY4PR21MB0773.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e4gx+a2cvxb5/B6NiFgSLyv2dw1I3g0C7B/NOYujejp5RpVzSTSzkbLMc7/WlsULIwf05pdyfh82+rlKNFfIplBOC+zXVDBCjYpShiwHlCMVD49gKNRyNtP73142KpPhp5R8RZbylKi3Hxm0umz3flnN6q2KJaN3ODmz7J6bYVR2ozK+f5AiymtEVJCttz2NBQnsEubl9ugN8CscNi5IMBu6wD8m+fKaJtTkyyciF2F9tDCglsqASNi41dCeIDbX3LCnMkgeaGjkxklnQYD3tWNdBsn+Vj+NltwTAxerLiKsQ3hZBnYEWVAwuSS+cs115SMLa+o8eCbKabGpq9xeEJnnGcqfYPILmB+vGBrqKWhKdRfbkAXfOPDpCAC5JQ4opuA7+RwwsOo6jHbctZ+V93lL9C6XWPercXU86DsyDgY=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299e930d-757e-473f-8a2d-08d67f5a5384
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 04:38:44.2601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_203850_384200_B0A8A0E3 
X-CRM114-Status: GOOD (  15.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Michael Kelley  Sent: Friday, January 4, 2019 12:05 PM
> 
> > >> As Will said, this isn't a viable option. Please follow SMCCC 1.1.
> > >
> > > I'll have to start a conversation with the Hyper-V team about this.
> > > I don't know why they chose to use HVC #1 or this register scheme
> > > for output values.  It may be tough to change at this point because
> > > there are Windows guests on Hyper-V for ARM64 that are already
> > > using this approach.
> >
> > I appreciate you already have stuff in the wild, but there is definitely
> > a case to be made for supporting architecturally specified mechanisms in
> > a hypervisor, and SMCCC is definitely part of it (I'm certainly curious
> > of how you support the Spectre mitigation otherwise).
> >
> 
> The Hyper-V guys I need to discuss this with are not back from the
> holidays until January 7th.  I'll follow up on this thread once I've
> had that conversation.
> 

Feedback from the Hyper-V guys is that they believe the Hyper-V
specific hypercall sequence *is* compliant with SMCCC 1.1, in the
sense of being outside the requirements per Section 2.9 since the
Hyper-V hypercall sequence uses HVC #1.  Hyper-V wanted to use a
simpler calling sequence that doesn't have the full register
save/restore requirements, for better performance.  The details
of the Hyper-V hypercall sequence are documented internally,
but we do still need to get it published externally as part of a
Hyper-V TLFS version that includes ARM64.

Hyper-V uses the full SMC Calling Conventions in other places,
such as for PSCI calls, for SMCs to EL3, and for the Spectre
mitigation related calls.

Michael
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
