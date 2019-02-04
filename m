Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C641C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AC32147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VacvPsCy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BbiNwtic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AC32147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bm8rt+KJcj0sbsyBjBcwD1IVibxqjgCodODMlUKVeks=; b=VacvPsCyG68pA0
	uGqzoIOQsNX6R66nuYRPw5LV9ckKzeJ820FK525RvvrJzFs2P3PukxqFDLqacKC40o1UhhkO8T5UV
	NHJLJJ2jCf2wbBWB2O64+ebXAhSOxCtgHN4VyZ3KY/r6819cRUeBgWXPV2Dy6juWyNVAoNDV9nnEA
	DIJyqTDtdDkP7mFZLFnyqbqWw8r0qUNtHqon8dCG+iIiuI9Mcao4q013wexvSObcm2j4OFoSQN+gy
	qe1HI4d93296Blr5yLbtkSoV6RV4V4az4xydKyUqWdaaaED8Ro8cZSzI0HdDuD5fpv3lluACwOz8U
	6k/3WHzF+rjhv5YUt1+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqajn-0001yU-57; Mon, 04 Feb 2019 09:40:23 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaji-0001y0-OF
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:40:20 +0000
Received: by mail-ed1-x541.google.com with SMTP id b3so10705724ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 01:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Pb3lUw7DjM/W91nlG1PjwpEOuXLFtGd6iTfqfZ2ZHEE=;
 b=BbiNwticcXE6YYALiJ1tlqKCHhki2N7vG37ojLnI3eNHY/mIAeFYPtRH69AB+pB/kJ
 7h4FaqN5v4+JIiEuhTulk2VGK9llrHjdFlDa4WA3dxnNRk61Nk2J+Y0jw5AjAD/xmOVS
 uE2/wauNO2EvsH3vKWY1jfblspuU5GpzT4QkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=Pb3lUw7DjM/W91nlG1PjwpEOuXLFtGd6iTfqfZ2ZHEE=;
 b=um12lWj+T701ZCHFVuqvO8y7yr5jh32PSsMWGgOJzlUccSKZ6n4sQEng1DTEvJgYgx
 5sHEPf0t9dBDXDI52BKiLpQS6LbeXK2ohCRR1U+OhZ+klbr/qqqyQZ6CiabIn+da22yT
 hZrbdWvVV1vMqKCvDtHaZeENgFDR2lApxgAvgz03AduLoqLGVXnFrB/Qgm52PzghJXCo
 oLxWUZISb+NMMPHagHJGsfLnPX7tPS+akdprXl3fE+wCOndq5MPmJjPZC6r9sZdhGAQt
 Wr/G/vE973MeZgOEE9OVNXpMeVyDhfE3ukXQ5ENN9qfEilsyf15g3XUIaEDKMxDXFgfC
 w8fA==
X-Gm-Message-State: AJcUukeGAXqHwkD+M1Ts142kZGhKFA1uRUEmY63tXHjrBNJaFVLCWPAj
 jpwmBjpUPCkGFNZ+vwlF8vMgtg==
X-Google-Smtp-Source: ALg8bN6pVNVS3EOUrTJ540ORIKI0g0hUh0hLARW5O3RgmVw0qWEQwF81qo3TJ5FUBAkYIHnsbTBiAg==
X-Received: by 2002:aa7:d394:: with SMTP id x20mr43535336edq.193.1549273216275; 
 Mon, 04 Feb 2019 01:40:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id f35sm4072761edd.80.2019.02.04.01.40.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 01:40:14 -0800 (PST)
Date: Mon, 4 Feb 2019 10:40:12 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204094012.GP3271@phenom.ffwll.local>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204082353.GE19087@ulmo>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_014018_855007_15347D9F 
X-CRM114-Status: GOOD (  30.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 09:23:59AM +0100, Thierry Reding wrote:
> On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > > eDP panels usually have EDID EEPROM, so there's no need to define panel
> > > > width/height or any modes/timings in dts. But this panel still may have
> > > > regulator and/or backlight.
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
> > >
> > > Please don't try to make panels look more generic than they really are.
> > > You're going to have to provide a compatible string for your device that
> > > is more specific than "panel-edp". You claim that you don't need any
> > > extra information that is panel specific, but you don't know that now.
> > > We have in the past thought that we didn't need things like prepare
> > > delay, but then we ran into situations where we did need them.
> > >
> > > Just do what everybody else does. Provide a specific compatible string
> > > and match on that in the panel-simple driver. Even if you can read all
> > > the video timings from an EDID EEPROM, you can still provide a mode in
> > > the panel descriptor to serve as a fallback if for example the EEPROM
> > > is faulty on some device.
> > 
> > Pinebook used several 768p panels that have slightly different timings
> > and recent batch uses 1080p panel.
> > 
> > What panel descriptor should I use as fallback?
> 
> You don't use panel descriptors as fallback. The simple-panel driver
> will bind to a panel device and use the corresponding descriptor. If
> your device tree contains the correct information, the descriptor is
> correct for the panel you have.
> 
> In other words you need to ensure that you have the correct panel in
> device tree for the board that you're using. This is exactly the same
> thing as for other devices.
> 
> One way to to this is to have separate device trees for each variant
> of the board that you want to support. Another variant may be to have
> a common device tree and then have some early firmware update the DTB
> with the correct panel information.

This would defeat the point of edp, which is to standardize the mess of
panels (at least somewhat) and avoid having to change the DT/ACPI
tables/firmware for every board you ship. Also, we do have DP quirking
infrastructure already (using the OUI), I think if there's something that
doesn't work then we should quirk it there.

What does make sense though imo is if we try not to stuff the edp panel
into panel-simple, because it's anything like a simple dumb panel. There's
also some integration awkwardness since with this panel you need to do dp
aux/i2c transactions to get at the information (edid alone isn't good
enough for edp), and I'm not sure how exactly that's supposed to be
instantiated. Maybe a special function to instantiate an edp panel, which
takes both a DT node and the dp_aux controller would be much better,
instead of trying to auto-match against a DT compatible string and load a
panel driver which is almost all fake.

Or we teach dp_aux to register itself and somehow teach panel-edp how it
can get hold of the dp_aux channel it needs.

But fake mode in panel-simple sounds like the wrong approach. At least
from our experience with i915 (and I think other drivers supporting edp),
the standardization of panels for basic stuff at least worked.
Self-refresh seems an entirely different story unfortunately ... but again
quirking that for DP stuff should be done using the OUI I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
