Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB0C37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:06:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4460B20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4brhKLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4460B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=up912jXCTLtTCP+Dxxc0tDqOKQUu+qnGfWSeBL9BGxQ=; b=J4brhKLc3hVDqy
	Fk3CQloTKH+uWLJ6kjfExw9NsstJP0Q67vwLSeB6Sj5p9ocqtKoDg0PzxQHyrdzeJF6TJTqPQz2WS
	zhTeiACtHeAqNyaQQrMK+zLIedAO+wh7RpsY5tLJ1mv2QHzIXKoj18m/XDI2VoBi9k+O/DFnWjj7R
	9JTCs/qYmdQ9j6plsxqg6ifXCb/DSKp5eeatp9RBAkAFbyU2by4/C01EaFGR5K9LTnK9yPYhvMmhp
	mJOmfszVJ5p6LoW86uaD+c4DfgbNfohi0sJ+8O4//G4I7YfcD6vhK+Ey5IPnSi5HwurrhQ4ICPE6U
	hmzqG2QFpdya4BP2iJgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gllRz-0004fm-L2; Tue, 22 Jan 2019 02:06:03 +0000
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gllRw-0004fM-1B
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 02:06:01 +0000
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.231.131]) by
 mgwkm03.jp.fujitsu.com with smtp
 id 4255_5bb3_81418fa6_6eb0_4331_931d_fc08e8ed2bb6;
 Tue, 22 Jan 2019 11:05:51 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4569DAC0284
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 11:05:28 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local
 (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 3AF60BD6675;
 Tue, 22 Jan 2019 11:05:27 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw15 ([10.0.194.54]) with mapi id 14.03.0415.000; Tue, 22 Jan 2019
 11:05:26 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Mark Rutland' <mark.rutland@arm.com>
Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Topic: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Index: AdSvK6W0/Nm6810RQFa/OOuw1JbhXP//gw+A//n57fA=
Date: Tue, 22 Jan 2019 02:05:26 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
In-Reply-To: <20190118141758.GC12256@lakrids.cambridge.arm.com>
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
X-CRM114-CacheID: sfid-20190121_180600_320354_C78CF218 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>, "Zhang,
 Lei" <zhang.lei@jp.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Mark

Thanks for your comments, and sorry for late.

> -----Original Message-----
> * Under what conditions can the fault occur? e.g. is this in place of
>   some other fault, or completely spurious?
This fault can occur completely spurious under
a specific hardware condition and instructions order.
 
> * Does this only occur for data abort? i.e. not instruction aborts?
Yes. This fault only occurs for data abort.

> * How often does this fault occur?
In my test, this fault occurs once every several times 
in the OS boot sequence, and after the completion of OS boot, 
this fault have never occurred.
In my opinion, this fault rarely occurs 
after the completion of OS boot.

> * Does this only apply to Stage-1, or can the same faults be taken at
>   Stage-2?
This fault can be taken only at Stage-1.

> I'm a bit surprised by the single retry. Is there any guarantee that a
> thread will eventually stop delivering this fault code?
I guarantee that a thread will stop delivering this 
fault code by the this patch.
The hardware condition which cause this fault is 
reset at exception entry, therefore execution of at 
least one instruction is guaranteed by this single retry.

> Note that all CPUs and threads share the do_bad_ignore_first variable,
> so this is going to behave non-deterministically and kill threads in
> some cases.
> 
> This code is also preemptible, so checking the MIDR here doesn't make
> much sense. Either this is always uniform (and we can check once in the
> errata framework), or it's variable (e.g. on a big.LITTLE system) and
> we
> need to avoid preemption up until this point.
> 
> Rather than dynamically checking the MIDR, this should use the errata
> framework, and if any A64FX CPU is discovered, set an erratum cap like
> ARM64_WORKAROUND_CONFIG_FUJITSU_ERRATUM_010001, so we can do something
> like:
I try to provide a new patch to reflect your comments in today.
Unfortunately this bug may occurs before 
init_cpu_hwcaps_indirect_list called.
It is means maybe errata cap is not available. I am trying to
figure out best way to resolve this problem.

---
Best regards,
Lei Zhang
zhang.lei@jp.fujitsu.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
