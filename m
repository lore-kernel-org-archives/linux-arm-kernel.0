Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C05BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:04:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5092087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K/nnxz8w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGbIsZb1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2v2mR0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5092087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m2+6xxayVL0ecd1gTYzl4OgyGMkYseLz4bgzl+P0BAY=; b=K/nnxz8wmnOlzY
	moRXBfH+p+tihlv34X/CFfVvHK2oLfLVcFPRC8srBbSUyYaJV9isEzaasLld7wztk0c2kSgbM7zPw
	TcKs8aPY5OtMl4PTfTOBMUUmM5eTAvz+zca8j2xG9ABl/i94XfDS8jYWiQx9IaWdfiXE+aZVDYmy8
	HkNux4EEdMl08iJquDtns4ndcKCqM+WVmAdqEr4fbeUY9Ly11AqI7YpEryAgt9MIpjbCd10/Kiqvr
	bbgU4w/SBGcxcznQHgNGEDMnj+UJ0JGfgzpxl+HVZC70JSKYVBlzzIFB3/1RXKMIgpqIf4Hvlx+F0
	YL7xBsoA1OhxRedIdVEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqb7Q-0003z0-86; Mon, 04 Feb 2019 10:04:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqb7M-0003yE-Ky
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 10:04:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K7FHYP4WCte0n2jLKNs3+2YvyzzFVKlfPJ8JKEwhsWI=; b=rGbIsZb1PxhYbyJ2wiGLJc6sQ
 x94Oh2WSbR+gLA6i74nx0dyllWeUgkoI0Han9qorHxZ6z2pYANe+hec2QvzV6yxo/hOH8aK3iWeb3
 c6obBetb6hFUEVUccDw2p76+O95lzwlhudoSriTOp0+bwWXVL0T6nDMVg5w5jCKDgsetxO2HaukRZ
 4NXaKTpuTRSUsno6hdL1DFgUBbhwbQCIp64RFTagjETW/nSrEJqAlEpVR2PBD2RKvJppK2VAAjfd8
 VqJOu8iMApKFymV/GPMJ+kBc7RtINOitlqt12vK8ioj166Ql7HbaTrStAGoUp8hf8PNzmHjpWJbRr
 YHElhBdFA==;
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqb7J-0005H3-QM
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 10:04:43 +0000
Received: by mail-lf1-x144.google.com with SMTP id i26so9890176lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 02:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K7FHYP4WCte0n2jLKNs3+2YvyzzFVKlfPJ8JKEwhsWI=;
 b=K2v2mR0BPGCK9AUrcRtb7Lq6y0NUQlwdMXAHqEKYG7FaG3wzhASDvPnIX5J8ULPW+3
 iSzwa56BLYjhvCQNUE8cVOuD2tXiII4buXdFvOuwg+vxr4ApCsB4sR4Ulqqs5Fwq4OTP
 nPfu1C6IN89R0VwNDHRHob5mnDj4e03SEBlys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K7FHYP4WCte0n2jLKNs3+2YvyzzFVKlfPJ8JKEwhsWI=;
 b=otOPCADEakZ/N0Kt/RbQ4sdnM+XU3pLn+Inzrin/xrPitahVcALU6kQajphiumo4fr
 njKNIr4cyc3BNsYlyJqGCNBHyZybxTKC4OB1NdEZd8vSYjMeL8fE9aI4+/g7ByE9TcrE
 tzha9ICpGgVKMWDB9znSIb+vwcbMzNcFZ7mcKRG/5K0Ssil0KG8HTn3mg1+2K1QVtPjy
 ptp31y8QNTJPFJz8CCdUmF5c3ShBValHXDIryIfHGCGYRgIl1gTWJwNH7Rko4KgUftTL
 1rPmecrL9LYRmX04fmEfAMLL4J+VTiuUheqGdo4FIkCQVPkILTdHL2ImpynLfRcrER7B
 2LKA==
X-Gm-Message-State: AJcUukegz9cUs3cEvNIlbQ/eOE2VWpMAQN2yuTbUgBryXHwTKP4xi8lk
 WdTg5Bi+PEvGTQJNPpD7cH2BRu3izILvSqEts+64hg==
X-Google-Smtp-Source: ALg8bN63d5+JEf+EaXiUaRPcWX8h0ld88o//YdCI/FGHzpksxGTQD6ARuazMzHyNPu3PFbLDQCBi/JGk2FrWQ2Jo690=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr37596335lfh.167.1549274678234; 
 Mon, 04 Feb 2019 02:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20190204095853.12212-1-masneyb@onstation.org>
 <20190204095853.12212-2-masneyb@onstation.org>
In-Reply-To: <20190204095853.12212-2-masneyb@onstation.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Feb 2019 11:04:26 +0100
Message-ID: <CACRpkdapj4xo2JBBw=xo3gVAWOb1dMG8DUVvyW4qw5CAVupEfA@mail.gmail.com>
Subject: Re: [PATCH v2 -next 2/2] pinctrl: qcom: spmi-gpio: select
 IRQ_DOMAIN_HIERARCHY in Kconfig
To: Brian Masney <masneyb@onstation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_100441_872525_2C51FC55 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: linaro-kernel <linaro-kernel@lists.linaro.org>,
 Kernel Build Reports Mailman List <kernel-build-reports@lists.linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 10:58 AM Brian Masney <masneyb@onstation.org> wrote:

> Select IRQ_DOMAIN_HIERARCHY for spmi-gpio in Kconfig since this driver
> is now setup as a hierarchical IRQ chip.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - None

Patch applied!

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
