Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E4C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:14:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A35222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f59ccAI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A35222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnn3GRPx1KLNgWao1Bm3JhttyYOQI23dpGMoEPnvW9o=; b=f59ccAI/Fu0nHn
	XjWQJVtqadFrvWVv5sTzF2yS2XdQpxfk2WRKFg+8yoG4YtR61dicghwXgV2LCCoMYsQaK08kSqSIf
	/w8JJSBRht8K/iZmfWEVfhdAQj1/0MUJ8dOzydgKJeBjyhKCHeTuSCfBy5SO65E5gPoi/CTN2PLjc
	JoX1WX+7LX5kUpQ17W4QtD2XaQd/6dJyh97k6PdCfWlVea8+irnH26QlDXhuCu6P/RTA8/nf82tTx
	vZ0htyZodLQonh40YUtrMp+te8owwtT7USzIDSUVY9cGXv89BZaQznfO2VZdyVSH8IexzvnmneGGN
	Era8zF/cmdBj0KFw5cRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwFG-0000mw-GO; Wed, 13 Feb 2019 15:14:42 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwFB-0000mM-Nr
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:14:40 +0000
Received: by mail-qt1-f193.google.com with SMTP id y4so2891434qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tnkbvZ4SUfk/2APVTaosBjf5D0L2yv+PdFOHZEZs4uw=;
 b=XgRP6WEpAce1NB+72OllRUBDOUwH/z32D+80mm81mfY8wjGoro/J34xRefAyT1Sw78
 tGFojeFyowirfjs7WSz+7tNkkN8zYpOA2I9BuguHatshvbiHSfDZe+2Ts/hYLWQ+ZnXt
 JW9p7IqRQqnUY+PZMwQi8IV+n9Lj+ftB8BmzWqO1aMa5rKMOESZewdOlmBmMkDh9YY/y
 iwzm6HttZSmGzjTFsGRBQdPrp3GjTAoHrWlQaPmZcllZsIdVVJT/5PzXseDxh9dVJHtR
 mCTdlMWC6vEK3VrTQw/IodSkta640nofw9uquSE2cMs3j3ovk3O0nZcBS/O9vb1O6BJP
 8LRA==
X-Gm-Message-State: AHQUAuYn8luxGTfpHEUI3fIakn3IZz37hOAikNshTNd5XWTELyNDVSGt
 +vrrtE6SO0ZE/BkgLwRvxbdJ/0szTqfcVrKbT6+RTTFt
X-Google-Smtp-Source: AHgI3IYh3sphghThQkfIfnK6FvNU1OsWOI6pFar5JvAje9PGmbEyl/4Gx5q/ClqzCYr0fTOMwzg2ERt/y5ZlhfgZl9o=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr782662qvi.40.1550070875339;
 Wed, 13 Feb 2019 07:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-4-bigeasy@linutronix.de>
 <20190213084643.kesmhabdooqns2ze@linutronix.de>
In-Reply-To: <20190213084643.kesmhabdooqns2ze@linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Feb 2019 16:14:18 +0100
Message-ID: <CAK8P3a3o_k7qiWndWP40xWhxNEmB0e+6iHC0RtfpqAZBtqTLXQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm: use a raw_spinlock_t in unwind
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_071437_776673_BD512CF3 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 9:46 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-12-07 11:27:49 [+0100], To linux-arm-kernel@lists.infradead.org wrote:
> > Mostly unwind is done with irqs enabled however SLUB may call it with
> > irqs disabled while creating a new SLUB cache.
> >
> > I had system freeze while loading a module which called
> > kmem_cache_create() on init. That means SLUB's __slab_alloc() disabled
> > interrupts and then
> >
> > ->new_slab_objects()
> >  ->new_slab()
> >   ->setup_object()
> >    ->setup_object_debug()
> >     ->init_tracking()
> >      ->set_track()
> >       ->save_stack_trace()
> >        ->save_stack_trace_tsk()
> >         ->walk_stackframe()
> >          ->unwind_frame()
> >           ->unwind_find_idx()
> >            =>spin_lock_irqsave(&unwind_lock);
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> ping

Patches 2/3 and 3/3 look good to me. Can you add them to
https://www.arm.linux.org.uk/developer/patches/ ?

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Are there any other ARM specific RT patches that are not yet picked up?

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
