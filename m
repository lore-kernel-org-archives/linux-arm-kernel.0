Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAE8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:11:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA06020872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOvXIodZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4qllzli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA06020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TLiKXd1PhCwGzgqNj8UvuaR8a7zQ4bvV5SrhTXaO1Dc=; b=qOvXIodZHUVywk
	SKI8xswd0bgVppKvUZy0jAE2ow2v7kl5JHv4pOKb4CvIhYRsWH1aa7SbAtNJ3dL+VGB8rb478wmcP
	Z2DCsn3/QlUvsVe8yNaEdi3enWVd+ZK5gPsmEyjz0CagSfH2LD2qpzozxeIwakGDBhnPaXAMAysrc
	Xv4TtAJV0RoaikrUT1zcA6K8GpoOsYjsYOCTKKn5Ji+qn5E52kKG2sQD8W4Oebrjc515EXS5rST8W
	24OD6PgqiDwMqEaJ0iEv+TxD2H8TwswwatCG8Wkds3RG/YiWa0Wsz466jBHzeQwK0tnPVjXqTKKbe
	B2PT+Gt7zOlvoWAr5e2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghq23-0004Mq-G6; Fri, 11 Jan 2019 06:11:03 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghq1z-0004ML-Uh; Fri, 11 Jan 2019 06:11:01 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so13869273wrt.7;
 Thu, 10 Jan 2019 22:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CIiCoovpaUnBgLP3pt9qYms/wUO6h6OcA+/iCwE7uDI=;
 b=I4qllzli0NzBcI7vPbOJ66qScNosNGrxNRPQxBZCDvHsN+HasK1FWGlInJF1CMCezu
 LaoIaOEw0jVzx6fFrGi3mWYAM6lHDtMAiVzMnGjcUNhSBHtDDrJEjE7I+wYBQflk/Ocw
 E+QdNU12mamtA6QhyVIHZDHrxSfnE+D9vxi5z8Yax12gwLttjzsnWQYUXtew/2DhvQMG
 ZRvQ69z5SILBM22qJ8QExDT7USoIqRaozO7XBqQ7+bVxWNRi3C143XcTzx53n3XRRe7L
 JkIYrMwd6r69nbAlB/t4tMDMk7m/LaCkhpQAY29Fffvq5JjPX7aK07PA+uKnu+RBxI04
 Vb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CIiCoovpaUnBgLP3pt9qYms/wUO6h6OcA+/iCwE7uDI=;
 b=rIpxnxdvfpHnW3E/eVWoQwS0iZmPZjnN2+RtAzfNMb4M57DJQdhEbLMvNOTRuLQxqi
 byznOHkmjF6rXBQ636g1uhojdYQNzDlPiCZt3OQs5wcKfHvhJeb5vCfACRTWAOwePKal
 VR2zoyHwUBhZQRjhknm240r9PoQO37WZL3IIq7DpokrW+XZeS2ueQfDSFNY7IHoWinlB
 gY/Sp7TLCSgqMnyvEfgF4u/uLCsIy4jdK7aFhlmHubsZsWaNt3rA+FifX0QKgdhMszEe
 6lSd1dVSWw+ix4ORNpitd2vE1k4d8XqwmqeXGMl7etqW1A1Smion4T5HZlgjjYQkgHtA
 pUhw==
X-Gm-Message-State: AJcUukeSHSEfDE7JdkXvxdLgVvLVcByBQL2BatTEAKfyGGiRB3Xsics+
 oPkTbeRz+L3bOfcYcgochOznsNOHQzJUAJvWFhs=
X-Google-Smtp-Source: ALg8bN4pjYEjFtLD3l8Ks6/HhSG4Dj7RvucMjHQuo9JUxJBvsS9JSuqYLZbj7cWaOxP5thiRlrP9Iy5y3ZL2z0tLmmo=
X-Received: by 2002:adf:c108:: with SMTP id r8mr12508579wre.233.1547187057471; 
 Thu, 10 Jan 2019 22:10:57 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
 <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
 <2090321804.324042.1547101471247@email.ionos.de>
 <CALeDE9Nzibm=GUfUDKm=d8Zu1fR7J0t-UXMAysmBHxN0oKd-Zw@mail.gmail.com>
 <528752360.347624.1547146121882@email.ionos.de>
In-Reply-To: <528752360.347624.1547146121882@email.ionos.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 11 Jan 2019 06:10:44 +0000
Message-ID: <CALeDE9OZpGVD4HGxCqjtWf1qCXxkH1YAAM28na7tBvFyRpHJow@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_221059_990771_EF03CF6A 
X-CRM114-Status: GOOD (  12.35  )
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

> > > > I get difference results with 5.0-rc1 but neither of the above apps
> > > > work either, will follow up based on the rest of the thread there.
> > > >
> > >
> > > My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:
> > >
> > > start_x=1
> > > gpu_mem=128
> > >
> > > AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.
> >
> > start_x=1
> > gpu_mem=64
>
> even with those settings i'm getting a picture in qv4l2 (v1.12.3) and no crash.
>
> According to dmesg i also have 64M reserved for CMA. How many do you have?

I have 192Mb of CMA with LXDE, the vc4 driver uses CMA rather than the
gpu_mem via the firmware so that's what we set it to (and to 256Mb for
GNOME)

> Does your qc4l2 make use of OpenGL (not in my case)?

Yes, mine does. The crash with qv4l2 was only when I tried Cheese
first, if I reboot and just use qv4l2 it works fine when configured
with 128Mb without any crash. Which display driver are you using? Are
you using vc4 or the proprietary closed one? With vc4 using cma rather
than gpu_mem I wonder if we can reduce the amount needed there, but in
the interim I've at least now got picture output when using purely
qv4l2 and a reserve of 128Mb

I'm not sure quite what gstreamer1/cheese is doing to cause that crash.

Peter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
