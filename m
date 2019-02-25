Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB835C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:16:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4492087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L51E7iWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4492087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWeO+uHKrEKeLglVTuT8c8aFeV2/s2Z3BhEk8Mpz3YA=; b=L51E7iWmRcVoKz
	ompeSw8y/Q4uHytRAOQGclLKUZMzTn2ycFSWGnSnHInFVypVIvEuBNIf/wBfzuAcwFLNUBna4uBsP
	S+Ts3FOPHQ8alUFiElEoI/D+SU7S6LyNdNGej2kKf7kEJyy0KkiNbSgm3Q+ASu2A05OrvZJIAMAtw
	4Va9g9bxGvKjlFlFfBNtLx1LKU4rozdyVR56PZ+9exUGzq0+3g5xKmjpYezH/OlELFHheEidcB/Bs
	CVXJsZ3eVWpnmx3yMfdBSiX1Cd0a/JGiwljYSRjh6H10zuYsDRrGaFZaAwu0bMcXccANMWALeQlDD
	TxA+myOqbiJD+uXutvhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDIp-00022S-0Z; Mon, 25 Feb 2019 10:16:03 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDIl-00020M-U8
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:16:01 +0000
Received: by mail-qk1-f196.google.com with SMTP id f196so4903445qke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 02:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aRIVD7GnAal5hhE52J6l8iPFyzOcIMst1UGXS8hb/Qo=;
 b=WSOq603jrb8v4BGahaaUEGtTcuzQ4gU/flNeokri2/gBuUTy2GdhY5uVdVAqQ5aFLR
 5X/COQA3Gd0mHH34mImpXZhBevKMwY+cvtN+e3bIjSnnuplMlrG3Fc9/yA0bufPe5RSH
 pSjNOvhvk6Skf7NkVVIV315C4wppzOtfu91WV5qt50tKL7hbOziarB4dYSbsTyY8aXye
 KC3vTSgMm57b8FQ8XIhODe72XJ3HtM9tyfVo8j71iV9IeaSUexCT8L0BhzoSTEuvOymp
 xj9fuYnGjzcBfMHnzNFCfvP3VaDZyta+8A7O8EngFyfpEEbTqhfeh7NLPCfLda5NElo5
 bJEA==
X-Gm-Message-State: AHQUAuZZaopoxmEY4VsMurxbMo0iPK1i8wqMnJfCCbnw+g8VzL7HUO/Q
 aa1M/Ex5akGaCYkE9UD0y+LKrQi+pSkQpE3V/C8=
X-Google-Smtp-Source: AHgI3IYs1vEXPSfQT2HmAsgQi/pfsGfLvN4KJmdQK96W1T6hZs/9pD6kUlZ1+twuNhXY0NqZqBxXr4BBne4k0OBVJyw=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr12257124qkh.173.1551089757878; 
 Mon, 25 Feb 2019 02:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20190223230452.8913-1-linus.walleij@linaro.org>
In-Reply-To: <20190223230452.8913-1-linus.walleij@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Feb 2019 11:15:41 +0100
Message-ID: <CAK8P3a2bCNMdF3DUrB2tCcHnGHLQN9eriZ9m0Fh2auxxh5CyCw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gemini: Re-enable display controller
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_021559_973430_A740A181 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 24, 2019 at 12:05 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> commit 137cd7100ec6fa36d610e106df00acb4d8af99df
> "ARM: dts: Enable Gemini flash access" contained a bug
> by disabling the display controller, while the whole
> idea with the patch was to enable flash access AND
> the display controller, simultaneously. Fix it up.
>
> Fixes: 137cd7100ec6 ("ARM: dts: Enable Gemini flash access")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for ARM
> SoC, as it is a regression fix (late) for a bug
> appearing in the v5.0-rc cycle, it should be tagged for
> stable if it does not make it into the merge window.
> ---
>  arch/arm/boot/dts/gemini-dlink-dir-685.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to arm/fixes now, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
