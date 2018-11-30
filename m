Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1935EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:18:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32DD20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxq7QlYz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgxNcIcX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ItA2EA5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32DD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BFJWq0F+HokrKQj8qdiPN0srj7KMRhSpDtdHvKpnkKc=; b=qxq7QlYzG9oc3A
	ClUFljKxpZC0xrI6TV05WNl5ttakUMhM/TTIVqAjoNO6wc2V3/dcBrvIpITanunpgrV+4fOlfaEE0
	Fc+ATgGEhXOrOhe9VT12bmGPVIP517Rcc1FOqW3qpqm7XK2ovRzTZ/QQKgagiEPHgpr9nOfEcnXnj
	AFDEg9aCzZQ8Znr2bSKpxcbGEAA9E6IE2eaHsN2lzQEZ5RjLOWNCkubEiirjYqQIk/mV0bSKY3Wjz
	AHV6Gxeqny1fhkZAVR/vQdhTSV89AaHTtb5s0bCT/urW2I6yU8pGAi9nSj6joYI2kFjZ+2ZYMDEk9
	29dVnKA0GbGeBKR4YPNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnMb-0006Av-HH; Fri, 30 Nov 2018 18:18:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnMa-00068g-7I
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 18:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aE/ryYoe4+vq46HZXjUHCZF39w883V6XR55xnxY7DlA=; b=vgxNcIcXEq+FOP7Aj0AzOxuyaj
 XNnwF6iOnDHvnJoUmiJ2psEtYu5z0onxDuJY6cqK633RhrIa+wAFf8bSbQil0FRvk4nD5Qvwk+ZaF
 JITg2/mPHNJFswkttuSEUueJW8039UDsqeXr0Y2KY+a6a2bJKlqeqQ0tcpCisAccA55f89jecfvS9
 E87UFToEPA30pNHc6YefLUxGq/Fp+iM+uMvXRTYNU6leGA3UH+hbiupxM8g+phq0GZ92+0ZTNbwn9
 ciWNR6nO300zDsxVGsG70GDB99KiEP1GFTjqXIaUv1ltU4qQvM+xXn9/jScgMHewsRckm7AEn9F2m
 /HzednDA==;
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnD1-0004ft-G9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE/ryYoe4+vq46HZXjUHCZF39w883V6XR55xnxY7DlA=;
 b=ItA2EA5G37Dnp/cqqFwVFO5zKXUHYb1xnATanXPjJRXakQGKrqdkZWHEcBgbs9rcnV1ZKP/qNwaPo7m+owAyD33tF6QXEHcZjnMM2H8WOfQZE+YXkWd083LppBimNhCC2SPuEQGlTdJUUCG7iuUIAgRE3M/MNrAf+JxlkhedlNs=
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com (52.134.110.159) by
 DB7PR08MB2969.eurprd08.prod.outlook.com (52.134.109.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Fri, 30 Nov 2018 18:07:58 +0000
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::dd06:f986:fcee:10f1]) by DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::dd06:f986:fcee:10f1%2]) with mapi id 15.20.1382.020; Fri, 30 Nov 2018
 18:07:58 +0000
From: Catalin Marinas <Catalin.Marinas@arm.com>
To: Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [PATCH v6 04/24] arm/arm64: gic-v3: Add PMR and RPR accessors
Thread-Topic: [PATCH v6 04/24] arm/arm64: gic-v3: Add PMR and RPR accessors
Thread-Index: AQHUen7pMt7QtgG5bUSXuzm+OFhkGaVouj8A
Date: Fri, 30 Nov 2018 18:07:58 +0000
Message-ID: <20181130180756.GN43329@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-5-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1542023835-21446-5-git-send-email-julien.thierry@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.54]
x-clientproxiedby: CWLP123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5b::22) To DB7PR08MB3209.eurprd08.prod.outlook.com
 (2603:10a6:5:1e::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR08MB2969;
 6:HsK+OGur0upOJ4mRKPpJRFJ4bpe9sW7Fhar8sp1PkIgwYf1bPg3U7iA+Xogly97KXWZgkW+WL1S4LK+OCsB2hzWbYy0cXU2xafvtpi55oKk/NaxIFDOPfe8FT9mnmWtL3yLY591mDMC3+GZRu2dedHLf7MiuvC86BC3QH8S2spb69lDZ3SuDv0YJKGqijdGXfI9kAINVn/CCbTaRyexgIPMUwrbya+cWVeXvRsXYcUQF6esZxD99M1WpM86Eaq+ZAhncLpele2y4twMgAY31tI/8HXJVD4SvZb2ZJ1psLXqazNDCDeMdzQUPrmMg5rEUJIrHMlGLBjeVc7kBt8PFS8Me1EOp9TTgrDMe+DMg3dongZbZV82R6Eo4JLJQtVrIBDYfBTyfT0cyuCO1iBwbnwHdFVQkwYn/gKx6xL3SEBt89NNJO+PmYw5WdnG4jK1svqxeUe5LK3Zla4wJJmom8A==;
 5:bh/WrPUHaahmZ+WtEV/UFvSPedjmRc6735HNEgC7qwUqR9xXO/ggL6mN+pydgLInfEr6D0DsFG2clU46+7JhxqSlnQPd6gvxLZiNohsH5dQWgD07L/ovJnEKH68/xgXZwJxX+1FAfwHEnyzlddSTGIrM6O/fZAUDBFBea5WOCR8=;
 7:p3KKJ+ZIYTDkE3jfzYn8Enr3I8KbtbcqvLDNV/pGVmHresif2+4T8ZD4c4rn9cBwd5ukfoxc3QRsWvUanDBqqUNh2Fc4LG/uGAzg7dUV6E1zXu8dxX2vkH8LejJAvCfhtC2qmUDDymcBu6RhVFA16Q==
x-ms-office365-filtering-correlation-id: bbf7946a-ad0e-47b7-fac2-08d656eec26a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR08MB2969; 
x-ms-traffictypediagnostic: DB7PR08MB2969:
x-microsoft-antispam-prvs: <DB7PR08MB29698EA6D80DFC6615272016F2D30@DB7PR08MB2969.eurprd08.prod.outlook.com>
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
x-microsoft-antispam-message-info: 7MvrjnVdXYwIncvgQTaco/7hWGmGqE885uYauUrxFKmwaeHzx+njHDpa7ZFK1k1MWKa1GOlWcvp+1NHXQJpaZx1ajTI2A4OxkFoaroDtUMllfu+qVRk2ilnnwFJYch4orS/sM0YdR0RF9JsofumpIqyrytDR2+6kZYFq1UDFU3Wtj2eV1b0PbpyiXfgB2QUqrx6DwqFLS795Ypz2qrmzel+/gxCReLr0yMyjPwgKvrlBrgFNn9XwyKHwxO7lgQ+TnrTzHRzWAw6FWoT/VaGmr/exO08rVln4cXB204mVGaZihjhZB9dckehGRmm9hC8/o6KJw0CR0uqqn4JVUIeV4undndlCCQ6dxZnwkzugAKc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <09A583346644424A853689B0417C17B9@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf7946a-ad0e-47b7-fac2-08d656eec26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 18:07:58.5374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2969
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_180811_532936_C85F7367 
X-CRM114-Status: GOOD (  13.54  )
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
 Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, James Morse <James.Morse@arm.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 Russell King <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:55AM +0000, Julien Thierry wrote:
> Add helper functions to access system registers related to interrupt
> priorities: PMR and RPR.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
