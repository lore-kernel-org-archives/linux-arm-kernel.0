Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F52AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:02:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDE220665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yvn3X+33";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MF6Z/e8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDE220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OPGN/we9wh9ck+SdkSPsPDSKGrCab21KJFH4/ypAMWI=; b=Yvn3X+33qKX4VE
	ztvPTEUMQMpOKQdz5x99E88SxtVDG236cpiR6reszuwjtRYvb2DTi1sR2fEWOsfCM75wVHWEwBdbq
	deIGumq7iD3JuqyWFLSMaXa+rvp6OZxyQzXioIygiTbkZl/Y9ayj+L7J4xhLipvTpqf2TKY9ULLRS
	Kq1g+IYz1F7d8Uw9frJtz8+V5eDS6m3UdHKVDoI9VCKH7jLtzHDrcKSg+1163RN+ci75hy/C9k/Nw
	+7eVCDRS4RNkpkWW7fRyPuMncv8a9ZqUyLcaT1rkL4nRTTEuYe9ENAODCnAPN8b6WWUNetYN1a2Eq
	j2kSPnqdvU3wfm/i+aOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgXH-0007fc-1N; Thu, 10 Jan 2019 20:02:39 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgX8-0007as-Od
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:02:36 +0000
Received: by mail-ed1-x541.google.com with SMTP id f23so11247304edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=jrR7MN3zWtTOEAlREM10G1K8GL1YyZtNgrncxhm6R/A=;
 b=MF6Z/e8vyuyt3PZWmhubBZvsoDGV8udz/9JB9n1Wa8tk8Rot8D3Tprb7lewlEEba96
 6XR68EF8ElKcjjmoKF5GmqtAeyQfJL0xJ2ujsI6Cj+XWV/0h3pNWbaV1GWemf3wrPvJT
 BKlj4qE76qf5+xcV/avF8kNovPx4huZrQdeeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=jrR7MN3zWtTOEAlREM10G1K8GL1YyZtNgrncxhm6R/A=;
 b=jxaB+LzLwVBeZ3ZAAmmMCyP9D0uhXHBkvQTXfWCqBqVTPIiTyxVkrQiIiu/1gCwDG3
 kDFAriOLzcfUTT3H977tQb3INPstekH67bAZ3p1nL6/iNDsAKcBWn9FAW6vlwcyYDvy7
 GqvLsJbkwUsJbnE9J6h8hy7c5pWf16KXgtZHanwcHnZB3omxdSDF8/Qqux4Sn0O+/27D
 3mT6wdQ75vv0TElkCymOqxhk60/78H4HzEu+F6ypLRv8QULkxebQ5ER3mfddYoJF1Hv5
 DSDvDLQgwu1hXcMYQh08fhhEuU2uKzCtU0JTlM7zmLZY8SkZiJWkqHeAFRb4mnxTLWde
 50OA==
X-Gm-Message-State: AJcUukcdDTKJpeigccwGAyLf/Flf+jVZDMG543bNyr0+wRvm8oSGOeaV
 1tcL91ynAMJL41jlNtFsdSYmPw==
X-Google-Smtp-Source: ALg8bN4ghh7FfiwCL04u7h0DHffsPEYyFSFMnK/w05EGbuocyRoLMP0SFemKJXl0ZmaVw/yLr33Heg==
X-Received: by 2002:a50:9724:: with SMTP id c33mr10876479edb.288.1547150548360; 
 Thu, 10 Jan 2019 12:02:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id c23-v6sm1230019ejb.62.2019.01.10.12.02.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 12:02:27 -0800 (PST)
Date: Thu, 10 Jan 2019 21:02:25 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Frank Wunderlich <frank-w@public-files.de>
Subject: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
Message-ID: <20190110200225.GN21184@phenom.ffwll.local>
Mail-Followup-To: Frank Wunderlich <frank-w@public-files.de>,
 CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@linux.ie>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Alexander Ryabchenko <d3adme4t@gmail.com>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_120230_863703_07D5959B 
X-CRM114-Status: GOOD (  18.26  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 Alexander Ryabchenko <d3adme4t@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
> Hi Daniel,
> 
> > > Would be good to use the new generic fbdev emulation code here, for even
> > > less code. Or at least know why this isn't possible to use for mtk (and
> > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > needed anymore.
> > 
> > Back on the mailing list, no private replies please:
> 
> i don't wanted to spam all people with dumb questions ;)

There's no dumb questions, only insufficient documentation :-)

> > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > plus all the kerneldoc linked from there should get you started.
> > -Daniel
> 
> this is one of google best founds if i search for drm_fbdev_generic_setup:
> 
> https://lkml.org/lkml/2018/12/19/305
> 
> not very helpful...
> 
> so i tried kernel-doc
> 
> https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> 
> which is nice function-reference but i've found no generic workflow
> 
> as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
> 
> i personally make my first steps as spare-time kernel-developer :)

There's a ton of in-kernel users of that function already, I meant you can
use those to serve as examples ... If those + the kerneldoc aren't
good enough, then we need to improve them.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
