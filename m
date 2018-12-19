Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E400C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:53:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B7B21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fkOXcADW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbrvZotH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B7B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bT9wZXHGRJIMsWoJkYR7GlVNVfnRGwACdn9KEjiEH34=; b=fkOXcADWaY8jXC
	0OgGgC9Z9R1uqC2fXTPL3OfU4S5KLqh0WGKvqWi8zj/zGpeHessfL3sH2q6mVBlt8zO9G5phJcXva
	mGtJOn6EN6XBICTgyMtHyJK21ErjGOWHAiR5jgs7PW7hUox8sdPd9DO4LtqiLhq80jrqsIFiwCZ4B
	uOu3GMWvvEAgog+MZ4Z7lM3ZCS9mjrFL8Umu5p9lBDCukpX7DUTdS4J1T6XI1mSLyMU/fnuiHv8V8
	wmBTbOyeyEGR950ZHvk69rKdYEDfW5TkDSws2rtxywvPrEZA1l8Mp6Zl1/da3Pq8NvsOkIPe0uBzj
	iAx5XhTUcrDEV0uuhUxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWfh-0000Wf-L0; Wed, 19 Dec 2018 07:53:37 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWfd-0000Vm-QY; Wed, 19 Dec 2018 07:53:35 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so5067858wmd.0;
 Tue, 18 Dec 2018 23:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6K6EYOUe/E+VJRf7q6cwYceJD486XbsJi/37EkOFMuA=;
 b=YbrvZotH0kylnt81ATu3CQrSv3JMI9/aE90aQaSZ6ALaunb4qWLKSy+PW0Q6vdsixS
 I1gF2odcjX71MKE7VP5RmD8jHRmIxnwRl9K9DIbgobTsGp4EPu9s9AK2YhY8w3T1prR9
 ivw/YMV6r/y4dzsbwCvRqQQ8j3LWfQ6dqcNnHgqet9IDWSpdXxundGX8WexNMeMY7PLw
 2GIs0+lPfBIvZ0eu7hcLiV8B8Urag42VaBJjHVqYgYVD2vq389jjr4VEcFwrRpqq3aPm
 CcUe/3RG1x3DXu1kfclZUhhPQ143NAaZrrzyKXb2WS8iSHlvzZihmpjVWsRZiid/mEvZ
 WzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6K6EYOUe/E+VJRf7q6cwYceJD486XbsJi/37EkOFMuA=;
 b=ldE3bSYdAFqi4/PHssbylDd7IcwACNocKVRjZqEehRf7o4KrOa5IGSn934TtvCMEKK
 9TNneomHPjh3kgrmGNynHpiUXuMN6dwdZ1WNpz32oWYAYdY34lvqMIFETkc/9y+KFjP6
 FZIuX+Gto4nd1IzW1Iy8PSbIOTE+pNniwrSwjVWAC/Qx9Hc8MmExTRfdB7oMXNcCZSxj
 BHQpBXiljnVgUHgfAgt6O6A3v0swVVBWnFwuvGvSv2RA7aiovJ6ducxU7m0rVQsFBO33
 +BW4faU6IHxRGeWKc4g0VbEKZTDDuU5f34LassGVb3+xtbEF6gCCxfTFDfZ8CRcy8kot
 WMoA==
X-Gm-Message-State: AA+aEWaFjlD2gZTDCcSIdGUcIrR0gwQ234Com1O5CvSiIwR4wQ0VRMyH
 BjVRYef/C8N5HkaC3ZDfKA/UpMBkImhqGcsliBE=
X-Google-Smtp-Source: AFSGD/VpAMJAFK7KghK4IawgVpJvo28uO1thcsROp/wENdi7eQaD7BxmYctyZMUPwDBhaJd5sccIFS9e9TVPUUPbl3I=
X-Received: by 2002:a1c:1593:: with SMTP id 141mr5922877wmv.85.1545206001244; 
 Tue, 18 Dec 2018 23:53:21 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <1540481375-15952-4-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1540481375-15952-4-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 19 Dec 2018 07:53:09 +0000
Message-ID: <CALeDE9O7i7ZDLSaGk6ZD_7ou2YUnNR_apAwwhgnikrFTU951=w@mail.gmail.com>
Subject: Re: [PATCH RFC 03/11] staging: bcm2835-camera: Move module info to
 the end
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_235333_864613_028FCB66 
X-CRM114-Status: GOOD (  14.67  )
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
> In order to have this more consistent between the vc04 services move
> the module information to the end of the file.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested with a v2 camera module.

> ---
>  .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index 7d3222c..cd773eb 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -43,12 +43,6 @@
>
>  #define MAX_BCM2835_CAMERAS 2
>
> -MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
> -MODULE_AUTHOR("Vincent Sanders");
> -MODULE_LICENSE("GPL");
> -MODULE_VERSION(BM2835_MMAL_VERSION);
> -MODULE_ALIAS("platform:bcm2835-camera");
> -
>  int bcm2835_v4l2_debug;
>  module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
>  MODULE_PARM_DESC(bcm2835_v4l2_debug, "Debug level 0-2");
> @@ -1976,3 +1970,9 @@ static struct platform_driver bcm2835_camera_driver = {
>  };
>
>  module_platform_driver(bcm2835_camera_driver)
> +
> +MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
> +MODULE_AUTHOR("Vincent Sanders");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(BM2835_MMAL_VERSION);
> +MODULE_ALIAS("platform:bcm2835-camera");
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
