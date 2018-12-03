Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8AF2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yvoi6OCG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ok6VhZ/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8AF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s2kpY/OQ/e9Ehu5lYN+RT1k06cJFlP3jcdUHsmnpk/Y=; b=Yvoi6OCG6NFRwz
	oBD7sHLpJoZhQA/MA8Q5MiWCiYX6KKo5H8pb6fJcFyxSnX4N6/cqOo2ETmQ/VvnRZOlKoptJMR5YU
	V1r8TtFtCw0mzq6hB91puz+yWOdumyC98Cx2EGLE65UnCzsGCaM4DkAF21o9NXJaErHcNxNrmMJSK
	uZqxaZ136Us41PxTXk0GMZW7BwZakaXcZkMLwBjKO5NED3Be448aXn7j3Lm8f6879N+1Tn0moDx2M
	fAXAz3ogrWFgJbYUEOovJNa66M9IGELEoONpgDk3qg6UjYVyDREWUHKs3jLAuRB47oAwRFownxlF7
	FRalw0K1ytjTrmesN5fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlY1-00012b-Tg; Mon, 03 Dec 2018 10:33:53 +0000
Received: from mail-eopbgr140075.outbound.protection.outlook.com
 ([40.107.14.75] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlXx-000123-UL
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL9sQ9CNXk/Ddce8sg2HStetp/IA5BzlRevH07kk/t4=;
 b=ok6VhZ/FNYHnKxZRAg+xHpmuzCgDc4VPCU9QdnLUFObdwEUmwDewvs/4jD1r/usSbXBSVKa+P+CKy5AIqCx/qa0Q9dQNlK4RH/sk2eNiyER69hDj507Lu+3h0NoVaePu3R27XAvWFz6l08hZjpEMMuu265VDHkkxy2WgVevTlGg=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3628.eurprd08.prod.outlook.com (20.177.120.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 10:33:34 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::971:f108:751f:a081]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::971:f108:751f:a081%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:33:34 +0000
From: Julien Thierry <Julien.Thierry@arm.com>
To: Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
Thread-Topic: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
Thread-Index: AQHUen7n/WwLlgLNB0KOZP7C5Kq2z6VnGG8AgAXZ2QA=
Date: Mon, 3 Dec 2018 10:33:34 +0000
Message-ID: <a6529e7b-1191-7ec0-8adf-8d512b57b78d@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
 <20181129171231.ho5a3hx3ig3skm2x@lakrids.cambridge.arm.com>
In-Reply-To: <20181129171231.ho5a3hx3ig3skm2x@lakrids.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::20) To DB7PR08MB3082.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Thierry@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR08MB3628;
 6:ugtQBVv8Re8UJTSN7Y1/7qmcWVKm3kK/XEZ+lcL1nIvAIrdiJWJpKDG+FloW9s+InfseCSeLkRaG5X6m8XeTVTIb39ugO/NFC56eszG6pJ//VmFVjBUFsFfChH2RzmvQB2WioxewEsZDf8S3zkdXXxyW3RR4W7o3wH/FzQCdzjB7mGwGIbQupKg6ru4Pzxh8TSEg/18bfDe5140oatHULCR2PPkyvWhcNAvPPT6herz4VuMSevZvuDT4rndtAJTMpD5ppg9AIP+fwLIkgdYpf3VoHury4Bq6BuF708aB70NEpA3Hw3I8Vwz2x1z/xI/W1fMnzt7++gO0EcK9U9MX30y+wkOBB1IxYeGJP7EMXyMVAT1qR3V8hLbgjfsu+vaaQuo1jBDUut5tf2kCpgS6tbOmXFYSanLFpZdLc6HlaKU8i+4Fozja+SCgs7rsv2LNt3IjgLlbPN3KFEL+QSFQ7A==;
 5:kff7sg0gr5+93C16Y5KbgJ0j177RirJFLfGmVrEubPFnOxQApdCD3CWnLXlNZOZDUq2stAsOuIKODS6MC+pGQcCoB1Wz3iD3B/x0hzZMkDCYkiKoFc/58lCct8XoyAefwfA5fFvfcn7nQOTQ/U2IJ4zzIhWOsYx2cPadiTUCtuA=;
 7:Bv9FDcj51q4jxmXX4KNS/CcoKKEd2M0TWMe9YCcABVe9BG9jp8CVqk2rG47Uh+tNuSXNFMpOh3u6neHtVTshoY3A4ULEh0J2DDq3YsuvHnOfHWJjbxuPO+YFeaM9O6sIHkYNNHT1BOE6vFbkletPgQ==
x-ms-office365-filtering-correlation-id: 301b50e4-bf29-40ec-7ba9-08d6590ac6c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR08MB3628; 
x-ms-traffictypediagnostic: DB7PR08MB3628:
x-microsoft-antispam-prvs: <DB7PR08MB36285012467A5EE52CCEC49E9DAE0@DB7PR08MB3628.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB7PR08MB3628; BCL:0; PCL:0; RULEID:; SRVR:DB7PR08MB3628; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(40434004)(189003)(199004)(68736007)(81156014)(6436002)(6116002)(8936002)(305945005)(476003)(478600001)(81166006)(72206003)(44832011)(7736002)(4326008)(53936002)(3846002)(31686004)(2616005)(6306002)(6512007)(486006)(5660300001)(446003)(86362001)(11346002)(97736004)(105586002)(6636002)(229853002)(6862004)(99286004)(26005)(186003)(76176011)(14454004)(52116002)(6246003)(25786009)(106356001)(31696002)(386003)(53546011)(102836004)(2906002)(14444005)(256004)(5024004)(316002)(37006003)(36756003)(66066001)(6486002)(966005)(71190400001)(71200400001)(8676002)(54906003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR08MB3628;
 H:DB7PR08MB3082.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CA4g+Nb3Yv+l/dQb+ENU0ncWCQksB4HthOAAz+Do342bv4/i+tQBqtpKglPXVi5squLfjqtw3r2ymZFAIt4C5W9m1Q6osEqFyLfxlWIEnSs/CeAofUz3j7lcrnLJvoqpq5PP7YpK0bDg0n/DmPllsWf6p7d+ebVjAp0usSeUY9MN4eROgoUEhLA9mJql5sBiVPw+87UX84zmz8QXHFh6hGPAYnhUoDV4ToOCn7019I0Y68jUhUynT//NMMvnszmBRa3F4W7ZPJJQgEmgHtB1a1kAe559oumFQnVy7CYtShvM01liayowcp/kG5z45+eVIOkAn3WBkEEwbP+NAaMlLjhxXGZFDftKH06rY8vc6Kg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <902ED79CEF9B7442A2EC60CD001C44E0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301b50e4-bf29-40ec-7ba9-08d6590ac6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:33:34.4351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3628
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_023349_978844_97E69212 
X-CRM114-Status: GOOD (  20.85  )
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
 Suzuki Poulose <Suzuki.Poulose@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, James Morse <James.Morse@arm.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 29/11/18 17:12, Mark Rutland wrote:
> On Mon, Nov 12, 2018 at 11:56:54AM +0000, Julien Thierry wrote:
>> Add a cpufeature indicating whether a cpu supports masking interrupts
>> by priority.
>>
>> The feature will be properly enabled in a later patch.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  arch/arm64/include/asm/cpucaps.h    |  3 ++-
>>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>>  arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++++
>>  3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
>> index 6e2d254..f367e5c 100644
>> --- a/arch/arm64/include/asm/cpucaps.h
>> +++ b/arch/arm64/include/asm/cpucaps.h
>> @@ -54,7 +54,8 @@
>>  #define ARM64_HAS_CRC3233
>>  #define ARM64_SSBS34
>>  #define ARM64_WORKAROUND_118887335
>> +#define ARM64_HAS_IRQ_PRIO_MASKING36
>>
>> -#define ARM64_NCAPS36
>> +#define ARM64_NCAPS37
>>
>>  #endif /* __ASM_CPUCAPS_H */
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 7e2ec64..a6e063f 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -514,6 +514,12 @@ static inline bool system_supports_cnp(void)
>>  cpus_have_const_cap(ARM64_HAS_CNP);
>>  }
>>
>> +static inline bool system_supports_irq_prio_masking(void)
>> +{
>> +return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
>> +       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
>> +}
>
> This should probably be s/supports/uses/.
>

Fixed locally.

> With that:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks,

Julien

> Mark.
>
>> +
>>  #define ARM64_SSBD_UNKNOWN-1
>>  #define ARM64_SSBD_FORCE_DISABLE0
>>  #define ARM64_SSBD_KERNEL1
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 03a9d96..1b5b553 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1145,6 +1145,14 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>>  }
>>  #endif /* CONFIG_ARM64_RAS_EXTN */
>>
>> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>> +static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
>> +   int scope)
>> +{
>> +return false;
>> +}
>> +#endif
>> +
>>  static const struct arm64_cpu_capabilities arm64_features[] = {
>>  {
>>  .desc = "GIC system register CPU interface",
>> @@ -1368,6 +1376,21 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>>  .cpu_enable = cpu_enable_cnp,
>>  },
>>  #endif
>> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>> +{
>> +/*
>> + * Depends on having GICv3
>> + */
>> +.desc = "IRQ priority masking",
>> +.capability = ARM64_HAS_IRQ_PRIO_MASKING,
>> +.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>> +.matches = can_use_gic_priorities,
>> +.sys_reg = SYS_ID_AA64PFR0_EL1,
>> +.field_pos = ID_AA64PFR0_GIC_SHIFT,
>> +.sign = FTR_UNSIGNED,
>> +.min_field_value = 1,
>> +},
>> +#endif
>>  {},
>>  };
>>
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
Julien Thierry
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
