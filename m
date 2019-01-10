Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF94C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:45:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C4220685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UwsTBS4Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBE7ACjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C4220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D4pigctqUvX43uRCvMFyI+A4Ta7ohLcIOesAzHsbUUM=; b=UwsTBS4Y+XvzSo
	Grexwl+xiJKGb+lyF4pYgY5w5oGH0hhOXdg3FAL/HSgs4A7GxyOb4g5fGo2bCVO5sa/t1uojv4f41
	04rP1Cw8q5RCvzqLYNx81LZXJYu4r7vrssmY7Ev2zJRepPp0JR495hVfKZeeKS+qJocaYpfjB2Wid
	rsnNh90oiaTky70iE/EcrJILB90gsY8zdJ4FxpRjMZl86v+SmPuksKn8O2nzH0eEPqfcGpV9MJEil
	r9UGgxX3RKXllmXWN+UaVxVZMfpf9tNsMEgK+KS1wBhA6G2K0m5q1oNB+H9fRQJ7rqIF5TTxJ/sL8
	BX2nBW/OsP+sgh0ZFSJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheOJ-0004lf-Hz; Thu, 10 Jan 2019 17:45:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheOF-0004lG-Td
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:45:13 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0EA020685;
 Thu, 10 Jan 2019 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547142311;
 bh=KNQUK2yuRv+Ya/H3gziEtNCNwmfQ58I0jmwXolJkOhk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XBE7ACjkRRimbpr32uswmIQ/aYHa6CFWZf/CHZQGn8Ash+fl1aAA6eUgdSIY6kmSi
 R7yAoEhHkGQ5niFe4zE69kBO5a+HKSpdhPXKlhzNCW2zX2tiGU9CUb+UA3OgD0MS7+
 ZHcxJXYWSgldXY+hj4A9sYupUMEsFB1PdHIbDxqU=
Date: Thu, 10 Jan 2019 18:45:01 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190110184446.75b4350a@bbrezillon>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_094511_974900_A955334A 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 15:10:28 +0000
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> I found an unfortunate issue while recoding plane handling to use
> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> which is not correct. I simply fixed it (patch 1/4), but maybe that
> will cause regressions for unsuspecting users who simply assumed
> that the clockwise rotation was correct? I don't know what to do
> about that? Adding an option to get the old broken behavior seems
> useless, wouldn't it be just as easy to just fix whatever app to
> rotate the other way instead of adding an option somewhere?

Hm, rotation support has been added before the standard rotation
property was created, and at that time I assumed rotation was clockwise
(which apparently was an unwise choice). Anyway, I don't have a
solution for this problem, so I'll let Nicolas decide if it's
acceptable to change the rotation behavior.

> 
> I have only tested this series on sama5d3, but I did check the docs
> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> and sam9x35) supported by the driver (relevant to patch 4/4).

Thanks for addressing those problems.

> 
> Cheers,
> Peter
> 
> Peter Rosin (4):
>   drm/atmel-hlcdc: rotate planes counterclockwise
>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
>   drm/atmel-hlcdc: fix clipping of planes
>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
>     frame
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 179 +++++++++---------------
>  1 file changed, 67 insertions(+), 112 deletions(-)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
