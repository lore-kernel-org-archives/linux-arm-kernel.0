Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E0C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:33:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2C420856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDIzRrmm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Vx9QI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2C420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nOQlmVqmVBnMYnMJ28qGUQCjs52Sgjlbag8pj5/Llp0=; b=TDIzRrmmYRvbpZ
	AezNYR2nUoTc58YkUGIs/7Vxc8yOiez9pMLUoOMFI2R2d9h0pENj6uFsRKAg7p1dZNBFoG4dX2fTa
	3lqEJbxPLW52a3ug181rIS0OsMIMsAuooz0w1FiyyjcvPBShbe5ax484WaoKb+uz9qiOu+BAh6IQP
	FTlPa+0wZtVsLuQqjqzV9jI4+9vscB8EvFqt1+GUlSXmvSHarWydRNyrRe9V0jWXjQHAtakN6sTKl
	OJp9+SamPmuu8MKoOb4WP57MnutIUNB5BbqHIJ33U/a5jhR2EKrxGE1a/rhB2ROCORt5w1XnR7pnR
	1uM6SrYGazuO6ub+NDUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gq6ep-0006EM-VZ; Sun, 03 Feb 2019 01:33:15 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gq6en-0006Dh-2A
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 01:33:14 +0000
Received: by mail-oi1-x243.google.com with SMTP id w13so8901574oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 17:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b2rZqsmXUinV92RCK3JMrvsiT5FW5NXrFzy/UPpdOXo=;
 b=K+Vx9QI8Yw9w+iEQ5djyBvPEhx5d4CLj5jJcTCXob7BtVU+j3KmN8G3efmB2Zz7UbU
 in8J521sJraDLba4BTXARR8lhqRLHLAve4oLMVmK+QhWVoO0YhWQaJDFmTQaT6ILQfLK
 T2oykvaQTouXEzplootYu5h//m9GyJZQ/jkkl4v6dIsFl+dbI0AGjecsbz7IoZG8HylY
 3RzxXUCPOILS3EfdKkev2uOVEhoqGk6Hh+T8NuJIa/00Rxts4GnZ89vg6+dDjV6rxYfy
 Cc3A7YjBm/gipveIDdJd0GG3zuAk6MZel6C/TXL3mNTmhXtj0oP4MXgmdnAco1JXcVO7
 /1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b2rZqsmXUinV92RCK3JMrvsiT5FW5NXrFzy/UPpdOXo=;
 b=q3c/ziBqNUeUIbQuXfqhq9SBdGm2MgL8ALzwwuchxLBZ6bIMUvlEiP7uamKcOG4Drr
 xR9MSUD8yHxeFhINROlVD+s3szVoYkjeKWPhLMvcPIXJEXTLTKmhXqKwgLOQ7TOizip8
 dsalSW7nwExuTDO10drcU51oMmty2f5jTMxT928dV7u8ccqQ/yYbcWZMmtjpZaJDA3Kf
 7HgeeCgLcgv7Ye2iWmA9/RuUKXmRpxlepPLLrIneuJac/dMzwkFM6IjkZEOKfqMoI5Ur
 hKUqvP9DuixLHbvhM/LZUBGsjj+vQUOG+R9Mmn+lAnZvMWayjLN9aXj5ABnetdnvJrpc
 RWow==
X-Gm-Message-State: AHQUAuYouq55K1FeO+FeXcCg6x+5wnpNqar/+IGAD6gwHU6wPXVkPZZ6
 iv80kPrY/WbbV9RmTBepjFA4CjjsnxOYIfQww7M=
X-Google-Smtp-Source: AHgI3IadzqU3/VlJYXkrAWtXpdIzg8LS8tCNdb6IXKAaHs5txitejuJQHv4vPtq0bjKHOD1uo5EY/i363+DG2/ddeh8=
X-Received: by 2002:aca:3904:: with SMTP id g4mr14282408oia.24.1549157587966; 
 Sat, 02 Feb 2019 17:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20181018073327.64942-1-icenowy@aosc.io>
 <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
 <20181018094258.oahlopafvm2udvoe@flea> <1585874.9P5eR8PMbl@avalon>
In-Reply-To: <1585874.9P5eR8PMbl@avalon>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 2 Feb 2019 17:32:42 -0800
Message-ID: <CA+E=qVew_TFXQzz+7V6njG4w-Ay4YZND0FZ+8F2TRnhhOBb2Mg@mail.gmail.com>
Subject: Re: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_173313_128682_AA00884A 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Oct 18, 2018 at 4:31 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Given that the tolerance is a property of the panel or bridge, I agree with
> Daniel that it should be implemented there, or at least in cooperation with
> drm_panel and drm_bridge.

Clock tolerance is not specified in ANX6345 datasheet.

> Semi-related information, I think the CEA and VESA standards allow a 0.5%
> clock tolerance. What is the maximum clock frequency deviation required for
> this platform ?

This particular platform requires ~1% deviation.

E.g. on Pinebook with 768p panel: requested clock: 73.0 MHz, real
clock: 72.296296 MHz (0.96%)
on Pinebook with 1080p panel: requested clock: 138.5 MHz, real clock:
138.461538 MHz (0.03%)

So unfortunately 0.5% is not enough.

Regards,
Vasily

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
