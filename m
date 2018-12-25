Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E7C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:46:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C090217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQJ31Guc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=live.com header.i=@live.com header.b="gb68k9nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C090217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HrOeTSCFla8WkVra1n5neMdT+WGelfC/FwnKa/Aswtk=; b=NQJ31GucVo6a6q
	fnQS/zjb2efLEYe0Ij8vitpy1bI+zNfV5T2qtGZZGAtSMEtxGGsZyYDfqiLA3s46TC2wdUwP8XZAX
	u3r8MVRElAxIpg5xTWra1bbkFVD9X2qK8sWBeNb7XKbPAvXhTZlG/vEsyhEabvVpNqqCm+4/11Pb4
	nH+IPtbT/r0aXCXqj9gEEsXdtFa8ryrU/RdQzXyvADO+qcZNwueddrn23aGzv8IcH1LHRSECcPr9Z
	wKvy/TgXmUDPErKCHMmij75PVyKxdocL495M1ewIQdUquWOIBwc4E8inLGQKWeAQm0Uz5NQUXZscR
	uU6909qOUV/J9p/TFqcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbcjj-0003ov-Ex; Tue, 25 Dec 2018 02:46:27 +0000
Received: from mail-oln040092007049.outbound.protection.outlook.com
 ([40.92.7.49] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbcjd-0003oA-6J
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 02:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWFakmN9dLQonjGFCCXaisoPPPkm9wz2Tqq2hY8IpRs=;
 b=gb68k9nWNeC6JyicST54eRnwHIgWNJsP2LhdzABL9hrUeONOaEFbm25jkkiUtGNARhtQFcl4hfzAIhmwAIOVRvAF2115K+eBBz2b/ylOzIPV3rBQtFBR96U8HOl9EMQhV7YXJYWLQyHZdWy1JPgp+w84c78HpNTcQ9fVD5Hw0rc1Lzri37epCx58uVjq0Bx09jQ1FGK2JkWEKzdIDq5YamI5VlK6ZeslFZT7fPWcnCbyEfDjKOKVvYnU51vokzbuKdAb4l0NDs4CMMs9kUYIiJlG/rTbTTxhnKxcrGFuulDmtix+u5gClxGds8JE3hSkXYCxwCvjaOK/r2QMiadcxw==
Received: from CO1NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (10.152.80.52) by CO1NAM03HT197.eop-NAM03.prod.protection.outlook.com
 (10.152.80.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.13; Tue, 25 Dec
 2018 02:30:33 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.80.53) by
 CO1NAM03FT009.mail.protection.outlook.com (10.152.80.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Tue, 25 Dec 2018 02:30:33 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1471.019; Tue, 25 Dec 2018
 02:30:33 +0000
From: Yueyi Li <liyueyi@live.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Topic: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5x6WNpCYAgAEYtgA=
Date: Tue, 25 Dec 2018 02:30:32 +0000
Message-ID: <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::30) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:ED8CAFCDDAAC72BC79F84A445901B78D61BCE5473B6CEE8A632B44068641364F;
 UpperCasedChecksum:720A7341F854FF4A24886FCE207ABD44CFD04736EEF6C855DE53299E64DE7D23;
 SizeAsReceived:7984; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [e6ETr/gPwoZ4KSwZ0cOvb65rZDPT6UUS]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CO1NAM03HT197;
 6:w0tNl2ayrq1mJBHdPhAvGVtIW91BYm4HXY2JKlmlH1jk0QmT3O/cfLxyj9qSozYcO4z1MoZPCV1K+77AFHYXGfTSeIeX45wWkMX7dDwesNvRknqFAPgw9rqJfkMhdyJbftgNbyIlurASZFijg3sr3E76dJ5/MwKM3aL64X0X6mRNvtRRfagJoysLwHzG9TBEYAaNBav62N99Jthm/iXYZyYhjQ6FNAHyttI/kRWBIbc2UIaJqbZGMYKrZgapzvgJr5++2PIts01y4ci1amTpzhYlOXZTjDS0DhosQOk0MRaLq8krBxxVujgr5A3bnnvaD4gL55XzI3Ad/rPjYXLo2Xfr2QiMH4I6RZCMB67VJJHFAQSLPj/PffPyzLv6YttDActihBzGsUAP2DwQ1CCfVm51Nd+OrCqU7ysJB7oLVNeggN1mfUs2s+55LOs//W330SyLv8gPWNcOGOv4JAaXAg==;
 5:vXLf7/LV6MdKK5jDtcTSReng1NVnOmytZIGvzr/EA34DolsrHgbsv3Q687RYU40dqvwxySqhwtJU3OUMJIr8iL9R3WvzOu7EWEVC3llFAfiirXbzpTE+UnlcqV7l8njFg+HEWtozHxhup7SEMHyfwUMErqDw50dieIYvWYITVIQ=;
 7:/ggbrV6cioCc8VeqmHzvsDX2c0anfqxtAkkJ5Ui2vTuEmWH6KfV9bd2i9pXCFeHmsJ2T/ZIdiZsbjhEV6xWU5wFTSRSiZCOljfzVr4Fz6R6v4BcgK/2sY64VExhUsjECXSoqquGbp+lC29FEAVj6bQ==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119063)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:CO1NAM03HT197; 
x-ms-traffictypediagnostic: CO1NAM03HT197:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:CO1NAM03HT197; BCL:0; PCL:0; RULEID:; SRVR:CO1NAM03HT197; 
x-microsoft-antispam-message-info: bzs2yNjAzCgTl/+ExUjvwzm/As/r3b//q/4IGQMMLib/I9oJKrQ8MTW6LMuBtS6a
Content-ID: <4FD45580FFC0B745A13E84CA26AFCA29@namprd13.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 05506636-fe52-4bc9-b481-08d66a10f152
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2018 02:30:32.9231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM03HT197
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_184621_298894_FE9BD647 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "markus@oberhumer.com" <markus@oberhumer.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,


On 2018/12/24 17:45, Ard Biesheuvel wrote:
> Does the following change fix your issue as well?
>
> index 9b432d9fcada..9dcf0ff75a11 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
>                   * memory spans, randomize the linear region as well.
>                   */
>                  if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> -                       range = range / ARM64_MEMSTART_ALIGN + 1;
> +                       range /= ARM64_MEMSTART_ALIGN;
>                          memstart_addr -= ARM64_MEMSTART_ALIGN *
>                                           ((range * memstart_offset_seed) >> 16);
>                  }

Yes, it can fix this also. I just think modify the first *range* 
calculation would be easier to
  grasp, what do you think?



Thanks,
Yueyi
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
