Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69115C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E680204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JP9pxdfu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOj/wo+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E680204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yYsbVjBXCZDQCQnmlADlM9BjV7Ga+mbwZiommv/Mi3U=; b=JP9pxdfubIU1JX
	Le2OVLZnclc/HZdGfuqCnJTo4dNNyRA7I9z553i1I73WzpaFOBVyyyYnQlV4R7fPnMceuxwzsQEEh
	5igCD7496wGLsToF6hFTySWhUdEfHDdh9PQsS1+F7sh/6Yiar6OVKgvgdMSk4NE2KMoK+brZTXkkn
	iQQb52xZ8OH9sqGlOB8/tKIRgf6ID92xIvKqwm9ppxKgjwqU2gowqnw0Ekd6B4bnA51DerK85UEcQ
	VEzro15cqQt2b4qYIbY9X2NiivVxi2cX/jDKUrdIbHwX8bDyqWgRONL4eSyDPYLU8bwzHDoqFsFob
	n3WzOGFsx6VADkNwthHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWgy-00018i-Qv; Wed, 19 Dec 2018 07:54:56 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWgv-0000t7-Es; Wed, 19 Dec 2018 07:54:54 +0000
Received: by mail-wm1-x342.google.com with SMTP id m1so5059496wml.2;
 Tue, 18 Dec 2018 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LVz8XQy8S3syubEB1IzYIOPAmIXQT9zLbADj52/Vct0=;
 b=hOj/wo+iOJsCQ405ZhbFZzmxAzrCOTPjWNEziOGVtkZ/k65Zhiq5U5am/0Tu/EcJ+e
 zSumNTvjLmVonOS4dHp7E0ru9rW9jh+cbvQHXut+atskJTKJtP+WyiF6yT6+VEatIGn1
 h/RQF/e6Tam0+kPiRioO67N1hUyUE8Nwphi0lIutVtRoKecOgms2+iQG0IRqIRj5flLY
 fq7/2WqkztD5oazTR2tZ2PdhwICITIAKU/c+w/5DfIjm3sC0hVhbtXKMx+1okQmGNCBw
 W0m+WRPEGXVzHSOzbKmhFQf3vVtPZdwOLxP37wppOZBw9Ms0Yc1AElKVLMnL6aO3KjXI
 WMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LVz8XQy8S3syubEB1IzYIOPAmIXQT9zLbADj52/Vct0=;
 b=IqZ3udDinRWcLTG8fY1g34P03B/mjAZEwajKTULt8leYSWtJATbgCQ47asigMZCXSW
 bGHGqwRsEv0L/VFlJrp92iie2o/nyOvvtf3l+3SM8yAMomW7GH9+NSKY+fdvll7EnYFC
 9jAOogSCS3gkcVxRZE2CGhJIQ5NhAsetsOWZEuB04fd6ZIKD1BSUNP3cjOTvbN0MNxQp
 DR5YoJ0DIOigRZtrYqnnf8nzFDIWBPRrfI+Xoc2RIT43he/FNNXasDnj9/L4v7RiucKE
 gMBYDvjjwprlPaCDDRmcEtqbO7eOrZzKmXvR9ZqfJu5//y5GX+vAGREbRXrgbaUUJYqL
 zrIw==
X-Gm-Message-State: AA+aEWatPl6RsdrSX2HuZoCGeiwe1kfaMsSzBdBJLnPwhthln1pc99AP
 OxN5X7ShrsjLPm4o5Q4nsuWDaPOUvTd6qlrKae8=
X-Google-Smtp-Source: AFSGD/W479tMpk0K0mrc59w0M7mOKbMyP7QEHyAwzvJvQgnXm5jSIOXpmC1OjfhYn1DlOPYp8MlDjJX7ebQshcY6xs8=
X-Received: by 2002:a1c:be11:: with SMTP id o17mr5930812wmf.111.1545206081910; 
 Tue, 18 Dec 2018 23:54:41 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <1540481375-15952-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1540481375-15952-3-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 19 Dec 2018 07:54:30 +0000
Message-ID: <CALeDE9McktTeHDpAuQJt_rYKJuDvHRXObEd9aStm=jXWhZZp-w@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] staging: bcm2835-camera: fix module autoloading
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_235453_503823_B7F05A35 
X-CRM114-Status: GOOD (  14.09  )
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
> In order to make the module bcm2835-camera load automatically, we need to
> add a module alias.
>
> Fixes: 4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform driver.")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested with a v2 camera module and kernel module loads automatically
as expected.

> ---
>  drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index d6fbef7..7d3222c 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -47,6 +47,7 @@ MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
>  MODULE_AUTHOR("Vincent Sanders");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(BM2835_MMAL_VERSION);
> +MODULE_ALIAS("platform:bcm2835-camera");
>
>  int bcm2835_v4l2_debug;
>  module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
