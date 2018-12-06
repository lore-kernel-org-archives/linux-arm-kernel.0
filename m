Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F45C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D891220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/E66nCh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I6ukPYW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D891220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lxIBzPJ5hhPSHZqxunp59hWKG0jIZNpOroV4ioQmZq4=; b=j/E66nChPd9h6h
	0bWKgNcsVJV87u2/pOjsiaX5/ej2wkilNCk9lrS4Anfws50yCMlNF/rhp3SbddwRTPpAp4SqlmDGt
	vWF/M6W1rkYFZlNQThS0gXv2NY27Uo/enLx+nOtG0sctactkAzcBzqyN6sG44+F9pvqbl/uDypA53
	EgVC2Jk+1jNTbGDn0Ww1RqPL6FYhMMhtbLWEx4CPoLQLfY5SsdC2PA1NdFkM0acWi/c43GanLn+mG
	9l6QKoYTBRH4f+3tSGPS0AI7tmZIITv4a+czIKRBopFrd5TXm4QMVbTabXbkfa5FSLjtan3Jdth4s
	Czfkhi2y6I8OlxQMmegg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUv1T-0004Gl-Jj; Thu, 06 Dec 2018 14:53:03 +0000
Received: from mail-eopbgr130078.outbound.protection.outlook.com
 ([40.107.13.78] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUv1P-00045Y-Ff
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+gMKEz811/vZ2GzBOcVu25LAu9zjiuBvSmYiy0cFO4=;
 b=I6ukPYW8ZMVpxT7fdmgKc7v+mLK7f60vO2L1ZQPtqY2CtVG5i01bIa7XB1YjxhjMbEKDZ3g/I0Gp+0/EkX/Lu3MzsKZhdtytwp2BpqPqfKjx2Dk7qpq5vcgcdBfWBO3kL5Rq0Z5luKGufUHAHX7dlG3IcgIkhDAOmso+NN8655k=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1861.eurprd08.prod.outlook.com (10.168.85.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 14:52:46 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 14:52:46 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH V4 5/6] arm64: mm: introduce 52-bit userspace support
Thread-Topic: [PATCH V4 5/6] arm64: mm: introduce 52-bit userspace support
Thread-Index: AQHUjLl4fOQ7Xtd5CU6Lx4bVfQoqCKVwdYCAgAEuwYCAACQfAIAABNMA
Date: Thu, 6 Dec 2018 14:52:46 +0000
Message-ID: <20181206145236.GA408@capper-debian.cambridge.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-6-steve.capper@arm.com>
 <e1a9b147-d635-9f32-2f33-ccd689dba858@arm.com>
 <20181206122603.GB17473@capper-debian.cambridge.arm.com>
 <c87c833a-7dfc-6cd4-aad7-119df9bd7178@arm.com>
In-Reply-To: <c87c833a-7dfc-6cd4-aad7-119df9bd7178@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:3:22::11) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB1861;
 6:zDxgyklb/mmxUdQz1wYeHLQknEy5XbvygOK5PGRkqBUdQeUmC9PjGjA56J1cCiC5gKtN0w+aLSksfdbNW1nlFK9d/p1ogLvmlosP3igWPLUiX0RY/Paa0NyY784r0ry2Wq9EH4N2WiDS2z45YL+t3WBWdJwOVZzZB9SIPkCrmPfbzIDFyN26nmQ442SyvH5dvAQUrXuHUk8Y/yDC3OvRKxBNAOdYtFyX+eNl2xUdlgIHb887oFKQb8JMCr8U2pmKtzSnBRRfb9Q6IYDWSMaIzm5RTywltGyXlLjJ9tstxsbaXsIKHJq8HwkIcaLJLXTUp38jbxWjVcKYs9Q9T29tfTg7BwvzMT3eVUdwxPrfgt43Qa8slexkvYhRKtwaHZBrrK74PPOBZQzDSE9+0zORCK4H2GctFede+zygBq/cNOQeDi4/bwLd70kw7zt8mKQO0Tb/JElKAWhJa3+oaFCFnw==;
 5:JcS10kfFs6NHp8wjF9rNqqfGrnWOWOgByJNvagi1VVYNpdB9CM3jn3VaEWqlTjNCVphzHT7u3CROck5rmLdko6Uwadj8W09PnTqAPFEgbwAJ6khHklow9EG6pJ8sWXSueQZ3IuuAcVbTl81SVwxdu4EMDNuVpRtmoJ/rMyJiJA8=;
 7:n5DG0WSKEgRcO+c9aEEip+5/DCLxqmFe9B5ZsKHQori4T2WJq5WVXqvJOQ1tMaUn67knmAbNz3C99tM1txDGdcW2GIUn8qLK00yQ+icv5dTG4aGdMLF1jnfO5QrYzkEpjLrFhMUvAgghDn/0QtUJxg==
x-ms-office365-filtering-correlation-id: 55f4fc1b-a73e-40dd-cfbb-08d65b8a7b9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB1861; 
x-ms-traffictypediagnostic: DB6PR0801MB1861:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB18610F4F2B7D979136CFF77881A90@DB6PR0801MB1861.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0801MB1861; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0801MB1861; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(68736007)(81166006)(81156014)(25786009)(2906002)(316002)(5660300001)(72206003)(8936002)(478600001)(58126008)(86362001)(4326008)(93886005)(14454004)(8676002)(53936002)(54906003)(106356001)(3846002)(105586002)(6116002)(97736004)(1076002)(386003)(14444005)(486006)(7736002)(446003)(66066001)(33656002)(11346002)(53546011)(256004)(76176011)(26005)(6506007)(6636002)(305945005)(71200400001)(71190400001)(476003)(6486002)(6436002)(6246003)(186003)(229853002)(6862004)(102836004)(99286004)(52116002)(6512007)(44832011)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0801MB1861;
 H:DB6PR0801MB1366.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: muBW+rXWSds6pRppWjISXSZN8ZHZC1Hd0rCaZhyO7vesXYHSozHLW9XF3GEkIWo1jd5YFmkQ0lb9HVCMO6jOcnwj3UAqa505X7GgBXJQGZ60pO1Vm3XwyVMzEqD0JD9owR5FxP7viRuxL8sznShb2TQDhDtyAo3vLeNTaz7fTT+Nw2E0Ovoze8utyCcF+ZO43LlXgo1YnATDH7986WIH+6We4cno+DiCoXXIbs3BmcWS1IKKkSkXzaa8mXD8jXGU9GKp++hosvh5UmVYGYjGdJaqrYGsNRL6nv05pquf+okspc1YfJTmZ4Wlhd39EtNNd80t9AHTRjCbpzCxMTpRn6Y+wvBzJEsvfB6+BkaUiaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3970E43866B09449B2F3F19F50340B9F@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f4fc1b-a73e-40dd-cfbb-08d65b8a7b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 14:52:46.0811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_065259_561788_9A71D1B0 
X-CRM114-Status: GOOD (  20.66  )
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
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 02:35:20PM +0000, Suzuki K Poulose wrote:
> 
> 
> On 06/12/2018 12:26, Steve Capper wrote:
> > On Wed, Dec 05, 2018 at 06:22:27PM +0000, Suzuki K Poulose wrote:
> > > Hi Steve,
> > > 
> > [...]
> > > I think we may need a check for the secondary CPUs to make sure that they have
> > > the 52bit support once the boot CPU has decided to use the feature and fail the
> > > CPU bring up (just like we do for the granule support).
> > > 
> > > Suzuki
> > 
> > Hi Suzuki,
> > I have just written a patch to detect a mismatch between 52-bit VA that
> > is being tested now.
> > 
> > As 52-bit kernel VA support is coming in future, the patch checks for a
> > mismatch during the secondary boot path and, if one is found, prevents
> > the secondary from booting (and displays an error message to the user).
> 
> Right now, it is the boot CPU which decides the Userspace 52bit VA, isn't it ?
> Irrespective of the kernel VA support, the userspace must be able to run on
> all the CPUs on the system, right ? So don't we need it now, with this series ?

Hi Suzuki,

Yes the boot CPU determines vabits_user. My idea was to have the
secondary CPUs check to see if vabits_user was 52, and if so, then check
to see if it's capable of supporting 52-bit. If not, then it stops
booting (and sets a flag to indicate why).

This check will be valid for 52-bit userspace support and also valid for
52-bit kernel support (as the check is performed before the secondary
mmu is enabled). I didn't want to write a higher level detection
routine for the userspace support and then have to re-write it later
when introducing 52-bit kernel support.

I'm happy to do what works though, I thought this way was simplest :-).

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
