Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FABBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAA420892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D8eC08AP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c/cMmeWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U789AFMHTICLLtQM3fOuOIi/0tam6tC4qAgBG5zMDsU=; b=D8eC08APBwcaly
	9LzNvnD4+0+DiuG7zXh+HopXv340LY+rdCouipvW7eYspHkFds4HowaCXk+CrDP1aGRsSaFPMFDsP
	l6Ny9hu0LbTPOUrYdmRVUH+jeHwhX/l0ixHNR77pYKDegZCz5fx5eMGWZbmHKfvrpEHPfNrUaEOgd
	3U0tlQgDmgywiawyVmfuBmV+ZRhfgQMP9CvjmoAN6NBwFM1xAFzwv/ekmXzWV7vfG32xfJgyjjYgp
	jwuBp61oP5HGBxi+CS9jhyeMjquWvuQHZnhWE+VRqUy5lkgtqoPGyyvoL0KYSiEbQ1Z/iRz17iwbb
	k/uZAB4M+FqNF1hAq7aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsxg-0000V3-9Y; Thu, 06 Dec 2018 12:41:00 +0000
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUslR-0006Xn-5Y
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:29:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQrUQ9P3XpvJhDsuycEeb78z/CTR9KwjVnhATLSlxNs=;
 b=c/cMmeWIiC1jGLZyQ29ejjNTB24XcNdi2pcNuPxSfInZ8v0x05JntO+0GZUt2raVXX5syzYG3lRMvtovi7dsqJVYRCJwBDVNAulee40vnrc2RRYh8we9MlDuiLUx6UlNGL3IVwR3ddbhC/yIh3If9sIEmoqvAe47rg7ScaRw0gA=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1623.eurprd08.prod.outlook.com (10.169.226.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 12:28:07 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 12:28:07 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH V4 6/6] arm64: mm: Allow forcing all userspace addresses
 to 52-bit
Thread-Topic: [PATCH V4 6/6] arm64: mm: Allow forcing all userspace addresses
 to 52-bit
Thread-Index: AQHUjLl5W54CY2lM/kWoyEE8IlnLUaVxmp6AgAAKLYA=
Date: Thu, 6 Dec 2018 12:28:07 +0000
Message-ID: <20181206122758.GB17572@capper-debian.cambridge.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-7-steve.capper@arm.com>
 <20181206115132.GD54495@arrakis.emea.arm.com>
In-Reply-To: <20181206115132.GD54495@arrakis.emea.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0060.namprd18.prod.outlook.com
 (2603:10b6:3:22::22) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB1623;
 6:MTITCnaTsObDSRVl+ySJhSd4gY8YdpxW4PFYnDKijOmTXVylhA/9A1FA5Yd823fKGkAvQi2fTejMUyAzFtd4MdEuH+P4HU9DGCeQ7pED9ovfRqUEWCh1cUtxS6FONy55544vCSDCGLYhmhg7kB7117IMevWaTfZHu0s4mrWClmB9iRIxXIZ7F2Yr+1zA6qlTGhw5vWiWyI++Wvc5nfBbs9kMJ8XKUfoPz0JmKtMDEZoSOnsKMtOx0e1aVZMzH5Tf1lDbuMNLJfzMyUWNOnx+O+NJZ9VNMPwOcWV4721yfahWr/arDFH66Lu/GN7vkpZYUv0w3SvNVvaFQUHMeKwCn9cAlyUmn4P6ucQCM0B//4OLC4txfVKm3dVWj2apy83frU7tXsw7NEPNgxqvD1aGAq/3X+Ku44zmq4L4MPit4AuAEPC4q5u6uftfzdPq29X2WRXFyXs6J5UM/r9jp+PKqw==;
 5:466gXmMRWJIyb/vk+CEQbmci7MQtgnsQFu6S1NKLdaOchOPGM91b2pbWF6fWhAIvtToL5PMm8tjV068yNy/zr0y5aO64Ij0U6cFudEx30A55fGpVYyQKfLAT90+X9VDc8xO2c8P90kmnVWiv2Udjz/H7uRsqbl1FK+jMQUlpKMY=;
 7:G17QnNU1mcsWPp2H4cFpchK4LX9PNVjOOVh7DC7VnLg2Q0JphgiU2ndvg2/uUspnzMvGrhPoPgX4y6byXATjlPw0DyHIHwwoxURGkROmqjMFun2DgJQ8jdLDAdjezU4PzfV6F04VYCMSEQ0Lm9pEYQ==
x-ms-office365-filtering-correlation-id: dc25eebe-dacf-4d9e-612b-08d65b764701
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB1623; 
x-ms-traffictypediagnostic: DB6PR0801MB1623:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1623A82CE757EB7092D08A8681A90@DB6PR0801MB1623.eurprd08.prod.outlook.com>
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
x-microsoft-antispam-message-info: gv32UUc6w4od8yCQ1MwIOWJksZjT4SXJCdCRbLufG9wQH0jxGNwVpaRSUFw07j4F4QR4/AsTaBqCzXIej7YkUhZ+mal6HXPbihdMOATgrkXevzU3qMyPdSxXHlv6AobhnT0+DiLVTK2j/7Lx2tY5bWuw5kBEwrdjtvbDF9KXLZVCzXufeAIz1DhiHzS4JTGrHN70QXDd+lTkbfnWpYIL1OjMXx6SHJwTdUX0Fy5v9/GVvHQP/0ie/DkA2rv6tVxLyeiB37/+4vDDIDBIfmXk3ShJlOd5wK5kCDueJhOM5ZGDevY8FbuqE5i5lU04nWiIlJzHZZ876Rrm35a1xjVTxIUHZ6R/T5Knrs8LrhsIhGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <A69D1A85E3666F408922354C98372FF0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25eebe-dacf-4d9e-612b-08d65b764701
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:28:07.7377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1623
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042821_877452_11A3B838 
X-CRM114-Status: GOOD (  13.82  )
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

On Thu, Dec 06, 2018 at 11:51:33AM +0000, Catalin Marinas wrote:
> On Wed, Dec 05, 2018 at 04:41:45PM +0000, Steve Capper wrote:
> > On arm64 52-bit VAs are provided to userspace when a hint is supplied to
> > mmap. This helps maintain compatibility with software that expects at
> > most 48-bit VAs to be returned.
> > 
> > In order to help identify software that has 48-bit VA assumptions, this
> > patch allows one to compile a kernel where 52-bit VAs are returned by
> > default on HW that supports it.
> > 
> > This feature is intended to be for development systems only.
> > 
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
