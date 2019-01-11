Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D9EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:47:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6BA206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fA6gSs3Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bqaaOx3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6BA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TbX2ZvNTJEOsE7CijzM4wB7WQ75EFlGkTtXi/PnIMok=; b=fA6gSs3QIkxXrg
	FuFGsyySy4bV0UQIz7AOWYa5ypVzZLQjaAtI8m1HJAl2hdGlQ32EJFiHx3nYjGu/RGBnPEA0NkDr4
	SJ05xP8QyJH8DN4hjRVgKUxKZ26zoadlqBjYfV88vsZPYjyWLMvzA8UEwhF9gFgGyckGpTFzqcSry
	LrNqM/2hVn4I18ZMViJGFCF7CEVvnasxItLPUivpeilmY+Xq7FDjdI5cO1trEmwGq5IsPy8GMRhb1
	U5/2XtMDXXs0skbNp22GGzcD+ojJCcB/uS198wFdPcU9wa2aByPbWWTRUttNhuG6B86Jr87qcPy8O
	ewTlGU4790RQfHWvdR4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2lj-0006TP-9J; Fri, 11 Jan 2019 19:47:03 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2lf-0006Rw-41; Fri, 11 Jan 2019 19:47:00 +0000
Received: by mail-ot1-x343.google.com with SMTP id k98so14164497otk.3;
 Fri, 11 Jan 2019 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EwTgfDXrGBWBRBGzaiJXo8VHk0775DRmtyXsq02SAvM=;
 b=bqaaOx3sssmsTrQ3h7GuQyKeOcWKYkpbOSjvxdKeUQ1DJnlQ4qHQ/9A4ILpe1W5rQv
 E8GTyW759XNnfbcfdJhmUFGhLD+LPw8vkttUxQfCCLP4iuTZPuv1H7o+nr0ilGw4zgSB
 bufGrBdMn7rx3pl+wJiC8weSNEiEyZAxh8TfodqjZWaYyPmaVL8QBOghJLlBm4F9GWNo
 fQhDfnnNQgHa76oPSsX1ov3+wo9xqm7UMQwFQ53+IcUnhD5dcIklXdXPGOqBdVp9IEGX
 kEwru6EZqygU0npbrl5AE8vT+p9tmX12AnuPl5mwDiWLtSpLxlB/7bWhZ/Mf1FosKDRY
 ftbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EwTgfDXrGBWBRBGzaiJXo8VHk0775DRmtyXsq02SAvM=;
 b=gJ2+npVC/bCndqppi2U4IoCnFyx5jrbC/aTi3Hz7U8nJpy7ClMEdbl/2FBpVpOW+QA
 BqcJqyGFrNG9BRSVY0M002UJFUCB7Bk7m0IBcme2+ehJqfjg7qLmf/jaoFtMRJ2YnP05
 NiKEGFS/ndl9NDzXA87vPNe3jVMOCutz3LzTw7N1U8vC4IC1L1ldQwiI+KA36kmJrVJU
 TONfJTOkIGciWJvOfO0AJl1dZ+Razq8DJEZLA6FYwTJr5u+3UX3W4+sz4r5FKR57kJhn
 gVGFsQdr7sVlr47j3rrj0Gp73QNjCMs8HQ7+xRtpS/8NmzG8TTtD7KO6lMudjpxf3IN/
 ljxA==
X-Gm-Message-State: AJcUukfgu8fLfD47Iekx6D9oL4fJA/LiAYrtmXf7fnhPzffIqUZBbdQd
 d3JGVzs/v7CxZ/i7eMZWmLSqGFXiu+mg0mlNZ4I=
X-Google-Smtp-Source: ALg8bN5f4HT8rVu0DCXSn8Hw4Osm2eSQ9//ixSJf68In5OGFFe5oVpm2OYQ+jKTrNLv4mr9Dpt9hbraZ+jo0dkayi14=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr11061364otl.342.1547236017328; 
 Fri, 11 Jan 2019 11:46:57 -0800 (PST)
MIME-Version: 1.0
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
In-Reply-To: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 11 Jan 2019 20:46:46 +0100
Message-ID: <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
To: Loys Ollivier <lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_114659_189768_2AF7BB30 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

some nit-picks as well as my Tested-by (in case it's not too late) below.
thank you for taking care of this!

On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>
> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "active high".
this depends on the polarity from the cd-gpios property. above commit
caused cd-inverted to be applied twice (effectively making it a
no-op). thus "cd-inverted" only means "active high" if cd-gpios also
sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
together with "cd-inverted" then the GPIO will be treated as active
low.

> Fix the SD card for meson by setting the cd-gpios as "active low" according
> to the boards specifications.
not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"

> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
in my patches for the 32-bit boards I used the commit which added SD
card support to the board for the Fixes tag. however, I'm fine with
this as well (I just wanted to point out that there's a small
difference in our commits).

> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
