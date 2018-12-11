Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:19:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E99820849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S1bMqwvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E99820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GR8NjCWZ5ldzqfSUqmrI6/WmEn8uWDdD1b1E5kqlEp0=; b=S1bMqwvmCzl46v
	v/wT3cyH1G/Pp0xP9JoPkhjn+cKCNRYam9g1Lo711SDi4up44JJ75S5xmbcr8ukGw862uvQ1AusCF
	4NiRbvd5gaa3fvjKtORgiUghJ8xp7/bQlpqz3O4pFGX3zJoibha9VJQZ0UXb4fkibz0ny8D1ER2Sa
	fNjd87R8KCKGsXzKQBxiULpu95+0VSKTnnXMbvg4hmpJShKvoHVq3vY2IUORgKmirojzU1uy6Fffa
	wJr7Xqquvx3GiIpWzuBP7rERj0P+NRMSFbNxfvK3tTUe8S9uF9D0fBuV6LrtFJcP7geAW/CXwV1hQ
	2N65p313eUdUIFLFwb9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWisf-0000gj-SB; Tue, 11 Dec 2018 14:19:25 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWisS-0000Nw-7A; Tue, 11 Dec 2018 14:19:22 +0000
Received: by mail-qt1-f195.google.com with SMTP id n32so16485894qte.11;
 Tue, 11 Dec 2018 06:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=61TCe1fK6sylidA87eq9i8nHVHyclUkO4Sk83IWCg78=;
 b=X9cw1aFiIXDQ8T7IJdPKiu0YdPJLYauL4d+Zw6d0wEUqps0rlfjvSue3blXPtLmM3B
 Lmm/KWEJFP+FcY099kDt030vWjhVP4+J6WiXvWDKG+P3+b7pU/U4U3CYtcI1HKM7at98
 p1XZHyzz6OdZtN9rSssz22dHoZR0HZrg/q5XnA3qJQYMmFpSTzNqNHQbGMmMf124VVne
 4JKKihmSL9CZbupv3WY/y8sUVOA3GgYUjjfmQ+0Xq8QN7Yb0UCehNF25wVv5VRXOFXOm
 pb3sR42Ga3hz/nfAAusaU+uZr3h6Yiva4O81MhiJr8nfIv58OF5PEGDkvqb9pEf06ed/
 2tqg==
X-Gm-Message-State: AA+aEWYRuSlotVmOfORGBWM5cB8QPYrUmGdizH3SNq7YTC4XBu+RmimK
 HPM0qLTYkL89TKJBiTAWepZHv57YP9m+wPzzWco=
X-Google-Smtp-Source: AFSGD/Xpz9/k7qrun1tRMkSVNVXR/7unQ2BB0XXxnlq1ayBR5m70DpFsHf9Yl2STJ6f8VfmLLh3JWWrWwB/km0/bjI4=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr15296962qvk.40.1544537940648; 
 Tue, 11 Dec 2018 06:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20181210211231.4084251-1-arnd@arndb.de>
 <20181211100728.GC3116@kadam>
 <64c0fef108dc3bdb137c84714644d770f2008ac5.camel@suse.de>
In-Reply-To: <64c0fef108dc3bdb137c84714644d770f2008ac5.camel@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 15:18:42 +0100
Message-ID: <CAK8P3a2ztF4miKwco1DTR3T=DxncV5sBOoLgrqPCVF2Nn-KFWw@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
To: nsaenzjulienne@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_061912_693210_A2A5FEF6 
X-CRM114-Status: GOOD (  14.01  )
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
Cc: driverdevel <devel@driverdev.osuosl.org>,
 gregkh <gregkh@linuxfoundation.org>, tn@fastmail.net,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 1:31 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2018-12-11 at 13:07 +0300, Dan Carpenter wrote:
> > On Mon, Dec 10, 2018 at 10:11:58PM +0100, Arnd Bergmann wrote:
> > > Note that I'm changing it back to 'killable' after the previous
> > > patch
> > > changed 'killable' to 'interruptible', apparently based on a
> > > misunderstanding
> > > of the subtle down_interruptible() macro override in
> > > vchiq_killable.h.
> >
> > Oh wow...  The non standard down_interruptible() macro is ugly.
> >
>
> Same reaction here, *_*. I wasn't even aware of it.
>
> Arnd, as long as it you're not doing it already. I'll prepare some
> extra fixes for the rest of completions and get rid of that file
> altogether.

Ok, please do that, and add me to Cc. I think there is one
counting semaphore left (g_free_fragments_sema), which could
just use the plain down_killable() before you remove the wrapper.

I actually have another (longer) patch series that is not entirely
ready to convert all counting semaphores into a new
'struct counting_semaphore' to split them away from the
semaphores that can be converted into mutexes, completions
or other replacements.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
