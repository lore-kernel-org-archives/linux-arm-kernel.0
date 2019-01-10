Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E82121738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qGoOWtTL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoK66N4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E82121738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oeh/YBFewOg7qqfQvf4tvWwSwyOOSQd+B+a9pbY7yXk=; b=qGoOWtTLWLqZqI
	ech8Mhty29DnyiWR57TuyU+H0CSqfrNdwAdTKyka3uadLV9EbDxOSy/G5E3MzL8hrDcnWfXgf8Ix0
	Ryps46cnvGkQyvvttJvfUHmwQz3TRxE+CqkMlDICBZUpOT+VbnJ+vp7IaWld611NC8XvFiQN17KJ6
	qWsIDUOhUxsd3jnNRz31nMQClUlfv1a77ue651WCWGCISHOgkzUuQ7HXyIt1939bk7hzfa8oJnLJl
	fYa6UOsaSnaiTVsekhcMu2c79uEqs5WsvxIkP9doM4Vx/47GqArpoWA8el4PCoyOuI6zlo1XwBJZo
	ws7DL4RjfapdrOK9IgBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghTvn-0004zY-Lz; Thu, 10 Jan 2019 06:35:07 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghTvX-0004e2-CZ; Thu, 10 Jan 2019 06:34:52 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so10029343wrb.2;
 Wed, 09 Jan 2019 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S4AgsKpRiNgIldpuSwsFRlXK+UXRrqDvvQBvzgeoj9c=;
 b=BoK66N4hTI01cZufMyi+dlUZQecIQersFVM/XF6r3so6Yn4c2aWiBTfSH9CIc+J8is
 /GfyqoaQch4cK7H49l4Gq/xuaj3FPBu4ITYAATnn2c1ZfoZCR6VdIGMxFZ7cr78FbBCb
 L1ofK3/lrzQ2V5vi3Sm39GuyGlBvNpAk5HN5EWh6BA4f9IIVIC8/csoPR6VjryTeTUmb
 B+UF5x2WnL8kj+/GnTBdm9j0oqFTBNhWR13G9GUPNVu8IgQXOOY3NEldeD/OsssVnwgk
 fWE+X4lpVEtgSoDA0srDUx069nH4gR8H+BJ7LHRZlQ0WSvlroM+eqRJ2tJXIbZ7Nho2W
 Flow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S4AgsKpRiNgIldpuSwsFRlXK+UXRrqDvvQBvzgeoj9c=;
 b=Dz2VHM7DiWyGhiAN+JwoKsu505GM4U9Fs/6uQMih3T5Oy7HGPrYTV4AxeaWCT+aRVh
 72Dh5Z0vU1jDCXVJuQ+QijHbyA0y+gQXiMRzc+PyPeiKqWKOeWf/qH42zn3DF+c9+IXc
 t52YLfRkQJfHd20vdlAR1SEZgLOd4HGP/UYwEVYMqkbsDrZtyrOBfeFPTINZw1SE6wdV
 iXwC3o+LDXbGSunQ2baofqieu2czzujDyKYu4Jx/DefSct2b9Jl+L3v8zvdft77vt6FD
 X6uJSotOK24bZGaPsVKQ+XVqX6bKXgoSAcufbuK2fWqMOPd5fx+I+9FpkuaPhiiSzinI
 q8nA==
X-Gm-Message-State: AJcUukfSkCMBWUXankRrULAV+UOnUAverg23jyRQKtSHA1VCF3d/wLqX
 O8/DW6yBtZdD82pcjnDHvT6WdrFFrZoC4QQMo1g=
X-Google-Smtp-Source: ALg8bN463QQAL0y9C9RE5vGUJ5vDmXx+WPrdt6zTzsaM4qqlXr7ivPcVm/3YVDZc4NDjJKcFDgKBnmUWCqdNbs7ESFI=
X-Received: by 2002:adf:c108:: with SMTP id r8mr8035458wre.233.1547102089117; 
 Wed, 09 Jan 2019 22:34:49 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
 <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
 <2090321804.324042.1547101471247@email.ionos.de>
In-Reply-To: <2090321804.324042.1547101471247@email.ionos.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 10 Jan 2019 06:34:37 +0000
Message-ID: <CALeDE9Nzibm=GUfUDKm=d8Zu1fR7J0t-UXMAysmBHxN0oKd-Zw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_223451_451417_154CAEB6 
X-CRM114-Status: UNSURE (   8.25  )
X-CRM114-Notice: Please train this message.
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
Cc: devel@driverdev.osuosl.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 mikebrady@eircom.net, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > Hi Stefan,
> >
> ...
> >
> > I get difference results with 5.0-rc1 but neither of the above apps
> > work either, will follow up based on the rest of the thread there.
> >
>
> My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:
>
> start_x=1
> gpu_mem=128
>
> AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.

start_x=1
gpu_mem=64

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
