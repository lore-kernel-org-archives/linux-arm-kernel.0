Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:28:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE98B2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qn5SAcDp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VHZj3CZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE98B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M0oQ8nu9G8L6IGqmr4BSzzI4Oenn/+R1j3p8Ugz8x0g=; b=qn5SAcDp26Ea8s
	UpbUAAoFCQaoow/WuppMaG+VuZjKITcdRmkgCeWJXtbaKN7r54pcQnUgtilbPCso9iVI3A6uAhlBw
	Ke0edRaWpbgbf5hvBqC2N3hpyyRccvJ2UAd/EhHrm3N1C6udQXsR+OY8YSz6hM8NXibVLFfe2krr2
	tsYhdL8Nwy6Br9+eNBHbzjkDiTDG8ettuRWyxIExCdW7Eio6bq4P/IkZHzs2GTv5H/UyJUPnqSBRw
	82BDYQFrx8RzWkyKZCsKmjXXZcOsJW+X1uLhje+08flyLR/5Fk4LqP1KTEniqb0U3bS28dRSnydAQ
	NeIwnovaBgg5Yk04p+zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grs9z-0002e8-H1; Thu, 07 Feb 2019 22:28:43 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grs9w-0002dp-69
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 22:28:41 +0000
Received: by mail-ed1-x544.google.com with SMTP id o10so1178628edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dNU+E7BC4Z8mhP0GgejfSsCoO3n2WnTCKZp5RJcMK0s=;
 b=VHZj3CZVxJu9iknzB327ef5wECNsX1bjtCfQcGNywQ00jsFEKpOeQ8MVSxy4twDNyI
 zS5Q5Kqj0nvw1d2z5BJaK8rhoWYXtp0IjhzE/+6mefAAEQc90oCLN+76AIL4Fa2AMfzC
 SR0eYttezVvDEyeKg6bjJ5cLne/r342qc16aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=dNU+E7BC4Z8mhP0GgejfSsCoO3n2WnTCKZp5RJcMK0s=;
 b=Z4/puXL273e7rN7tlb1zNgV4uEQcJtG738IbvB4KRJ34Jas7/rgMvFJPFWKv5KhJY2
 g67B/fZ8ZQTfNK5KEQCuW18DO0DZ1ZctsmRKukLvB++Gcz4Sx49UcA9ZeyASpBwGk/xS
 ZGNvkGEgBj4NY0/vkgwX3zIzUF/RIIh5W1NrWkkx3rtdBzmss8EbXolgCgQItHucykns
 ndWkwKoqexJIl0WSkDIVRGJZuGHMHoepgOdG+Q1BwQriodPu0CS/754KDS2jxEZ3nLE9
 tFz9KdPD9/J/ifBazP6B5LIXJ6rQEgfAVSi6MVede7n2Zn/x5YZnx5HpwO8o1FHkK0Ja
 WFWg==
X-Gm-Message-State: AHQUAuYsC74coJh0UrO5TSAHkANirx3U+hVContidKfkAcMtc9dQd2i3
 uyzrhhQqQ1Kt7fRgl0tutjE+9g==
X-Google-Smtp-Source: AHgI3IaHZ4oUG5vuv5WzngEfyewHwFdGOpTPx3P23va4IeHDwwizteeJ2taRctt7wBpICWJ2DxI3EQ==
X-Received: by 2002:aa7:d798:: with SMTP id s24mr4252669edq.1.1549578518340;
 Thu, 07 Feb 2019 14:28:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id z39sm139791edb.81.2019.02.07.14.28.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 14:28:37 -0800 (PST)
Date: Thu, 7 Feb 2019 23:28:35 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] drm/mcde: Add new driver for ST-Ericsson MCDE
Message-ID: <20190207222835.GD23159@phenom.ffwll.local>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
 <20190207083647.20615-4-linus.walleij@linaro.org>
 <20190207222239.GC23159@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207222239.GC23159@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_142840_224416_EA2E7EE7 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 11:22:39PM +0100, Daniel Vetter wrote:
> On Thu, Feb 07, 2019 at 09:36:46AM +0100, Linus Walleij wrote:
> > +static const struct drm_mode_config_funcs mode_config_funcs = {
> > +	.fb_create = drm_gem_fb_create,
> 
> You need drm_gem_fb_create_with_dirty here because you have a manual
> upload screen. Also might head the advice from the kerneldoc and check
> your buffer alignment constraints here instead of in the check callback.
> But I guess either works, best would be if dumb_create would align stuff
> correctly (which it should), but since this is super theoretical (usually
> modes are even enough), who cares :-)

Forgot to mention: You might want to wire up the damage rect stuff and
only upload the part of the screen that userspace/fbdev tells you has
actually changed. Doesn't apply to all (or even most) userspace just yet,
since brand new stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
