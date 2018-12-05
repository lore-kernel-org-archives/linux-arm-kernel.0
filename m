Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE67C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC33F2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PPhSO+pM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYARkkVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC33F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X//TJ/rPu9wl/e/QPDWV4nbgyuAcg24fbOBbgILCvh4=; b=PPhSO+pMQdVxHf
	iZDYgmRaumVAm6M0jb3E8WBtNVh2Dvl8wiItLIkWdz2mUJAG7Au6G5hZlDh3F5/DGZ9UXXSmanTYt
	E5gS2ZRRv55Gm1Km4Kl/T6XdunJ1ky+RNqpAfsKupvb+kt3hW2dwwy6iy4dlST2e20F4Z8J/TFMP8
	QFUHImFtSWZvnVxfR3YpG61tVmoN6M5mAtU24CGWiT4jzjrYATKhRBaTrImWfIDI9+AP5224aX/3c
	6mm1HnFcy2SMvaxTqs2FsLsmykbeHupl46Auv2cbUEkhuxuJnRhyZ6wLSBoWBbnbXQZEeeNhzRz0K
	4htOfJN+bk0U6XH6BEvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbU5-0005EM-H5; Wed, 05 Dec 2018 18:01:17 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbTq-00051c-VR
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:01:06 +0000
Received: by mail-pg1-x543.google.com with SMTP id 17so9380400pgg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XKgzt9jM2iynx5qWwfVAz9jDsDSALJ/HvNJnuoHSRwM=;
 b=dYARkkVOVOwA/n0mNacNjsv+3Z8Iz3cG3a4CIGxWBur1GzLk2shhYV1aUN+YFxa/eO
 u8tIaWujNSqaS8wSAW3YZbzUuTtBgFCs1149sACCKG7OufZCtGyEVTOpShA6Ce4xa1PA
 XXZ1+afRVPWX+2dJBKA6QCxPKZSZkbts5NKSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XKgzt9jM2iynx5qWwfVAz9jDsDSALJ/HvNJnuoHSRwM=;
 b=BaFBLHNpbPZmF7OVRLZlmCkuKj9UNiGzv1uZ4G2O1wgjq5Bt+3gk0hR8y3DvPmqrWL
 eCewbBWSW5+IaJtcrx+7efYj6YFZ63dcI38ehSRWtsGNq1adSFAyfvrGYOuDoBPcpcQe
 eEzLYHXYG3RZKCvw+xYf+E2mulyhFCI3xBvPG5s+9U2H9FXKenn4T72uG4VhzhHVKIGH
 GvfxOYETWuzzOumZg3taxZ815p1gGPlF0tGtdHIrNDseiETR9Uz1DpdSDrb/n9vSOqlD
 m3inU2U2s2OCtGZ9kg5e4ZmNyCs+KrZL0KekvB0K6/5fF2l4JIMhu4X/AaFnWiF0NEQj
 bgVQ==
X-Gm-Message-State: AA+aEWac3aX8iJ/4rZXcAzDmWTTpd+cAGnBMj/PSO5D4dq7Tc9xgDMkp
 yTN395Dk90Cjqr6lLm89X/NKVg==
X-Google-Smtp-Source: AFSGD/WEOYZ84gpscSD2jL++UKPtsWroJTiYRpRHL7v+NzIxZQxei65EcouT35NhBfyPHPXOdZN0Tg==
X-Received: by 2002:a63:235f:: with SMTP id u31mr21122158pgm.122.1544032852341; 
 Wed, 05 Dec 2018 10:00:52 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id y71sm35751942pfi.123.2018.12.05.10.00.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 10:00:50 -0800 (PST)
Date: Wed, 5 Dec 2018 10:00:47 -0800
From: Brian Norris <briannorris@chromium.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20181205180046.GA57043@google.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
 <20181205030127.GA200921@google.com> <1693737.bVF0dcvACY@diego>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1693737.bVF0dcvACY@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_100103_497078_108B5DB6 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 03:11:03PM +0100, Heiko Stuebner wrote:
> Can you maybe give "drm/rockchip: shutdown drm subsystem on shutdown" [2]
> a try? When the underlying issue of rebooting surfaced we had 2 competing 
> solutions, so we at least don't reopen the issue, that people have problems
> rebooting?
> 
> drm-drivers seem to be short on shutdown handlers to peek at but this
> second variant mimics what tinydrm does in its shutdown
> (calling drm_atomic_helper_shutdown), so at least shouldn't be completely
> wrong.
> 
> 
> [2] https://patchwork.kernel.org/patch/10556151/

I tried the linked patch on Kevin and Scarlet with 4.20-rc5-ish, with
$subject reverted; I saw no warnings/complaints, and things worked OK.
Same with Kevin on 4.19.6.

I can't test on 4.4.y, since drm_atomic_helper_shutdown() doesn't exist
there.

I can provide a Tested-by to the original patch if you'd like. (I won't
provide it here, lest patchwork apply it to the $subject patch.)

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
