Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF582C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:38:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EED21920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H2X1mUwS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnKSRHdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EED21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v5S0KT8buM3ZtjukRG1R5FHkmu0zfYay38SOwQW/xB8=; b=H2X1mUwSaMGSWw
	zqBU9nLAgAzYm4wsoCc0UPUobvPCHNLyPZ9oAptgdWaw28rww8zedIQlx0nn/27bEMMf2f7WOAkWg
	V7nln94yIDTBar8PV/O7+AOzVeAFO37v8TF+RqVThANOWYikNWEWZKQ6PXW++kB4jh3mP7ic5/eGQ
	Mx2aGFotzPIQPjzoUoG/ZF4AOxjgy92eGa+8Z3qk/9GjykIWkAdDzuIsI9B+uYFgvs5rCHOFVeh8n
	Gk6wLqRJ+Wv+3QarMyAoUDO3YqQL1crReh0VTw93cxnlZ2VmyM4pgmjQ51xVZHBSGe7vBhPpBH9Oa
	e4+Z0/qC9g+49SpC9GUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guY4I-0004oG-8F; Fri, 15 Feb 2019 07:37:54 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guY4E-0004nw-Q3
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 07:37:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id b7so4428124pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 23:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4ss0OJ5BCI4F+c8Tn3mN8EpXhDNG3dZjBEBOVvg5GYo=;
 b=QnKSRHdI7j/4NE1JJs1G/HgSEfjKlc04T3AMk3v7angqLRKNNkSt10cHmnQaafY9oc
 p7giF1HAYDoK5L7wF5TqQOMG2XzIS3J4UWauIMWAO7fCXVt0JFWk/U/oftdhi0vZ5hZW
 nyaB2y5NGOuAe88BOfdbqTTna0a13LYCrZHklvJEZJvM53U+dclhYhrdlMGcfd4PdBNv
 CpVFqEZ6isCq2m7o+ggohnanQQ78PWV/a3WwSuJ4YzsdFGAxYrgOZkX8v37V6hmWoYxw
 K38uPtF46aLbkFerxgQByKH1I3MvA7lMGchgjNIak7TQlDis1STVzXzAPxXJ21xmdm8Z
 SW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4ss0OJ5BCI4F+c8Tn3mN8EpXhDNG3dZjBEBOVvg5GYo=;
 b=otvAl0+EpdOv3bRBok6tFbuZ9kSi1yCXSBvr7mNaNpNIjghv5/2/ziJaLB3PzCL2za
 aGjq+BsPK7/0JUV5yHAFZv0jOdznzjwq5tZxo4oVSyGDuKfU7EDoA2t4/hyTQ7GXpccn
 Zzh5/daTNH4S9OvbjxcQCgbWtso7/V1/5KSB8ev1dptbwbp50uQAdkuLWpNKN+GORhII
 hfAT1ipN3cNPWhKUSZocWYyJ7VKTRCkeCzWtlYKcobj2oLVsbGLqmASsFuQ3DDGqpAsm
 i3Chd5Zz23CuBb0Z0aNra3evZMVakssZdC7CiEJqnlXwK9FniXUmJiGiHPR/1KbWSIM0
 XmMA==
X-Gm-Message-State: AHQUAuasf6EMDUhj+CLuS0ad8kTgAcyyv9YAGBUZ90FKsjKBBpWe5D0X
 6mXxKyWprO9cumWmx5iUw1U=
X-Google-Smtp-Source: AHgI3IbmIs9kstanvYsfH89FM86un6uslYJO+zS1lu31Z/b3ycAp7EDRCu70RdouroNHmG0e/3aeiA==
X-Received: by 2002:a63:5922:: with SMTP id n34mr4124308pgb.435.1550216268956; 
 Thu, 14 Feb 2019 23:37:48 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id k128sm5974558pfc.34.2019.02.14.23.37.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 23:37:48 -0800 (PST)
Date: Thu, 14 Feb 2019 23:37:46 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 01/37] input: davinci_keyscan: remove unnecessary
 includes
Message-ID: <20190215073746.GA187705@dtor-ws>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214145231.8750-2-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_233750_870841_BD9FE392 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 03:51:55PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The mach/ and asm/ includes are not needed in davinci_keyscan, but they
> will cause build problems once we make mach/irqs.h a private header for
> mach-davinci.
> 
> Remove all unused header includes.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/davinci_keyscan.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
> index b20a5d044caa..b4db72f833ca 100644
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ b/drivers/input/keyboard/davinci_keyscan.c
> @@ -32,10 +32,6 @@
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  
> -#include <asm/irq.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
>  #include <linux/platform_data/keyscan-davinci.h>
>  
>  /* Key scan registers */
> -- 
> 2.20.1
> 

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
