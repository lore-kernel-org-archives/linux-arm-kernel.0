Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F01206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mq19icDk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2gWqV+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F01206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u9HvE3xIf+Sctt68bBgOW5+ElFheDYGmAP7UjiTvt/g=; b=Mq19icDkxlOxtQ
	3ecjsA97kZKZhJVFimfUhjl/q/gNvQ1oN/cXYTQCm0VT9qNJP1iZXPpUYJzJNUe5sKEd0Sq6ujZXJ
	cqxBDuJxFOt5GXjKgGSX4FqSWAUwwnsITUFHF7YJnAMT9USZ/nJbS2aPZNuz3G6Ro6+lmyz0VW3bm
	hrTuuxVpaBCIwFKFbN130OYc+YgemiyaiqFikKFHHJn3ebqGqFSZpFKlB59NY7nIl9/YF/aAlRp+L
	E7FV6yoTg/Gt2A0iwM9pYMS0uRS4kMkgiboIimCMtV4LlQeVz1m/vOtjwsh8XINM9eP3fiIn6rtVR
	DVngnQmFGNxxrFSdwBNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCX1-0002CU-Av; Wed, 09 Jan 2019 12:00:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCWx-0002C3-Ta
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:00:21 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 259CE206B6;
 Wed,  9 Jan 2019 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547035219;
 bh=TwI3gTLhbBNd1cYXCGa3vZ8P336E2Tv4RllKn2O0a5A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=h2gWqV+Ilp+6yZbP7H4pV+YOZWQNGM0OaA5DRrcRyOB8ax8QxplhOo5uo9kX+pYQx
 kQ85VIt3cmJNGeXwsji2tNiOsWh6hP30mJdYUcZFW411LwzirW7xXD0D9wa41r1/6D
 +bugV8XiOFX/FbOhH/RvQnP1PxTQxSOv1bGRqaT8=
Date: Wed, 9 Jan 2019 13:00:08 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Message-ID: <20190109125833.0af5dc52@bbrezillon>
In-Reply-To: <9b73f5fa-e5c2-ea55-8d96-be6de8a1f34a@axentia.se>
References: <20190108123129.20031-1-peda@axentia.se>
 <20190109101224.GT21184@phenom.ffwll.local>
 <9b73f5fa-e5c2-ea55-8d96-be6de8a1f34a@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_040019_973585_8C2CD78C 
X-CRM114-Status: GOOD (  20.17  )
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

On Wed, 9 Jan 2019 11:37:19 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-09 11:12, Daniel Vetter wrote:
> > On Tue, Jan 08, 2019 at 12:31:36PM +0000, Peter Rosin wrote:  
> >> While trying to temporarily hide a plane, one thing that was attempted
> >> was to call (from libdrm)
> >>
> >> 	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
> >> 			0, 0, 0, 0, 0, 0, 0, 0);
> >>
> >> This call causes a pair of "Division by zero in kernel." messages. Kill
> >> those messages, but preserve the current behaviour that also happen to
> >> make the plane disappear with the above call.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
> >> the feeling that the src rect should be clipped together with the crtc rect
> >> if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
> >> the equivalent does not seem to happen here. Should clipping be performed
> >> on the src rect?  
> > 
> > Any reasons atmel can't switch over to that helper? Would compute a nice  
> > ->visible state variable for you ...  
> > -Daniel  
> 
> I have not researched that, and as stated above, I was not sure if that was the
> correct approach to begin with. Boris, any insights?

You can look at vc4_plane.c if you want an example of how this helper
can be used to get clipped dimensions of the plane.

> Does this code predate the
> helper or something?

Yes, and I must admit I'm not actively maintaining the driver, so there
are probably a few other things we could simplify by using generic
helpers.

> 
> Maybe there's some register bit that hides a plane explicitly, matching the
> ->visible state variable? I haven't looked at that either...

I don't think so, but you can simply disable the plane when ->visible
is false.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
