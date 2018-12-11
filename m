Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF6C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:21:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B04B2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QjM7Qmag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B04B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5i+TSnmULgqWkg5FvQoYV43Y4DFPp0QmCB/t5zAjX0U=; b=QjM7QmaglWBTIs
	7bQ63C9aVy2gNw0Nkfdw0HGn8a5W+/X1ge9GFwiQqdhyvnvHA1RXDQ+s7NW31Inot8eh2Y3GsNtak
	wLcyhiLpcob5KOXTA1GZ6otBFTcAetkDvBUVZGfbKeHX6KyzHVHsv/lQjIYhNy6LA75LBY0JE+jx2
	uBsndvAZj+cxET+pz7hKbqYhn2mrbNCbEqrvVbPx7m4ugkm2TVdkqqQ/dHip79LpY5ffSjytf6FZM
	YdEXXz0zFpor/cdXplp8iKPbxR9CvDYQfIAFRXo9bj8QsIUy56CKotZcdbOCnvbUIl0pe7lTTxfh3
	8J3Eg8bJOlLnAgwEmY3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiuO-0002Kw-27; Tue, 11 Dec 2018 14:21:12 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiuK-0002JU-F0; Tue, 11 Dec 2018 14:21:09 +0000
Received: by mail-qt1-f193.google.com with SMTP id y20so16483507qtm.13;
 Tue, 11 Dec 2018 06:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M/cGzShs0MKCyLX0xYAlyd+tbubontrbVeKPl+mGAjA=;
 b=NVRfq3e6jEgcXLtCjj+0QKYfKHJumJi0eYJ0BrAOWRa14gPZKOIhoXy8btybILczuL
 04HihJTeuS3ZNS+hZpR5+IpHUkTWvKBEGP6htdtOk0Cg6n7caX2Xc+ZME3OjfEj7zOQZ
 hezQzQEB8a0+J3ynh/gxL1uW8aPwVXM1uKVyGtE3ncsx7Dmmr40+821Ce26qTSKp4a/L
 ehijLSdJiKxzvJyhumbQsX8sOfere56ENyXeLw/qPmlX66/a3JurO8a5ez9bVR/Jrm35
 kKSWtpuT1+/LBlnycroXchxRITO3DX35tJyEgn3iXF/N/Y/k+EEkMW6zCDjDMpKyw2xi
 xYIw==
X-Gm-Message-State: AA+aEWZqLHSMwpkSZxNmws2iS9f8voMZKf+sCGgK0tyXywzQjU3PAAgT
 seac4fOAHHkzeqMMN+A1ISV2+Hu3gorc6t/qOu0=
X-Google-Smtp-Source: AFSGD/XHzQ+nokHT6zDYSTsCA4Z2JQFzwrdpuBY1CCak+KYsDIkkD5/DjcYYCDMUuctEbIlgdD3374Ug/JIsISTrQk4=
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr15752166qvr.115.1544538057011; 
 Tue, 11 Dec 2018 06:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20181210211231.4084251-1-arnd@arndb.de>
 <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
In-Reply-To: <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 15:20:38 +0100
Message-ID: <CAK8P3a1f0hJhZBbj6yf1ZZS3znDOSFK0e7KHveW95zjB1x=+tQ@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
To: nsaenzjulienne@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_062108_507701_8D1A9E6E 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 driverdevel <devel@driverdev.osuosl.org>, gregkh <gregkh@linuxfoundation.org>,
 tn@fastmail.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 1:36 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
> On Mon, 2018-12-10 at 22:11 +0100, Arnd Bergmann wrote:

> > @@ -447,26 +444,26 @@ remote_event_wait(VCHIQ_STATE_T *state,
> > REMOTE_EVENT_T *event)
> >  }
> >
> >  static inline void
> > -remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T
> > *event)
> > +remote_event_signal_local(wait_queue_head_t *wq, REMOTE_EVENT_T
> > *event)
> >  {
> >       event->armed = 0;
> > -     complete((struct completion *)((char *)state + event->event));
> > +     wake_up_all(wq);
>
> Shouldn't this just be "wake_up(wq)"?

I wasn't entirely sure if we could get with more than one thread waiting
for the wakeup. With the semaphore or completion that would already
be broken because we'd only wake up one of them, but I was hoping
to stay on the safe side with wake_up_all().

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
