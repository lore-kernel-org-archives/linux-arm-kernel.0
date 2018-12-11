Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F5BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:14:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367E92082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lWGcC4+n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jVw9MqYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367E92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dldxVqHNSGtQQL/MOc9R+7XMUT+y8szp25YO7xvDWlI=; b=lWGcC4+nWxgW0d
	hAOuEgbvMxuvh0fncN8cRiM0mvvEUxThLzfUoAB2eWVhvGJc4fDJ+CaSgA60rgwyrHkNQkfr1UU1a
	Q3JouzsL+zK1dD8h965hc4Zhp4dDcVAV6GJ4bYAvxl4vu5G+E15s+DgzQeRBCfCe3y8Wgnv9Anfli
	U2nDD/YGujNxs5bb1yypx2WzmQatLgY5jD7wtYkszEbBqUrfhwB0WwC1zsVk8owpFZ1zjhj4Ohq7f
	MN2liMBARt7X10G+8BTXSHyIdY/3MN2qWqwoUGlV5WMNMSp4chSZea9AIqgeo8z6KNUvRXUEqNTV0
	L4ZFt0zcWgMkqel6Q4Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWe7O-000415-40; Tue, 11 Dec 2018 09:14:18 +0000
Received: from mail-ve1eur03on060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::60b]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWe7K-00040J-4f
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:14:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNjV0D+5aLWg2OqpaE43FEBXfaKOWMxGB8txSk7sH+M=;
 b=jVw9MqYMsSHgHyMLTmwMJVyUcUw0jQ0kx3pHqhagUypp4zMV3Luk9UzyFcRj4SMChxB09/nIn1ukC6TkxO1qmO7DX8yg+GiJA89qV9BnTRl2r1pbLq0ZsAccmTN6y/QJYz/3NJ9lnoL2RGtt25d+vZgFvRXJ2y4gDqBhDkWFJFc=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1766.eurprd08.prod.outlook.com (10.169.227.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 09:13:59 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 09:13:59 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH V5 0/7] 52-bit userspace VAs
Thread-Topic: [PATCH V5 0/7] 52-bit userspace VAs
Thread-Index: AQHUjbYoCPvIyy3x0kyyrdC6QUb7RqV4Y2MAgADk2QA=
Date: Tue, 11 Dec 2018 09:13:59 +0000
Message-ID: <20181211091349.GA24521@capper-debian.cambridge.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181210193445.GB8923@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181210193445.GB8923@edgewater-inn.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:3:22::15) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB1766;
 6:QZzGxq3dMBfssyZk7ty9esw7vl+cYNagtWdR6PjbyIyjMIgeHqwRqLOF7NH3u5CbeNi79mYgND1an++zsl14kTY+sDFL+n9/daQwNcaA9QmciWOfzpuN6oJvaesiu2iLPD5ZZeRcnFjgI1o4oiU5wKbgLhCtzEG2Hw/6dzei5JdICyMGttiSOrrHZB0Dj3/Zej7bHLeB3UMd05XloakWkagmdYsSmm0euHHM4DEfbaoowJuXTxoxMp4iAn9ZtCc2rOtPeWjbipAp9Hvhn8ic/s1hRTNQI63hgPXfoFdzgEB1VmBGMl5u8XkoGdA+ermWsPdsPsS/7xPs3UCRMZZWYHpqZPwwUs7BNmBJc6UofelLYmR3oGD394i8xXDsrLnV0UHOm2fpdiMEKsUqeCVpGTHSIQyvWhJlB2fQMjj/ljSO3ODbskbNiboycaqkN1AgMGSjVx75LMusEsy6LY5ohg==;
 5:WucCRVAEGo/9RFTENdDK+czeuR7ULDii/Jgm/oBhF4nSh8f+FyTegqUrB9LAxgazTh8+VOO0bgpSRFfIGVz7R7pOoDD/fOdpXOjs6hX5DLExZHmu2I9W52xpSaxgdcOke0VoNyjRKkpWzAuIdFcACRJmhn63TCuiQf0BLi86D8s=;
 7:u9DcTl8k68zsC25k47obD/Wrtw+c67CerME9iSfvk941yrPvn9lsYmhVBfYJG/41M+uWMe3nu645yDXc6K70h3mKsKlyc2l83dgSxizm4inXPjE1UH1VGldcUjdZu5ptD0aHcJ+Cy+1hzhW7MlieiA==
x-ms-office365-filtering-correlation-id: 88ea24ce-75a7-4ce9-aa0f-08d65f48fc1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB1766; 
x-ms-traffictypediagnostic: DB6PR0801MB1766:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB17661C855F5DBFA714A04E2181A60@DB6PR0801MB1766.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0801MB1766; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0801MB1766; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(6436002)(386003)(3846002)(2906002)(6116002)(86362001)(486006)(44832011)(6512007)(6636002)(26005)(478600001)(11346002)(58126008)(99286004)(229853002)(6486002)(1076002)(316002)(71190400001)(305945005)(52116002)(186003)(76176011)(7736002)(54906003)(476003)(71200400001)(5660300001)(33656002)(256004)(8936002)(14444005)(81156014)(102836004)(81166006)(97736004)(6862004)(6246003)(25786009)(66066001)(446003)(4326008)(68736007)(106356001)(8676002)(53936002)(6506007)(105586002)(14454004)(72206003)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0801MB1766;
 H:DB6PR0801MB1366.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zOuXrFNlIvRNw24HJAfS4hgbv2zzyJSLNzKS1GWL9Oeeq/DZbuFhpsq0jUu937/MBSPg8GKDbIqIVUD9SGBUeJGs3m1n8bxoCF/+NviOWlmdPFbPJ6yLWF7XzSzkBT112SRsMGQblzmxc2vNJ2HEwEivqjOq/5Kpo4oEYVgcRZi3qQdlz5rN3x/UC6vJK/M40pn6ZlwPq/BU1+PvQL2/2TtcE8su/1KF3j5YKCirBYDYgprBIY+gUvPuOWbxu2ZFQkFuZiq6zd6X4t+wvoVsRojCeEb7I1MT+13XjrBQ98x/Ai1kmeKxHd4HZGvura8V
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <B1DFFA7C8DC6A445852BDC2FCC2C7BAA@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea24ce-75a7-4ce9-aa0f-08d65f48fc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 09:13:59.5582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1766
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_011414_496223_8A7AEFAD 
X-CRM114-Status: GOOD (  17.40  )
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
 "jcm@redhat.com" <jcm@redhat.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Mon, Dec 10, 2018 at 07:34:46PM +0000, Will Deacon wrote:
> On Thu, Dec 06, 2018 at 10:50:35PM +0000, Steve Capper wrote:
> > This patch series brings support for 52-bit userspace VAs to systems that
> > have ARMv8.2-LVA and are running with a 48-bit VA_BITS and a 64KB
> > PAGE_SIZE.
> > 
> > If no hardware support is present, the kernel runs with a 48-bit VA space
> > for userspace.
> > 
> > Userspace can exploit this feature by providing an address hint to mmap
> > where addr[51:48] != 0. Otherwise all the VA mappings will behave in the
> > same way as a 48-bit VA system (this is to maintain compatibility with
> > software that assumes the maximum VA size on arm64 is 48-bit).
> > 
> > This patch series applies to 4.20-rc1.
> > 
> > Testing was in a model with Trusted Firmware and UEFI for boot.
> > 
> > Changed in V5, ttbr1 offsetting code simplified. Extra patch added to
> > check for VA space support mismatch between CPUs.
> 
> I was all ready to push this out, but I spotted a build failure with
> allmodconfig because TASK_SIZE refers to the non-EXPORTed symbol
> vabits_user:
> 
> ERROR: "vabits_user" [lib/test_user_copy.ko] undefined!
> ERROR: "vabits_user" [drivers/misc/lkdtm/lkdtm.ko] undefined!
> ERROR: "vabits_user" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Apologies for that, I'll be more careful with modules in future.

> 
> So I've pushed an extra patch on top to fix that by exporting the symbol.
> 

Thanks!

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
