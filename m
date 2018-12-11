Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:25:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA8A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iQWZEtK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA8A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oqyu0iuz0Nlt3hKW4DOfBr6KIhkQINj5QWAflp/jNYs=; b=iQWZEtK32MW3h2
	Y/D58ewhPEmiTIcekiewSvT06vqvCnVTs7abhRJwDBHYWHSYtZ+GxmzCfsdRcyR9E1uWb4knxFJ5+
	s+yLQB+Hqjvk9Ei8UTcaaJmIlUSKJFtoFAu7D/WxB5l4Pyntwp3GgZZw84mdEqOGXjOj/EK6Xzhlt
	q/klqKWYyEWKeUXjg6G6gxwmpcSV31WkvxUlHemiVFmEsdUnER2ivioZQ82gQ+VO0gt3BIiz39vxd
	6SWmfik5o35f13gtIoS2bz3ttQEXX9NRTmiNeL8hopDGVOt+M+b1u4Sh78B9G4W2PChy6nlRHkAqf
	YWih4vbmpzheBUKrdyvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWi2D-0008Ri-Kj; Tue, 11 Dec 2018 13:25:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWi2A-0007D8-8j
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:25:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 924DDEBD;
 Tue, 11 Dec 2018 05:24:59 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9624E3F59C;
 Tue, 11 Dec 2018 05:24:57 -0800 (PST)
Subject: Re: [PATCH v2 04/28] kernel: Add masks support for Raw and NTP time
To: Thomas Gleixner <tglx@linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-5-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fe008742-6af4-35e9-131a-284bf3781dd0@arm.com>
Date: Tue, 11 Dec 2018 13:24:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_052510_318986_6E8459BF 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 29/11/2018 22:41, Thomas Gleixner wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> 
>> Depending on the clocksource selected there can be supported a
>> different resolution hence we require a mask to be applied to the
>> time calculation.
>>
>> This patch exposes the mask in the datapage for Raw and NTP adjusted
>> clock.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  include/vdso/datapage.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
>> index d50a108afaed..0a7bdccf5773 100644
>> --- a/include/vdso/datapage.h
>> +++ b/include/vdso/datapage.h
>> @@ -34,6 +34,8 @@ struct vdso_data {
>>  	__u64 wtm_clock_nsec;
>>  	__u64 btm_nsec;		/* Monotonic to boot time */
>>  	__u64 tai_sec;		/* International Atomic Time */
>> +	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
>> +	__u64 cs_raw_mask;	/* Raw clocksource mask */
> 
> And why would they be different? The core timekeeper has them duplicated
> purely for access pattern optimization and simplicity.
>

As you pointed out I followed the pattern of core timekeeper, but looking at it
after your comment, it seems obvious that one is enough.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
