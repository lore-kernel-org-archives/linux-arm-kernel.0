Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5617C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F3120652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJELEncD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CiUEtZKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F3120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5xhlgv6SGYFD2a67Nk2yoQW7ccXauOHSD8hbwV0sq6M=; b=UJELEncDr4MbhL
	rcVUWNG3rukCtfUZxl7+DggDe/ShSIwtouoB1dWDkP6DpwSAn9OoQzw9DHaovN6amQFcfozo05yrt
	tqB+OXMMYQMjElyp3VRctYyfEg0IdOoYQ1w3D8z4KSDCVOIZo7RrqkObniQcQJWI/RJghXDwIUnXi
	cLXwVHPM/38yL8v5aBm6uMKQL/Gfel6hg7OWUvJY6CcIyUz6YaMddCh1SIwTMJjALoc9FgqkbR5s7
	DnN9eOxMNGN9MDSesnMOMuovANbFxqyf0szUyu0vDuvowcEc7jU1D+Zct0j7pHRFXdIgHXSpoU8fv
	Ye1ktso8kKAVapsG9L/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx8Ag-0001G2-AX; Fri, 22 Feb 2019 10:35:10 +0000
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx8Ad-0000BN-1q
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVIriTRVCTPcMUtnkUEwPQPHDMJsMQepce13OgpO0qI=;
 b=CiUEtZKQrG9Iq6GUfIDv6OhVEMAUDj3DibaZ9jWApZRKxtytWzzlGrEVcEMswmJyfPa/F9MhC3YqvXxqTBr/Hvh1/NxXEIGZQ6ql5XGSZMWTEU4VNx8Y1G8zZ80eWkkZt5JJAawohepCb96yuqqtb/xD1uh6jbG4ScAGAw4HzDk=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3310.eurprd08.prod.outlook.com (52.134.31.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 22 Feb 2019 10:35:01 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52%6]) with mapi id 15.20.1622.021; Fri, 22 Feb 2019
 10:35:01 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Dave P Martin <Dave.Martin@arm.com>, Andrew Murray <Andrew.Murray@arm.com>
Subject: Re: [PATCH v2 2/6] arm64: HWCAP: add support for AT_HWCAP2
Thread-Topic: [PATCH v2 2/6] arm64: HWCAP: add support for AT_HWCAP2
Thread-Index: AQHUyd/t7tbqB8zsQECnf+yB7P6UeaXql1yAgAEJZwA=
Date: Fri, 22 Feb 2019 10:35:01 +0000
Message-ID: <a3b8a7f1-983a-6d39-8100-88424dc05d6a@arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
 <1550751657-30252-3-git-send-email-andrew.murray@arm.com>
 <20190221184500.GO16031@e103592.cambridge.arm.com>
In-Reply-To: <20190221184500.GO16031@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9371c21-0748-41ad-f91b-08d698b16612
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB3310; 
x-ms-traffictypediagnostic: VI1PR08MB3310:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; VI1PR08MB3310;
 20:KGYMaysq13xgRTtMJnmedfcWEM+cs57nU7PLqvtXhDQoW6uRlXrGshRvoZJ9Ns3XWbZu0UDcC1ZKl7zNKqSzeoWfLgay0W40XNZpCAlGZKIAO/vly+IrOM+0lU+h9MpCLy2LPVWdjm0QFI8aVBrT2E61k3T1THfFRlKRiztgOpY=
x-microsoft-antispam-prvs: <VI1PR08MB3310E522C718294D94CC9B8DED7F0@VI1PR08MB3310.eurprd08.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(366004)(136003)(39860400002)(376002)(396003)(52314003)(199004)(189003)(102836004)(316002)(26005)(105586002)(64126003)(386003)(6506007)(110136005)(58126008)(8936002)(4326008)(305945005)(5660300002)(85306007)(6636002)(2906002)(53546011)(52116002)(25786009)(186003)(31686004)(54906003)(106356001)(76176011)(14454004)(7736002)(6436002)(8676002)(486006)(66066001)(6486002)(2616005)(81166006)(65806001)(31696002)(14444005)(65956001)(53936002)(256004)(478600001)(86362001)(6512007)(71200400001)(68736007)(476003)(3846002)(99286004)(71190400001)(11346002)(36756003)(6116002)(81156014)(72206003)(44832011)(6246003)(97736004)(446003)(65826007)(229853002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3310;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7wiVCSIUyd4gu3CWafEX7iNf/7iPgZfvanY6fnD+kP4Ua2USdn10SXbo83R33uXehvN5gIqlt0QmqWKO7DqdtTfohwjVI19gRAJ3o0NugBu3rIXiMaiu4XoKa8YRHxI8aRkerxI/s7g8QElHVtmQ7mVJowXsskE5nugzan0YTDfabGNyb36lvKh/fulWF99cPeh+KBcEyHhgGqdtWWz9TqbYfTZobGd8n2RXQ4wZVOIwz2WCxaCT3miNGAqVCf4VPl3XdVUjvCOFeONwTHe96D8ql+rVfoGLKKHCZxRcDlK+bhIMpUCZQAVqDA3WklnDQpDB+1Jq6N7mTj7eZzvhdrMr3XFxWm1A/eR1UQ13RDUYgXayP64n3YX1wVuQzqd42db2bnu4DG5d6rLQh50i6k9GoG6EJFbVqHCmDp0A26U=
Content-ID: <1335440255E84C47B5243DD380ECFEB9@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9371c21-0748-41ad-f91b-08d698b16612
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 10:35:00.2112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3310
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_023507_183957_38BC4208 
X-CRM114-Status: GOOD (  20.92  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21/02/2019 18:45, Dave P Martin wrote:
> For ABI purposes, we should take the opportunity to document the status
> of the currently unused bits.
> 
> For interoperation with the glibc ifunc resolver ABI, we may want to
> reserve a bit among AT_HWCAP [63:32] or AT_HWCAP2 [31:0] that will
> never be used by the kernel and always passed to userspace as 0.

if hwcap2 is introduced at bit 32, i'd expect the top 32 bits
of hwcap1 to be 0 on lp64 (and thus libc may use those bits
for something internally or in the ifunc abi).

> I'm envisaging code such as
> 
> 	foo resolver(unsigned long hwcaps, unsigned int num_at_hwcaps,
> 			unsigned long const *at_hwcaps)
> 	{
> 		if ((hwcaps & _GLIBC_EXTRA_HWCAPS) &&
> 				num_at_hwcaps >= 2 &&
> 				at_hwcaps[1] && HWCAP2_FOO)
> 			/* feature present */
> 	}
> 
> We would need that _GLIBC_EXTRA_HWCAPS to distinguish the second and
> third arguments from uninitialised junk that would be passed by older
> glibc versions.

yes, i plan to do such a change.

> Glibc might or might not choose to try and wegde AT_HWCAP2 in the top
> bits of the first argument instead of bits [63:32] of AT_HWCAP (which
> we expect to be zero for now, but could still be made reachable via the
> at_hwcaps pointer).

the public api via getauxval and hwcap macro defines
will not do tricks that break lp64 vs ilp32 portability.
(that would defeat the purpose of hwcap2)

> Coordination would be needed if glibc carries on using the
> <uapi/asm/hwcap.h> HWCAP{,2}_foo defines for here while doing tricks
> of this sort.
> 
> Szabolcs may have a view on whether this is needed / useful.

for now coordination is not needed, glibc does not
use uapi hwcap.h directly, but copies it and it won't
do tricks that change hwcap values anyway, only adds
one new flag for ifunc resolvers.

> If so, we should document any required guarantees now so that we don't
> accidentally violate them during future maintenance.  For the benefit
> of userspace folks, it may be a good idea to have some clear statement
> in Documentation/arm64/ also.

on lp64 glibc will expect hwcap top 32bit to be 0.
this can be changed in the future if we no longer
care about ilp32 and at that point we may need
some coordination between linux and glibc so
the ifunc resolver abi does not break.

> Because of the ABI implications here, if would also be good idea to copy
> the libc-alpha mailing list, and possibly also linux-api.

yes.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
