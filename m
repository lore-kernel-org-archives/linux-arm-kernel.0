Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0032BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:49:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D492147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlSLZcr1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jPKZZF7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D492147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qGzjY4tOfpziwXkr5IzNVJZKGTCCQ2Rrp0KaZ6bxFtM=; b=MlSLZcr1GKcWiR
	DD3ePrIouBEkr2qEaslTR7f1mcMOK5XdxsWOFpD8OEUhVLq70smCK4CJDWyukzUEf3naVrMEhtFpm
	qGMveg8RrclP81vTLnWzcGr29Dn3z0V40btWC9/5Ih57cT991DljwXKK0kMVyPae7/gH9iAN0VTz5
	ClnCiD3ihxsyl9Yn07HPhAYyZz0nxlX+yx+DhoQIcCOsofakA/NeLyhoonCZMH1l63/HClKzJ4I9t
	O5vXwiQlEdHMT/AH+qY3SXIxDbNyItsOCazR0sxvy0SGY09pT6UKaMeYVws0CDh40FizN0yLr0URv
	yCProu6viNtlV2wHXRXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpfl-00062R-5e; Thu, 07 Feb 2019 19:49:21 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpfZ-0005mG-3C
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:49:14 +0000
Received: by mail-ot1-x344.google.com with SMTP id u16so1902155otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=32dcltOQ1P4EoeLXctHavIhMS0EvxGLs/iMVzRHCsGU=;
 b=jPKZZF7tN7/34sOt1r8tSTVBcxcos+cBMXyBuXvH6dVtt3C4pIb+IpiZG+HKpC+ot7
 dhEh/OcLGMV03sN9KWVOjb3a+CjR/P/GIghAyJxJta1IvRicRvLuzrfK51fdxKiSiUo3
 3EGtVjonMdx9hOeumg9x/oGgJVgiGFFJm4+a9Elg0RdflhKaMbYJu1crfwPUyxGae9FQ
 UZNRbppQejlKbAVjRtHIEjnH05TXMjeCNM4YyW+LO/CcproE/ug/kmXyr74T+TEG/fcb
 Dz5scdqDJ9tqLGTbSYugLPGPmaatIdhpcAmAlZWAz1kGP/IXJ22cmI1odr3YBd5ObWuR
 ftLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=32dcltOQ1P4EoeLXctHavIhMS0EvxGLs/iMVzRHCsGU=;
 b=mBP8SeQ20LEXKvT/DZQNBNmzaLtqOXHkFKafIPh5jENhUQRfm+JMC0lYiGiozI0kF+
 2n+9M5w8twb7mlQFSDHsYHyIHOGU9UrSaY7XRENj3fxpToHITFvnrqe5XXfHGbXL0I0W
 vjPlP4ABy9n0N2Qsksglm3BxkFhXW0VSV+VjLzfy0ZL0K5Nd1mm9rjvLb0OWiejoF27e
 J84wbHw8rPNb0n1Ri/dQ0Evx73OhI5zcZ6pnygBAx+V7C9l1nkLv04BtZNggeWjTkOA+
 gtpgagmc51WdpAVflQfIdbSosoNNaoy4yrBhbEzSFI/qeJnYtvzNw5srGZ4TzGbvy4EH
 dszw==
X-Gm-Message-State: AHQUAubTa6Pw2aXp7B3030QfVpGgxMuZLGEKEWofduUE+BCvWsg/DUcY
 34WRZlbUqGoMBB1t2vZjg3xoUycckEdUE9T1QjqM5A==
X-Google-Smtp-Source: AHgI3Iao5B2FksP2nvHzOyXP8JNL3FyTeoQrKLOUtI6ClvTUCW156Q1UP7kwUSycC27zsurQ1I8shPEE6xHo0kMlXcI=
X-Received: by 2002:aca:eb13:: with SMTP id j19mr1311537oih.100.1549568943164; 
 Thu, 07 Feb 2019 11:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 7 Feb 2019 11:48:51 -0800
Message-ID: <CAFd5g46aiJ2srDf9akR+TwPg3ZheVYJE1JQ4AGm2t8hfO6rF1A@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_114910_079987_0D581ACF 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: linux-aspeed@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Feist <james.feist@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 11:40 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 118 +++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 26 deletions(-)
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
