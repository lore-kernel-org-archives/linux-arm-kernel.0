Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34277206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E4X+XrFK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BBjxKl+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34277206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ENCv0pPhuJTP8TkT1TRpIthvAoBhhgSRlI80Ec/Xsw=; b=E4X+XrFKAd/HYl
	HxdMo3Hfj3UARSBcbbDLXGJAZcjcQQiHxJpLFbhKrkeXCV2ojMqb/nXLr9UKo6lSVxyTxuXbbWfXn
	0W7Jk0/Xcwze7FEidgmKge3+CwQd36+4eVFdMwsSHgVF2FspJu6oGRfnIclQS4GNOsf08rAUUNcm+
	xDcAmeJpOieiT9LpCZGL8LS8++m5UWwDLqGN59F77dopdboJ8pT9jJWI2iEf8oMz3lUp26n5Utkzv
	GPVBKGQIf0b+ceTvcNeGMZ1IAQgTMI2hYx1IocusfjbQFmALiryIi1IlNZXSwsbVe7NNd7zFUWpNL
	/UDgXokiTegryaZ+vm2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp1p-0005dZ-8G; Fri, 14 Dec 2018 15:05:25 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp1l-0005YN-MQ
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:05:23 +0000
Received: by mail-qt1-x841.google.com with SMTP id l11so6518255qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=01Rr7o8gfIjmeNToKMPqIG72s20V5VWyTkW8ormrDIg=;
 b=BBjxKl+r7EvW9i1tUhRH57AtvN5nTvemfMV8xaNr+HmUAFxQsby8G1IBqs7NSlFgIS
 CostJlttru90zGAepUpGZpnJE1fTGgSd6ZXNC/tvlJgUdb0LrqlNzu2hPbiO0d8wWdah
 /n/V2gA27ToSjFHfBn805SN73a02U7NqbhjqDJVEZwD8Ee32uvaE0iodLiteD27VNwU6
 4yRIyEpjQZ4hd5/V5u+CKMFAn2ZFPCZdAF1EYOHxMdAevjAs5828YRd9sJnPEhzvwqXr
 eWVZykJEh30V5T0mQfAev3EPIi1SnJhgF+hKcLyMOt0eGp6fh3G+KBKN+J7MXvpTvXBY
 GIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=01Rr7o8gfIjmeNToKMPqIG72s20V5VWyTkW8ormrDIg=;
 b=AnbiWNuqgHelbDSyMVGfk5gKgm44VteMNqwHCnBdqnNzF1+Hvzb/2B9krXa07Plzil
 itCsVSfqVSN+hOCpxECn6ph07DgwP5s5ZxeAl1KbmM6My6meoTOIAd7zdV+Tskpgd+Mt
 vVpD37SbWqe4JpcGsDWzbBeAlDYoPY2QQtFz4msbtocaveQy0WmazGquaSvb95yI3qyx
 ipQ8eEVwBQUqPGXyT7tZGLqKSBq1syp9nUcopGEcDcb9j4myFDHQPf8Hh4LU6t77/UdA
 6L5D20K60AYhRU65haxl9qn1jzNp2Gk7Vejypy5dgCjd5qqKqVxMxX8tley/6QCm4FJH
 /xQQ==
X-Gm-Message-State: AA+aEWadKWkFD4cmpBfIxyBHDB+Lj5O7rYbWJSy7YC1SUNZA1w+brVlu
 UUnI5YyyvKLoimg8PLnASqdmiA==
X-Google-Smtp-Source: AFSGD/UThxAHkwR9bjXgacyOfCmn4upnIX2OBa/NekgIqiqb7B5rXLEhKyfdiUZm6PIaQQML52wWpw==
X-Received: by 2002:ac8:3810:: with SMTP id q16mr2944662qtb.91.1544799910327; 
 Fri, 14 Dec 2018 07:05:10 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id q15sm3166712qkl.81.2018.12.14.07.05.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 07:05:09 -0800 (PST)
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1812102229480.1667@nanos.tec.linutronix.de>
From: Qian Cai <cai@lca.pw>
Message-ID: <15e4006c-2ec0-c572-55e0-acbb75625eb4@lca.pw>
Date: Fri, 14 Dec 2018 10:05:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812102229480.1667@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_070521_734313_C490E0CD 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, longman@redhat.com, akpm@linux-foundation.org,
 mingo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/10/18 4:31 PM, Thomas Gleixner wrote:
> On Mon, 10 Dec 2018, Peter Zijlstra wrote:
>> On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
>>> Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
>>> warning.
>>>
>>> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
>>> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
>>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
>>> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
>>> [    0.000000]  acpi_table_parse+0x1ac/0x218
>>> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
>>> [    0.000000]  timer_probe+0x1bc/0x254
>>> [    0.000000]  time_init+0x44/0x98
>>> [    0.000000]  start_kernel+0x4ec/0x7d4
>>
>> It seems to me we want something like:
>>
>> ---
>>  kernel/cpu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 91d5c38eb7e5..e1ee8caf28b5 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>>  
>>  void lockdep_assert_cpus_held(void)
>>  {
>> +	if (system_state < SYSTEM_RUNNING)
>> +		return;
>>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>>  }
>  
> Hmm, no. SYSTEM_SCHEDULING is what you want because RUNNING is set way too
> late.

SYSTEM_SCHEDULING works well here too.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
