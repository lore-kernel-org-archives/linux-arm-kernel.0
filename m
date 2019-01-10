Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ACEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:36:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03BF214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B8NKkVuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03BF214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9arySV6goH3KmGnasKfhi5KdZCWh7/EE1mqE6gBVok=; b=B8NKkVuCAoZG6Y
	ISSbrhfnAoPDDi1huM20fgF6bHIO74fnnNfrbNEkbz3Hsu6sdk+srNQdg3bQxHv6E4XLURYcebM+m
	a6F58pWck1Dkk+L0I1wAhKrVh6N07GGG0uyxsdvnCX8fA5u6C+OMMV2FBFId8U9koj/w/8S44gl7i
	6MQyrhRFadsKmrHIuFetYG6RkToJvquVw1P84Z6KiTbsWvj9BTO9nbOFQ/5M6kKWQU7EokqSejgp9
	MRuUcLbMh2HrLssa0mNUrixHve5dnk9OmNxrtD1uaVh7T6d4zjW6DISJbDwO3qB6lec1ERZsAsQKb
	EJaVCY2m//erG8hhNZ0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXhF-0008MN-LR; Thu, 10 Jan 2019 10:36:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXhC-0008Lf-46
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:36:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122E9A78;
 Thu, 10 Jan 2019 02:36:16 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB853F694;
 Thu, 10 Jan 2019 02:36:13 -0800 (PST)
Subject: Re: [PATCH v3 02/24] kernel: Define gettimeofday vdso common code
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-3-vincenzo.frascino@arm.com>
 <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e2156e71-a167-ce03-650f-9093d5cd4330@arm.com>
Date: Thu, 10 Jan 2019 10:36:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_023618_176271_45DB987A 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/12/2018 18:15, Mark Salyzyn wrote:
> On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
>>
>> . . .
>> +}
>> +
>> +#ifdef VDSO_HAS_TIME
>> +static notrace time_t __cvdso_time(time_t *time)
>> +{
>> +	u32 seq;
>> +	time_t t;
>> +	const struct vdso_data *vd = __arch_get_vdso_data();
>> +	struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
> const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
>

Thanks for this, I will fix in v4.

> -- Mark
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
