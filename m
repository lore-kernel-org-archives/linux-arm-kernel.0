Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4845C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F11214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iplg1e16";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+beiec4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F11214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dC4+jxiVifTD+Hm+lnPfCwmYMQB8peIUl08dOaMw8gk=; b=iplg1e16sw4GUE
	a3ArYBltEwBZesktPhB1Q8VzblXlf54mSLHFMnz3FqOe9UfDrX78cHhKkCBs9Wmi9JvXmLyI2u3kH
	dmxpMpdfgbHFDXpnxE9u1eCpLd5wUueDsNwyMVHrvyz/MHONdE1q+4hxEh8eQwG6XKUDglWv6rqb+
	CUwlivrjtv2g2FArJ3G0XJlAEF5yQ3joOMAtxjkfL0xu2UQgTsbvoCWc0hns40VmkLjA0VcDRsW7Y
	Mar7UlxSJbvVY22pCki94uCjMmYVo6aBURVCCRArZS26zt3D+y8+YvbOT0pWPQl87q7tv8A2eCe5r
	+fYj2zTllqzhgl4n7/7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghSnW-0005Bm-J3; Thu, 10 Jan 2019 05:22:30 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghSnT-0005BM-7U; Thu, 10 Jan 2019 05:22:28 +0000
Received: by mail-wm1-x342.google.com with SMTP id m22so10683408wml.3;
 Wed, 09 Jan 2019 21:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=brDme0V9c9SkRRLD/NqoKdN+XhY5qkzD3KGdD01xm8g=;
 b=i+beiec4andtuXGRqzGG3gsXHsyMVK3TJSTmxEPrmf2DnzzjI4/U3vfswPD406FokK
 RCe2L5tzG9mxNqwQOP/gNDKle2tMINAfKoDZqFMmxpFSsxuA17Rr7a0GlMzAhpCRKukH
 vSdXCiI1mvWKkDHOK9EB/BKE5DpcLl4lcv4LN+wv5kLB0RRgFzpqer3/1QQuJQg8p2DX
 QPe43RuyM+/rNY4fsANVget1x8lH8B1PTd3iIVjB4QeAl0cFeu+mN57yawNzp8YdEX6k
 pmTFkiRsmjS7CjykLehmvTrtbr38QeOpnuPl6GT1QIYAYICLkxJLcJ2eAueNOJNiMJTx
 pnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=brDme0V9c9SkRRLD/NqoKdN+XhY5qkzD3KGdD01xm8g=;
 b=ebb4gs3iJ6/SEVICawl8GDR0146xI1NHmpZ/sRxlN5tv89xi2DKtXy//2kANGECsm7
 TAWM87KHVxzbW4gtkHd3mia8t+MCP6RfDekrDtft1MkhPUGTMhj46ixeb5FGvVTy3DCu
 39fhdexfhprOKEbcEjoPWzUD+gutLm+iVoBtIoQQKtViteEGzOm1fVDi0Yu9pQg/J6kB
 oB5cU9byWmyst6WWBALsnQJ7/07FNCRDIS1kNEALjqs5zrbZuvNokYN0vrQ9iABoG8lg
 kK57ZZynF9k9xPcxIvL0sKOl7gtKlnKZ5m4A0X6pFiczeEycjPSRTyqGN1ltc5R/OVD9
 pwcw==
X-Gm-Message-State: AJcUukcUQ/om4e6eaLPP/YxcUNb2SeyeCaCSFbNxowU4Sl4TvZE+7vtN
 tVySt1OdEtnu4XlPbU5iYPAVnqr7cxUuW8U/vsA=
X-Google-Smtp-Source: ALg8bN7JGHhAwM4DZl+VM2kwLU5w2MHpjD4V1YlOu3whtcjBhCdbrnr+/a+OF+Qn+VoHxgoiDRB8f8dUkbAyd7X0aXE=
X-Received: by 2002:a1c:be11:: with SMTP id o17mr8071882wmf.111.1547097744671; 
 Wed, 09 Jan 2019 21:22:24 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <CAAoAYcNJdzJW9X=hr5+5oAFWcVUexwY9zGQ_-T9X-M89jpnipQ@mail.gmail.com>
In-Reply-To: <CAAoAYcNJdzJW9X=hr5+5oAFWcVUexwY9zGQ_-T9X-M89jpnipQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 10 Jan 2019 05:22:12 +0000
Message-ID: <CALeDE9NxRQ-1P9N_LK18qB4UZsdbonxRy=SaSGnxAfm23utrYQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Dave Stevenson <dave.stevenson@raspberrypi.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_212227_296784_E87FDA0C 
X-CRM114-Status: GOOD (  21.57  )
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

 Hi Dave,

> > > This patch series improves the load/unload of bcm2835 camera and audio
> > > drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.
> > >
> > > This series based on current linux-next and Phil Elwell's series ("Improve VCHIQ
> > > cache line size handling"). After Nicolas' series ("staging: vc04_services:
> > > Some dead code removal") has been applied, i will rebase my series.
> >
> > I tried testing this series applied to 4.20 with the camera module. I
> > tried with qv4l2 (from v4l-utils) and using cheese, which in turn uses
> > gstreamer. I basically get the same crash for both options. Desktop is
> > LXDE on 32 bit Fedora 29.
> >
> > I've not yet tried with 5.0-rc1 but it looks like it has this patch
> > series and some other bits for the vchiq drivers in staging.
>
> I'm trying to sort the patches I have on our kernel tree and get them
> in a shape to get merged to staging.
> I've built for 5.0.0-rc1 and also see the same error using:
> v4l2-ctl -v width=640,height=480,pixelformat=YU12
> v4l2-ctl --stream-mmap=3 --stream-to=/dev/null --stream-count=300
>
> It's three independent things:
> - The firmware has failed the failed to enable the camera for reasons unknown.

OK, with the extended firmware enabled I get the following boot
messages before trying to access the camera:

[   27.541690] bcm2835_v4l2: module is from the staging directory, the
quality is unknown, you have been warned.
[   28.203301] bcm2835-v4l2: scene mode selected 0, was 0
[   28.203882] bcm2835-v4l2: V4L2 device registered as video0 - stills
mode > 1280x720
[   28.219128] bcm2835-v4l2: Broadcom 2835 MMAL video capture ver 0.0.2 loaded.

Any idea what I should be seeing besides this if it enables it
properly, I get different errors if I don't have extended firmware or
not enough memory.

With Stefan's upstream commit 4cc357c500d (staging: bcm2835-camera:
Add hint about possible faulty config) he reports "Not enough GPU
mem?" but I wonder if it's more accurate to report that the wrong
firmware is loaded, I've managed to get that error if I have enough
memory and aren't don't have "start_x=1" (or have start_x=10).

BTW what is enough memory? It seems 32Mb should be enough, tried with
the same results with 64Mb too but I've not found anything explicit
about features vs gpu_mem, until I've started looking at the camera
we've set it to 16Mb due to using the open vc4 driver, but as other
things start to come along like the camera, and presumably accelerated
video decoding, this seems to affect those.

As a side note it would be a useful debug feature from a support PoV
if the following line could also note which firmware is loaded:

[    8.087691] raspberrypi-firmware soc:firmware: Attached to firmware
from 2019-01-09 20:07

Something like "attached to extended/reduced/whatecer firmware from XXXX-XX-XX"

> - The error path then hasn't returned all the buffers to videobuf2,
> hence the warning from videobuf2-core.c:1468
> - The driver has then tried to pass some buffers to MMAL / VCHI which
> tries adding them to an invalid list.
>
> I'm investigating why the firmware is failing to enable the camera
> initially, and then look at cleaning up the error handling.

OK, let me know when you've got something you want me to test.

Peter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
