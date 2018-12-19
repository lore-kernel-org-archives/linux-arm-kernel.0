Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:08:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3485021852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FyAk2YBe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tw8/zNOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3485021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g9/dd5IDknRAYGqQa+JsWn6ndh+qfEbHtg8n28oB3KY=; b=FyAk2YBeWYez+l
	sPPdllf2e3s/073KHDwvcZehzP08j+s9N2eT+0C1mDP1HX+BhGp4UHUv6s9yqAPx3l++zavu3E1kP
	pQU9zmIVFnDUImHDS0TczL7pWPK4k4zWMBOZUBJuJc4dmq34waxeyVHWkdUkQAHWIhEyhhiCcSJpR
	VgorMrK9GwTvMru60d5cXIHZNXvhoyywbL3M+1Ih0cEgldkm9QYJqdwAsLnEjQ68tzJ862bM/lv5b
	CfEk27qlgGRpOpRBVgWEWmQmHFOLilK/AyvJweUg6Afto96NS83djzvTwBT2VKmvmKEdwK4v+b0CC
	0jN2tgzdmYZ2GxSfhZTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWtd-0007u9-2g; Wed, 19 Dec 2018 08:08:01 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWtZ-0007tM-Of; Wed, 19 Dec 2018 08:07:59 +0000
Received: by mail-wr1-x442.google.com with SMTP id l9so18429726wrt.13;
 Wed, 19 Dec 2018 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xchlq/2eGF8BW1jyx5Te4paWrshTmePBj9xG3tgq4o0=;
 b=tw8/zNOgNO9o3ffcZQiJdjUvsJnCL7bLipyIDLfHN+75v9ghTJnOHLo21unCOEPIf7
 JFFTI/eXGKk1jLrVxbrchUijH+JR0RqDOyBtjLyKiIzwOeUxePnN4HUX5Fu1GG1DGF/C
 RdxANvpWBTYsBnzOzVPWwfgYOOOgzSvZ16uo26SOuZMpghf48mxjDSGx/OJiX3/sZtzo
 hq2KqMftgwRrMAvrCatyyCz50GDEnCbw7WeqlhSRTqqVtuM/puQhqjztfnXDrBNosy2t
 pjh1JowwZou43aY+6zaLTrPHQXeJtiySHa8Vu9ixm7XoTAzeVFL0saEjWZOiPUuTlxcF
 x57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xchlq/2eGF8BW1jyx5Te4paWrshTmePBj9xG3tgq4o0=;
 b=UZx0Co1aNeFN/OWmSgrKOxsg4w8gXUOaMFBp5J26rHpuiLb4GZNGABDKS2pnV28OyV
 A2DdsjJnB4fJe90Bjx3MtjobmtrHr2R+llOGUZGYySERamPnAJzIZ/zfF8TuktVxcm3k
 Zk2MtKjfVromqEOoYs1RvL/SAABetVoU27TZZCtHnb9Yyi9cL1N3VxB8Q7CWnx4YC2EC
 eouOA0vdd5DodZhX1aE3iHXwR9iDZiSUMPLCwntD9CqlgyCYS54+0L4aJLktSYCWUYiG
 sxZN8rnTsvMePn/1QnhsTy4jeqc50b6bntTz0f9xlEktlkVFx9z4OaNFPkqlV7X/QIq6
 uRcw==
X-Gm-Message-State: AA+aEWbCrYw9VDpPMgDQQ/sAHJSqttQXZbDy+9dBSZdHW12x9CAbUuT9
 ZFfxTA580y2pGdn8MIwXom/hDfTqsiLKv+6bS58=
X-Google-Smtp-Source: AFSGD/XjbWxXRa281LenHQ30EO1iKpcXwiA+cupg8d+/PtNwwEpwv9rl/xYFrD2fIk3XeEsG1gjifkPUZNMLX7vVjLQ=
X-Received: by 2002:adf:83e7:: with SMTP id 94mr17657084wre.278.1545206866055; 
 Wed, 19 Dec 2018 00:07:46 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <1540481375-15952-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1540481375-15952-2-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 19 Dec 2018 08:07:34 +0000
Message-ID: <CALeDE9OvitAob7PM7zYTfJZx=enH_YZSiTDzgD_8NDwWJhdLow@mail.gmail.com>
Subject: Re: [PATCH RFC 01/11] staging: bcm2835-camera: Abort probe if there
 is no camera
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_000757_803885_7433A299 
X-CRM114-Status: GOOD (  19.84  )
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

On Thu, Oct 25, 2018 at 4:30 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Abort the probing of the camera driver in case there isn't a camera
> actually connected to the Raspberry Pi. This solution also avoids a
> NULL ptr dereference of mmal instance on driver unload.
>
> Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

In testing this both with and without a camera module attached it
appears to still load the entire v4l stack even if there's no camera
attached and it remains post probe, the /dev/video0 interface doesn't
appear, which is what I'd expect, and from the dmesg output
with/without a camera module it certainly seems to do less. I'm not
sure if it's possible to detect whether we have a camera module before
we start up the full media/v4l stack and exit the process and unload
the module but I suspect having all the v4l bits loaded without
various interfaces might cause confusion.

# lsmod| grep v4l
bcm2835_v4l2           61440  0
videobuf2_vmalloc      20480  1 bcm2835_v4l2
videobuf2_v4l2         24576  1 bcm2835_v4l2
videobuf2_common       49152  2 bcm2835_v4l2,videobuf2_v4l2
v4l2_common            16384  1 bcm2835_v4l2
videodev              180224  4
v4l2_common,videobuf2_common,bcm2835_v4l2,videobuf2_v4l2
media                  49152  3 videobuf2_common,videodev,videobuf2_v4l2
vchiq                 237568  2 bcm2835_v4l2,snd_bcm2835

Peter

> ---
>  drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index c04bdf0..d6fbef7 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -1841,6 +1841,12 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>         num_cameras = get_num_cameras(instance,
>                                       resolutions,
>                                       MAX_BCM2835_CAMERAS);
> +
> +       if (num_cameras < 1) {
> +               ret = -ENODEV;
> +               goto cleanup_mmal;
> +       }
> +
>         if (num_cameras > MAX_BCM2835_CAMERAS)
>                 num_cameras = MAX_BCM2835_CAMERAS;
>
> @@ -1940,6 +1946,9 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>         pr_info("%s: error %d while loading driver\n",
>                 BM2835_MMAL_MODULE_NAME, ret);
>
> +cleanup_mmal:
> +       vchiq_mmal_finalise(instance);
> +
>         return ret;
>  }
>
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
