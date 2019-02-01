Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF33C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2321720857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="niZhCR/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2321720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dR1luziYvW5gvtODetj6+3ShH+QjkCRH48PGq1wtVYM=; b=niZhCR/wKDYQ5E
	Yifj4qbYYN6g+OShZd0GQw0r845+n5dv+AkBTI0zEuLG0++jssNFQEKAeW8byCBo2bQ2eWqkAgdoP
	S3srI9vV3Yc7h03cfTdsarhwt2wCGKaeFflzugumnRSalPERBGGhgi6rmT1YP6jnsAnm63dAhn8Cs
	WAquIf8gjC1Dccyar/xjShHkZcwjdjLLRSJ8cnyzQh8ugQQj/Er7R0QJoZQNd8fr1iC3DLBAxMBzm
	KDcnfeHvQ8Ew8IJF09JasLpfsHXw9zn+JSKdLhypr6K4zyfjGLp0JgbPqc8yma0+da+FJ1u9yK74s
	eR69eLwqBMWTA+gxo0ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpRmE-0001wI-6u; Fri, 01 Feb 2019 05:54:10 +0000
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpRmA-0001vW-Lv
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 05:54:08 +0000
Received: from yt-mxauth.gw.nic.fujitsu.com (unknown [192.168.229.68]) by
 mgwym01.jp.fujitsu.com with smtp
 id 719c_141d_c9ffbbf8_523f_4f4e_a212_e56aaf489f8d;
 Fri, 01 Feb 2019 14:53:53 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B2F0AC00C3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 14:53:53 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 23075BD646B;
 Fri,  1 Feb 2019 14:53:52 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Fri, 1 Feb 2019
 14:53:51 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'James Morse' <james.morse@arm.com>
Subject: RE: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AQHUuKy5V4yTFdOO5Emj9g0aGwlQl6XKckPA
Date: Fri, 1 Feb 2019 05:53:50 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
In-Reply-To: <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_215406_962854_EF899F4D 
X-CRM114-Status: UNSURE (   5.87  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> James Morse
> Sent: Thursday, January 31, 2019 12:00 AM
> To: Zhang, Lei/張 雷
> Cc: 'Mark Rutland'; 'Catalin Marinas'; 'will.deacon@arm.com';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'
> Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> erratum 010001
> 
> 
> e03e61c3173c ("arm64: kaslr: Set TCR_EL1.NFD1 when
> CONFIG_RANDOMIZE_BASE=y") ?
> 
> So you'd never see it if you disabled CONFIG_RANDOMIZE_BASE?
For security, it is necessary to set CONFIG_RANDOMIZE_BASE=y.

Thanks,
Zhang Lei 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
