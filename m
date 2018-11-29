Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB88C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E0C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkRRj+Ru";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y8BqipgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E0C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=19+GH8ptsBCOd1fEDUV1FxFByxbvGlijLnWLGDe/kI0=; b=HkRRj+Rukgas2/
	6V4EE1E56WnX9i3gSC+FvpH5DONzjbPhm+UvRSa4R2C6Np+9fxEDt9dbw7PizsUsqvpUxgk5CMXOX
	avIrP+nVlRqHlzs22vKlq7f0nk84pKtLAD8z6AFFFBHts4xfc1o1xT+pfs+GdgWKRvhpzdNu3y/P3
	r/l6u+W4vRvumPVj8wDmeGNhVrXQR395rpDX2K4YLJCpE7KwycZ25njL8XO0X3O9YVERiU9VbLuBO
	R1723/WixkcbXdpN64cxGDtKJ5mgVDrg0ZZvadLRbdyNqTZBr/S0pRTJw4vvTzz+y90e53HlqHzym
	tpu+UJMz1LdTgx6wwocQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVla-0007fU-Hk; Thu, 29 Nov 2018 23:30:42 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVjr-00050s-RT
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 23:28:59 +0000
Received: by mail-pl1-x642.google.com with SMTP id gn14so1799942plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=sWbxhkFth6vBUM1Snfeosc2LQRu3OThmz1EQOLm+GtE=;
 b=Y8BqipgP0P8KiOPbWRR0HSv3yNvQns2cREminu0kcCwGBNo31c59pVet7RZ95dB5wa
 jupLyKSqWXUE73WuMhQmMGZR0Htfz8nzmeEwx/1RswqBfVmHRyjyX7Fv/aJ4bsI4iW0p
 Qp4PayFkbz9HGnpyJqjMW5R8k4pDpoJF+NOMiykS1yXTSnm3grBJEjRPYS5ZRDxJkpX7
 8abht64xdiGB7ZrezQ6igmHtw/dsfh6bYRUdZTaaTMrUE0qHh17MOupmmsR4AeBC/C1p
 NfuSDxaVd+1w7/ja2ZauZvTYyg5ACme+60F8bwalj+lPE3TEfF1bz3G60ty9ckD/gb8r
 7rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=sWbxhkFth6vBUM1Snfeosc2LQRu3OThmz1EQOLm+GtE=;
 b=VgZ7O18hXmpll7Zr78uDcVCHV48JBosHV+Pa8IxtzitqfxIHopAT4EjPqHmLKNbKM4
 U/XRqezBKryB9ZrXBCqRiRLAVkLm0WUNlWTzjWZiMFSFlXTChMDqHexZeUIVVi+aAvC2
 5UAZluqYqkIFluzaZmgKOOO/b4jnsNU9oa5ya3mobtE4VlBb4Ph4NE0MmM8nlVQVbDJ8
 jKDmcD33No6R1jNGf8tTPr7Jb6pWj9uepAzQn8+sC+QFDCVgnU9hohMVCiKwa44nbVBR
 6MtwtVbMKvsWBUkbS+KIuDv0Adgzj28bZ3TIQx/BwYzFYyoJMZZJCPSjuqbw8+NJY3Ir
 srQA==
X-Gm-Message-State: AA+aEWaVTPRVHto2QdUiWOSaoP2Npbh80HiS3/1Vu5pzEietDnFLoiI2
 txnAGAzC8axd8QiDYzzzO0GbtQ==
X-Google-Smtp-Source: AFSGD/X3OKi16ppD27/OdLHWtokaOXJm/Xe01KObh0iafGtVGjCVGpxow+wUi5kFnJ5Ua41K+RIFgw==
X-Received: by 2002:a17:902:7d82:: with SMTP id
 a2mr3419606plm.163.1543534124838; 
 Thu, 29 Nov 2018 15:28:44 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id z62sm4484115pfl.33.2018.11.29.15.28.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 15:28:44 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to
 built-in
In-Reply-To: <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
 <7hh8g0d8tg.fsf@baylibre.com>
 <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
Date: Thu, 29 Nov 2018 15:28:42 -0800
Message-ID: <7hk1kv79at.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_152856_297994_53114BF8 
X-CRM114-Status: GOOD (  17.52  )
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
> On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
>> > voltage supply of the CPU cores (this regulator is typically called
>> > "VCCK").
>> > Now that we are preparing support for CPU frequency scaling on Meson8,
>> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
>> > kernel so we can configure the CPU voltage early in the boot process.
>>
>> Can you explain a little more why the configuration of CPU voltage
>> cannot wait a bit so this could be properly probed?
>
> I was under the impression that cpufreq-dt would still initialize even
> if the regulator is not ready yet. however (after reading the code
> again) this is clearly NOT the case.

Hmm, a quick look at cpufreq-dt suggests that it should -EPROBE_DEFER if
the regulator isn't ready yet.  Why doesn't that work?

> there's still a benefit with this change: your Odroid-C1 in your
> KernelCI lab would also be able to change the CPU frequency (so in
> case something breaks we could spot it there).
> will you accept this patch after I updated the description to mention
> that it's for KernelCI test coverage?

Possibly, but I'd still rather see the dependencies worked out correctly
so that this can be module, and cpufreq-dt would defer until it's ready.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
