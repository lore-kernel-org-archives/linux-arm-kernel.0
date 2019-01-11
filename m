Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE03EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F9C20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmJLHqP3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj4G7xHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F9C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ORLnmLnT/mhEpfRmetnEXVJXGgiLAk0UcqSlxbdPdQI=; b=mmJLHqP3icjqZn
	mRP9fm8TQ7lWnrRLRpV+ScpM/b/y4+5MEMcrZnBJb8yCod9dbiuCQNZwXdUaMWb9xWTFuMZ2apcKk
	fz6NQFkl4NL/QeGcwyraramcZekiMJixo8YeZcmjyB0PsSfdJUWR9wWQ4OjcC/YDOt7YxBCwl/Zev
	Zfu/zD6DEn+8w/9oBdGiQ0BHGzI55slh0YuZeNTgwDF9R4OJnKfWUTW7IDvQG9CxXXyXnYUQCVIgY
	m45NYNqUljiK7xvQQR0uOEoM4JrmoFOSq2BBC+Fy4tf4TmAdi0qbErMSX7uFFYWvW+xrfZ8F6RM8w
	FCVEzQJX6jEMhAQCucMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghs31-0002fZ-Vc; Fri, 11 Jan 2019 08:20:11 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghs2x-000233-OT
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:20:09 +0000
Received: by mail-lf1-x144.google.com with SMTP id n18so10204945lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7LOnIHDA/eHXfoobZ1x6d8D6i4KB4HZ7mDYfH/6WzVk=;
 b=Nj4G7xHFdzxbDOxDB/ulWdtXEU8e4Hn7RZIU5u5SXZwdDfFrRIalGWlVOo23Jf13U9
 2YfX2vZQiI8Gv8P6MLrZPZzUoQQfBjaxNuOuLMj+OAeVchMBnxe1Lu1R8eUTE+aQ9LCx
 A979kQSGwoX54uk2eVa2HIOH5JbgvcZofORoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7LOnIHDA/eHXfoobZ1x6d8D6i4KB4HZ7mDYfH/6WzVk=;
 b=f04Ktau1qfU7MG3rzpOVRVjPb18lWhKEn/5J2C2HkYw37h7sWnfVyFkgkfNHVetQiD
 jj8aE57s6rYqyy2Gac9oLNvPTmvyEyBTLr2UUKyQzX5iEtpTA+wh6EBevwc2G3RDaP0J
 mVXZ7sW4EEBdJwYqq3g5z9wUqkulUHhX2F5pKs+sy3ORXZKw391D2+6rNuaH9STQE5mt
 Gz+2Y6XSLLo/JAxOB514SbdVY2oSxby+KMHK/G6bAsJUyVD7fA++P5pUxS5RJ/hqSPFy
 5VlxQc9VAoDV3kvUhaeIHQl3vNSUDSOZxP4D2uiZG7CgAbof+oKK6LIdi4y9NBXpWAjV
 elDg==
X-Gm-Message-State: AJcUukevvf06sboEdGyV09p6TWmiY0romrwovu7jy0wmmf+8D7P3UR4J
 KFkyb029uus0TLCzXCe6jmDo19olwvBagRLcwmpTzw==
X-Google-Smtp-Source: ALg8bN4Tn/hDNN5/egRReOL8Nv3jSxYxEUykrpllQKfGFjTjZ7RayXR4vo0kOIHJdQQR0eR1XbrcyX8HtpXMk5DIyAs=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr7955480lfa.32.1547194805439; 
 Fri, 11 Jan 2019 00:20:05 -0800 (PST)
MIME-Version: 1.0
References: <E1gXPav-00064t-KY@rmk-PC.armlinux.org.uk>
 <20181213120153.GA18173@mani>
In-Reply-To: <20181213120153.GA18173@mani>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 09:19:54 +0100
Message-ID: <CACRpkdakqbVprrHgO01i_uSXsFa5=HXtzBu5qiVmW5twQ84PmQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: actions: remove boot_lock and pen_release
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_002007_859073_11CDEEEB 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: linux-arm-msm@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
 linux-actions@lists.infradead.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 1:02 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> On Thu, Dec 13, 2018 at 11:55:57AM +0000, Russell King wrote:
> > The actions SMP implementation has several issues:
> >
> > 1. pen_release is only ever read and compared to -1, and is defined in
> >    arch/arm/kernel/smp.c to be -1.  This test will always succeed.
> >
> > 2. we are already guaranteed to be single threaded while bringing up a
> >    CPU, so the spinlock makes no sense, remove it.
> >
> > 3. owl_secondary_startup() is not referenced nor defined, the prototype
> >    is redundant, remove it.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Hi Russel,
>
> Is this patch a superset of https://www.spinics.net/lists/arm-kernel/msg694546.html?

Please apply Russell's patch first, I can easily apply my refactorings on
top later.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
