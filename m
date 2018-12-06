Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B59C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:38:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BEF20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dv3Yr9xE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Erg2GV48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BEF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vZggI3pX1bTyxsXu8M10pGhD1ju1BA084iji3vu1Bsg=; b=dv3Yr9xE7tkcEo
	wN3+WragvTIUv/z5juewbBIHO4jd0K6CwREFVsa1LRRpKRg+01wxjd7fMMy2oq5jyujqGPohSKxxI
	NQDjkqWpfDzvLtSIfKG4GyonqNUcY8lCBuLUiYX8U5UwJigCUmhgBntmGbXw7vdY1stzgX3JGRj0e
	AYKGJ4JVwpoijSeECsYfgcuG4Jfx9mNS1H08rUB4ASnSYFmcSbi7FNBtJFQh9Sq7nJtc/fuhMuxJP
	O0//1YB+qxBLtx1wzAz8SEYtdRN5q4vbgVFBJtEd626UN8R8Kz7Dg+aNdT2BbfczLKKFuHeTZLxPb
	eUno4fKQPiBik4mxMYIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwfe-00050f-9U; Thu, 06 Dec 2018 16:38:38 +0000
Received: from mail-ve1eur02on0615.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::615]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwfa-0004zY-87
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:38:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qujxz7HqmhT6jWV9rRLjw3fmJdV52CwVMPQZ16RCzGs=;
 b=Erg2GV48VO6aH+W+NgkaVCUEvxKQNiWOT2O1401jb2QgW+LRe2XopPTM1Y7/si0xz+KckgHiugf9MhRzgNeAcW73LhSuYt34QtuggsgST0o9W5Vr82imWgx/fktSGvz1pxZqZ6cYHrRa619RNxlq3FP6PBunIHOvgvEV7ZoH+as=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1942.eurprd08.prod.outlook.com (10.168.85.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 16:38:20 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 16:38:20 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Allen Pais <allen.pais@oracle.com>
Subject: Re: [PATCH] arm64: hugetlb: Register hugepages during arch init
Thread-Topic: [PATCH] arm64: hugetlb: Register hugepages during arch init
Thread-Index: AQHUamzWh21jCJGCvkCd5Sdgg3o/0aVyL0sA
Date: Thu, 6 Dec 2018 16:38:20 +0000
Message-ID: <20181206163810.GA1084@capper-debian.cambridge.arm.com>
References: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0068.namprd18.prod.outlook.com
 (2603:10b6:3:22::30) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB1942;
 6:9QUZww0M1iqyeCKxF7SXKeP+SFU/fzY0lvTQ8SctkgZt/4brCVmmP5UQfNNRBwPG/nbUKhEErI2nO17RUkliEUbrPznRsI87a5MUuvWGz6JQ5PtRdLcJF7cFOu8oG0CKlEf3f9+FKbJGsi6cdEjldDNfol/+QwNNE+HMMod8o8S70Ksxd41CDgJcZ8uRdDmfrID494X7FPRFFPYaF+/vbwu3V7MCX7LfQa8XgNR5B0w4KlkrUoCb3+3ORBpxg883XeSNFjAQplq/uwpEwjehUz22oM1n3v1btdM3n68PgDHPKkzOwg9nPp7+E+YuAxDFNjYVJvuZi/UM9dN5LSplfdnoTFd3OKKbttG74VZG1kpNBIhAF++3co3HJdQcO8Jzr8wWqJhXFko8S7qJ3TSee2qGvMYWrhI8ih5QsXKiWj3MuheQmxPFQMoNlPHiGKkY2ZN7H/Ea6JavzV8FkxFL9g==;
 5:ULwNqp+vH0yuWrW4HJLRjmNxAVwqZmhvFUGpkEcL7bo9djvhgm5B3FHNuSxQWu/1i+UBohUq5LSOygbGg+PKVsu2UOMwV+6PQy4B/Yo0E/nv0zEyPLrhruWLr9QOPhIy/pNmhLZgkjmxAuMco3n632P+BuKR48kODREo6dqAVX0=;
 7:9PfqLy/7G+AXssWzfWOFO2hebvPmQRslq4n01F9DXk4J0lHZd+C5HI4VKQuSjczF/2HX4zfL1FdsjkFf/QT+GQ8a1BiZPxEcGyAa+nn6utMxRM6OGMAE0PNXUX3QRDPxcimEcN+XH3XaK2HEihYIMw==
x-ms-office365-filtering-correlation-id: 283a4714-ad57-4f1a-50a5-08d65b993ae1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB1942; 
x-ms-traffictypediagnostic: DB6PR0801MB1942:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1942FB0014055A653A06AC2881A90@DB6PR0801MB1942.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0801MB1942; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0801MB1942; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(58126008)(7736002)(86362001)(229853002)(26005)(305945005)(106356001)(105586002)(256004)(186003)(1076002)(54906003)(71200400001)(44832011)(2906002)(71190400001)(76176011)(5660300001)(8936002)(316002)(6512007)(99286004)(476003)(11346002)(446003)(14454004)(68736007)(478600001)(6116002)(3846002)(486006)(25786009)(52116002)(53936002)(6246003)(6506007)(386003)(6436002)(6916009)(66066001)(72206003)(102836004)(8676002)(4326008)(6486002)(81156014)(81166006)(33656002)(97736004)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0801MB1942;
 H:DB6PR0801MB1366.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KG+tAiqUQk6iqJS6ZNWIRrgy8c6y7pstYexD2wN2f47sAuKEaAal+83ydY9WTdGZgzMwGbwiztAuw4PmHel23PtoJqZiJA5GJ/f3t1TECMAWQvp+Xr75zvFe7rUnJFZinWb9v3ZmcYlTZQw2+TGrUKoA9fK+iJmWF9mkDCbG/VstYYh8Ez0R1sOMd4uVpOWk5M9fbklGrpaNj7nbAkoo1m0m7rlPaVoyEKtSEMXvR3+5QsQc8ogvndTlK3rQ8DEsnujr/sFXwzbKUmKoIwcDM6xA2lziFMoJLst3tCm2uXnrtF+8dWviiswiJa7h+eU0VBw19BDBSBRENdoBcMOQFmE6iVeoBrqSWb/eVmzvSsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <93B0BFDA9607C644A8C07B230C56C8A0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283a4714-ad57-4f1a-50a5-08d65b993ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 16:38:20.0766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1942
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_083834_346245_55FB7241 
X-CRM114-Status: GOOD (  20.36  )
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
Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Oct 23, 2018 at 06:36:57AM +0530, Allen Pais wrote:
> Add hstate for each supported hugepage size using arch initcall.
> 
> * no hugepage parameters
> 
>   Without hugepage parameters, only a default hugepage size is
>   available for dynamic allocation.  It's different, for example, from
>   x86_64 and sparc64 where all supported hugepage sizes are available.
> 
> * only default_hugepagesz= is specified and set not to HPAGE_SIZE
> 
>   In spite of the fact that default_hugepagesz= is set to a valid
>   hugepage size, it's treated as unsupported and reverted to
>   HPAGE_SIZE.  Such behaviour is also different from x86_64 and
>   sparc64.
> 
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> Signed-off-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index f58ea50..28cbc22 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -429,6 +429,27 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>  }
>  
> +static void __init add_huge_page_size(unsigned long size)
> +{
> +	if (size_to_hstate(size))
> +		return;
> +
> +	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> +}
> +
> +static int __init hugetlbpage_init(void)
> +{
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	add_huge_page_size(PUD_SIZE);
> +#endif
> +	add_huge_page_size(PMD_SIZE * CONT_PMDS);
> +	add_huge_page_size(PMD_SIZE);
> +	add_huge_page_size(PAGE_SIZE * CONT_PTES);
> +
> +	return 0;
> +}
> +arch_initcall(hugetlbpage_init);
> +
>  static __init int setup_hugepagesz(char *opt)
>  {
>  	unsigned long ps = memparse(opt, &opt);
> @@ -440,7 +461,7 @@ static __init int setup_hugepagesz(char *opt)
>  	case PMD_SIZE * CONT_PMDS:
>  	case PMD_SIZE:
>  	case PAGE_SIZE * CONT_PTES:
> -		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
> +		add_huge_page_size(ps);
>  		return 1;
>  	}
>  
> @@ -449,13 +470,3 @@ static __init int setup_hugepagesz(char *opt)
>  	return 0;
>  }
>  __setup("hugepagesz=", setup_hugepagesz);
> -
> -#ifdef CONFIG_ARM64_64K_PAGES
> -static __init int add_default_hugepagesz(void)
> -{
> -	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
> -		hugetlb_add_hstate(CONT_PTE_SHIFT);
> -	return 0;
> -}
> -arch_initcall(add_default_hugepagesz);
> -#endif
> -- 
> 1.8.3.1
> 


Apologies for missing this, I like the idea of having all the hugetlb
sizes accessible right away.

FWIW:
Acked-by: Steve Capper <steve.capper@arm.com>

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
