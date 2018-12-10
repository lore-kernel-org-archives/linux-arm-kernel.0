Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF99C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:18:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A13F20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GLhRHHj6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q2NWIpH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A13F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V4d26+vLj3Mk/VAE9VsAkSzlUojJxAtx9/Ve7NEIjFY=; b=GLhRHHj6gKx53u
	obzsNsGy2gPGwFN1J5Fa4WzkXbLY75gB8BnBZjSPm5MWwE5UObf4VofFnex7EQqe3g6WADlenKPJm
	vFnqWmlgLUeEDFf97cHKpm5lN1Z/5mUdNmqJgNISqLmGMeUD0UWSJ+kSdWGECelb3ef0TwQep3+Ho
	g33/W46OO3CSKI06ResfgOC+3bPhFCZvOeXTvJjsnqirLnyl4mNjEyWcwumv5P5VmHoB8CC1WaXD/
	cgR+nniHE7mmI6l0QJKCoZHvZC5YHNNzKEjyNlxRUsKWrc9Gkt5ZRsxRuHjFX+9PmYvA+U2HB5Rgr
	Pn42PIIqS/QRqScNjryw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSw7-0007R1-Nd; Mon, 10 Dec 2018 21:17:55 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSw3-0007Nv-0v
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:17:53 +0000
Received: by mail-pg1-x541.google.com with SMTP id 17so5562467pgg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=C94QuNa+7VK3Rf2ToYyYT9nrOJ5ofXPZR4RoJw4IVnk=;
 b=q2NWIpH5UM7rq5CcdQ+mPXlrvpsOD20YoycBO2qjFVy2HmACw02Yy3HwIo461Ls9Tl
 n59zFfYtZkX0SHAiHEe2vocOsR3GQfZjgAL25lqEkbH0/W3MXymlsMo9PRD079F5z5Y+
 2MWUIXa528ti6U4oH9MPXjdZFfu5YQITl2jy296nM11FIxYeIfEt+tL18OxWlnTXKYos
 QRYdXMHpAIln1MuUT5bB3ngCanFjTJ1sdDOSli2+YcxQP9tnLu2U75yo4Jlygci9in7a
 Y4NK5ptBS8kd2JnR2+WPn5knS1BnHGptOlJWvAQqLStHgwt9Jdi+4KkiFOnwPn49cllt
 GwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=C94QuNa+7VK3Rf2ToYyYT9nrOJ5ofXPZR4RoJw4IVnk=;
 b=aHiitKJaMekdTyoCeMqaTVXx+9mqwIdyPa1I4428EcKBCNg3mN/GP/xvu9yVquWrE5
 C9AO3U1XfhWNmQJG51KcYfhKd601ToSSvV5BpcIrevFiCMeKZE+TJ303oNKph2cYtPDS
 ghG+Dix314FrlL3yRKNcFOes1ewHFdMeCFmw0FbwhSP7BPZqqrnB0wxe/1M61LeSkU5Z
 PcGv/AvwELxKUnv5GFLJ7eNumOwx9/msqof9mcuvbCk3hHv8kBuTeO+WI5LcPPom1Jzs
 +wzL/SyawRDzqe9JhX792l1cJW05lR60Iu0hPq2tyfRWwQ0281WdIJrNUechP4yexvoz
 RE7A==
X-Gm-Message-State: AA+aEWYvEjo/oxW4RSm45lM5oJKAj9mRsjiSYMsuFHcsSyS3oJ7m9Inl
 ID+5WAcaBbW6n37GZRn8ZoVDTw==
X-Google-Smtp-Source: AFSGD/VnBAoBo97r9FRQJg3EcpzMiSTg/VC/2UkFQ+BeeoDoH8wctLqdqrauv95QEjAvRU2P8abXhg==
X-Received: by 2002:a63:3d03:: with SMTP id k3mr12254348pga.191.1544476659770; 
 Mon, 10 Dec 2018 13:17:39 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 h128sm14691064pgc.15.2018.12.10.13.17.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 13:17:39 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 2/2] soc: amlogic: meson-clk-measure: Add missing
 REGMAP_MMIO dependency
In-Reply-To: <1544471155-26661-2-git-send-email-clabbe@baylibre.com>
References: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
 <1544471155-26661-2-git-send-email-clabbe@baylibre.com>
Date: Mon, 10 Dec 2018 13:17:38 -0800
Message-ID: <7hr2epuln1.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_131751_068445_0F3E091F 
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Corentin Labbe <clabbe@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Corentin Labbe <clabbe@baylibre.com> writes:

> This patchs adds a missing dependency on REGMAP_MMIO.
> This cause the following build failure on SPARC:
> drivers/soc/amlogic/meson-clk-measure.o: In function `meson_msr_probe':
> meson-clk-measure.c:(.text+0xc4): undefined reference to `__devm_regmap_init_mmio_clk'
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

now queued for v4.21 (branch drivers)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
