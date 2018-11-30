Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:07:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CA820867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nwQZT1W3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZJLzOlVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CA820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fk/X9MLTd9m9Lcl27tG70zdp6llzWpS8sTDIcO29Rrc=; b=nwQZT1W3eOTipA
	t8HpH8MXNz4wLnGlZcnTQFXR0jJi8X0jBYoQh1Qf3AuoRtEYB+MWhpLctjUpZhsu8vTjEBTJBW3ml
	9hNK66iPiNJTymXnNXJ91F/ovowvNos2iEowvNrT4VRuq1MBOmZ/sU/9zzxbOXKjcYOG5bWqMDqNf
	qXmvQceScI62MDqUbC+fecHSJmOza6NaksegvrVhlo+CRqFm14IatDo9iskKHAal7y75pJ2EOWCg3
	0LppNSdcdbNImbWooHfZgjMz537hi6w9ghd/jBbF3JhwKbKEounD2tXL/2PmPncSHlrENLYkIU1SC
	DKKr2gYkFvl/nGPSBd3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnCE-0001oR-AY; Fri, 30 Nov 2018 18:07:22 +0000
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnCA-0001nu-9x
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFLSl4wfcTBopZZsbrx/LMK/joa7CFVbLXBZUhF/QUA=;
 b=ZJLzOlVfVI/HSbqGS7nOh1d2xyFbLrFVz17JwnfJPLA8eOYe80UQVofUWeqo+OWaCNFSArhboibjTHUrNgYf5SEqdUmADpUloHxio8yWQZ3ELTSz1I2vGtGEvTJ23Pi8sGXruN5a6NkMBsGSWpJb/xTLQM4pMxNvvfnKGbMWfbk=
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com (52.134.110.159) by
 DB7PR08MB2969.eurprd08.prod.outlook.com (52.134.109.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Fri, 30 Nov 2018 18:07:04 +0000
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::dd06:f986:fcee:10f1]) by DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::dd06:f986:fcee:10f1%2]) with mapi id 15.20.1382.020; Fri, 30 Nov 2018
 18:07:04 +0000
From: Catalin Marinas <Catalin.Marinas@arm.com>
To: Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [PATCH v6 02/24] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
Thread-Topic: [PATCH v6 02/24] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
Thread-Index: AQHUen7nxGZoDoW8kUyngIYWbbyzbqVouf4A
Date: Fri, 30 Nov 2018 18:07:04 +0000
Message-ID: <20181130180702.GL43329@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.54]
x-clientproxiedby: CWLP265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::34) To DB7PR08MB3209.eurprd08.prod.outlook.com
 (2603:10a6:5:1e::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR08MB2969;
 6:81kCegboiF6dIV83rUJ3TukvLOCePnMI7dbcy0THQDE9hBh2ihZ3PyEpkvS3RLQrJBnTK/8GIqwrZO65G2wYVV0gTdpSZVoa/oVeBAaCYkuBv0WMVp14A3kfd8FnhDES59htD89/6D9EGPiv5zX0YFMwesgW2LTZbOA6d/aSlDNLnrI4cW+VRuJNChmzIBA+Omq64zRjTJTKWDxfcHGAF8Wpr/6g7mqiZ+8uQzIqVaQXuOHkYOHWEGN/A9neXsjjfIrf10ajt7fvv8nnF0+wVgw4Q58gOzP6tV6pXCa9djoZPhcgng8qFTifLzak9hv/Auo+dqrBGu+CeFxPlHZcC5OtO7AYRSS3yjWFsAND1lmXjWA1XXcfdDlXWKIpqJ24dtY8T5vWBH5VpBfz5lKkEjzE+yPbX/MyXsoqjxdFDRWqXFtBqdkuM4VDw8p2jfOetd4QJcUCQcLnmcrGOpGOlw==;
 5:ZyxbTMBtgkauVDixHbuz7rMU58aOjGW0zJZaxo8rpBtSTz3Xps3zmsfbk2smNbQfaLyzk1rCjaRQ+P1W9MNyfjv2pxNspqtohVTphjiGgKrZw+CQiJEAjZN+Z3JJ596ck+b4mhZq3b7HzUVE4vt/VxJSfugQk8+q4O6aBPTd2LU=;
 7:iGxirnoLiJmGDVUkm3dAjRnjQfvq9zLJOPNiYaUaVij2CXA6MzVu7SmUHniKo9lL8JMf6QVn24LjZbbvrTRwgKHEyMG/tCUhT8/deEY6vbWqgBuJ2aNOoX0Cf41CUm9HuAlyyWQWI4oojLDa1fQWSw==
x-ms-office365-filtering-correlation-id: ec494ea7-c26d-46a1-15a9-08d656eea234
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR08MB2969; 
x-ms-traffictypediagnostic: DB7PR08MB2969:
x-microsoft-antispam-prvs: <DB7PR08MB29696E1B4E59B6EEA186BCB6F2D30@DB7PR08MB2969.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:DB7PR08MB2969; BCL:0; PCL:0; RULEID:; SRVR:DB7PR08MB2969; 
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(40434004)(81156014)(386003)(6506007)(3846002)(102836004)(71190400001)(44832011)(71200400001)(6636002)(66066001)(97736004)(54906003)(14444005)(52116002)(5024004)(476003)(58126008)(316002)(26005)(1076002)(186003)(6116002)(11346002)(446003)(76176011)(2906002)(486006)(86362001)(256004)(53936002)(6512007)(6436002)(6486002)(229853002)(25786009)(4326008)(99286004)(33656002)(72206003)(478600001)(14454004)(6862004)(6246003)(5660300001)(7736002)(106356001)(305945005)(105586002)(81166006)(8936002)(68736007)(8676002)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR08MB2969;
 H:DB7PR08MB3209.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HaFahx8iif/hodmP/+xw7csDrauCoQYCKKMYGHI25zItbjg+kgfXUhNHEYS1JSAMrVqWD/Mc3UgwaGD3G3l3Fpj2jBmeVo8vjhm0nG5dhG8tvhFiBIfE+Mx7CxnRgiDJR8bwNY72vgbZGPqkL3MGBB0agnAcAC8CtaOD6BBopwUuxMTEDSKZGzJXHjjx//yx7iOeBdbvzHQwKmSLsQlFrr2bXZw6BvEai+3CS0jEFO81RVOcchYsJYYdlSCMTIOwiSv2am/8zsLcUW1qnbVznySLxm8p9AuXZItoJ2MQYfh+B5E6E1M9Ts8mewolAJ21uWBnO6HBYmjqH7wheoix+5/151X9u5yOXSXuucKfBQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <F2AC86898C3F314FA23FD3CD8CB8824D@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec494ea7-c26d-46a1-15a9-08d656eea234
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 18:07:04.7406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2969
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_100718_346549_7D78CFFE 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
 Suzuki Poulose <Suzuki.Poulose@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, James Morse <James.Morse@arm.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:53AM +0000, Julien Thierry wrote:
> It is not supported to have some CPUs using GICv3 sysreg CPU interface
> while some others do not.
>
> Once ICC_SRE_EL1.SRE is set on a CPU, the bit cannot be cleared. Since
> matching this feature require setting ICC_SRE_EL1.SRE, it cannot be
> turned off if found on a CPU.
>
> Set the feature as STRICT_BOOT, if boot CPU has it, all other CPUs are
> required to have it.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
