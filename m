Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF3CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:38:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5532620685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rWHvCoaz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3kh1jT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5532620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HDyPNGSafzWDxN+7pLsz8JSuBOdTPQqoCeTHAd0zD34=; b=rWHvCoazDlH5QC
	rjZf+R8+3ZcaijFgSvlU+AFElF81XrNHNW42XkkewpYa6bmb6yzLjXLcbO8iL1/V88PvJPrhcQvmv
	+biRQUOpYcQYgaVJN/iWxTDhX2gI4qfpupKQrDF4onEZPGMQHJhKPojUzaETaJcQQcQmXEMMAPBSY
	ztF9HGYc6WoJ1/W6Fgxd306L9EsR6++sjwHwau6hKjAHefYUueL9KiRrmp5/+4JSJmAeyzXtAOZhz
	MZFReXWMjdmLlq3+gJkoU2C4YomTsgaiGjvml82jyz1D4zQPcG08wu0AybwbJB5+Al9XVAUyULqJN
	e4UH/7KxRrCnDeGIY9sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghLY9-00068b-NM; Wed, 09 Jan 2019 21:38:09 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghLY6-00068A-MZ
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 21:38:08 +0000
Received: by mail-vs1-xe44.google.com with SMTP id n10so5691997vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q0E13t76P4f46qIpKbwm1PIalSHlmYXrVb7lzustlt0=;
 b=J3kh1jT3fAen0lKqM3wDDfKvWGqpI2JTCxz8e4J4POwrcpR21YViNdV8S92L4iW6Q0
 m0HDDuvtW5vauozn2bRTr0RoZVs65NY2qEkdJdmCdDQyp6W9RTeKT4quLt1dZvRMnvLr
 TkFLMEdCeIbxVcJCoZB1LdGzZ0P5urJW+dzAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q0E13t76P4f46qIpKbwm1PIalSHlmYXrVb7lzustlt0=;
 b=iR8Zlv2N7KRSAavfBLarAWQGSHHtyVQYwh8U/TL5KFksPdn0u68QzFV7KOoxrvfcNJ
 NtrWHW+7whg+HCOIvtOjabVzgfAVA5DyEilZp6DVkuN8AsJMpoN0lTKj/8LGDIa6iiK8
 4TvhmPHiWcMS2t6GZAQz1lXeXxZ4xZdpQOpEX/e1JOYXE7mpYjY+lvsNAt1WFA+EZMzH
 YhlTpplNAcvXKF0YSLCBqmAEnPbWKBIGwpXgCulaKK3yGluMf/ja54+VVxwySTn4oylI
 LAjU+kR2rZYPXwTfngHyoK+AeNvyWdrE5AzbfHPPkfYZ6Q8IyHqNgauYIBA85NXwTuSJ
 Qcog==
X-Gm-Message-State: AJcUuke+abS8JzE3jkdWFtL5Qf/EFrLCZ8dyKSch95+RMnk2BaL/a/qN
 YqGKHzSl3ziaPKXJUOPq4YC3qhC53qo=
X-Google-Smtp-Source: ALg8bN7N+0x9UkwY2bLQ292MorYuX7cD/Zq4G8djoOOjZzo5kA0u271QPrAgNM2y3I8kQabcBqjsZw==
X-Received: by 2002:a67:47cf:: with SMTP id b76mr3273308vsg.184.1547069884014; 
 Wed, 09 Jan 2019 13:38:04 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com.
 [209.85.221.179])
 by smtp.gmail.com with ESMTPSA id w65sm47130287vsc.16.2019.01.09.13.38.02
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 13:38:02 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id w72so2016611vkd.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 13:38:02 -0800 (PST)
X-Received: by 2002:a1f:298e:: with SMTP id p136mr2931774vkp.40.1547069881716; 
 Wed, 09 Jan 2019 13:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com>
 <20181209103740.GB30658@n2100.armlinux.org.uk>
 <47a91e5a-0e97-334c-2f36-a0bd966a0050@intel.com>
 <235f0830-a293-5b00-4510-7d7d4c829d26@intel.com>
In-Reply-To: <235f0830-a293-5b00-4510-7d7d4c829d26@intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 Jan 2019 13:37:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLYG=UBrJXmrtoZVCka-w4_k_op8c7M1cQXmZs702fZ5Q@mail.gmail.com>
Message-ID: <CAGXu5jLYG=UBrJXmrtoZVCka-w4_k_op8c7M1cQXmZs702fZ5Q@mail.gmail.com>
Subject: Re: [kbuild-all] [PATCH v3] ARM: smp: add support for per-task stack
 canaries
To: Rong Chen <rong.a.chen@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_133806_757446_6DB904D8 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: kbuild test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Emese Revfy <re.emese@gmail.com>, kbuild-all@01.org,
 Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 10:30 PM Rong Chen <rong.a.chen@intel.com> wrote:
> I tested the commit on another machine and the warnings are exist.
> I found " -Wno-vla" was lost after the commit, so I think it's a real problem.
>
> -Werror=designated-init -fplugin-arg-arm_ssp_per_task_plugin-tso=1 -fplugin-arg-arm_ssp_per_task_plugin-offset=24 -fsanitize=shift -fsanitize=integer-divide-by-zero -fsanitize=unreachable -fsanitize=vla-bound -fsanitize=signed-integer-overflow -fsanitize=bounds -fsanitize=object-size -fsanitize=bool -fsanitize=enum -fsanitize=alignment -Wno-maybe-uninitialized -fsanitize-coverage=trace-pc -DMODULE -DKBUILD_BASENAME='"test_ubsan"' -DKBUILD_MODNAME='"test_ubsan"' -c -o lib/.tmp_test_ubsan.o lib/test_ubsan.c
>
> -Werror=designated-init -Wno-vla -fsanitize=shift -fsanitize=integer-divide-by-zero -fsanitize=unreachable -fsanitize=vla-bound -fsanitize=signed-integer-overflow -fsanitize=bounds -fsanitize=object-size -fsanitize=bool -fsanitize=enum -fsanitize=alignment -Wno-maybe-uninitialized -fsanitize-coverage=trace-pc -DMODULE -DKBUILD_BASENAME='"test_ubsan"' -DKBUILD_MODNAME='"test_ubsan"' -c -o lib/.tmp_test_ubsan.o lib/test_ubsan.c

Hm, so the -Wno-vla is getting clobbered.

in lib/Makefile, I see "+=", so I wouldn't expect a clobber:
CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
...
CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)

and scripts/Makefile.gcc-plugins is using += against KBUILD_CFLAGS:
KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)

I'm not sure where the per-target CFLAGS are built, but it seems like
something has gone wrong there?

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
