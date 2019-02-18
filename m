Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F97C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:16:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DDD2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5V1Cjz0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cNvtYaWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DDD2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hvr9RST9MhlL7/RHhYakjJ0fTU2nIVPOPNKzhFn3TmE=; b=c5V1Cjz0jkZPaQ
	wzA8NUQZFPvtUCgeTfyDw61fbEMSOqzVK+AU4RDKGDfEgTV2+QFZJyHjrbCyTTeWBfudY8nKc4MrP
	qatOKT2znxiKP9ni63WIme/fJySKCr55gMJRqFnpmsLSGpcH4/hyW01KkkDEfC1qsS6hAw97LCB2d
	7D5VyPxX+03+03To9gEFVu3qLbX9HLjTV/nqh372h7tDCI/2n/Y1wxNbSP6x0B+gAVsA2ATcXs9qE
	0Tg/5kdMZWGPFpjuoUZV1K/d8MUSQMED6EM/kHjAoc/5W95ToxKyJ7cUUvUZB9y54iBf6zQGrbA6R
	RC0Iiq1bz9MT4qUWo8CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvguP-00046i-3I; Mon, 18 Feb 2019 11:16:25 +0000
Received: from mail-eopbgr150050.outbound.protection.outlook.com
 ([40.107.15.50] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvguK-00045e-1G
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:16:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZqQyXCcgD1TctuCMZ3oJqcD71M8+afEsxnaE6VsR4U=;
 b=cNvtYaWtWCofaIkS8LRYZhoJCLxOAFwsag2Sn6feb43hhmsTiuIyRsMG4LqjtVWqd2EW3XLxX5wym03duxARP5EVGFOg6MwYItHYsjKTqBDQIv+PnLTkIg2W5AYC2JnUMOFkKUIa4DIvX4r9nCQrZmXC+vnlHhU7nBWzOdcc5Kc=
Received: from VI1PR08MB3742.eurprd08.prod.outlook.com (20.178.15.26) by
 VI1PR08MB3040.eurprd08.prod.outlook.com (52.133.14.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 11:16:13 +0000
Received: from VI1PR08MB3742.eurprd08.prod.outlook.com
 ([fe80::2508:8790:80cb:2f91]) by VI1PR08MB3742.eurprd08.prod.outlook.com
 ([fe80::2508:8790:80cb:2f91%6]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 11:16:13 +0000
From: Mark Rutland <Mark.Rutland@arm.com>
To: Steven Price <Steven.Price@arm.com>
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
Thread-Topic: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
Thread-Index: AQHUxVBWN94KMPHRGky/cHEAHAjWbKXlbBIA
Date: Mon, 18 Feb 2019 11:16:12 +0000
Message-ID: <20190218111610.GD8036@lakrids.cambridge.arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
In-Reply-To: <20190215170235.23360-2-steven.price@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To VI1PR08MB3742.eurprd08.prod.outlook.com
 (2603:10a6:803:bc::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b8b040-c7d8-4678-b7e0-08d695927dae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB3040; 
x-ms-traffictypediagnostic: VI1PR08MB3040:
x-microsoft-exchange-diagnostics: 1; VI1PR08MB3040;
 20:PAe4UTHox4RFirNarP6SeS7J5sqpFTbGvfRkDYVXTe29ZAg7gqQOw9WoRKGqd6Xx4H2iEygXxCTg+54oaaEglcKYq7mq3laRG+Q84eDN0OZgLHnOtpbOmY0JvBbexRKJSev6g/8w9UElUCp4voAUAlMNHmV8Wm49iYEMKdhzSEk=
x-microsoft-antispam-prvs: <VI1PR08MB30409863CC5B821026461B5284630@VI1PR08MB3040.eurprd08.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(40434004)(189003)(199004)(4326008)(6436002)(256004)(14444005)(71200400001)(54906003)(71190400001)(5024004)(33656002)(44832011)(6512007)(6246003)(53936002)(58126008)(66066001)(106356001)(6486002)(6862004)(105586002)(7416002)(486006)(97736004)(76176011)(52116002)(8676002)(5660300002)(26005)(99286004)(186003)(6636002)(8936002)(81156014)(7736002)(81166006)(25786009)(229853002)(386003)(6506007)(14454004)(2906002)(72206003)(102836004)(11346002)(478600001)(6116002)(3846002)(305945005)(476003)(68736007)(316002)(1076003)(446003)(86362001)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3040;
 H:VI1PR08MB3742.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MiAbm4pal49uvdYcysOYssPdAc7uIviWQPGe+4hPJQihXt7iCDAnOdzomM7T8n+S7jrWrpXQTFSvDOBJEsidIB1g1igrRJjrwXAa3o6ECIfrPZRWKthM7OV/Exn00xZjlHvJUczldMlAmHT/C2B+gPZbzOKp69bsSBJkTVMVPlinjn5PM2SXd71L6igobN0cxV2Uh0zdn/EAcRt0LosPPP6GbwzgYbQXnMiN1IrJ8tW0aARoVBX908UtDrqiNKPUXM1BGAUGzwDKEkwVlIluG3iXqep9CyhD+4Ip6UY7qbotvBKxAvZsBPAYqPtTkQ/hmIIZZVc3Nc8p+WpZZr5HcE5zqlHZ5NUjKFxCNd23y8G2bWxwemqapO9pCL1e7rsH7CPO7NF+x0rulxOXpVT8pQfn+a2CStgixBg47ccU3dc=
Content-ID: <D5B84DEA07E5D94F81D38A6C14E569A9@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b8b040-c7d8-4678-b7e0-08d695927dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 11:16:11.9985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_031620_078298_A0463F21 
X-CRM114-Status: GOOD (  18.71  )
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
Cc: "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <James.Morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 05:02:22PM +0000, Steven Price wrote:
> From: James Morse <james.morse@arm.com>
>
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
>
> Expose p?d_large() from each architecture to detect these large mappings.
>
> arm64 already has these macros defined, but with a different name.
> p?d_large() is used by s390, sparc and x86. Only arm/arm64 use p?d_sect().
> Add a macro to allow both names.
>
> By not providing a pgd_large(), we get the generic version that always
> returns 0.

This last sentence isn't true until a subsequent patch, so it's probably
worth dropping it to avoid confusion.

Thanks,
Mark.

>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index de70c1eabf33..09d308921625 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -428,6 +428,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>   PMD_TYPE_TABLE)
>  #define pmd_sect(pmd)((pmd_val(pmd) & PMD_TYPE_MASK) == \
>   PMD_TYPE_SECT)
> +#define pmd_large(x)pmd_sect(x)
>
>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
>  #define pud_sect(pud)(0)
> @@ -435,6 +436,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  #else
>  #define pud_sect(pud)((pud_val(pud) & PUD_TYPE_MASK) == \
>   PUD_TYPE_SECT)
> +#define pud_large(x)pud_sect(x)
>  #define pud_table(pud)((pud_val(pud) & PUD_TYPE_MASK) == \
>   PUD_TYPE_TABLE)
>  #endif
> --
> 2.20.1
>
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
