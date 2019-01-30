Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E6C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:30:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF89620815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AR7YPJ+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF89620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xUzj5K364IQbk2hSprF7MHP/Q3UF6YPG0P9oI9Iiulg=; b=AR7YPJ+XDge2a0
	nWLmp3GWLLuE5DssDsVUfruqE5nEzFAeW/R7nnpjM1OsWt+kPIW6I9ljnh0/mB5HuQ5yt1kKlRCM3
	n7qy2xKQpwpWkoc+QvjsijsEDARaBJKqTVqWGeOSU6LDchC6naZzdhpcHMtCKwzUp3pJBk/ILZwaU
	3AyqXM0NBOO2p/fQExXknTgSyr5SjHcIFRNIKAuZWgn4mDNrsfFcwMcdv/XLTT4gp74GGbdK+GxdZ
	mGskfZmg9h2tJWdog1hfYc+NyZ2aP4YOUq5Q7JJlHrfdLoDAV1t6Hn3cS0Xxr4t3whbZQGKsjoJbe
	jtE0+u9L3M+O9Be/7Qgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon8n-0001zp-PH; Wed, 30 Jan 2019 10:30:45 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon8j-0001zV-R0
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:30:43 +0000
Received: by mail-qt1-f195.google.com with SMTP id t13so25623890qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2RhT5QQBo9CnhrSqsK9zeY8SpPxw6YQtRAC8uX0MA6c=;
 b=WRYpOw+vK3hefF7uaupPNLi41ZmMhiYSFFTvNDf4KPsbDpqLLHEDuLkCHxT35xIOkY
 u7Aott2EjPXAKQYjThzeW5rG0pNzXqprZGbZJiY00yi0BHiw7QQ36G4p/RdA7cfEK9HF
 txWfS9AZgTyWF/arDi4s2XJ0k9DKAX7lKEYQotPTzdGQMxeQ0DDCLTsxws90KSkPzkl5
 OhUXSMMiVb7800IfHpcpPV6WRWrBVygiaXBvBajCUWPv/FHGdD3/ymPETUzl17jbZzgT
 Wgs5m7TsHKapttKCFSt6ds2nPn6LuK/W/pc6kRzuPeMlurZq3EjM2+v+c/Nx+4g8czFG
 TcBw==
X-Gm-Message-State: AJcUukcFgNOnQo/DA4w7RNZYhlYmkc7OQFVlh4mO2geE2cMmCvcm31cC
 ba8GMANB6YVqqWRADTw4Fp42IbnbEWEOtva0wfxUwQ==
X-Google-Smtp-Source: ALg8bN4gk1gkiPZhBES1+GsVzbOJNWK/Z3JzyP3y3m9AARvU7dTUXSP5iRy5qUKoLFZ3OE0QzDyBzfLslnwYdbYfvCU=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr28031686qtm.96.1548844240920; 
 Wed, 30 Jan 2019 02:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20190122113525.13705-1-sudeep.holla@arm.com>
In-Reply-To: <20190122113525.13705-1-sudeep.holla@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:30:24 +0100
Message-ID: <CAK8P3a09=Z6rfyeqZmSF8rZVuUHwHx0FM0PAA5kaukJFmv_GLQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: provide the mandatory device release
 callback
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_023041_867484_83E5603A 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>,
 ARM SoC Team <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 12:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The device/driver model clearly mandates that bus driver that discover
> and allocate the device must set the release callback. This callback
> will be used to free the device after all references have gone away.
...
> Hi ARM-SoC team,
>
> Can you apply this one patch directly or I can send pull request if you
> prefer ?

I applied it to the arm/fixes branch now, and added a Cc:stable tag
for backporting to 4.19 and 4.20.

Thanks,

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
