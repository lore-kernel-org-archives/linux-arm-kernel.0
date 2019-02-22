Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:37:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8D3206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k46llMhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8D3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iKdzs7Ox3T8AQU0mKOGiEs+QfMMRUruLKw7VtOv57Y8=; b=k46llMhx92UVXD
	/26oD+fsL/JuQ/hrCZDWhrYmGObWXn6elVT7DQGp5isqbe1+DUcV/IHVOlKn2o3pkLaNfnNiGoN3x
	SBisSr3orpCWEM6gfkzi/i0el+VjFj3XNItRTo+xlu2GD5xZFwX5IoWLzMkIB/MpRNX+XxCSs0SSk
	kGt9nGT74z99Yxc/oSBBbYuP5KFGoLkuq0eFC8qpGbWkNERSB6XkJV+hmJfqVQJL0uzOcC5RxuyLX
	SBro4TvG/SgRT+4LZwqjvmNxO+Y8kOlYIbrKAQJiwyjYXc0Tjpz7gt4Xr9pBQeltSSkO3riuAVri7
	WcnCJRphWtLawaa1b4og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFhK-0005Zr-RR; Fri, 22 Feb 2019 18:37:22 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFhG-0005ZM-JQ
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:37:20 +0000
Received: by mail-oi1-f195.google.com with SMTP id s16so2466267oih.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Pgi0UuvjVIOozSuy55GGq0+02k4/aVoav1ZQ7oqCvUY=;
 b=SpZHQPoWVRa7usddgIq7glt7pTN8sAyGxBDYlcp3QsAipGbPg7Rz50yofAQp0+9lzc
 iMvZGYePH8OCa7M+819c3itB1WaXLUBg5NDyMAW2ibdvZDEgNbCIAygg+jKKh23gazX0
 e8nKWwEoET7RjejIC/007RrZBgTFQR7EdQs0p47GlM1XpDucI84uZL5oafuHdnnxeaep
 WikTy6WCFHUkhTUo+G6W7rS0jI8ga2RrKPhBodWl5gXoJwvQsjJh3/5P2NqEsNzeBxno
 P8J6VDVXPyZXDiHKC8ECIBLgm/rw3YB3Ka+a1pfmhkry0aEnDHxnOY6pS0A+5/m8qsLx
 NtTg==
X-Gm-Message-State: AHQUAuYkDWXr7eD3hcdL/s6CQoM3oFtcl4IYuReziARcuhKj/hfG9Jhm
 gz7LmevwfhPWd5GysNKBtw==
X-Google-Smtp-Source: AHgI3IZ2wsfZnfdXnWRfVynnp2iFhP092DFI3Wl71yEkYbRSEaVo9LeRWQBtD/9IEb9NIGJtQh/p5g==
X-Received: by 2002:a54:4391:: with SMTP id u17mr3165943oiv.111.1550860637731; 
 Fri, 22 Feb 2019 10:37:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w22sm808451oth.45.2019.02.22.10.37.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 10:37:16 -0800 (PST)
Date: Fri, 22 Feb 2019 12:37:16 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 10/11] drm/panel: simple: Add NewEast Optoelectronics
 CO., LTD WJFH116008A panel support
Message-ID: <20190222183716.GA7627@bogus>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-11-anarsoul@gmail.com>
 <20190218183301.GA5480@bogus>
 <CA+E=qVcdDQJvssZgu23gM_gKvz2G5GAWcmjFBokE_V=WGJ4h6A@mail.gmail.com>
 <CAL_Jsq+pyAd_kMMz+yKjqY=asAi1X1XguM58VjfVhPwD-xi-2w@mail.gmail.com>
 <CA+E=qVcmLnr9sL7UjG2PSC0Ji5PhW=xOLQHGvRUG3yMMZW1hnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+E=qVcmLnr9sL7UjG2PSC0Ji5PhW=xOLQHGvRUG3yMMZW1hnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_103718_636536_F7F08926 
X-CRM114-Status: GOOD (  24.34  )
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
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 01:35:26PM -0800, Vasily Khoruzhick wrote:
> On Tue, Feb 19, 2019 at 6:54 AM Rob Herring <robh@kernel.org> wrote:
> 
> > > I believe using eDP connector binding wouldn't help much in my case
> > > and it won't improve accuracy of hardware description while adding
> > > unnecessary code duplication (edp-connector will be pretty much
> > > simple-panel).
> > >
> > > Since currently there're no standalone connector drivers, implementing
> > > one requires significant refactoring of the code that I'm not
> > > familiar.
> >
> > I'm not talking about drivers. I'm talking about bindings. Those are
> > not necessarily 1-1. There's no reason the simple panel driver can't
> > have an 'edp-connector' entry.
> 
> These aren't independent things. Bindings are useless without drivers.

What I mean is bindings for panels and connectors are basically the same 
thing. The kernel handles them quite differently, but that is a kernel 
design decision independent of bindings. Another client (of DT) may do 
things differently or the kernel may do things differently in the 
future.

There is not any simple panel binding really. This originated I think 
from a 'simple-panel' compatible that was originally attempted. What we 
have is a collection of common properties for panels which panel 
bindings can use. And we have some common panel docs too. I've been 
meaning to clean-up and unify all this. What I'd like is a pool of 
common properties for any connector or panel to use. Then we can define 
what subset any panel or connector use. When there's something standard 
across devices like LVDS modes or eDP connectors, then we can further 
define a subset. It is easiest if these subsets are also encapsulated by 
a compatible string, but that's not required and some times undesirable. 
For the latter, the 'simple-panel' compatible is what I'm thinking of. 
It needs to have a well defined meaning such as following some spec.

> Also how are you going to address mainlined platforms that have eDP
> and use panel bindings? E.g. rk3399 supports eDP and uses panel
> binding - see rk3399-gru-kevin.dts as example.

I'm not.

Supporting eDP and having a standard eDP connector are 2 different 
things. I'd guess chromebooks would do something standard, but I've got 
no idea. Assuming they do, there's nothing to do for existing bindings. 
They are already defined. But I imagine having a 'edp-connector' 
fallback would be helpful to the chromebook folks.

We can easily map a specific binding to a specific or generic driver. So 
if we ever have a generic eDP connector driver, then we could perhaps 
move rk3399-gru-kevin to use that. Kind of depends if it matches 
whatever set of properties is defined for eDP connectors.

> > Also, since you have EDID, you should be using that for timing data
> > IMO, and the binding needs to have enough information to support that.
> > It may if DP-aux comes from the bridge chip or it may not if you need
> > to describe that connection. Again, this is independent from what
> > Linux chooses to do. If Linux chooses to have its own timing
> > information that's its choice. Another OS may choose to use EDID.
> 
> I see nothing wrong here - anx6345 driver reads EDID (over AUX) and
> uses timing from it, if reading EDID failed it fallback to timings
> defined in panel driver.

Okay, I didn't look at the driver part closely. So really, it's just 
having a fallback compatible and defining what that includes.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
