Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917F5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:36:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2CB2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XTmZQ2fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2CB2192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=plBuKLTC/9USBkfr16TfUcc2oZvaCq7NoID8A2H32v0=; b=XTmZQ2fiveQ/ZF
	f7aR8toIqPczOEG4UTUu1i9YXG+T+4V2q1rYll1WE+4Xew9yXXb7cJz2dDNu5B6KB0LHuXw/Zs6ts
	ga2lzw8hG/nmRmZoNQDOTtkEB/3b2lohRgix96B0P4MRTV0dxtAjNprpa+tzk409FNA5l8UEunTFJ
	Xvk/GfL3PHnJMPOJKaul520rHMPPGQ5ZtkTcQyFVMCPTe+FEURDYrOrf351AFU97ZM8vVwNW5KsQt
	ltb9HaGPPRIt9WrGhjYkdFiuQCzevFTNHKoRHz8CRsDuPqe3iXqC7piPulW7csJDeMEjLGWOuRUrS
	VQLJTlctnzx0JAc8qEnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucjK-00007M-NT; Fri, 15 Feb 2019 12:36:34 +0000
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucjI-00006f-8z
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:36:33 +0000
Received: from ttb-m3.gw.nic.fujitsu.com (unknown [192.168.231.163]) by
 mgwkm01.jp.fujitsu.com with smtp
 id 402c_1518_38cea97f_861c_4b9c_a9cf_6e779b96b74b;
 Fri, 15 Feb 2019 21:36:27 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by ttb-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C90C240C0424
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 21:36:24 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local
 (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id 02FAA692668;
 Fri, 15 Feb 2019 21:36:25 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw13 ([10.0.194.52]) with mapi id 14.03.0415.000; Fri, 15 Feb 2019
 21:36:25 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Topic: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Index: AdTENhuVebuKtHOoRzCPb6sZ5vznO///+H8AgAAo/wD//jk2sA==
Date: Fri, 15 Feb 2019 12:36:23 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
In-Reply-To: <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_043632_568965_71C2F841 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Will Deacon' <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,


> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Friday, February 15, 2019 3:23 AM
> To: Mark Rutland; Zhang, Lei 
> Cc: 'Will Deacon'; 'Catalin Marinas'; 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'
> Subject: Re: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001

> I think we should do this: never set NFDx on A64FX. I don't think we can maintain
> the TCR
> swivel before any memory access in the KPTI trampoline. (It already uses the
> FAR as a
> scratch register!)
> 
> The errata means we can't use these bits. Its simpler than trying to work around
> the symptoms.

I think you mean it may be a problem to modify the KPTI trampoline 
because some patches about KPTI will be merged to mainline in the near future.
I understood that.
I should discuss with my colleagues whether we can set NFDx=0 all of time on A64FX.

And thanks for your patch.
If we can set NFDx=0 all of time, I will review, test and report the result.

Best Regards,
Zhang Lei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
