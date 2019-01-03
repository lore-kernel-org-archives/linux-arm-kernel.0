Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:09:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEE9208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IrIl4uLE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXe8lu5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEE9208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=13Ve6WmYG1vd06lg9ZfODqZSVjGlr+Wq/bE7sAzSlTY=; b=IrIl4uLEUmKido
	OQDtbx1zQwmITiUOJmzOpnMYEwStZokqZWV6/QJ/mXPuCMapaKSJQWHVkx904AXt5ZLs4iRjfaN0R
	JM1IcL9yoG0aky6iyDgkS9drMEivN/96mEI6febnyiC0IHJf7NOr9tytiBfmmGX0Rsd7lM0Ye/D69
	JQLb98alWb1xCZ+FiLFVzKxv2X2uaxZhwXthZeRiDEvq3tm68Ld8cN+06UOMNin3uqkYDGL21r8JU
	4jNKg+cCaK+Z9J7n5tNn4YxijZ3nrkMKJoTdow8DyrLfzWnq95VPSdkPhMegp636gt+7MrqPhvkvs
	53ntceV/ynazW2D5hKsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf9Ig-00071x-8Q; Thu, 03 Jan 2019 20:09:06 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf9Id-00071W-62
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 20:09:04 +0000
Received: by mail-pl1-x641.google.com with SMTP id t13so16334937ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rNEa+FnpCnduXh+ho0dhw3PcaZNvi/6iMUSXVqJ8at4=;
 b=fXe8lu5WMjBLBaQYGxN+AbWvO87Lw/BHe0BwgWM9fGGVij7XZ1q5CfR6/d4yLfw5/I
 0icD2fF4hCdLKZDJ39vF7mP7UZIwngJyX2JRPrR2/PRAetdIILAugZVfebEtpVBGJJ+/
 kOMY6mKEwiJsgkjAaj4UX6ysLo5gC4eSqy8uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rNEa+FnpCnduXh+ho0dhw3PcaZNvi/6iMUSXVqJ8at4=;
 b=gpZanq0geZ2r+kWqrEAtLtI0knH/zabZjrD5NAXLiCZKxTVbhtzm2Orh7d2fzsyzQz
 yWBUXA85mUIyiefa2XTsbYASXDMv7e9+yoZeJrmyRagPBQkd+mSV3q36aytx2TduTdNN
 qb4C7Nml/dgtNfQan34+S4RnQDsKtcdttUP4q9wf90/Tix44pYq/83XOXVY9h6kiFeFh
 i0RdpYPGgZdpiExTYOmEWVgo+HMXcZ9ssuCDPJY7LZGOT/DjqzG4LUpqcrT2B9IMTbsB
 Qg0Nz8UIgL8PKWQHYJhPUVoEJ1sDVoHBZORLTr+Tt13rw/81BAEzQ7/zdZBGFF5tv4dV
 W1yA==
X-Gm-Message-State: AJcUukeFdPnzPlZiv06eQjsGHK9DcesxYmGK5MvhcBq5S+fPxnlKSbqP
 mpq+LibBRsLhum9fpp4P9dza0Q==
X-Google-Smtp-Source: ALg8bN7hoZ7oAMKi/c8dDS0b4KSQwCuIGJ6M1dnJiGgHJ2b9fnN46GF9pGFDzG9cVCcoYbkggjz+8A==
X-Received: by 2002:a17:902:8e8a:: with SMTP id
 bg10mr48333395plb.192.1546546140810; 
 Thu, 03 Jan 2019 12:09:00 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id w23sm9318542pgc.72.2019.01.03.12.08.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 12:09:00 -0800 (PST)
Date: Thu, 3 Jan 2019 12:07:56 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH -next] hwspinlock: fix return value check in
 stm32_hwspinlock_probe()
Message-ID: <20190103200755.GD31596@builder>
References: <1546498950-105456-1-git-send-email-weiyongjun1@huawei.com>
 <16205f0c-3514-731c-e948-38695e3a525d@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16205f0c-3514-731c-e948-38695e3a525d@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_120903_228938_44D92401 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 Wei Yongjun <weiyongjun1@huawei.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu 03 Jan 02:06 PST 2019, Benjamin GAIGNARD wrote:

> 
> On 1/3/19 8:02 AM, Wei Yongjun wrote:
> > In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> > and never returns NULL. The NULL test in the return value check should
> > be replaced with IS_ERR().
> >
> > Fixes: f24fcff1d267 ("hwspinlock: add STM32 hwspinlock device")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@gmail.com>

Thanks for the fix and the review!

Regards,
Bjorn

> > ---
> >   drivers/hwspinlock/stm32_hwspinlock.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
> > index 34a8e00..4418392 100644
> > --- a/drivers/hwspinlock/stm32_hwspinlock.c
> > +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> > @@ -57,8 +57,8 @@ static int stm32_hwspinlock_probe(struct platform_device *pdev)
> >   
> >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   	io_base = devm_ioremap_resource(&pdev->dev, res);
> > -	if (!io_base)
> > -		return -ENOMEM;
> > +	if (IS_ERR(io_base))
> > +		return PTR_ERR(io_base);
> >   
> >   	array_size = STM32_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
> >   	hw = devm_kzalloc(&pdev->dev, sizeof(*hw) + array_size, GFP_KERNEL);
> >
> >
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
