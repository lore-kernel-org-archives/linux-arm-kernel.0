Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F493C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:55:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEEE20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WeB84Tyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEEE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RpqSpn5bBENVEim+UXxqTUFe0Pvo4bpySjdDjasz4rc=; b=WeB84TyckRdiYh
	mh4El1rpyrd6prSkssuZZTzazI+0WNvtnQ2lzcs/Z0QRqtG/kA7cxJCfWASi6U20n2LFxWpDlrtsJ
	Vm7cA8ez4SsDgkhrl7iP/8SP7d6a818GSgOa7LZpLbsI6J00S+cnTShhxke68MOFOZbmA8vW1hXK6
	K5q7qginZBgnYMZFLGMeLA4QHpQtkLe3MmhKqeARo5s24jwZyaMHaU4wJvKbDaK55u1D7p64lhhHI
	oYJOh+rRjAvaXhUl3Qj+fp2hwe0BqjHDSXD3B9jO4zo+pfORtLOx3+Wa3/XTvGRadqyrM4HjMljEi
	XUurZ829vybYCJpik72w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goR2m-0005Uw-Tx; Tue, 29 Jan 2019 10:55:04 +0000
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goR2h-0005OD-O0
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:55:01 +0000
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by
 mgwym04.jp.fujitsu.com with smtp
 id 72fe_4f90_13cc3859_cf4e_497e_ab0a_2334c95ef8e2;
 Tue, 29 Jan 2019 19:54:54 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 02832AC0124
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:54:54 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id CDA043286EE;
 Tue, 29 Jan 2019 19:54:52 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Tue, 29 Jan 2019
 19:54:52 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Catalin Marinas' <catalin.marinas@arm.com>
Subject: RE: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdSyLRrS1IDcSdJoRF6WCq7/B3VdwACYGWwAAMw1BtA=
Date: Tue, 29 Jan 2019 10:54:51 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2C03E0@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2A32D6@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
 <20190125180813.GM25901@arrakis.emea.arm.com>
In-Reply-To: <20190125180813.GM25901@arrakis.emea.arm.com>
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
X-CRM114-CacheID: sfid-20190129_025500_030820_0EC91162 
X-CRM114-Status: UNSURE (   8.65  )
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
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Catalin,
> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> Catalin Marinas
> Sent: Saturday, January 26, 2019 3:08 AM
> To: Zhang, Lei/張 雷
> Cc: 'Mark Rutland'; 'will.deacon@arm.com';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'
> Subject: Re: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX
> erratum 010001
> 
> IIUC, this can happen very early when the errata framework isn't yet
> ready. Given that this is not on a fast path (you already took a fault),
> I don't think it's worth optimising for cpus_have_cap() (and
> ARM64_WORKAROUND_FUJITSU_A64FX_0100001). I've seen Mark's comments on
> why checking MIDR in a preemptible context is not a good idea but I
> suspect your platform is homogeneous (i.e. not big.LITTLE).
Thanks for comment.
I will post a new patch to resolve fast path problem in today.
By the way our platform is homogeneous.


Best Regards,
Lei Zhang
zhang.lei@jp.fujitsu.com

 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
