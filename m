Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:30:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A5820675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKvFuGLM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iCKaVeiX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyJWpk8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A5820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ykFrErBVz33eW9ws/eliuXnLpAWR3Tqacbcr1UVZAHU=; b=oKvFuGLMT5/rlp
	iCovUBAl+FoiCx/Tnv0bDmZ1QgA7BHKXUfaIo8HdOduNJE9+EqKSHvdrYIm6hJNidREgtE6XvAEle
	fuCfIhxAcoHb5fRd6W0RGXZFzO+hazSL0yaLY/rM71Rr9MRbrux86QEWT3Q9bYoXm6VnCo0llTc/z
	sk/4K3hH1d+D9Li4UHPcDqbnm9j1Xdx0uurjvjcE2TiAWiHTAUxFLS9dVrJ4T5XebPfea8dJ1CReu
	wM0FJr/CLYxfgM9dD5SJ2a44ycx+4NkS9d6bkO1uh34cI+16l/NhInT13GfIYKGFxRiCCXm8g3Z9p
	qMbrleo0Bo/TS7B8CukQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghe9i-0005BR-IH; Thu, 10 Jan 2019 17:30:10 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe95-0004R6-E4
 for linux-arm-kernel@bombadil.infradead.org; Thu, 10 Jan 2019 17:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1eJAYllhYBxC4K/ZOvI9Ck8pvFks/t7mOPGeMfP+Wks=; b=iCKaVeiX62glGVdsQIIkj35DmU
 gs2+hhbMkgpc6xQAijBf1cVsjHC9MLzJECutI+2M/tk5yAO7KCWl6RhjYkCG0c9YAFriSIpGdyjr4
 5lSWrv2JLNyc1kIxqOKJThbhv4lI9Lk9oixPopRVXN5fg2r8BN21QgWk+muyKl/ncTQcq5WbQlQgU
 KserZSJYwHqJi27wq1PvFA22Vb3L6lVHGYDRPvdehMgH1lDK0hvRdr8mYSKs3fzpHofz0UJQIqOqb
 Yq2jIa0AgIBTwjSbQDsE3/LbkhjTCDN8ChW88/feUFNHt2g6CSkuUJBkhFNObi8iOMjsN7Ih8mnWn
 SHo5Yc4Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe93-0005tA-KC
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:29:30 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3E4920675;
 Thu, 10 Jan 2019 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547141366;
 bh=q6nzpHw6PA14SiZLCIxsAslUipB3CPV2u5tQO8zhUJo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RyJWpk8pjrRaAOV75OxxxUhQ+LA0rxZMfWmPJJZ7OjrEnAEwq8s6QyjuSkyCAo0fi
 OnBSl1kMX6h5NGG8myMlqn2DdZ+xV9EOFCU40DwFdZpPXFKzBdNshsfwzwSslLnhG1
 v6b7NpG7nLVXNNhOVuT0TVJio9TgIvMHRllUEaGI=
Date: Thu, 10 Jan 2019 18:29:17 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Message-ID: <20190110182904.5efd08f2@bbrezillon>
In-Reply-To: <20190110151020.30468-5-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-5-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_122929_734014_353F3E04 
X-CRM114-Status: GOOD (  19.81  )
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

On Thu, 10 Jan 2019 15:10:48 +0000
Peter Rosin <peda@axentia.se> wrote:

> The A2Q and UPDATE bits have no effect in the channel disable registers.
> However, since they are present, assume that the intention is to disable
> planes, not immediately as indicated by the RST bit, but on the next
> frame shift since that is what A2Q and UPDATE means in the channel enable
> registers.
> 
> Disabling the plane on the next frame shift is done with the EN bit,
> so use that.

It's been a long time, but I think I had a good reason for forcing a
reset. IIRC, when you don't do that and the CRTC is disabled before the
plane, the EN bit stays around, and next time you queue a plane update,
you'll start with an invalid buf pointer.

> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 05519e8c6586..f2f570642f84 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -728,9 +728,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>  
>  	/* Disable the layer */
>  	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
> -				    ATMEL_HLCDC_LAYER_RST |
> -				    ATMEL_HLCDC_LAYER_A2Q |
> -				    ATMEL_HLCDC_LAYER_UPDATE);
> +				    ATMEL_HLCDC_LAYER_EN);
>  
>  	/* Clear all pending interrupts */
>  	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
