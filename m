Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E2C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:52:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EA120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nnhRbI4z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ByY8CpDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EA120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Om0fqgIxk9vXKQZXcJP5TxnBehnfJWaiHCPuNGXMfxU=; b=nnhRbI4zCqJlsA
	i7vRLfirqJav0euQvO3BWgQY+WAot8qz2CL3HCKM0UQvups2tQMU/DM3AW4YkcRpcLXDxjgddFRLv
	lpgKP99VAeRmUwuD7uYHDUCzMyoSs7Xw6kto6ukVFNDS9W+1SBCQV+JvvX74USVoZEg40YOKTnPzm
	kEWcYP442OcdbrUmE7NmN0cqoAZ2a0LHrrM8d9FzF8CgWGZQYXa0BjEEIX6kp1gxh6/g2sSlXRCTC
	2TRtGOvhrfzfddYjiy196GZWGgln3ziuMELCLX0tiQcHKbNzuvu/zNivwgPS6Sk948bzT2nJQbaYx
	wlez6QMjmXNa1/ZmNr3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGAw-00059o-1k; Thu, 13 Dec 2018 01:52:30 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGAr-00058a-LP
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:52:27 +0000
Received: by mail-io1-xd34.google.com with SMTP id x6so340083ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 17:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Sh/8tg+p+bV33QXiedI77lw2JdiNLBCp9uVCg9kYHE=;
 b=ByY8CpDXDlbX8AmkFtMVAYwW8fqpsCZd8TixzCRNtSoNzq0c23z4BNs/fPqez/aNl7
 ywHAUv81k89YRHfIvdqk94I0MIYXnh4libKzLEPpwxzWx0WqJW9u8DJ7a06yieHtKCe6
 QTxiTS0UlUZrlLYwhTThVTXunxFqynLQ6bq0almVogVLrCcQ5zO+uzu4VtoFqodbsHgs
 dr107V5Fe9ClHjrBL01Han9q/kxKCQ/TC2GT2987e2gX0fLPUp59W8a/opsfDPMIqqxs
 nV8V8p+BFPU3yEg9u1LGQ1tt3BIpneY6MUOa7exLiR7P8JkIMAMAy7KtqVEwxYfbAxyM
 BqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Sh/8tg+p+bV33QXiedI77lw2JdiNLBCp9uVCg9kYHE=;
 b=K8ZNMZlkHvuBTpkPdzXDTUw+XohrLdHqli7xza3DkpWW9SB2tlASfsIxFitsE1+H66
 htp4OR3sjD4FoiOyuH2oJdg3jh0PLW2RbfEyfKSJVEMBhObSVjQ9y13RJ1/xJEcdzlAM
 6so0AaCI0LA9HwuXJ9513PJGP7nrPjXdkOLNW2Hu0O0tTHjp31D5j2S/zSau9+Duvwad
 tYuGbAkSlGdXOFtYFj8gPgJbLvoFV7+w6uqTpE42yq5fyVgPPGdZlxkDgTudvbChJIR5
 IzR4bj6dq+yXl2iPbzLfDzAO7I/DaNrNXriq1upwM2E1JyxenbwTJlbbV03bA9M33A25
 RB5Q==
X-Gm-Message-State: AA+aEWZkxcxa6dnHa+iPDl/Su9Ouk5VLlUFuzDX5kbrqXnXQVEiohgzt
 5cVT2cklzVk8J4YPxJYRQdnnw2rthH1EACiv2mcdMw==
X-Google-Smtp-Source: AFSGD/ViJUO+P2ZUlsTtAveO1YF4Ls2pWpD1eKSlUWG63jZjPVww9aTnMORQuUWsC2whMAZ5tZ5kaQfxFG0vG9g4X64=
X-Received: by 2002:a6b:1414:: with SMTP id 20mr18581386iou.140.1544665934237; 
 Wed, 12 Dec 2018 17:52:14 -0800 (PST)
MIME-Version: 1.0
References: <7hsgz2s3o7.fsf@baylibre.com>
In-Reply-To: <7hsgz2s3o7.fsf@baylibre.com>
From: Olof Johansson <olof@lixom.net>
Date: Thu, 13 Dec 2018 09:52:02 +0800
Message-ID: <CAOesGMgqfAKZG_X7QgBtOeAuLm3uxdiKgpZDVUx+G4DAmkRx9g@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: Amlogic updates for v4.21, round 2 (redo)
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_175225_790063_19AF4EC1 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: linux-amlogic <linux-amlogic@lists.infradead.org>,
 ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 7:53 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Arnd, Olof,
>
> Here's a redo PR.  I dropped the bindings adding resets to Mali which I
> mistakenly thought was uncontroversial.  I was wrong.
>
> Kevin
>
> The following changes since commit 5e339a1d7e438b2cc9f46ec9f2682efb58ee2dd3:
>
>   arm64: dts: meson-gx: Add Internal Clock Measurer node (2018-11-29 12:30:09 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2-redo
>
> for you to fetch changes up to 8b3e6f8999f8d704fccce225b9455b3fa639d1c9:
>
>   arm64: dts: meson: Fix IRQ trigger type for macirq (2018-12-07 13:48:58 -0800)
>
> ----------------------------------------------------------------
> arm64: dts: Amlogic updates for v4.21, round2
>
> Highlights:
> - fix IRQ trigger type
> - AXG: enable GPIO IRQs, PHY IRQ, watchdog

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
