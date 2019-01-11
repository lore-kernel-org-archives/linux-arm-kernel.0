Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA08C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB462177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B3pCQw0M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZGjL6Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB462177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gh9/bQGtny+vbDlHtold1/X4dq6wfV4HwpAD37FpchY=; b=B3pCQw0MfEu6E/
	t/5Iga4Ppdc789jlTGenrrdzzZqZP6m1XfdTyJkEphXxUcNzewHRNdW+TYi7Ki2iX+KmgJigsrTiL
	A/BBc0b9USUJ9P1FXArDD9UMbfKcoz0XxhVCtaMWp7vlV4lkww+QFKRUjg0beMgHCk6MWnDkSdY7F
	Ot9JH3zn6Glldav8K8tXT3tj3iaEm2XDCAt39VqPuzl+EeQVYpZrYeMoqiLv1Uclb8ghkIqkpqMS4
	Rj1BbYz/hL+uP4RKgheUhSJ9/YXUDQvWTMqAj6PhvdTVqxQt/bWwho0j3cmJxvDqSuSiot2WXsLDU
	P+ezQtt0dJBwUY0n9I/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtED-0000a5-CM; Fri, 11 Jan 2019 09:35:49 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtE9-0000Zf-Mo
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:35:47 +0000
Received: by mail-lj1-x242.google.com with SMTP id v1-v6so12354238ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nV7G+8TxoRX6W31GaZA6IRFBQ2JHWzlQx61Eq2QMIik=;
 b=jZGjL6LqVxunezlexwns1UVYEWOyonOtNOe8Q6UMxJ6MTyCSLhfX82YUbABjbp3zfM
 +LbAxhBTVxes4hkiwlCq6phe+4z6BdFMZfstD3gEJDzSaclHx7c0pLJmkHCKll65jECz
 AvQo1boUoZ9r8LzjRD8sRCKO+zdHyCeoGKX54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nV7G+8TxoRX6W31GaZA6IRFBQ2JHWzlQx61Eq2QMIik=;
 b=pA8QDAcjUsQAByB5uJZruFrqTy8DPo/GOObieyA5oMYvFnFYqYjruDsmE0iLYnLP10
 Z/wARn8fXU8L0UC6LXnecfdLflO52Rf72ODwRqsMIZK4E5Yqm2SM1lCZMQqoYeJl8iPh
 TiGxh/LvLB/bkaBV6nw4Iy/Sj8UX6LjprW8urfeaiyG0qBDZUi19EhzaPFwUILQ6ldfQ
 vvNDn6psx8MgkhHUiM8Mi1HyUAxsG55o6oBi4/Hsxu8uvh/F06KatpKpECfDl0Za/AZj
 fG7Y4Lsq1VpMfRKseudNACXitYMdW7j8YxoUXFrsTSr34QkFteu7eL+FbT7AhjsWf0ed
 KQcw==
X-Gm-Message-State: AJcUuke5W8TilzOvWilTveJaXYFEGXNJEBlX0yY/frhUs7bZXSvI/KyW
 TvBuA1WJdAn5L1uKmDGfCSwiACNgj7NCkawZtYDsDg==
X-Google-Smtp-Source: ALg8bN4ZDHl7n1BcsmXdlj4ZkbmjbHYy3QhK2shYEh930nNeNXcy7NlAOAhbq7+uIchjWk1vUX8tpRG4hzG2NGbAGUg=
X-Received: by 2002:a2e:710a:: with SMTP id
 m10-v6mr7997009ljc.66.1547199343515; 
 Fri, 11 Jan 2019 01:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20181231095256.14814-1-axel.lin@ingics.com>
In-Reply-To: <20181231095256.14814-1-axel.lin@ingics.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 10:35:32 +0100
Message-ID: <CACRpkdYT8eb2PD2fOvHo7MsSi7Ltqjbjk=udnKsW-q2YSFcGUQ@mail.gmail.com>
Subject: Re: [RFT][PATCH] gpio: sama5d2-piobu: Set proper output level for
 direction_output
To: Axel Lin <axel.lin@ingics.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_013545_752633_119779C5 
X-CRM114-Status: UNSURE (   7.22  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andrei Stefanescu <andrei.stefanescu@microchip.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 10:53 AM Axel Lin <axel.lin@ingics.com> wrote:

> Set proper output level base on the argument of direction_output.
> Also remove sama5d2_piobu_set_direction() as there is only one caller
> now.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Patch tentatively applied as non-critical fix (for v5.1) unless
Andrei has concerns.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
