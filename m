Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:54:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E791206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pAKiUwtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E791206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hMJeAI0dJW+tXcVCCq8BidsQA59aENGtGVLBY8dCnII=; b=pAKiUwtvlUdyXk
	NCgSrxFg+Hfry70rNxf6Xo86kK9cz7mk+Y57cr+Nr/4X1I+EgIVadvQ++aDroVI7i1d+gMC07WZjc
	4e5VtNWTbYcWy5FuoyMoYJ2yyqLyJNhwUdG0UgiLeAWlNYTIoymNhk/EYj+AqaKLL7alrvQNt4HVg
	KspbTKXpcFpj4BbvuElws400GzkGJsuD2jc4SDBuNn4Wm9E02PkBEkQPYatKs5YvyqZ/GT5FMm17N
	IPNjpIqtAi9Y+1ubwvo5YDo8Ouht9S96SxxbXQwbD5RVhrUz0AUlYX6qL8QJRJzeRzRAaq55j1+Bk
	gU4MGrXWAjLLC6B82jlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guesp-0000Rz-52; Fri, 15 Feb 2019 14:54:31 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guesl-0000Ra-Vk; Fri, 15 Feb 2019 14:54:29 +0000
Received: by mail-qt1-f193.google.com with SMTP id w4so11182101qtc.1;
 Fri, 15 Feb 2019 06:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zy01TE5gjFnIEXeBq2lwrwl54yYw23wpLZ7EVTFj+PI=;
 b=DLtpcgFQ/ic8tGQCzLlOVQqG3bv9EsLR6PVeeGZCpPvMgwpdnuBFxiuc+mE/jDTagc
 pV34fFrnEiy3KLgv4PIo7JeNYD1doLC2I9+qB/ShyVRi0NnhEjFUaBhbA6T3R51gsIfd
 Dioi4leB+af/gL9+ZMwwS6ORFaOUOgjdb99dqTf+DzMz8r1A7LxFzxnaBmjZBY0Lt32k
 8MFf8jnav0jE78eDhlxAuYtL6Hjl0wKTuCoK8akw+e7t430TgXhkOOtkgB99qs64zvQD
 wobpWGTi45WAUaGGCym92v9SJ5YLzVAYfuLrswqTm18CFXf/1b2/CiuzUg4pEXvAyAql
 dL9A==
X-Gm-Message-State: AHQUAuYeXChCPwvQG7GXLD3OEKxUM+5HEUCIk6/+tdDLdPIhZoYERUhz
 3EMbvOauJiUo3Gd7uZj9WyYJtQhdI0pgMbmrmmc=
X-Google-Smtp-Source: AHgI3Ia5A79PzWzzf1aBrIhOiljnLxpO/RZ0tquteNZyWXHFxdgn0kjEieOTv4FHeNoIXqcmFu0Ky/dlQcyd/oMfnd4=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr7445363qvi.40.1550242467154; 
 Fri, 15 Feb 2019 06:54:27 -0800 (PST)
MIME-Version: 1.0
References: <40e8af4e-e86d-af97-d9bf-0932c97a2829@gmail.com>
In-Reply-To: <40e8af4e-e86d-af97-d9bf-0932c97a2829@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:54:09 +0100
Message-ID: <CAK8P3a3jS29RYQfSj84D-mAaGzdyQ1MYLK+MtXp7ubYrssY-ug@mail.gmail.com>
Subject: Re: [GIT PULL] Mediatek DT 32 bit updates for v5.1
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_065428_015561_53CF572D 
X-CRM114-Status: UNSURE (   8.63  )
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, arm-soc <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, Ryder Lee <ryder.lee@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 8:59 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v5.0-next-dts32
>
> for you to fetch changes up to 60b71a239bbd286232a547349815d6330f10db7c:
>
>   dt-bindings: interrupt-controller: update bindings for MT7623 (2019-02-08
> 13:18:04 +0100)
>
> ----------------------------------------------------------------
> mt7623:
> add cooling mask to all CPUs
> add compatible to sysirq binding

I replaced the URL with the publically accessible
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
and merged it into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
