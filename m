Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDFCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDB720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cr1jwePJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WJS3e6AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDB720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mPrGFUHdcTm/hT2Ig5nSSLkIARmc75VBjKRIqfpV09U=; b=Cr1jwePJP9Umgb
	MtAvbcGN/NG3lPkAHQeQpBBeoek2SLPJsS4pv0vVDiOHDnYf80jSgWtPX0u4WVvCaS6WyKRMHmtZg
	5qNrixjwMTBfNI6MkGPi+fbEJTStuJ3J5I6PravuqEFNu9VZ8Dkg1amaBco6cUCS3rpXQnkKLMk09
	Tgx0ojmWNjrpUTBTYUn1EVAKtTtGpu0GqdRbDFZvICy11oHp/RqH84jSD8z00SWiIkxKrE1SSSFV7
	GyLstjDozVT0vUc2iNdPIcw95MIhfC72qqj6hpuFd5w7oDtlZVROOObrEu9wmjI3rvNqA9QGwtO4o
	8YlE5MwbbWy/s5WfEyXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSX1l-0003O7-Qx; Fri, 30 Nov 2018 00:51:29 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSX1h-0003Md-KE
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 00:51:27 +0000
Received: by mail-pl1-x643.google.com with SMTP id x21-v6so1893155pln.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 16:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=3qvdcJZ8PmRKbLEtfm59ggyyqKNvacVBja+BjrAt068=;
 b=WJS3e6AVEzrj2cNpHm8MlAx/K1Lv5wEha+ApFYew9Bvs+1Akii+dzTgWZ9BbQUCkWV
 y5y4PA8NJvMfqaqLZuhV8zutLSyWv78JxpzQSsaoIM9FmLWAP/VhSg9xTg9TbZ7yATHA
 opOnw31UXZPj25JGgXm174OWTW2U8Q6+UmQ22kN/OYkYuTaeq8PlVeEegBDOo8mFR0AD
 w14EujUcNJrxjQxWx1tYmBU7M7Y+zvvRTeWV/V+/vqlcDUBJEjjm1VuTIgTlh3eoMj/P
 y1VoW/IDW8mUb7+OWIT3iG7MNnAic6yrLXLKQPoPZOlJGpG5F3BzTqW6tn5JL4enJeM6
 8TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=3qvdcJZ8PmRKbLEtfm59ggyyqKNvacVBja+BjrAt068=;
 b=AVlcXnpC04lk+RjXzEwYRZJjVJnQDqcpx7ZYjGKejmFrOOMtpZ+AC7y1q5otBAuxsL
 0c/w9g8K+gKLBVRqVamVDispis2xYTS1+nKp+sxQeyLWKk2bdQfiJsCCL7ooSRG04nCN
 ddPb9CzbR6hupgCZFiliS6VREL0q4iX6PtI69iLd382Fj8bsSE7a4uumuixvYWHwIJJo
 O2xfI19Jb8U0V6vf6AjC9MMSCQUnCAn5gV+Mq3nBGKOLbu0rbH7/9XxAaxf6UqtcFb8a
 2vRaEffwGQcrA760dwtbue070mOIGQ2B2itw7AOpZgQzZq4oRwdzRIhuBTNa3LnxwG1T
 EMlQ==
X-Gm-Message-State: AA+aEWaKUbi/ElTKCp58fPTzAgR0sEB/3kdQfs0P/kUcu8BE1ijJKVHZ
 W0ZjBikJnCsm+6y2k/bKDN51RA==
X-Google-Smtp-Source: AFSGD/X9wmudIEKf+M0xp2qRrZW5YYkX6+DVaoYHlNiJQZtYuP0oHnlFoXVsE/JPb47cb1qJi8b8Lw==
X-Received: by 2002:a17:902:27a8:: with SMTP id
 d37mr3709000plb.182.1543539072726; 
 Thu, 29 Nov 2018 16:51:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id q75sm5257657pfa.38.2018.11.29.16.51.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 16:51:11 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to
 built-in
In-Reply-To: <CAFBinCB8r+5tGKxfsPMapayxmDuWOi=WihvvdxS=UxcnpeYqdQ@mail.gmail.com>
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
 <7hh8g0d8tg.fsf@baylibre.com>
 <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
 <7hk1kv79at.fsf@baylibre.com>
 <CAFBinCB8r+5tGKxfsPMapayxmDuWOi=WihvvdxS=UxcnpeYqdQ@mail.gmail.com>
Date: Thu, 29 Nov 2018 16:51:10 -0800
Message-ID: <7hefb375hd.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_165125_668369_0158F33C 
X-CRM114-Status: GOOD (  21.94  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Kevin,
>
> On Fri, Nov 30, 2018 at 12:28 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> > Hi Kevin,
>> >
>> > On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
>> >>
>> >> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>> >>
>> >> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
>> >> > voltage supply of the CPU cores (this regulator is typically called
>> >> > "VCCK").
>> >> > Now that we are preparing support for CPU frequency scaling on Meson8,
>> >> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
>> >> > kernel so we can configure the CPU voltage early in the boot process.
>> >>
>> >> Can you explain a little more why the configuration of CPU voltage
>> >> cannot wait a bit so this could be properly probed?
>> >
>> > I was under the impression that cpufreq-dt would still initialize even
>> > if the regulator is not ready yet. however (after reading the code
>> > again) this is clearly NOT the case.
>>
>> Hmm, a quick look at cpufreq-dt suggests that it should -EPROBE_DEFER if
>> the regulator isn't ready yet.  Why doesn't that work?
> sorry for not being clear:
> I was under the impression that cpufreq-dt wouldn't handle -EPROBE_DEFER.
> I'm not sure why I assumed that. As you already said: deferred probing
> of the regulator works fine.
>
>> > there's still a benefit with this change: your Odroid-C1 in your
>> > KernelCI lab would also be able to change the CPU frequency (so in
>> > case something breaks we could spot it there).
>> > will you accept this patch after I updated the description to mention
>> > that it's for KernelCI test coverage?
>>
>> Possibly, but I'd still rather see the dependencies worked out correctly
>> so that this can be module, and cpufreq-dt would defer until it's ready.
> KernelCI shows multiple "pwm-regulator regulator-vcck: Failed to get
> PWM: -517" messages on Odroid-C1.
> however, what I failed to notice so far is that there's a
> "pwm-regulator: supplied by regulator-dummy" at the end of the boot
> process. does this mean that the Odroid-C1 in your KernelCI lab can
> load kernel modules? in that case this patch can be ignored.

All boards in my lab can load modules.  The boot with a minimal
buildroot-based ramdisk that uses eudev, so any drivers that are present
in DT will be loaded (if they're modules) or probed.

> (I will still send a PWM regulator related patch: that "Failed to get
> PWM: -517" message is very noisy and we typically suppress that in
> other drivers)

Sure, no objections to that one.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
