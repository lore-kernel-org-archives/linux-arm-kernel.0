Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36765C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034CE206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ixa6loiq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BWPaWGmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034CE206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i5BJHEyrBLSDQ+SVSJETJDp+rqwj9hUFPphMHmRsW3U=; b=Ixa6loiqkjVso4
	m1eMBh/XfKSLjz2fJFieai2FZCblNk9pvp45nT5OxfKMVTQLyL59u08QSnF8UdemVwv1UYoVkwA5m
	eqWYK9wP4T1npqKF6O3WSAlOYaMx5F1Lef5ClG5iS1chjpPe1AadoLAb2wAuKowePJPec7mdy3/wo
	gZU4lIpsOIOP/F0xCDGkQ9OSUVlFpsiOHqbNwxjKb3whGOiP1JGYsuuui0YqabD74+ite3i4vPr64
	3ENuaY8JbpzcRrY0mSRKYM1N6X1hL0RLv8mvPVw81IuZGTgmsc+fv1buSeb2P1lbN+Kugpo6OmPH4
	q/859DDQQTEFa0X8TSFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVpj-0000TM-6v; Thu, 10 Jan 2019 08:36:59 +0000
Received: from mail-eopbgr700075.outbound.protection.outlook.com
 ([40.107.70.75] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVpg-0000Se-Aj
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njfjVCvUL06l4WW6en/rOtyVLTktrSjrPmo4bkXx2Cw=;
 b=BWPaWGmvDfQmBM8IsoU4VxEweacU1uJ3VmrZIDvI1BSTij367KQH7SeUIt2DQZ2yFrPH2hDbN1qrFvHiCQsu8Lo8kB6gFPBAkFc5DJBKgGUwKngnY1KVqWzjag9tPDQKXxzjB6gshT50xphhETmNeKapAbKEy/L5Fxuc+2w/N+0=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1236.namprd12.prod.outlook.com (10.168.227.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 08:36:52 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090%11]) with mapi id 15.20.1516.015; Thu, 10 Jan
 2019 08:36:52 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Topic: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoLdCA
Date: Thu, 10 Jan 2019 08:36:52 +0000
Message-ID: <1ef4c460-9f11-3894-712f-b19b67287c4b@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM5PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:69::14) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR12MB1236;
 20:9QuVhKajwWEt+O0qT4vZN1R0wCAChLEYv/X6ojX3IIXSpqOksHIeoQiSPU7bArOP9uSj7kEkEuOY8wnA9dpyhXL9J0gVSe9P9JTOO5LBkXJsJSB2Isr0BZwYCca0I5wSwZflAGZdyhkWqsZ8eGtYxUC33GpaXgSAVzSmqujiIQQuTxROQChO+cuPEihgW+6eN1FPM0JBU0Hz3cK2w7g5zGUTaYmBmsP8IaBxASAPyEGPMFraGePzS2IYsOj2W9u8
x-ms-office365-filtering-correlation-id: 6372ea1d-7e7b-4acc-4a72-08d676d6c52b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR12MB1236; 
x-ms-traffictypediagnostic: BN6PR12MB1236:
x-microsoft-antispam-prvs: <BN6PR12MB1236E3815C269D269325248783840@BN6PR12MB1236.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(52116002)(2906002)(86362001)(99286004)(2501003)(76176011)(31696002)(54906003)(110136005)(316002)(36756003)(58126008)(72206003)(81166006)(8676002)(81156014)(14454004)(486006)(305945005)(478600001)(7736002)(6486002)(229853002)(8936002)(6436002)(106356001)(102836004)(105586002)(186003)(31686004)(386003)(6506007)(2616005)(476003)(68736007)(11346002)(446003)(46003)(4326008)(14444005)(256004)(64126003)(25786009)(97736004)(5660300001)(6512007)(65956001)(71190400001)(71200400001)(65806001)(6246003)(53936002)(6116002)(65826007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1236;
 H:BN6PR12MB1714.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CT25AwGHfhC4xNqLPU8CVb34MNnC+Zzwnw8wpFvzEH7nXMJJjpa3Id78GIgR/hPYMV1gGX4LGjnjnPRugazaHhgnMTA6RoYCRB1Ssqb8lsId6VG3s1ckfWnmypELUFlTMVZ0RuHubCiWHZ91IghC1Me1qsTriwzNqcWrAmdru7bIFlD+5joqx9FYQwE+gmV6lsGnCz8YXUP+Me120xyx96FMvICa/ngz38os0s2MrNb6tOQo4LxD91fe6R4nbbYTU8B/UP/Ln19l+VqSu2mVPtQiV2OtTQ9INmosdBovpZLK8ik+XaJYwnlEmG8LNjKF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <410D8B22E2614F46A9833CB4D8DDB197@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6372ea1d-7e7b-4acc-4a72-08d676d6c52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 08:36:52.4713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1236
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_003656_367132_D44C830B 
X-CRM114-Status: GOOD (  22.09  )
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
Cc: "Carsten.Haitzler@arm.com" <Carsten.Haitzler@arm.com>,
 David Airlie <airlied@linux.ie>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Bernhard.Rosenkranzer@linaro.org" <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,

thanks a lot for this! At least somebody who can explain why this 
doesn't work as expected.

The problem is that the hardware actually needs a few pages as uncached 
in a couple of cases to work correctly. So we could still run into 
issues with that solution.

For now we have blocked userspace/kernel from extensively using write 
combine mappings by adjusting drm_arch_can_wc_memory(), but that is 
probably degrading performance quite a bit.

What can be done to improve the solution? At least on X86 we solve this 
by marking the write combined pages in the linear mapping as uncached as 
well. Would this be doable on ARM as well?

Thanks,
Christian.

Am 10.01.19 um 08:28 schrieb Ard Biesheuvel:
> ARM systems do not permit the use of anything other than cached
> mappings for system memory, since that memory may be mapped in the
> linear region as well, and the architecture does not permit aliases
> with mismatched attributes.
>
> So short-circuit the evaluation in ttm_io_prot() if the flags include
> TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
> attributes immediately.
>
> This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
> Without this change, amdgpu does not start at all, and radeon only
> produces corrupt display output.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 046a6dda690a..0c1eef5f7ae3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
>   	if (caching_flags & TTM_PL_FLAG_CACHED)
>   		return tmp;
>   
> +#if defined(__arm__) || defined(__aarch64__)
> +	/* ARM only permits cached mappings of system memory */
> +	if (caching_flags & TTM_PL_SYSTEM)
> +		return tmp;
> +#endif
>   #if defined(__i386__) || defined(__x86_64__)
>   	if (caching_flags & TTM_PL_FLAG_WC)
>   		tmp = pgprot_writecombine(tmp);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
