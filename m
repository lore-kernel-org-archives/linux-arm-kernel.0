Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD47C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:07:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014D5217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GlI7j1wd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2q4F2LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014D5217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uLYiMkdzyhF3NbJp4JnfCbpt6QP6kPVLLwt0IWSEm9g=; b=GlI7j1wds6XBTg
	NSH/KXTfc6pUTO23Cla9woHtxkXWvNNa/YstpzSEaA2vZ88tnfyOsyG0y6VrrCJYqLZG7kJZa8Gir
	cpqUcrm54aH2ne/vbznVZqhFpKbD/Vzp89EcSGnuG62j69xNV+NQauela0VsZ4uHTnG5AUMsqK/sf
	MB4Guowj9KwV375xfQS4/7ROvUJ38C3qLa+NhCb0iCi5FaLm2yicJyzttmLJltgK865z3rLy7NLR9
	6FUQ6xsPMSeh7AGe8SD++sUKvaPrXuG6nv3/a/Z4MwbD8SIcqeLgonNaYS93lqORs9jpxO60Uzwfj
	bhfXxjFExJTNacaQeMWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqXPg-0003HH-JO; Mon, 04 Feb 2019 06:07:24 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqXPd-0003Gu-OM
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 06:07:23 +0000
Received: by mail-ua1-x942.google.com with SMTP id d2so4109523ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 22:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KG15wM6Jwx9Avl8HGL6Rq2KKwKL64VNzgD6ZPPI8pTY=;
 b=X2q4F2LNVwkuzn5p6WpLwB3s2R5YFu7qGAr55eorUXnrm0NoV8nlSzjilmwHg1qcXl
 DD6qzO39oFADV329MhsvAveYtE/qJWzZIiMgpZ46M+yTGpYmvGL4fp+KV+aoDMRxJP3L
 ifeZ7aS7tZsRCC4eECwsQwQ31mQRPrsQlY9oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KG15wM6Jwx9Avl8HGL6Rq2KKwKL64VNzgD6ZPPI8pTY=;
 b=lFjQTKvl8FNI8O/KFfSRsDbDZrOrW+kfOUWqFdKUpHE09OzNRehYs2YVBfHpEO46g6
 lE2ib+RdA7v/OmJcHIXc8VNIwJH5vvqKdoxgY4rn1JMCONQ285wTJN91MPIpK0Eqfv9Z
 +4uq8Xr4YQShuxiHHhL+LpE0Fe5Y4/aO8vdR3WYPITg4QX5Lw+ldp+aL9Vr8OEJdOGqj
 HRb6MjevtnYlaw9ocmGnEpQtAcv50/LhlQcBrezVu3RyOVIqBVyD/3QAmtK+xb/3tEgL
 iaQA0ZwQvcDLQijOk/uzAkZErqnt8m0+KUIurXrRXnS0r/X9kXYcbyFTB5Us/I4alFt4
 deKQ==
X-Gm-Message-State: AJcUukdvxiNJ0Grn6efrYC7uu+6ESy1+9cPj2IHEppUeOFaKofjZdbhC
 3YCwwHHvSO+IKydTdAIolFIEnj3MROH7OzAZp1K9MA==
X-Google-Smtp-Source: ALg8bN4FpJdHRTRWA4ygDlfIdgG0Zg11v1m6of6DJzSd7yJ27nXx183e6ThqUE4MLG7Ixl95gvAUFuazndfxxCxBKSo=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr21397916uan.107.1549260438893; 
 Sun, 03 Feb 2019 22:07:18 -0800 (PST)
MIME-Version: 1.0
References: <e944650d-514f-3727-2e68-b318aab9ee7f@web.de>
 <14a011aa-862f-7132-8741-df5173875f34@hisilicon.com>
In-Reply-To: <14a011aa-862f-7132-8741-df5173875f34@hisilicon.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 4 Feb 2019 07:06:41 +0100
Message-ID: <CAPDyKFqYWGv7bWW7rcCYhc-PdmRCBdskUTycFxK25VQgd0TWeg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: hikey: Give wifi some time after power-on
To: Wei Xu <xuwei5@hisilicon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_220721_817699_49E20356 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Ryan Grachek <ryan@edited.us>, Tony Lindgren <tony@atomide.com>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Reizer,
 Eyal" <eyalr@ti.com>, John Stultz <john.stultz@linaro.org>,
 Kalle Valo <kvalo@codeaurora.org>, Jan Kiszka <jan.kiszka@web.de>,
 Valentin Schneider <valentin.schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 at 17:34, Wei Xu <xuwei5@hisilicon.com> wrote:
>
> Hi Jan,
>
> On 1/24/2019 7:52 AM, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Somewhere along recent changes to power control of the wl1835, power-on
> > became very unreliable on the hikey, failing like this:
> >
> > wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> > wl1271_sdio: probe of mmc2:0001:2 failed with error -16
> >
> > After playing with some dt parameters and comparing to other users of
> > this chip, it turned out we need some power-on delay to make things
> > stable again. In contrast to those other users which define 200 ms, the
> > hikey would already be happy with 1 ms. Still, we use the safer 10 ms,
> > like on the Ultra96.
> >
> > Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Applied to the hisilicon soc dt tree.

Wei, can you please also add a stable tag to it?

[...]

Thanks and kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
