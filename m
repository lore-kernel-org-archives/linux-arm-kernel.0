Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85286C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5777220838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dXnjSInn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CZJa4e9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5777220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fbLhGznoxPSQQ+G9XwGgxtSPW39agqoy+df3UcyU5SA=; b=dXnjSInnGpNI7C
	OUqHk32upqyDFGzJNslxNNAcpw2/bArKOf/MZJXVRD6JIRRXnlGXL3og3Kt7PiCun8WfDD0Qu51f/
	VYT2jORICjAiRkvzD7VoN4nrdwBsfNiwtag3P4jMPscWVSnc3aRgRWRjWmcn1gbBge8Sv3ebiZggV
	gqb3ALdw7hx8Xh9ijCOUxxFCGlKFdJPKjyFsV4AODxH2lbF5SZ0CMcLe49g3Tjv/zvDjmwNEBwF0c
	+7x/FaOWh0Xez0F+lUM4mka0oLVZsF9OLVbkdKOtWr7Png+dn29hmB2Nnc1udxa7xMPsaN1NOWk0q
	qlbtWrZIjrckiNJAkdjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUslm-00072E-0W; Thu, 06 Dec 2018 12:28:42 +0000
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiR-0002az-1M
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7EzpzEaHfE2D6ezMbsB1YGUnYx4VY9uy4Mdmlc+BeM=;
 b=CZJa4e9lLFjHzrR9eQqYSjSFLukHsxxocmw81AEPG4k+Dzjr/wMfLplX5NleyvKR30Zxsp1uejB3EtRouf/+Xws/h2P3pxqUsmNHWVmfIh9KR+eetD7O7IWFKt5NQ+JiTwX7qzyyRTU5+MDEC3K0o/5imZqnTMpKXmHgn1mZxc8=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1623.eurprd08.prod.outlook.com (10.169.226.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 12:24:59 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 12:24:59 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH V4 2/6] arm64: mm: Introduce DEFAULT_MAP_WINDOW
Thread-Topic: [PATCH V4 2/6] arm64: mm: Introduce DEFAULT_MAP_WINDOW
Thread-Index: AQHUjLl1h2m3gX06k0qK/GanBxMfL6VwaMQAgAE7JYA=
Date: Thu, 6 Dec 2018 12:24:59 +0000
Message-ID: <20181206122448.GA17473@capper-debian.cambridge.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-3-steve.capper@arm.com>
 <20181205173651.GD27881@arrakis.emea.arm.com>
In-Reply-To: <20181205173651.GD27881@arrakis.emea.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:3:22::18) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB1623;
 6:1u62R4Gg/SNPPzXUE7lTX4jNt95irvac/KWzmjwsTkRk9+l/yOHkz2t4sFFf9JJxP22kg/FQCz7DlR7Ani+54vIzri/0nlAqcVHIrIPj5EbCLgcOrZRn4diQeG2rXjCcEEk6vGfGLoGmhqs6y9cwKfSVoMQJIj9IqJ5+MRfb1IfYdFaq6Q1J+V2mGpVlGKG8zVdKI9eigCTZryZ7OOyr8FKB+ruSr4TKbxnlwDv0yDMDNv/X62sNrzlxPlms86fe433BUYHu33mo1AjhrVLcCNS3j5G86+sDVdaNws5BSDk1WeTLW+zQ/M/D4kgjfmY5tE7RpFbK6yPKSG31HqZStERuGJdYUcZB/VUN2yw/7towSCk66bN2dbwpsv+OCYw+SWYycYg8f6U934rVi+BwdWfhtUHQjvcGsaIcxRvo++fjSfr9U1VvWcYEQcgSWqMBhDZh177UFyV9fp7WBHDjug==;
 5:2OJ0DzRczYOjnaJhvGuPGBtJu3D+YWiXiwcOo45yNyhnUGx0tHg93I0yaAghPDdQBeNnnkBuJJDSH5b/4apWtQfA8BRO0KEzUqbV/3+cG0QCU4iGW5E4MS2wpncYC+uM6awjYNnf6D3xvBe85Ii0nYIEru1kCwSNtAi57IHFqJ8=;
 7:+LJ71onOLQNYXswu82fRlCz4QTiMIICWawUANY/7QPbYYBrHzypcFgUiK2zkW81zBd9zssJzlgOwWGXZlCInf9Xjf37BmfwH9eDjfLttphmVXGxFI0LdZsP7ZKgjUF8F989+OP979LgAlgzyMHHgdQ==
x-ms-office365-filtering-correlation-id: 0bce53c1-2804-438f-5433-08d65b75d69e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB1623; 
x-ms-traffictypediagnostic: DB6PR0801MB1623:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1623207A7E7752898EB2A89A81A90@DB6PR0801MB1623.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0801MB1623; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0801MB1623; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(99286004)(305945005)(25786009)(229853002)(105586002)(6436002)(72206003)(478600001)(68736007)(97736004)(6486002)(5660300001)(33656002)(6246003)(102836004)(106356001)(186003)(26005)(2906002)(7736002)(6506007)(386003)(71190400001)(52116002)(76176011)(6512007)(81166006)(8676002)(81156014)(6636002)(256004)(14444005)(6116002)(66066001)(3846002)(1076002)(14454004)(316002)(6862004)(476003)(4326008)(446003)(71200400001)(53936002)(486006)(11346002)(86362001)(8936002)(58126008)(44832011)(54906003)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0801MB1623;
 H:DB6PR0801MB1366.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S2kt56Lhf4MmW4LDdwV9Dj8K56KNDXqxLuSn/XBt8bSKfifoZ05Q/eBUulKwLcr6PNcd+s8ucWh9AlOvz9PRVm4QvWCoczP7DIDxX3UkyScvo0v7BiKUV7bHEHQGT04CHhYOtoFSf5MLs9+ORXnHTpE7KI5vu10pGNhkNZU/OVW3NoRXGSB8tJwubxjcod9gNZpjf/YwOmreXQ1ftjxsT6NmX+B1hAezSQo4S4Gqp7OMwDtODJlHgUM8ggWMGTvI4OreoBIRveEWrN9BcP56xXsfnGiey8VBWvKKtu7ZnDk4BKJWnk0HIl5Sph+MmHwR9LDaov3IAdLxg50xSNrZfhl6bl6zNSOV/l0f7V5QSrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7E51D42D4238694986685EBA40B3C292@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bce53c1-2804-438f-5433-08d65b75d69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:24:59.4289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1623
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042515_425357_2B020DBA 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 05:36:52PM +0000, Catalin Marinas wrote:
> On Wed, Dec 05, 2018 at 04:41:41PM +0000, Steve Capper wrote:
> > We wish to introduce a 52-bit virtual address space for userspace but
> > maintain compatibility with software that assumes the maximum VA space
> > size is 48 bit.
> > 
> > In order to achieve this, on 52-bit VA systems, we make mmap behave as
> > if it were running on a 48-bit VA system (unless userspace explicitly
> > requests a VA where addr[51:48] != 0).
> > 
> > On a system running a 52-bit userspace we need TASK_SIZE to represent
> > the 52-bit limit as it is used in various places to distinguish between
> > kernelspace and userspace addresses.
> > 
> > Thus we need a new limit for mmap, stack, ELF loader and EFI (which uses
> > TTBR0) to represent the non-extended VA space.
> > 
> > This patch introduces DEFAULT_MAP_WINDOW and DEFAULT_MAP_WINDOW_64 and
> > switches the appropriate logic to use that instead of TASK_SIZE.
> > 
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
