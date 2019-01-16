Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CBCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:38:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64842082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n/+DKBtD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=live.com header.i=@live.com header.b="AAxgkoMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64842082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CfrlGiq9vx+yFC/WqcYc6+62l148VEa4N8+8YxFmJ8Y=; b=n/+DKBtDSZRDnO
	b8Z1CozewwUxVgtoLUDurHfTEVKhaxFQyoCt6PqmrLQWopUAUGk1Q9wI0tEo4H+C/kddYwZbY98s/
	S5RJ4NxC4kB18HMpaklMZC45NLoFkC3AExYLlAF7ejvfIYMF8v26ft40ChJy7oNxCIEzelKx0Grxh
	PntAjmooqyAarUVh/RWHPxHhVVTMT63T5OULS2CuljoTJdc+YJrqXKjlIPp6PZkPh9wS+7Fzdrhl4
	v2y+2SAAcfb7RrPAwjC526gfYosTAw9XDGdVkHuBD1RfL+lKDz6zzGsWo1jKLb7lTOxbXpv1U0avX
	f/T7PvH4y0zgHhFGuleQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgia-0004kL-ET; Wed, 16 Jan 2019 08:38:36 +0000
Received: from mail-oln040092000030.outbound.protection.outlook.com
 ([40.92.0.30] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgiX-0004jw-8g
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUC9sTABUlNvnz7PcA1F5QZVBz2nov3/VDKWTr5nEPI=;
 b=AAxgkoMcTJXkJp4OiKNyo+iPfKPRSBBe7dYhO68jBLJZWTr+XU8sy/rwY5UzHWDVgYQVV//WOosxm6Ti9KuCx3nCZ3t2gpkKG5D3MQCFfa7ckkIfTD4vQz+ujfVUo2brBre3LyORNoB8ha2rFQIyqkG3N/0o65xQboaUcgm5lqeyvuWEsD30NdgdzHAqH1YAFloOyXMV9c4CJEf08//IsYTRbzXa+OhJtJC0QJm7UQhmZwP2llm3j6A3C2sbv+YpJRkjb/z4tiis/4ihRAl0qhwholilYCURi5r/AvLK+8J2Z300U/5F7As/erPbo2L5zQWvc9geQpVxufZuYUVESQ==
Received: from BN3NAM01FT023.eop-nam01.prod.protection.outlook.com
 (10.152.66.58) by BN3NAM01HT070.eop-nam01.prod.protection.outlook.com
 (10.152.66.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.26; Wed, 16 Jan
 2019 08:38:31 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.66.57) by
 BN3NAM01FT023.mail.protection.outlook.com (10.152.67.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Wed, 16 Jan 2019 08:38:31 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::dd7d:4ced:858f:a868]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::dd7d:4ced:858f:a868%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 08:38:31 +0000
From: Yueyi Li <liyueyi@live.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Topic: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5x6WNpCYAgAEYtgCAAlAzAIAgVdQAgABG6QCAAA0ogA==
Date: Wed, 16 Jan 2019 08:38:31 +0000
Message-ID: <BLUPR13MB0289B8C3D58E9A3FAD2CF3DEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
 <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0080.apcprd03.prod.outlook.com
 (2603:1096:203:72::20) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:8CBF141CB0179666A69D1612D89480E29E52AEF2C7BF11574DD98D94D88170F7;
 UpperCasedChecksum:329E41B1E6911E6F91044BF8E3B76A840D53E6AF299D69842FD456158B9E8A2E;
 SizeAsReceived:9437; Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [NkqjnhVau7GQV0ctpQN5sdzmBSEo1e+X]
x-microsoft-original-message-id: <0b823594-4434-2c5a-92e7-711b22a96de9@live.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN3NAM01HT070;
 6:uoCrJFyKRyDt/OZmTBIniLPuekPq+2NZZvS4oI/EeGJ+EbF0uBkb9KGZkJarvDalcLX0nF8MN7AlpVnYbvBB+bnr9gYfwRmMqlE4jMXXBISaaaoFSPWMxeui1NMs+7My/LCSdcraiPjFj6ke37ufsrDe0LkgMDgLFuDxA2f3AEJhYwN2E4nCfhi+/7PatqMElJTvXlULIMg4nyOIXHVeLM7OD1cMOTrw0Jvj2fo3o/qMUFdxU5lMdAGY8kQkWEeeiUcDaOjY53Id5Gnn4ROH1DD/lJUsLZIPo9FsGZCSHaqbNyrIRsLHO6P6Efp4ZVdAJcmR9HkPkzQKvw4TgodgEcqxCTL8uMcJAGKgG01Tw7HrmfY2Grwbv8Sru+EypGsNwnkDbBvBfL1g7uCmN9ZLZMKH0gSfR8W1G9+ZkWN3oIWkZ1xfWyA5lvXsjXTJkcVtwPPj+PPGxfMrvzETBdQa0Q==;
 5:7R8nt1bQuXflFQwYmuWT0uWUOdgYRKe6xSQI6UgiUIU3e8kC40maOJB/e2wqaABYA+8Nw9H4tSHobR1UgG9TPhALCQ79xkrwf3Iw/US8osAGQhxU1S6BQPLx/s37GlqVdTv48f8qTmbHRz+pcnbUuI8auVwpbt+QaTl3HGkDirefQPXtYQOIdmM6y6vJzMgHz3TzMISDg8HwpOSvuSsBBw==;
 7:R2FRUcNatNbbLIJ9aPiSgIN6cKYs2c6kwc7nqqTe9kxlHPEhH/3jHAxeQRAet379XvYyiTbbwwm2DcOQWRsOY6rUJ/PisLMUNEHzAWfMqI4t6DWd4YeBUzvAEfPc1lgBVmk9H2M4/QdmGshD+Et3IQ==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:BN3NAM01HT070; 
x-ms-traffictypediagnostic: BN3NAM01HT070:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:BN3NAM01HT070; BCL:0; PCL:0; RULEID:; SRVR:BN3NAM01HT070; 
x-microsoft-antispam-message-info: ocWRTy5wYmLfvgdhOpEeYpu73raIRx3Mug5O7T++08mDQeAqSVuXUy9BWRkERGbe
Content-ID: <60409A429487BE47ADC190BB1A9D2994@namprd13.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 75972ae4-8155-404d-9371-08d67b8dfe1a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 08:38:27.8293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM01HT070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_003833_392382_6E527D3E 
X-CRM114-Status: GOOD (  13.80  )
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



On 2019/1/16 15:51, Ard Biesheuvel wrote:
> On Wed, 16 Jan 2019 at 04:37, Yueyi Li <liyueyi@live.com> wrote:
>> OK, thanks. But seems this mail be ignored, do i need re-sent the patch?
>>
>> On 2018/12/26 21:49, Ard Biesheuvel wrote:
>>> On Tue, 25 Dec 2018 at 03:30, Yueyi Li <liyueyi@live.com> wrote:
>>>> Hi Ard,
>>>>
>>>>
>>>> On 2018/12/24 17:45, Ard Biesheuvel wrote:
>>>>> Does the following change fix your issue as well?
>>>>>
>>>>> index 9b432d9fcada..9dcf0ff75a11 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
>>>>>                     * memory spans, randomize the linear region as well.
>>>>>                     */
>>>>>                    if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
>>>>> -                       range = range / ARM64_MEMSTART_ALIGN + 1;
>>>>> +                       range /= ARM64_MEMSTART_ALIGN;
>>>>>                            memstart_addr -= ARM64_MEMSTART_ALIGN *
>>>>>                                             ((range * memstart_offset_seed) >> 16);
>>>>>                    }
>>>> Yes, it can fix this also. I just think modify the first *range*
>>>> calculation would be easier to grasp, what do you think?
>>>>
>>> I don't think there is a difference, to be honest, but I will leave it
>>> up to the maintainers to decide which approach they prefer.
> No it has been merged already. It is in v5.0-rc2 I think.

OK, thanks. :-)
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
