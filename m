Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16032C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7603208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hXFgEvMr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFUJ9yjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7603208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8cvUA8/Q0iAcPY4AXKiE65S4gbrBqrgO/jz79yExBXA=; b=hXFgEvMr8aXl/r
	8YUww2ROQV5e+L7O8RIP7Q4ECXjSNU3M9Cl8FjR/6tjIJBiQ8uPowmGSlgbQrwdkZrATnkosJRAGu
	EoDFxpva2aPYxV2l2AwvfEOPjaVbQh3Zw9ZxUM3tgh4ox0Z7f5GHm28IsfVeIOvBdxErbnZxlKc8e
	awexw8GWgI+qj2MGlGzRJnRJMS4SIiVvR8N/4Jb0dkQ7D4Tpy0HCz3yTbafYhFieM6r94uZv4d00p
	YtDA3ksafF+ejhzU0FytWRHYTu5h3+Hgmotws6OLH1JaFJk3mQ8aZuBi5rHyUHfnGgGBqWuIDwQdt
	M/4tu+6/UjMjV+hPjmyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFEU-0002o3-1E; Fri, 07 Dec 2018 12:27:50 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFEQ-0002bC-EC
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:27:47 +0000
Received: by mail-lf1-x144.google.com with SMTP id l10so2882314lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ev/LVS760cPukiSw1NVD/XABFylNoWP0fj64GTi62Sg=;
 b=ZFUJ9yjDkLHMpQZEe8csUZSyytFx6wVT6DacOwqoQbuHWKoYRx5GuwYjhmtIz6znz5
 JOXrh9hK6bhInckmCBf7ZK78cokGhfDCowL9T228HZc//HGe3zywU9z4/anS3ntjwbzH
 Uo6woQJU8hW7Hj+JYzOMPdphRbsUN3NYJfG7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ev/LVS760cPukiSw1NVD/XABFylNoWP0fj64GTi62Sg=;
 b=EzkkzbnBc5Nh4TRsd4wn3tGKbyGv2+3Q3/F/AZAviqjG15wAdMcjz4XvwytM0lP1zh
 kjXeI22MewYysQImdnmjU9O7dbaTXhbnlwaWZqM8x/Fv7SH58CFpR4PLIZEOO3rZcBON
 5UQ4Kb5sxMwx22j5yEIJxX7PI6tdUPg6EhrZbN2J3oHX/S1KsKj+zgVGT6FLGW+e8g6s
 EwWsuDTYJL9yhBqJ/B2vsGUL+zKVt8CPlknxbTMJ8NQAl/F0JyePpN2y8DaO9rfYEGDi
 +1XXVOtNeE4KqhAhwWRNskWc+ik0fFdPYrRZ17al5EOqIYrqxTCOxMq8yFhwUzSYVztb
 9okQ==
X-Gm-Message-State: AA+aEWbtTs3YZXrwLrOzmqRtVyWEefpNhytyJlK7Ll2Xs/hrjvHuVAJ1
 rqFNgqOHWnJTc/sWPHBZEBtGNvnetdB48pByy3apww==
X-Google-Smtp-Source: AFSGD/WzVwt33quCfPcM17C38/d+3TTZdR1YU9bd5ZSO9Svc7jPaNqxAF7F3um95uTb+mtMa1Xw9utl4vSxOkoBq/6o=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1295388lfb.96.1544185651436; 
 Fri, 07 Dec 2018 04:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
In-Reply-To: <20181202021710.9307-1-tiny.windzz@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 13:27:19 +0100
Message-ID: <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
To: tiny.windzz@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_042746_494377_10F51CAF 
X-CRM114-Status: UNSURE (   6.99  )
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
Cc: Lee Jones <lee.jones@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 2, 2018 at 3:17 AM Yangtao Li <tiny.windzz@gmail.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
