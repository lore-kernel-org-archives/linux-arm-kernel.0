Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:03:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510AC20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCpIpfbs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mn2x6L5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510AC20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9GluiH996Kl01CLH2gH+rGufHahRKWstkosiP+eaWIE=; b=FCpIpfbsBMHWp/
	a9KK5hEEgZfKR3qrzqJ6fWkM3JNs3ZZnJLsW8XXPzzORq2ER6eSeFUSWVCBAIuroKKNGGEOryvBsl
	SSB6KXFu2iWyBMnBBDZl+COSsW8siMiqzuQLdKgSphcWBJpuicLpc02fkFzXH7MwBQhpi2OuIX3aT
	9Y/YF9q8nCSDu+rpAC3ZOSFJVl+3hfIKZ2QCdSJLkpqrSkkokTMPzKN369DsYGqkxhMzHL/TkYpsk
	Od+EaH4sQRLNFnyLrMKMnq0bUjYiq5v0tPcMZYDKTzRsRTXIQGNCteX96X9NciLFDybFCIsDdeZRw
	LVQ6ySPEYXF1KmfNQE2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwm8B-0006xF-Mo; Thu, 21 Feb 2019 11:03:07 +0000
Received: from mail-ve1eur02on0626.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::626]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwm88-0006wm-GO
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLe8OoANNsX1Eail0MOJi+OpCImzMERvz3loFTT/LU0=;
 b=mn2x6L5yequv31URbKONLw5XV4J0q4tQ5c2qIPHf4sr90QnQBdOLi1eM+3hAeCPSukRfS7ubF4kcVLOUzapBg+Zuxf3ovWbyjcx63MakU1C3K8GOj8pqFfuqC9D8VfW0occHizmf2axsXTwBp00kJB/5GXZQDaL90K/ftRS6OaE=
Received: from VI1PR08MB2862.eurprd08.prod.outlook.com (10.170.239.138) by
 VI1PR08MB3518.eurprd08.prod.outlook.com (20.177.61.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 11:02:57 +0000
Received: from VI1PR08MB2862.eurprd08.prod.outlook.com
 ([fe80::f0d9:64f0:bde3:8c4b]) by VI1PR08MB2862.eurprd08.prod.outlook.com
 ([fe80::f0d9:64f0:bde3:8c4b%4]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 11:02:57 +0000
From: Julien Grall <Julien.Grall@arm.com>
To: Christoffer Dall <Christoffer.Dall@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/14] KVM: arm/arm64: Factor out VMID into struct kvm_vmid
Thread-Topic: [PATCH 06/14] KVM: arm/arm64: Factor out VMID into struct
 kvm_vmid
Thread-Index: AQHUs+1CPLSrRhRKrkybA9Q8ANtlrqXqQh6A
Date: Thu, 21 Feb 2019 11:02:56 +0000
Message-ID: <1978ee57-c7bd-e55a-4e77-ad0b4b62d1d1@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-7-christoffer.dall@arm.com>
In-Reply-To: <20190124140032.8588-7-christoffer.dall@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::22) To VI1PR08MB2862.eurprd08.prod.outlook.com
 (2603:10a6:802:1f::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Grall@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f66dde38-d778-4f37-33a3-08d697ec2014
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB3518; 
x-ms-traffictypediagnostic: VI1PR08MB3518:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; VI1PR08MB3518;
 20:rcAf1JfvzmZ1GkQd4KDn5sAQc7GzVOVevspWU0rER01uvxnqnu9ty/2ZVuKCcOtqEC+Qk21S4ug7rqhTqUpB48BqU358slHp+4Pm+5ipqdc5WxUEDbRPS3jSj4kcD/b4oKdxqeGoLFqlbKCQHsF99lxZIH5WXHnHiY35HHHQO7M=
x-microsoft-antispam-prvs: <VI1PR08MB35188DE426F7068D91FA1703807E0@VI1PR08MB3518.eurprd08.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(71190400001)(86362001)(26005)(71200400001)(2201001)(36756003)(97736004)(14444005)(256004)(99286004)(14454004)(106356001)(72206003)(81166006)(81156014)(8676002)(105586002)(25786009)(2171002)(44832011)(66066001)(6246003)(31686004)(8936002)(31696002)(229853002)(102836004)(305945005)(478600001)(68736007)(7736002)(76176011)(6486002)(4326008)(186003)(316002)(11346002)(5660300002)(52116002)(53936002)(53546011)(386003)(2906002)(486006)(6506007)(6436002)(446003)(476003)(2501003)(110136005)(6512007)(54906003)(2616005)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3518;
 H:VI1PR08MB2862.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gg97WUmSHYLoUVnm0qqktz8z/+r1ggANAzVDY8GLMh+MvYNUIfw25t8143UYFyBAwJF6ZCBEC+NeiZWwNPKH0tMc0CSQr+Wa/puESe4PridoxWESo4ivdaegjVGGqszSwjAvmF6esasliuzMgObj349wJvE3QsCITTB/tDjFV7d2VFht8htaBWIEq1s5Ls9Pt8GTWXFz/PY7U6NwwqlcxV/pXvXDFFLChNZSrG9NO9iCuHRScxOUnVNP04oyk8tKVZsuXtO5lgy7ehkE7FIDPBtRR1qrGfyY2jbORele9dJeVnyfGPIacnW0FRcs1B5lnhOyuc/ui46WWSpz7rJ7KHtL7OXY6TF0Q4oFafGtL4S8Q8FeCt0AQIf+UtuVuf+mAmv3CJ6SZ/8ub65E1cNju9x/JymaKYr0Pk1jaxvINDc=
Content-ID: <7E8DC60B4CA826488988D8D2B3C89E0B@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66dde38-d778-4f37-33a3-08d697ec2014
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 11:02:52.3162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3518
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_030304_586945_5EA46C4A 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, nd <nd@arm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Christoffer,

On 24/01/2019 14:00, Christoffer Dall wrote:
> Note that to avoid mapping the kvm_vmid_bits variable into hyp, we
> simply forego the masking of the vmid value in kvm_get_vttbr and rely on
> update_vmid to always assign a valid vmid value (within the supported
> range).

[...]

> -	kvm->arch.vmid = kvm_next_vmid;
> +	vmid->vmid = kvm_next_vmid;
>   	kvm_next_vmid++;
> -	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
> -
> -	/* update vttbr to be used with the new vmid */
> -	pgd_phys = virt_to_phys(kvm->arch.pgd);
> -	BUG_ON(pgd_phys & ~kvm_vttbr_baddr_mask(kvm));
> -	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
> -	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
> +	kvm_next_vmid &= (1 << kvm_get_vmid_bits()) - 1;

The arm64 version of kvm_get_vmid_bits does not look cheap. Indeed it required 
to read the sanitized value of SYS_ID_AA64MMFR1_EL1 that is implemented using 
the function bsearch.

So wouldn't it be better to keep kvm_vmid_bits variable for use in update_vttbr()?

Cheers,

-- 
Julien Grall
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
