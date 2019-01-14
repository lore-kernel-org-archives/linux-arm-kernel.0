Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E494C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DD020656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LZO2GrzA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbDXKSrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DD020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=opV+8zwDm+cDM/Am3KRkcBZ/tM45Ji/vWQVn1zpAmQk=; b=LZO2GrzAWz6Z1CMWiQumY8e3V
	W0BogGh/PelTjkal1ufiHzfZUCwrk6y5cqBcXG3S37x61p6CCyj6pdmte02jFCk5Y6J+DtJcnDRUV
	4TvXtueijvcwPzC1LsuaH1K7hNiRF9HZIM4y3xl+a8RgY3C4PoEBFDFIA8xoO5mKUUa1+qHpeNams
	lF/ANSyPg3TMyci+5vETjWN5hxRp4cGuUX1Ix5CLMVa69RMFfoiz7IQelFHM16sTMgcaXoU+dK39n
	KXKsHjKiLVeN+JS/TN111/j8OCF57p3a+7+QXOZTEHx8zBWxMgVjjV/VxgNrFUnr+IJmSIiDg9mUA
	yaRJNKQqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gize1-0003Ed-Gp; Mon, 14 Jan 2019 10:39:01 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizdx-0003De-HO
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:38:58 +0000
Received: by mail-lj1-x244.google.com with SMTP id n18-v6so18538806lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TXPNpJddlN+nFIx50S8bpun/lW4F/t8xPgeguT2vRQE=;
 b=bbDXKSrq5ePEv7UJtyg0+8Eh27cr4mywPGT31x5pPUFzE6P9vp6dJn5gp3YZQXtJ5x
 RZn1mqz9kroOKIRJ3ngOoJLl/FUyYHLCxwAQvH3bCfl9l7EXS+pG5UQOpziDSKrfPSm/
 3CWM+IX+f+oj46e2Ubm6KoHryVZTJ5G5gdrZERismeX+tGH6VCDj1Ie0XaI5oiTHioRN
 t5cw/CLGw7wNS7VMZzhNThK49z0OfMJheJgYgKoe77C3PPli7vF5BHP9BlRajLRZPfFg
 cU3gQg6+6RTN3lcoBXqRLlz8qoa1c3BESM6d5TuHL9ZkAUIk3dk9H03e0YjVOjGUhNDK
 E5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TXPNpJddlN+nFIx50S8bpun/lW4F/t8xPgeguT2vRQE=;
 b=D6clUlPTfkYU/fRKFXpIEQbLTSmJ3GdeNcOd72AoH41M19brfiH3Lbcbg/wCGc9OyT
 3Vap0UbIB26DFOBvjD83SHCyKUEoVNXFFjS2TToHTdp07JfBBBcmZe5f6T0uv+nGhmFl
 xhQq8tLiobn0h/yqbjNViZ4EDvK3kB9+wRLh/ivdVt+EGYxX9l1IKE3FLvBpI0ZV+7q+
 abgZBZn4D3uFEzmU+Rmq75x6fw/JoUvB+etAN9JSA09TDMS5thBqP9ow7uxX0ix7ZRo3
 hsBBLeHCSOwHguFVuFjPiE4FYNHaZo1mi/su4ReQZtctA8uSV/xpzPifTB251esZ85QI
 lWLw==
X-Gm-Message-State: AJcUukfj9YYQ/L2kxbNUXuw3oYgrgiYzAR0Ey/4udSyIX8WZcQT5Petz
 Ix8SZNFEuUvCgArQunG3sGY=
X-Google-Smtp-Source: ALg8bN6XKxuBiWgGbPTPXc+blxEb/kWh+jADdwvz5aN3KIWtdjqSdXm+ULtrIXstG7V3iEAEPE7F4A==
X-Received: by 2002:a2e:92:: with SMTP id
 e18-v6mr15505174lji.130.1547462334856; 
 Mon, 14 Jan 2019 02:38:54 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
 by smtp.gmail.com with ESMTPSA id z6sm10691lfd.50.2019.01.14.02.38.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 02:38:54 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
To: Souptick Joarder <jrdr.linux@gmail.com>, sstabellini@kernel.org,
 linux@armlinux.org.uk
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
Date: Mon, 14 Jan 2019 12:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_023857_601357_87C5C78F 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: xen-devel@lists.xenproject.org, brajeswar.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sabyasachi.linux@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/7/19 7:37 PM, Souptick Joarder wrote:
> Remove duplicate header which is included twice.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   arch/arm/xen/mm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index cb44aa2..e1d44b9 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -7,7 +7,6 @@
>   #include <linux/of_address.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> -#include <linux/dma-mapping.h>
>   #include <linux/vmalloc.h>
>   #include <linux/swiotlb.h>
>   


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
