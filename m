Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85623C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:32:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F4920844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cK6HEbh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F4920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0wjmc5FPyJI4wlR9S+0CFyURsAmHZgDdgqWb3pJ6ZY=; b=cK6HEbh3FfrUzr
	iil5oUjOnB9i2l7OokUc9pY1QiThgSNszMHGOlQ0CXQS+kD7lmjvCS6GVmWAJJ5fB7DRTVnkIf1tx
	393bqFi/LEYhWNkz8kpp1cu6LVZxggIhWOq0qdOvvbJ+jtRskr4KFtf8cdIOJ+aopUuMYXS+4be/3
	+DuurcU4VM+VKBH4kpghbf/HK+82P6TtOSqrXXIAKJu1GYSsbDDNvVvGybKDG1STZfuK9pKqDH2yQ
	517s/CZ9Gwc4fCDLUsy7xpsCUlDeD7cbBOG+I5RA00Oor6Q0PDSZfB6Jns/qZlj/ORG8uow3v4qjL
	gGtG7PoIxzTqA3278gfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0po-0001Kl-3U; Tue, 05 Feb 2019 13:32:20 +0000
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0pk-0001KK-0O
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:32:17 +0000
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm04.jp.fujitsu.com with smtp
 id 26ad_8d80_b59e6077_922a_4a08_bbf0_d8584c36daa0;
 Tue, 05 Feb 2019 22:32:09 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 25DEEAC00ED
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  5 Feb 2019 22:32:09 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local
 (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id CE1C2BD66E1;
 Tue,  5 Feb 2019 22:32:07 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw13 ([10.0.194.52]) with mapi id 14.03.0415.000; Tue, 5 Feb 2019
 22:32:06 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Will Deacon' <will.deacon@arm.com>
Subject: RE: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AQHUuKy5V4yTFdOO5Emj9g0aGwlQl6XKckPA//+9wQCABwJDsA==
Date: Tue, 5 Feb 2019 13:32:07 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A30C3CB@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
 <20190201105144.GA27140@fuggles.cambridge.arm.com>
In-Reply-To: <20190201105144.GA27140@fuggles.cambridge.arm.com>
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
X-CRM114-CacheID: sfid-20190205_053216_287719_645F7332 
X-CRM114-Status: UNSURE (   8.49  )
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
 'James Morse' <james.morse@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> Will Deacon
> Sent: Friday, February 01, 2019 7:52 PM
> To: Zhang, Lei 
> Cc: 'Mark Rutland'; 'Catalin Marinas'; 'James Morse';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'
> Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> erratum 010001

> So I guess we should boot with NFD1 clear, and then set it only when we
> realise we're not on an A64FX?

In my patch, I do similar things at __cpu_setup which we 
set NFD1=1 on all processors except A64FX.

Do you mean we would better to change the place where we 
set/clear NFD1?

Thanks,
Zhang Lei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
