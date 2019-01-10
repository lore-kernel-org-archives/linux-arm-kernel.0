Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB7DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBB2206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Teuz/gbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBB2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3g9Xw6kC8YuBmy/elw9peplTiyK4f/3ITjaS+Aru1u8=; b=Teuz/gbUIuDWzu
	rp96l/clGF4PCfy4kUMlvg+anWg2PzdmQ32dBARytdhZz2JTyIY4s8AIsMjFFIKf6zKlD14Y8CcWL
	R+35LKkW1PFJbsKgLPzM7Kn/3nb8Rwmn22RdXpWjwrz250rS/mJLLOnQ8wmncQL64ajgfSZvRvEAW
	/qVRryJ95fV+Tu/7wUL6QG9gjrDx3hwx98UG5b2cehrD6wABiP/Tm1rWZErG9d98mDuRMGiRi7/x8
	ccOs/FDkjOgFOeikb4QsMtsymqLiHgsaUdYIOT75eq2DkVRMQyKlc+OteVuP8VDMYFLOyqVp9F7IN
	0WjjV334sR3cBR2JVvVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgl0-00057z-GD; Thu, 10 Jan 2019 20:16:50 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgks-0004w8-4w
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:16:48 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 4BC9780538;
 Thu, 10 Jan 2019 21:16:38 +0100 (CET)
Date: Thu, 10 Jan 2019 21:16:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Boris Brezillon <bbrezillon@kernel.org>, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190110201636.GA7074@ravnborg.org>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110184446.75b4350a@bbrezillon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=cw4OArruGTS2hah8c1kA:9 a=CjuIK1q_8ugA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_121643_223496_24FA6BFE 
X-CRM114-Status: GOOD (  17.94  )
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
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Peter Rosin <peda@axentia.se>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter.

(Hijacking this thread as I lost the orginal mails)

> > 
> > I found an unfortunate issue while recoding plane handling to use
> > drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> > which is not correct. I simply fixed it (patch 1/4), but maybe that
> > will cause regressions for unsuspecting users who simply assumed
> > that the clockwise rotation was correct? I don't know what to do
> > about that? Adding an option to get the old broken behavior seems
> > useless, wouldn't it be just as easy to just fix whatever app to
> > rotate the other way instead of adding an option somewhere?
> 
> Hm, rotation support has been added before the standard rotation
> property was created, and at that time I assumed rotation was clockwise
> (which apparently was an unwise choice). Anyway, I don't have a
> solution for this problem, so I'll let Nicolas decide if it's
> acceptable to change the rotation behavior.
> 
> > 
> > I have only tested this series on sama5d3, but I did check the docs
> > for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> > and sam9x35) supported by the driver (relevant to patch 4/4).

I wonder if, when this code path is anyway touched, could benefit
from drm_rect_rotate().

It is obviously not a simple replacement, but could it be used then
I hope the resulting code is simpler.

	Sam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
