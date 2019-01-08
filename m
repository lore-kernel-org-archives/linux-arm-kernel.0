Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:57:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3561C2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ok1hJB15";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5v80WBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3561C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4v0ur4hxbTEvGddP0an970s7MihF11Az92x8lhnHQO0=; b=ok1hJB15lh5zel
	5gNEvRTy4+NYwuI9FT+Zg8S9Y9YNRNihSR254lBRXnh0kNnMg10YRtdjpOZFoMpL0XrDshmGDKsWT
	VkCMx+TQg5ueItzR5I3gTKrH6Hq0EdSB1lAxma9+T+w7KpkZWpGQtTsE/RNpyTT4ZVwGLetigARJo
	cyeFUuKypKDFLUsqLqm/WQ0Zf78AsaU+q+TdsfwPv7lxNUth/Q4q4dFgQt4JsJYvq623suw4Mvxy1
	xdybk9SlUerakoYvnUvc/3gTVudVYevm/8XVopbJur8VYpwxJ/smVsaTb9XmXCGPbtTXsK1avxS5n
	ElbpqXhkjy6WkfV0dkFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnBy-0007pr-Pm; Tue, 08 Jan 2019 08:56:58 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnBu-0007pI-TK; Tue, 08 Jan 2019 08:56:56 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so3219340wrw.1;
 Tue, 08 Jan 2019 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6m8GZi/zEqa+7pc0pclu0Dkq63gNG9R2qA58cWIOkYU=;
 b=d5v80WBPOltLDUXb1WhEaUehH5Zg5QtmxWgeYnI7NhD21GhsBASFll0gZVjJJ0roMR
 fdR44GgbkQm86u2Jq/ft1edJgIven7r4ZO/vB3lN2ataUWHD40JKJZAuteZYJAQjkOR4
 7ZMKeS9WR90PynIk43DPu1LyXX9FKpjDtlWn1hDRxxVneZOn+odKVBvndZKII8MNnWQ6
 vzVMtnmYdlyQ0UPWJ1wfGtAYPOpgG0IGTNeUVEnBpVitMjkwqcBaiLYSSciFjuLQZIuo
 C2dWb0htQ0f0Q6/mJUVvX53kO3qglDNNR+KEhYORsXBWyzSKdqrl2GM7JovYPkfgJKOg
 nQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6m8GZi/zEqa+7pc0pclu0Dkq63gNG9R2qA58cWIOkYU=;
 b=aciARYrBUbNIxC0c/cNp/+w4KRexvnhhhMHZ8ZQwV3o1IiG8R/Y/+ZgJNfGiTB//H7
 foDLuVYXj1lacNO4gia7OTzAg+oBblDTzS2IJBGsAmJxfmI0ocxoWuVsIhDtecUkIDaB
 HFxBE4y6xzq2SgdayMNSDzDDhXWBmveKmKt3xbpYyxpOwFRFpFPhufta7wK2QGsoevSb
 vkVW2timy2Sz2bPtGoiSyMStt0YYhm/J3v3buwbDKzNFrcJy/cnAanm90apTAgrtpR11
 N3TOiprDmxsaL4OgilqDE5JFnCwD0zZyZDduRhVFnk3mlkNbSIglUG9ji0Wm6OEfbhN9
 s3xg==
X-Gm-Message-State: AJcUukfiMQaPy/FV+PBwKGU3zzxKmvYaYGX8csYjaH8rbvI1mh3UlXkX
 fbtg0Jw4vRTPOHoZDkLyAy3lEb21ol9AjO33FWk=
X-Google-Smtp-Source: ALg8bN4nz2XsSn3hp9CNmYNaIp+pXteoGTJcVwejcuP0Nel8QnOr1cwennbCLRrolTcKonJN+PvG7WKiHsY/tqqTNwE=
X-Received: by 2002:adf:9d85:: with SMTP id p5mr699472wre.41.1546937812883;
 Tue, 08 Jan 2019 00:56:52 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
In-Reply-To: <849520506.312349.1546937289972@email.ionos.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 8 Jan 2019 08:56:41 +0000
Message-ID: <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_005654_947517_CDA2B23C 
X-CRM114-Status: GOOD (  18.20  )
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

Hi Stefan,

> > > This patch series improves the load/unload of bcm2835 camera and audio
> > > drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.
> > >
> > > This series based on current linux-next and Phil Elwell's series ("Improve VCHIQ
> > > cache line size handling"). After Nicolas' series ("staging: vc04_services:
> > > Some dead code removal") has been applied, i will rebase my series.
> >
> > I tried testing this series applied to 4.20 with the camera module.
>
> first of all this crash should never happend.

What do you mean by that?

> But why didn't you applied the series which was actually applied to mainline?
> Did you apply the rest of Phil's DT series as mentioned in the cover letter?

I'm fairly certain I have Phil's "Improve VCHIQ cache line size
handling" patch series applied if that's the one you mean, I will
check (I'm currently dealing with 4 different kernels for maintenance
so I'm sorry if my memory isn't exact).

> > I
> > tried with qv4l2 (from v4l-utils) and using cheese, which in turn uses
> > gstreamer.
>
> Please provide the exact commandline and version.

That was the command line, it pops up a GUI and then just taking a
still. The version is the latest upstream which is 1.16.3.

> > I basically get the same crash for both options. Desktop is
> > LXDE on 32 bit Fedora 29.
> >
> > I've not yet tried with 5.0-rc1 but it looks like it has this patch
> > series and some other bits for the vchiq drivers in staging.
>
> Please try 5.0-rc1 which would be more helpful.

Yes, it's on my list.

> Maybe this sounds like a lame excuse but the intension of this series wasn't to get the driver fully operational. I think this is more Dave's expertise.

Well like so much stuff on the Raspberry Pi there's users that are
testing it and want to use it so when people bother me I test it and
provide feedback to the patches, if you don't want feedback I'll stop
testing and just disable it and send people upstream for details so
they don't bother me!

Peter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
