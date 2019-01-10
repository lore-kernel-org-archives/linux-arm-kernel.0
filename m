Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:40:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4F5206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OterVU72";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Y2adETpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4F5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TfQUDBF+s79h+N1LXqzuf7CAmkW6slYNEQ4BY1+0Dg8=; b=OterVU72BNKwKi
	F3LF3QfT0hH6WjJ8w1at7JMKnvarDS43nFudwLR8F6IrPINF9sDFwGRy8a/CMNPa4sdGzi67N6+5b
	vewbfPj6aZTERfR1I2d/tqg6WqGfJc1dAJNZbsHiUKycWbsqzg0YhRK1POULrClw1VpqwsSGZFFYw
	Ed3klc4OtOcc1kd86L39V1BdqcKB07MzaYDoLkhEt8J24Jk5Cb0dAcdot3fbhNxSaTyzsbuMFcvW9
	vb2n4yVfW+UV13kjGwL4QVNEe6epAss6PyoH0fk1i/hO/W+iujJU/q6PxvH5GHT+KNZFqfzvNAL9M
	iciRwzq9DpSB8h+CGazA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgBQ-0007Jz-VL; Thu, 10 Jan 2019 19:40:04 +0000
Received: from mail-eopbgr700098.outbound.protection.outlook.com
 ([40.107.70.98] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgBN-0006xu-Kk
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 19:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWTAc/Z1BvmTqFnFWjZzkPO+kmbT9u6bYCEVPRhiZ8E=;
 b=Y2adETpyNXPMKhZcj4MyCzn4lBGFTRC+ujBhE7qfzznKTa25hCnPYq9dth4btbuRPUlj/iBpGilinAjtzALsyh4qfrvTcuBqYmUdZFurUuhlMJiEL8Og2x5DYtIKgl16szetyQip1kNt4NVZ4P7ManAAUUswfNjyk5wVGblTskI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1469.namprd22.prod.outlook.com (10.174.170.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 19:39:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 19:39:51 +0000
From: Paul Burton <paul.burton@mips.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
Thread-Topic: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
Thread-Index: AQHUqQEbv9GqBtrBzEy9nMrieVYZQaWo5nyA
Date: Thu, 10 Jan 2019 19:39:50 +0000
Message-ID: <20190110193949.5wsysvchhhh2gfmu@pburton-laptop>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-12-arnd@arndb.de>
In-Reply-To: <20190110162435.309262-12-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::46) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1469;
 6:afa3TUPnhOxT013nTn2cK6LUXVHugi+LZBv81YCfUut8CAoGGlnegOwn+kgHzjkGlSuHh9thYEtiMTaI6oK0ByIY+zlox28jgpOUwWyv4R2sfXXEkck79m+thxnd9f4rdNx5tCm6JBDAY7tS9/Z4xjzlsPu0oo+WS3KyFYgzdSnQEDWkgdNr9yC4TXflEpq9KI4Ij9jGWRUiO+YfB3aTBr/kksyQhApwkBWb5i+MHy214YH3a5LqnPKwRxrR7GG76U+YHCai94+c8xXr/E9NyyL4WfafELst96YAD+KRTbsaXnkhr3mf5xUOlUFKhcL8cfxKkLiJre7PUMLfwYcPD8UUql8fPHPLZHvCmvTz9BMHzoY/TDPtT7Y3LlpnNnnM3+gt6EU/IFF5rvOLn2Ol4icumwPUYQxvBOi/MWxeclEtK5CdkV+S5Z24Ohwj5mkSc3isJbB73DaXbbSK8j6gXg==;
 5:fZ5jDKy1LHgNz0Dh90uY7NyY2A12VukAXmQrcZcUb/0t4xVwIdT7lwV1gSBIg+xyTnRooaI4/7CpP2naKuKKijVV7N10dYuNEG4bVdkYBkNtoBBUWz7VFZ91mOsRPQKAMjlXjM+Kuqamnukd+rRdf+ocHGJ15I5ehYYy2R7+boDchZyA0YbDZPlX/reQpbAB9aisQ6L0E3221gt6yO1Qeg==;
 7:QIJJvFe1Q7IHw50zPVdzVS38l8k2Lp3Se89b4eZtOWmn032FDKbDUm1FTAU02GGOPZUA5BtlTZPrJwDWXNIHkV9Cm3MQPWDjCHO2UbEUGYde0M2R6w9Y6kPqX9PcssyepphLP4U90Wd3u4NctsRumA==
x-ms-office365-filtering-correlation-id: a8f6dcd6-5974-4b69-4835-08d6773362c7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1469; 
x-ms-traffictypediagnostic: MWHPR2201MB1469:
x-microsoft-antispam-prvs: <MWHPR2201MB14697B1FE4D4F9CC90763DFEC1840@MWHPR2201MB1469.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(346002)(376002)(366004)(396003)(39840400004)(136003)(189003)(199004)(476003)(478600001)(66066001)(71200400001)(256004)(71190400001)(7416002)(97736004)(6506007)(386003)(14454004)(52116002)(33896004)(6246003)(102836004)(76176011)(5660300001)(44832011)(33716001)(58126008)(486006)(54906003)(99286004)(316002)(1076003)(4326008)(11346002)(186003)(446003)(25786009)(26005)(106356001)(6116002)(105586002)(6916009)(39060400002)(6512007)(9686003)(8676002)(53936002)(305945005)(81156014)(111086002)(2906002)(7736002)(68736007)(81166006)(6436002)(42882007)(3846002)(8936002)(7406005)(229853002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1469;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zdt4atwyYPo93b6QkPLZ9bsk6ttuI/2s4z0Zms9jRawy1SGNa0Q8KtlbFjpoIAHnVpIksYO8T7V2p6ZjRQom+D1Sr+F58y1164GJud6QzOh1Tk9+ignJVeIhdKm8tdDNKKZOqVwSlkkPtoW+mnSK+2swXdhuH9/GZZEaYg/GiHpfa3l5DtsDNnSivAHW5xZVwWuOQKwjuKoOqszNCwqTUtWmMexziUUTiz1V82MK/7eVeilxq26n7JZG+uPJ5heHVeSwSsA5/ot2nLKAb0mESTxfTR26ChrSgCSqhqPwMSAXXVaKQH6SoKa2AsSPzOri
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <84563C58F4996247B8C9CD40953EB594@namprd22.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f6dcd6-5974-4b69-4835-08d6773362c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:39:50.8952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1469
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_114001_836136_A0AB7A21 
X-CRM114-Status: GOOD (  19.76  )
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
Cc: "dalias@libc.org" <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "deller@gmx.de" <deller@gmx.de>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "firoz.khan@linaro.org" <firoz.khan@linaro.org>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Thu, Jan 10, 2019 at 05:24:31PM +0100, Arnd Bergmann wrote:
> While reading through the sysvipc implementation, I noticed that the n32
> semctl/shmctl/msgctl system calls behave differently based on whether
> o32 support is enabled or not: Without o32, the IPC_64 flag passed by
> user space is rejected but calls without that flag get IPC_64 behavior.
> 
> As far as I can tell, this was inadvertently changed by a cleanup patch
> but never noticed by anyone, possibly nobody has tried using sysvipc
> on n32 after linux-3.19.
> 
> Change it back to the old behavior now.
> 
> Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> As stated above, this was only found by inspection, the patch is not
> tested. Please review accordingly.

Nice catch! Would you prefer to merge this yourself, or that I take it
through the mips tree?

If the former then:

  Acked-by: Paul Burton <paul.burton@mips.com>

I suspect kernels configured with n32 support but no o32 support are
probably not very common - for internal testing we currently always
enable both.

Thanks,
    Paul

> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 787290781b8c..0d14f51d0002 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3155,6 +3155,7 @@ config MIPS32_O32
>  config MIPS32_N32
>  	bool "Kernel support for n32 binaries"
>  	depends on 64BIT
> +	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select COMPAT
>  	select MIPS32_COMPAT
>  	select SYSVIPC_COMPAT if SYSVIPC
> -- 
> 2.20.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
