Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A0AC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:06:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6252054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rKtSmDND";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iCsr4LmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6252054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0NbNisMqN9i++FF3LowRgIuGSkqVgh+gf7J5RqB7LqA=; b=rKtSmDNDumyJz/
	bnWaKJoIdZQqv57DQ+wapI4/KWRZRSDAJSoi/j8PvTtsyj4V1HR37nwvOzfR1Y02b7FnKxjiurvDB
	MVKa6GsAzDnKB8aO9+mx5mewiLxeqr/wT1WNrckdgIYkgK6+D5N0+hszMtqgq7YLL5dKF0PiIevmU
	Vodx1CuTA9yh2OunDiLcTCErcrFjWYor2nS52VJihyW/UGgDaX63ZC5Fr1rlT0YBP2RPSO7bu+uYz
	g3VqWGhqmbQGfpOWPaIpAORXlV2yaqNoeUg3jyy6/NK3VNU+o77XJvhY/3iCcco3bdwvlbXDp8lt9
	yjyUh9Vqx7vJM/Vhuhig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVQ8A-0006FY-GX; Sat, 08 Dec 2018 00:06:02 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVQ87-0006EC-6x
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 00:06:00 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0b0ada0000>; Fri, 07 Dec 2018 16:05:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 16:05:47 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 16:05:47 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Dec
 2018 00:05:47 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server
 (TLS) id
 15.0.1395.4 via Frontend Transport; Sat, 8 Dec 2018 00:05:47 +0000
Received: from BYAPR12MB2712.namprd12.prod.outlook.com (20.177.124.13) by
 BYAPR12MB2695.namprd12.prod.outlook.com (20.176.255.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Sat, 8 Dec 2018 00:05:45 +0000
Received: from BYAPR12MB2712.namprd12.prod.outlook.com
 ([fe80::2c34:273b:59ad:23d6]) by BYAPR12MB2712.namprd12.prod.outlook.com
 ([fe80::2c34:273b:59ad:23d6%2]) with mapi id 15.20.1404.021; Sat, 8 Dec 2018
 00:05:44 +0000
From: Alexander Van Brunt <avanbrunt@nvidia.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Thread-Topic: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Thread-Index: AQHUb2mK2jioXCSBXUOglXMUWPpsLKU2DOwAgABGE2iAN2VlVIAEmdOAgAAC4fGAABP4t4ABY6SAgABWZTk=
Date: Sat, 8 Dec 2018 00:05:44 +0000
Message-ID: <BYAPR12MB271295B398729E07F31082A7CFAA0@BYAPR12MB2712.namprd12.prod.outlook.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
 <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
 <20181206191850.GC20796@arm.com>
 <BYAPR12MB271239AAF4A0B79D756850C6CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
 <BYAPR12MB27120C304F7B085A0CA36124CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>,
 <20181207175330.GC11430@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181207175330.GC11430@edgewater-inn.cambridge.arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avanbrunt@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR12MB2695;
 6:GxKAZMRCyhOkl6j9PTSSQFsAvhK5pfMzf3DufLIlxcsGZNudddJb+2I1fVBxZPtRlzjkuNKIW3gJodSFxN0r51qpxh1vXsGjNMg2LVDr6Mhwle1Z3H8ySsSML7/LA2SDRlI77vyanfCM+KPPxMI/7dZUxRlxb2tDLWPqTpn1D6V1vFQ9iawy7UFQo4Lg5hQ9XKChDQXXi9R2cRvTvybb/jKc/8mpzQwkraxOiot+1PmQWVofNPUARxNKgYp1Yjk2GwzWfBeLL6X9VWnf2iy6R+94y4mFB18UKTLaK4N4SRMac4UWKI5Tsu1iaulRvmF2A34jfBwsAsWNqWHLbhgWbQLjUs2PNJzJP8vOaxRun+hFINVhTKL6Cr0S1E4VEAPXk5fB9f/G7bEU1eW+zJKwz57bUdeKqfDmer9yR8wsmq2XFsizg4sM9lzrcIIBD+FBjtCd8ge7X/g+Z89WtCOZuA==;
 5:zaHuFK37GkW3/dU/KosZWDM8hldwiuOVasrtxoxUGlK7Ct3tFN7d+4Y22uUOMJDPWTDsaqVlKdxlgLRSe/ZmoV4VLrjTct9fgvlv8ZCC66rqV7JB4BaUTt7BHmwbyLti8QCOxgLgMuattwAeroi/TPDhuY+bMPFvOIXShooJcA4=;
 7:uSkJ7V+UdDssvGXfuoFazj1hre9XkS3v7c642Fk/HdkchK7emdd10qwEzgYRfqtS8I9Ci8BdfSqt/5dIXYgYT78SwIk16qakFwWIzm2QWxM3Fwt5Lwn4Fl4ALENRmkHAD96sbqit1RoGnNTL2FnCxA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(366004)(189003)(199004)(105586002)(6916009)(93886005)(97736004)(106356001)(229853002)(8936002)(6116002)(3846002)(33656002)(5660300001)(81166006)(54906003)(316002)(81156014)(8676002)(6436002)(55016002)(7736002)(74316002)(305945005)(9686003)(4326008)(53936002)(6246003)(478600001)(25786009)(186003)(68736007)(86362001)(476003)(446003)(11346002)(26005)(256004)(14444005)(6506007)(7696005)(99286004)(2906002)(102836004)(66066001)(71200400001)(76176011)(486006)(71190400001)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2695;
 H:BYAPR12MB2712.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-office365-filtering-correlation-id: e844cd0d-fe5d-42aa-6004-08d65ca0e660
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR12MB2695; 
x-ms-traffictypediagnostic: BYAPR12MB2695:
x-microsoft-antispam-prvs: <BYAPR12MB2695DBEAC0A2767D3B52333DCFAB0@BYAPR12MB2695.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BYAPR12MB2695; BCL:0; PCL:0; RULEID:; SRVR:BYAPR12MB2695; 
x-forefront-prvs: 0880FB6EC1
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fukrr/cHv5D21NMapOcpmDagQ5foT6xt5Lfbht0G2NSzvKoFriiJuDDLny8E2/CQK85byWfkIzPtNY12nVDxc4lWYR7qr+cmAeDDd+TvqslDZwlrJPTgg4004EAocFFdSk8L94xWkpKyJHtFbQS55zbW76JfeZYcUAL+vPjjwAhwudIRSA14rj1JAmxamQ0h32dW3pwerX2rF+1NYzJWLHpbOCkhV24Z8mu158InbywGBVcmpmQFw2+904JPchfFacy+v0hrXkk87Rp67B3hs/TIlktLONDdcYjEY6oKCjmZv3sTYCM7CaGPFV+FCacizs7U0GwSIoDVMeaKy4II9FU+pndieN7Ysy5mjnpDchQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e844cd0d-fe5d-42aa-6004-08d65ca0e660
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 00:05:44.7741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544227546; bh=ZF1hFouDXDs4UBLIwuo2/kXizwYZ9ZY2jlI66QU6Hm8=;
 h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
 x-ms-exchange-antispam-srfa-diagnostics:
 x-forefront-antispam-report:
 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
 x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
 x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
 spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type:Content-Transfer-Encoding;
 b=iCsr4LmCeB+xhMcD6Ux9zVxwXyCpgUJqlOnUZK+nPpxpxf+3Joz1vQEOq4PvTF/YV
 l1QWEZyjW1lrYGPG0uvjPG0Iwo8dWw/m5gNG7urbTqR79E5c4jNqeFZXPtqUcqQluC
 m9kH3NyGih0QBHhc3PaKTZHrutNGb4wHijgfCsUsOEGfuXjRCPOLkv9pNujmXXawOU
 SL0i8XdMrkbFYWDgsAyO/Ls983Jco8ntI0p5hG/T40xJrXQEai7b6P3R0WIrzWyDYT
 Hhvdo01K5uDC4wrp8xtr3uUtK3vSsNduuCd5B+XJf6N8OdZBhXC0+VCR9+oRs60Olr
 S/rdk4sgLMA/g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_160559_271228_77FCA936 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sachin Nikam <Snikam@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Ashish Mhetre <amhetre@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > > My problem with that is it's not really much different to just skipping the
> > > page table update entirely. Skipping the DSB is closer to what is done on
> > > x86, where we bound the stale entry time to the next context-switch.
> >  
> > Which of the three implementations is the "that" and "it" in the first sentence?
>
> that = it = skipping the whole invalidation + the DSB

The TLB is tiny compared to the size of the inactive list. Somehow a TLB has to
not be evicted during the page's life in the inactive list. That is not an easy
feat except for the hottest of pages.

If there is a context-switch, most of the original thread's TLBs will be
evicted because TLBs have a hard time to hold two thread's working sets. So, in
practice, that is almost the same as the x86 guarantee.

The worst case cannot have a large impact because the maximum number of pages
that will not have the TLB evicted is the number of pages in the TLB. For
example, a 1024 entry TLB can at worst result in 4 MB of pages erroneously
reclaimed. That is not bad on a system with 4+ GB of memory.

We did benchmark the extreme case where half the pages accessed where not
evicted from the TLB. In the read case, skipping the DSB was ~10% faster than
skipping the invalidate or doing the invalidate and the DSB.

Compared to the improvement in the average performance and variability in the
other cases we tested, the 10% loss in a carefully crafted test is not as
important.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
