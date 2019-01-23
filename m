Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEBC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:06:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E147421019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZEtQtH+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pBf+7BDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E147421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c6AHjN5GbS4K3Hh/wQXDKsEtMzUIdsBqs+OBg3pzDl4=; b=PZEtQtH+ruC63T
	wCIrB4/MYmNcGoPJ8BE+031V6X1PaqmWbnWlAVxuEFicOcoO7r8e1GJMPdheM2WGNAbiL2axmrwfn
	hBA35YsYFer4kYR77DFGQy2ouak+lhq7nmfP1l/HoMVQokV9V27kNXHsOGfdCudJpLdwCaEI+RAcF
	jHkxq9O8Q/kImhA2KGCArhFNA6baZlFIuKjT1xGokqgmp7YF75Q5mAOLd+bKXuuaidcG/WJ6fChXJ
	LyFUe30njZRm+7vuCK3+3Q7Nph+/nOT7ifmlPJYW/tp00xjiKZcAhZ4I9i8hi0jku0x4HfQ5yKPar
	RMuefDY9SXG+UElVyJKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmGMU-0007P2-IK; Wed, 23 Jan 2019 11:06:26 +0000
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmGMP-0007OQ-VV
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 11:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvN4xtKgmmt4kfD3iavyv4MSDRoRUNR8dYEiu1ZVdWk=;
 b=pBf+7BDPwQeOoqT9EjX3+z1Jua/9NLpZwKHx0C8Uy4Kl9Bvl3qxwZ4crbrMr4XdCU8s1sASvbtNmyFRfoMfHGEAq/shRX1RJ/O0FvSGzbFTecZtS6kqwjYPgqd/2NLYwVWlrn02rsxVOacMubeXZ93uC5s6mST52vp41RXrl8Hw=
Received: from AM0PR0502MB4068.eurprd05.prod.outlook.com (52.133.41.24) by
 AM0SPR01MB0025.eurprd05.prod.outlook.com (52.133.59.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Wed, 23 Jan 2019 11:06:17 +0000
Received: from AM0PR0502MB4068.eurprd05.prod.outlook.com
 ([fe80::c5a8:ab5d:6acb:408d]) by AM0PR0502MB4068.eurprd05.prod.outlook.com
 ([fe80::c5a8:ab5d:6acb:408d%4]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 11:06:17 +0000
From: Eran Ben Elisha <eranbe@mellanox.com>
To: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Subject: Re: [BUG] Linux-next fails to link on ARM in allyesconfig
Thread-Topic: [BUG] Linux-next fails to link on ARM in allyesconfig
Thread-Index: AQHUswO7mwbjylU7BkmpK9OZcZxi56W8sUcA
Date: Wed, 23 Jan 2019 11:06:17 +0000
Message-ID: <43777a0c-8c04-0216-496b-e1025c7f97b8@mellanox.com>
References: <0B66524E-5E31-4B9A-BFA5-B7F77264C967@linaro.org>
In-Reply-To: <0B66524E-5E31-4B9A-BFA5-B7F77264C967@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0046.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::23) To AM0PR0502MB4068.eurprd05.prod.outlook.com
 (2603:10a6:208:12::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=eranbe@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0SPR01MB0025;
 6:JN8Pjv+t94D+RWK7nrKaSxRnRXvG/LQkM+pdGwhexGjrr631KFy+W3WG/zRGjRe26KDY89wptheYR9X1awu8P9/phw68voOxYTssk4/X6GCoIXtYJAQ0+0K945+CdUCwCfsO099kULVsrHSgKb4G3pjXLm7C6JgBI7vDwYHWHN6x7uLNtQ05YSOOpP72pPvh4UYDjBBjGYAX2i0v5+xmU1G/yciGxFwL9M7k4Hzlr/7z/H0GiODelJdt5kiCWhZufkgyZ15MdJ5vah6V6Dfn5Y7mRW9QhK6cbT0In1nUQjN2rDo8rNSp8MDptaWL99CG14LXDyZfkGfs2ePGuX4Rd4dQvx4VeQw2zcdUX0vvIED0my2oXdG+kMDHo4urLRWX4sT0C5AZ5JHTLciDdcP3jruiFcwPgRhnCQY8fA95q1ra3pbUuFaGPothEF2DUonpf6lqixu8chjtfQtks1ooAA==;
 5:3Ggq9uuUL9IYnGCOoUMUV/SiRDs/pj8WnD4VM5TIC57xbKE25fLH0dtCgeiyo0iIcrB3ZLCY2qbB1xzgDQE8mnj8uzwnuAt/hygriSpD5MGSILeui2UWJqz4moLZszWNt0LqHToQJtG/RqXHwomMYSxwk0t3PAPSDLbNTaxHdStyNUws0777NyYqRbEPeSint7dX/SZ2utt2ZfVfLRwnhw==;
 7:S2gUrWJIfJ5BVbXj/xj6pjxYrOGyrvkkTgJwRYGzBp7ZUSerN3SpL4T5nxvg0j12ZIzmFpCbHHzDlL+yc5ohBoZG4A5xLPDErNWBgPfjOhgXxOybWVE1AWU+LGgDJ0/lMGoaxHLK2l5ams1VTiJCjw==
x-ms-office365-filtering-correlation-id: 63fd2a44-b17a-43cd-7765-08d68122cbe7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0SPR01MB0025; 
x-ms-traffictypediagnostic: AM0SPR01MB0025:
x-microsoft-antispam-prvs: <AM0SPR01MB00250ADA4DDA498D2D29C6A3BA990@AM0SPR01MB0025.eurprd05.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(106356001)(31686004)(105586002)(71200400001)(186003)(26005)(71190400001)(86362001)(6916009)(3846002)(6116002)(31696002)(486006)(4326008)(11346002)(446003)(54906003)(6246003)(229853002)(76176011)(53546011)(53936002)(305945005)(6506007)(386003)(97736004)(2616005)(316002)(66066001)(6436002)(6486002)(14454004)(8936002)(81166006)(36756003)(8676002)(81156014)(25786009)(6512007)(2906002)(68736007)(478600001)(7736002)(45080400002)(966005)(99286004)(256004)(52116002)(14444005)(6306002)(476003)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0SPR01MB0025;
 H:AM0PR0502MB4068.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mcEX88O58inrTm6BLM1bM/UvtYSyMLQj8gssqvgmonEaig11yHAxJSNEEsCZv0iOfwJ4EhzjVlhT3QgqELlh1cbzm4e+smE2vzvq8yurqNf540S+rA7AgxuzShKtTVQQIj47OKQM0PImvsEzam+lKmoHdNaBIWqw273q7kMKKTAOOvWiwkvcYXmJrbxhooj8SW6Okh/BsLZXZvgU5a7FdEyqd1zLNsbhI/wbY6TdqgHkAB1FJuIJv/u8h4Zlx7rqzs3fBeI8m5Y41ZZ/lKGBgR2kwMqhD2c9SN3fFCcMSQuGvWI4dutcu2S2Jd+I7m0TKTnNozbVDXO7p3iZPblXmsRjRK3zNooR+eMvhXLGKy0oxDqGYeNZnRBwhNjH0alyiVrSwkokIF59UKN9Vtsg2ECUqFFvUfL3Lp2YwO6g3m4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <D7DE9D53FD6DD943BE8DAEEEEE5AAEEB@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fd2a44-b17a-43cd-7765-08d68122cbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 11:06:16.4425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_030622_252228_5390A6F2 
X-CRM114-Status: GOOD (  17.27  )
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
Cc: Mark Brown <mark.brown@linaro.org>, Arnd Bergmann <arnd@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/23/2019 12:09 PM, Maxim Kuvyrkov wrote:
> Hi Eran,
> 
> It seems that your commit 880ee82f0313453ec5a6cb122866ac057263066b causes a link failure for ARM in allyesconfig.  This happens for at least gcc-8 and gcc-master compilers.
> ===
> arm-linux-gnueabihf-ld: net/core/devlink.o: in function `devlink_health_buffers_create':
> devlink.c:(.text+0x4eac): undefined reference to `__aeabi_uldivmod'

This one shall solve the issue:
https://patchwork.ozlabs.org/patch/1029047/

> ===
> 
> Would you please investigate?  Below is diagnostics from Linaro's automated bisection job.
> 
> 
> Successfully identified regression in CI configuration gnu-release-arm-next-allyesconfig for linux between bad_rev 5b22549b8c0011b8cc81b6f4fcd082e5545c3225 and baseline_rev a37d50ca3b837c19a297f349365d11a20c1087d0 .
> 
> Culprit:
> <cut>
> commit 880ee82f0313453ec5a6cb122866ac057263066b
> Author: Eran Ben Elisha <eranbe@mellanox.com>
> Date:   Thu Jan 17 23:59:11 2019 +0200
> 
>     devlink: Add health reporter create/destroy functionality
> 
>     Devlink health reporter is an instance for reporting, diagnosing and
>     recovering from run time errors discovered by the reporters.
>     Define it's data structure and supported operations.
>     In addition, expose devlink API to create and destroy a reporter.
>     Each devlink instance will hold it's own reporters list.
> 
>     As part of the allocation, driver shall provide a set of callbacks which
>     will be used the devlink in order to handle health reports and user
>     commands related to this reporter. In addition, driver is entitled to
>     provide some priv pointer, which can be fetched from the reporter by
>     devlink_health_reporter_priv function.
> 
>     For each reporter, devlink will hold a metadata of statistics,
>     buffers and status.
> 
>     Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
>     Reviewed-by: Moshe Shemesh <moshe@mellanox.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> </cut>
> 
> Results regressed from (for last_good == cb5ccfbe73b389470e1dc11061bb185ef4bc9aec)
> 
> <cut>
> reset_artifacts:
> -10
> build_abe binutils:
> -9
> build_abe stage1:
> -8
> linux_n_obj:
> all
> </cut>
> 
> to (for first_bad == 880ee82f0313453ec5a6cb122866ac057263066b)
> 
> <cut>
> reset_artifacts:
> -10
> build_abe binutils:
> -9
> build_abe stage1:
> -8
> linux_n_obj:
> 17403
> </cut>
> 
> Artifacts of last_good build: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2Fbuild-cb5ccfbe73b389470e1dc11061bb185ef4bc9aec%2F&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=vnw3DbcmXDmLsGUAGHA2049UrZC8mSmdLBaFarb7788%3D&amp;reserved=0
> Artifacts of first_bad build: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2Fbuild-880ee82f0313453ec5a6cb122866ac057263066b%2F&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=dROJYaVNnfMkvW%2FH4g9s2fk2AZYhfn9Ix8L1rqiLyGM%3D&amp;reserved=0
> 
> Reproduce builds:
> <cut>
> mkdir investigate-linux-880ee82f0313453ec5a6cb122866ac057263066b
> cd investigate-linux-880ee82f0313453ec5a6cb122866ac057263066b
> 
> git clone https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.linaro.org%2Ftoolchain%2Fjenkins-scripts&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=H2kp%2B48EjDTWQ5sBEQV4gpI97dIKEMDXRQglmy4lQv0%3D&amp;reserved=0
> 
> mkdir -p artifacts/manifests
> curl -o artifacts/manifests/build-baseline.sh https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2Fmanifests%2Fbuild-baseline.sh&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=APPLad%2FPA8p1mQDculq7nKjqxQhEkVjqFsRdfcxJ5Ig%3D&amp;reserved=0
> curl -o artifacts/manifests/build-parameters.sh https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2Fmanifests%2Fbuild-parameters.sh&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=nPZNkN7qJKh6VkVWRdgy%2F3rAn4hu45Y8TsKzyJ9dKpU%3D&amp;reserved=0
> curl -o artifacts/test.sh https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2Ftest.sh&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=hhgapeTncxxom59LkMMKW5h4iAfSMHwMMWPByf5h67E%3D&amp;reserved=0
> chmod +x artifacts/test.sh
> 
> # Reproduce the baseline build (build all pre-requisites)
> ./jenkins-scripts/tcwg_kernel-build.sh @@ artifacts/manifests/build-baseline.sh
> 
> cd linux
> 
> # Reproduce first_bad build
> git checkout --detach 880ee82f0313453ec5a6cb122866ac057263066b
> ../artifacts/test.sh
> 
> # Reproduce last_good build
> git checkout --detach cb5ccfbe73b389470e1dc11061bb185ef4bc9aec
> ../artifacts/test.sh
> 
> cd ..
> </cut>
> 
> History of pending regressions and results: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.linaro.org%2Ftoolchain%2Fci%2Fbase-artifacts.git%2Flog%2F%3Fh%3Dlinaro-local%2Fci%2Ftcwg_kernel%2Fgnu-release-arm-next-allyesconfig&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=oUjVRjdaqwSAU%2FfEanP3sypSLm6yPZgO6R%2BpsAjy308%3D&amp;reserved=0
> 
> Bisect log: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2Fbisect.log%2F*view*%2F&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=5y6EyveTvr4fiXyRAWL%2F1y51Rj6uRoISn1D%2B4aOGyfs%3D&amp;reserved=0
> Artifacts: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2Fartifact%2Fartifacts%2F&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=0oEekMKLbQ%2FiPvjQpKkSG7o8nvc5ye%2Bv8zVbAxit9jA%3D&amp;reserved=0
> Build URL: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2F&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=t%2Bf17lejwkaWMqSElFR1X8mUqkV7xFRBOByCGraJ30A%3D&amp;reserved=0
> Build log: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fci.linaro.org%2Fjob%2Ftcwg_kernel-bisect-gnu-release-arm-next-allyesconfig%2F12%2FconsoleText&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=jmHZihJwblQaMDoBJH764Jce0zgnhNwAkdnOdcEWWao%3D&amp;reserved=0
> 
> --
> Maxim Kuvyrkov
> https://emea01.safelinks.protection.outlook.com/?url=www.linaro.org&amp;data=02%7C01%7Ceranbe%40mellanox.com%7Cf644c95171f34a044bf508d6811adc79%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636838349704100824&amp;sdata=CqoP5P5yS0Z0ByANRZiS63TxaWUjp515YcxoQV8ojRY%3D&amp;reserved=0
> 
> 
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
