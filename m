Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84F1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:48:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71B6208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k9dpPEKw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqHxnX1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71B6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w1Ocv3i6LCDJUncgeY0v6F0UGt5TJoh9cGTTks8kJ8Y=; b=k9dpPEKwEizG8K
	HIJOK5SnI/879FYLkNKtEM5CB/VN1Exhc0i8I1xg0JkcyTg4CHLzSL035r01uuTVjeTwipi/0gMzw
	0MYSpTeaQ+eHzwWihWUo5gDUB3kd88FNTBH+tUxG8U/u3H7YiL2aeGlZ8WLe3pICPcu89iogZcHun
	fKH6J9ThPHW6k3QUGmwOOD6CLTPhGwdw/MQ8HHjuj2syVJvGW+RQLs3cfbZZKekUw1l2eTB5tF+AI
	1rr5XZoL5Nj8KncDaFl5sIw6Gu6IzsFPspUacEAjjBs5NtFiFS1380jEAbq3+eNsHk3LYCjw6HkVA
	DFyHfIpHy0r06tOpmKCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheRc-0005Bz-Dj; Thu, 10 Jan 2019 17:48:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheRW-0005BF-SP
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:48:38 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F8EF20685;
 Thu, 10 Jan 2019 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547142514;
 bh=xYOCS96HW86Q+ESJdvapp7SjBLQTTrQ+OilUo7KtzFI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tqHxnX1Lfk9eQmtwFJQK0PTsjuSmXKFG0qZ/8i2JAJPtRVLn+RUe0PC1q9YnxrY7I
 kIjJ4XL8YZR/tJcljC07osZtaDbyTpAuceVhi1d6yEMrKXMbR6RWo+Ss6TpzIXSq40
 EJJTUjd6gAkBCZyvoNHWKcdUaV30UWJ6OGEh7Qhg=
Date: Thu, 10 Jan 2019 18:48:25 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Message-ID: <20190110184816.63350396@bbrezillon>
In-Reply-To: <20190110151020.30468-3-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-3-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_094834_934234_38864D9D 
X-CRM114-Status: GOOD (  12.97  )
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

On Thu, 10 Jan 2019 15:10:39 +0000
Peter Rosin <peda@axentia.se> wrote:

> The destination crtc rectangle is independent of source plane rotation.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index ea8fc0deb814..d6f93f029020 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -642,9 +642,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  	 * Swap width and size in case of 90 or 270 degrees rotation
>  	 */
>  	if (drm_rotation_90_or_270(state->base.rotation)) {
> -		tmp = state->crtc_w;
> -		state->crtc_w = state->crtc_h;
> -		state->crtc_h = tmp;

Again, I guess I assumed ->crtc_h/w were the width and height before
rotation when I initially added rotation support. This change might
break users too.

>  		tmp = state->src_w;
>  		state->src_w = state->src_h;
>  		state->src_h = tmp;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
