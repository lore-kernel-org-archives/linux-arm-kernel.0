Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC62C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:53:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3B1218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHYq+qJ8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ic+MFv8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3B1218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j/5RWZhCTiv7cBoHkMYCr6j2MsOjutpXGjPC7DWP2Rc=; b=nHYq+qJ8gPrR3M
	PrjxUPpGJjMhZ/AZOvCYSHWOntvbmfjNvMlHns1aRmWEK2jwliNpriujbD717RwCk/9WFWxsMWmPx
	D9Ol2h8I1TLeNiCvcDA/p+E0HcqPl0dFjyPK2R+nzIO2cMypKgXoBZdAQ7fwTk5hGkEhAUIX5AKsz
	YT8o2h9l/86VFaVlmNfzwvNsiDPkxnoXUJblzYCW4/cKPcBYYLCjBPhcT5pM+EHkaCW6HHDUnquns
	qdyoIO6dCMTgQAoXCBsLxZ60e9keIDpuSnYV7S9gP2ia4LCpoXm/QY1XkLfko1PKLYKn6dkI6s96H
	y1w5caATMt76JImssVOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpdwQ-0001Zf-IV; Fri, 01 Feb 2019 18:53:30 +0000
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpdwM-0001QE-Ct
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 18:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqGI6w9HtZwFw0FooYC6+A5Rh+4zi4qoAWyl3jCI6aw=;
 b=Ic+MFv8gRGIGFhNcCWOfAoVvdliZJVP6Rpe4Es5gqjgKyODl5aKNgo+rXM8PMrjL5K31dFiMF3saVKY8Nic/2tFAxCter6kCtZZ/6DDS/cr+j4IVX1LiRLFdTst3Vdb/rke9HGXbUETvLwRIgvu0KESIC4OcZW//4H9Lhh3IQTY=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB4073.eurprd08.prod.outlook.com (20.179.11.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.19; Fri, 1 Feb 2019 18:53:20 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::3d06:58c4:a969:554b]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::3d06:58c4:a969:554b%3]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 18:53:20 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Will Deacon <Will.Deacon@arm.com>
Subject: Re: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Thread-Topic: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Thread-Index: AQHUueLfvk3wiqo4IEK25Z94vYKAOaXK9e+AgABVDIA=
Date: Fri, 1 Feb 2019 18:53:19 +0000
Message-ID: <20190201185310.GA8870@capper-debian.cambridge.arm.com>
References: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
 <20190201134847.GC29903@fuggles.cambridge.arm.com>
In-Reply-To: <20190201134847.GC29903@fuggles.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0065.namprd18.prod.outlook.com
 (2603:10b6:3:22::27) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB8PR08MB4073;
 6:1af9cPS6EiGJqTX+fMWmoZWbox1+3fX2uW27SFcfBqTLessvqVA8HHug5eOeu4kZWdRbvdFUKXaLEnMkXQuZhMQCO5o1kdBwjiUyZWxXtF7ABQnWwd0N51xsLazMUdmNqORa7B3bDOpJ3pCuRJihIbUuwcj5v2xv/oDY656kZ7E7S+3oc4IFa/zyKkINkmv4vb9tQVlmHQ4uuhA/xgN14FqsHpwGX3DOmNeepRcOSEKzeHh7D3iLQ4Of4pLerSf1D7GAUnMLsM5YszHs+BcIBzFO5C75VdJdxoM2pgN7qy+eyg1U/n710W6ez6mpwQFBlIpqUTT9TtkxrT4Oz5iMvzPNmDrn1ExDaPV7t4oZ1BOMkdxsaZ/QuohUzpudVmFP8gKT7j+H4QtlH1YCySOuteeg+wyhIIbXGLS5iMpD4Ol7dWgV3yJlO+lFwNcIYDhhQsqBfI/p7SA6teZ+0kidCQ==;
 5:np0UkEpHvjU8eEDDKxPwqkwUXK7kWgbnGZcUil4uzPzvTviu6Ix2LU9fOZilYwoZqty8NZ7/8jI/9sCDQvzqlk5UVDHK3vG/bwSYMZJ/ez6aftjWk74USh/AjjsnfJJR+r0EMU9+ZdJSXK/wyKDVmkViScL0lJh1R2fzDCr8ljamuC3eciRtE2zdnbhvfBBrFmqzdvVnrlM2J8wOjmcgtA==;
 7:8xwuMLmNBX4n1ovDaW8+7Pg7jwqmiuTgrCm0728t5AAkpzBfJhb3Qi0p9504GMiEz+wMi2u3q8D/2XZpIBWdfW7sRltcz3P7rQtavWie6jnKhSyYPBqNd0JsaTicQHqkYP6aG3+AP7sMJ5lyMJ+Zcg==
x-ms-office365-filtering-correlation-id: 01a1268a-5353-4eec-b2eb-08d688768883
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB8PR08MB4073; 
x-ms-traffictypediagnostic: DB8PR08MB4073:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB8PR08MB40734590A181BEA33C1AF9F581920@DB8PR08MB4073.eurprd08.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(476003)(71190400001)(71200400001)(478600001)(72206003)(2906002)(6636002)(106356001)(105586002)(14454004)(3846002)(11346002)(44832011)(486006)(186003)(446003)(102836004)(26005)(386003)(6506007)(6116002)(66066001)(68736007)(53936002)(97736004)(81166006)(33656002)(76176011)(99286004)(6246003)(316002)(229853002)(81156014)(8676002)(7736002)(8936002)(6486002)(6862004)(52116002)(4326008)(6436002)(4744005)(54906003)(1076003)(256004)(6512007)(58126008)(25786009)(86362001)(305945005)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR08MB4073;
 H:DB8PR08MB4105.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2jClNOuH8iTw1SjUUrZUpLuyzd50lKxYCb/dsrqWrtloTTHXyg93xkkOvmRvx9lePwamdQonXr1e277rW+TnMADqVOCYWcftsSvS7pgTB6BaR75pfJqn2SEZ0nlOkTDHlAfHXEOpb7MnULDQORjak5nQ/78B7RXwLYxpmcfrSEV1T5BPS5mWxdEk01i2yiOuL7b4rGkiQgCoooLD4bsulH0gfvbrUX6dp3UaWNWyQk0GEcYlAtlL6YngST57sMdZyi7jE1KHF/nPFpbvj7HGNvQlOa0AsGnHMUoV5ByniNGcEWQQtndpXPEAzWd6jCAfPEik4U3vLruN4jSzfZZ5kjVhiiV/8oJLkE05rnjkWnWpHdo2q45SaYBQFZPQQScVfBYtXFR6Ki4jqq6M7HJWsWWn/3lUNvNZyiL1MwwtoU0=
Content-ID: <B68253465A6F2C4FB92F873ED5DA1B99@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a1268a-5353-4eec-b2eb-08d688768883
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 18:53:18.0812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_105326_761496_CBC30958 
X-CRM114-Status: GOOD (  11.78  )
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
 Qian Cai <cai@lca.pw>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 01:48:47PM +0000, Will Deacon wrote:
> Hi Qian Cai,
> 
> Thanks for reporting this.
> 
> On Thu, Jan 31, 2019 at 11:01:50PM -0500, Qian Cai wrote:
> > On this ThunderX2 server with both,
> > CONFIG_ARM64_USER_VA_BITS_52=y
> > CONFIG_ARM64_PTDUMP_DEBUGFS=y
> > 
> > kernel_page_tables could only print out linear mappings.
> 
> I think this is because the ptdump code is abusing both PTRS_PER_PGD and
> pgd_offset(mm, 0UL) for walking kernel (TTBR1) page tables. That's not going
> to work, because those are still configured as 48-bit.
> 
> Please can you try the diff below? (Steve -- can you have a look as well,
> please?).
> 
> Thanks,
> 
> Will

Hi Will,
This patch looks good to me and worked well for my tests in a model.

FWIW:
Acked-by: Steve Capper <steve.capper@arm.com>
Tested-by: Steve Capper <steve.capper@arm.com>

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
