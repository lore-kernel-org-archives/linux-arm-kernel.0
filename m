Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380A92084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="psSUMbCH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfqA7YNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380A92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lcHW1VRMGP1eydnOM9mVX75HtKYBXNJro9qQk2lo5JI=; b=psSUMbCH/Gq1yv
	qvWo78bevE8vxOgBpeSPdFdmYoEWptoHrqrqyUhWU4E07cIXOfX+Pqe5HyzIW2VqqGMd464euylBr
	O38c2eqFwxSZyo1BOwm4O0bKUF6RIqDgjjsesiNiyR4Ndlm9T9jfUvlYwSNJXLm/jsBFGrNaWbYGN
	v/6idKAaKePyzwacehRyVSwVvX3g6RSNHI4O+sanoQcCdqKZTLDT7laXrwMfCqaXqkvF6v+YJ3qdo
	dilogSYOSPpfScN9CnWoU1G67ukgQIi4ps/ncd70sWULgm6+i09FsJ78lDyd5wzZqq4oGi9mdWsnx
	oo8iqSf0IqMg0oue8xyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giBov-0003Qa-8E; Sat, 12 Jan 2019 05:26:57 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giBor-0003PX-CD; Sat, 12 Jan 2019 05:26:55 +0000
Received: by mail-wr1-x444.google.com with SMTP id t6so17259883wrr.12;
 Fri, 11 Jan 2019 21:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q5EImY5HnTtrEi8D7L257uaW3HbA5eOwRdm1AAXWagU=;
 b=XfqA7YNjltAgoq592DD7HNuKG2DnkKJneflzhIgLUMWTuhg9TkMvB/YL/ei0EMG6Aq
 I5RWINnDjrVZBv/QWvtFJgbjL4fP1Dq/rWyJBDCLx7SFLZI4lOXb3KVaq5Hi19hYmqWj
 oSOcO6+lpVBvyTuFtXMzeRQoQuk8HwsBv815c0X0gihD6/USwIevsasQC9ChYFtB+8hX
 ure5yGNVBbZZMneSl7/D18pcVD/xqcL6/SB1BUvZrG6mjC81o2BU8NPhHyFvtQWwA1dr
 DOVwePenxbUkJf0GtT5F3P/j7MNE8EcDbvpCUaKv2dUj5dSMz1Vzka5fCJE9tpAP8OE8
 YlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q5EImY5HnTtrEi8D7L257uaW3HbA5eOwRdm1AAXWagU=;
 b=YbhrIJtRjFLEJhNMa2KftvSjwix/YQ1yAb3W5d1DI2t57iSOlftU0/59Wu9oELgtFA
 h06aqUVAKwJBqFP9TwkLR8lEp8tns71zsCV/ZTAYHT1X5hr08b6szUp1yP8IKKTTjKuu
 oLZQpIDnr2o750ewWLkDYjV3VGX1dSwXox3D4Z5NH/TO8bDf3Y+kkpbdl5Gb9MQ1KeV5
 dE4+Ft87yMX0dTYQb6F42dDXLCzALMTFocxlmQb454FmHrc3cc3MMSvI+RTZdvA1fXky
 XboREvL6zM/q6bPp1bpu8AVLhPWxyDlKJs3EavvPiQ/iClYJMQHl2X2uuhcue7TjoZQ5
 Qg5g==
X-Gm-Message-State: AJcUukctaTArmyEDokGFohpAF/Y9K8N/RbcsZCwk/HZVQBxV+rGtwHxC
 TkpvnKOxZEOIma1s/0dEi+S/k6gN5ijJqMdYODNFTkseaPaBuQ==
X-Google-Smtp-Source: ALg8bN5ZpWVx3jHfs1fmoh369oISBWD3/ed9i9xJ4Pn06LqzhoBzYjVllVvMofuXgwwPiLquzDDrM6CayWb91MjjNSA=
X-Received: by 2002:adf:e509:: with SMTP id j9mr17069158wrm.76.1547270810152; 
 Fri, 11 Jan 2019 21:26:50 -0800 (PST)
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
 <CALeDE9OZpGVD4HGxCqjtWf1qCXxkH1YAAM28na7tBvFyRpHJow@mail.gmail.com>
 <CAAoAYcNUp2fjdqHgae6wTaL6i7ztfn4zUxri1EjbBatgQb76NA@mail.gmail.com>
In-Reply-To: <CAAoAYcNUp2fjdqHgae6wTaL6i7ztfn4zUxri1EjbBatgQb76NA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 12 Jan 2019 05:26:38 +0000
Message-ID: <CALeDE9N06YNw-o18sBRx0Jj4chL=5UeJdbDgWzx_60dpHCQFDA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Dave Stevenson <dave.stevenson@raspberrypi.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_212653_446153_7A4A3F66 
X-CRM114-Status: GOOD (  23.50  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, mikebrady@eircom.net,
 Eric Anholt <eric@anholt.net>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > > > > > I get difference results with 5.0-rc1 but neither of the above apps
> > > > > > work either, will follow up based on the rest of the thread there.
> > > > > >
> > > > >
> > > > > My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:
> > > > >
> > > > > start_x=1
> > > > > gpu_mem=128
> > > > >
> > > > > AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.
> > > >
> > > > start_x=1
> > > > gpu_mem=64
> > >
> > > even with those settings i'm getting a picture in qv4l2 (v1.12.3) and no crash.
> > >
> > > According to dmesg i also have 64M reserved for CMA. How many do you have?
> >
> > I have 192Mb of CMA with LXDE, the vc4 driver uses CMA rather than the
> > gpu_mem via the firmware so that's what we set it to (and to 256Mb for
> > GNOME)
>
> As Stefan says, with Raspbian the default gpu_mem to use the camera is 128MB.
> The memory required depends on your use case as it includes the
> buffers for the output images.
> Checking on a running system, a V2 camera streaming 1080P YU12 with 3
> V4L2 buffers is using 58MB of gpu_mem for the camera stack. H264
> encode isntead of YU12 and it's around 63MB.
> With the vc4 driver loaded there's only a small number of other
> allocations left from the gpu_mem heap, so it's around the 70MB mark
> that will be the minimum to get the camera running.
>
> > > Does your qc4l2 make use of OpenGL (not in my case)?
> >
> > Yes, mine does. The crash with qv4l2 was only when I tried Cheese
> > first, if I reboot and just use qv4l2 it works fine when configured
> > with 128Mb without any crash. Which display driver are you using? Are
> > you using vc4 or the proprietary closed one? With vc4 using cma rather
> > than gpu_mem I wonder if we can reduce the amount needed there, but in
> > the interim I've at least now got picture output when using purely
> > qv4l2 and a reserve of 128Mb
> >
> > I'm not sure quite what gstreamer1/cheese is doing to cause that crash.
>
> Can you confirm what resolution and format they are using in your
> failure case? "v4l2-ctl -V" after they've been run will tell you.

Format Video Capture:
    Width/Height      : 3280/2464
    Pixel Format      : 'BGR4' (32-bit BGRA/X 8-8-8-8)
    Field             : None
    Bytes per Line    : 13184
    Size Image        : 32485376
    Colorspace        : SMPTE 170M
    Transfer Function : Default (maps to Rec. 709)
    YCbCr/HSV Encoding: Default (maps to ITU-R 601)
    Quantization      : Default (maps to Full Range)
    Flags             :


> Your earlier request:
> > As a side note it would be a useful debug feature from a support PoV
> > if the following line could also note which firmware is loaded:
> >
> > [    8.087691] raspberrypi-firmware soc:firmware: Attached to firmware
> > from 2019-01-09 20:07
> >
> > Something like "attached to extended/reduced/whatecer firmware from XXXX-XX-XX"
>
> A very valid suggestion.
> I've made the firmware changes to advertise the build variant and
> firmware hash via the mailbox service, and that should be in the next
> firmware release.
> Pull request https://github.com/raspberrypi/linux/pull/2806 has added
> the Linux kernel changes to our kernel rpi-4.19.y branch.
> With the updated firmware, "vcgencmd version" will also report the
> build variant for you.
>
>   Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
