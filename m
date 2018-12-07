Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B2EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:50:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8395E2064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rKBAxo7h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahIf0WnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8395E2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LELrCT/wKOQBqxWYjbhsoL0ccypSFZhIuZ/z/bkvFOs=; b=rKBAxo7h/ZmA17
	7PCAiHQhk/3ifE3hzDAePGj5oUmFecj/XPYqHI48iBzEWkKsgAaJnT9fuCvNL4cq8su7Eg+Ex+8qx
	SrsfUk4MuGyFyz0XjlQmdAtA7GCqBhabA3wxHov9v6gs+KZjQLsYIncrTYh8soXnWjo0CLKC3Zvi6
	pslvrsYfEiyORD8g0wsNDg1Je9PVzQbd2kXfyO4hKHbnoCUK5NZdU2URgxvmegXHZwGd2w1wX53/p
	VzIZXeDgOzpxeD/EEXiTW+RjVsx2L+10EG7TjJYl8ewVHUSMvRUoAjoIsAG7+JYNs+wp5bEbaNK49
	w5VzcdeBhxlW/kJf9RSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFaK-0005Mx-KF; Fri, 07 Dec 2018 12:50:24 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFaH-0005Lq-8F
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:50:22 +0000
Received: by mail-lj1-x241.google.com with SMTP id l15-v6so3437785lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b2V6TXNDTcDI78xhEPca9rglPrJP9/itzFDBGRA3h4U=;
 b=ahIf0WnI5owq45cQtZYzhNecxY17kxa8WPFGQbF/kxl1sk1Cg6ZPUdyw/ZQl1kYcyj
 Jf39QC15UXXKB+1v2yTTN32kRxFsi5rAMRI+T/8axOS+HtEe89vQPNtPkeAfgB1ZmKs6
 bsR53wQGuhNpWfU9zNpmfivf5NXdOc4lqNWXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b2V6TXNDTcDI78xhEPca9rglPrJP9/itzFDBGRA3h4U=;
 b=etHFEdP5cXSDhF0xwV3m7XpI0pfxuichOUkxFdSJNyx7znOQNAKJIoR/5FDM78Z71f
 cu6i7BReDcg0OrCrWvtsgl/suUaaip3/YpGtpVGvp7USTe33QG8fp2/q5unwOy/YS2Af
 JToRg6BlBovVqMXR9j8j+r8MNaMjk0J5kTsq2TPvee8slJXl184oZxHYD9FEXb7pDj4G
 U+/wicNyLHEGIav3d1qfsIp8kzHTJTv+3LTqZNAmLtXg3md4zpjsERDuMFptNGMwE7nf
 Qu786mdTedQy8awoPKbSsof1uniVnm1eeFoiCr4PnuEiTaMhqYwxIb4a0Tu+WWkAzL4c
 aJlQ==
X-Gm-Message-State: AA+aEWZpEDw3b3Me/AP/fPSJv4YQJYZOS13wuRj1fbE5sLkWnRLQUgny
 8BWj5H3VO/LUbcyJ6uRyp/o7H0B7RRdPFDC0BahMZw==
X-Google-Smtp-Source: AFSGD/XUKWx41rjK6kqALodG6jWCvDkMKRpJJlE2vbcWncgKvoGLDzfmDbf+jLlSyVY2d+7dA1i2nLAEjVeY9gUoX2w=
X-Received: by 2002:a2e:994:: with SMTP id
 142-v6mr1125520ljj.120.1544187009333; 
 Fri, 07 Dec 2018 04:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
In-Reply-To: <20181207102749.15205-2-bigeasy@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 13:49:56 +0100
Message-ID: <CACRpkdYGkTrVy25nzZa9A-Kp7iNr4aMpTS_DyOEjHVmWOBbd6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_045021_291411_46045E61 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: ext Tony Lindgren <tony@atomide.com>,
 viresh kumar <viresh.kumar@linaro.org>, David Brown <david.brown@linaro.org>,
 Xu Wei <xuwei5@hisilicon.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 11:28 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> From: Frank Rowand <frank.rowand@am.sony.com>
>
> The arm boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
>
> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
>
> Fix by converting boot_lock to a raw spin lock.

This makes perfect sense.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
