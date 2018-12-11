Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1371C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A932146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xmj2DHYW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="f8XAGgbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A932146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8AgtFjlOWiIMttxky6pbHy0KV/6I1PaeaTUDCnVGBTI=; b=Xmj2DHYW/5GuFy
	yWymfWuAqwugAc51/1m7ju67P4nH6hTP249flCYwCK0T3dVpZGonDDt8vnLd7E23cnSeUgCCMtyez
	uNHgL4cH6p9NZgYML8t4EsR28BDeGidMuGoFmytS9wyvfd48D/w/P4dG6p37hOSTStngDejcoQjaa
	JH/zseLAeKtFdEpKwWNrh4YqxbmotOomP6yt95hAGU1oo5ieSv2uKcf7fsmbWNrCO4grhxQa3gXDL
	x9aNiB7D5JP4+mJjqSnvf0V840kTX29c1NXs3NOvldhExkT1uMJuBMRSiLvaYuLcAqB8lezj8CDC6
	aHaa5C280GZHSjHUX/Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkex-0005ZC-QK; Tue, 11 Dec 2018 16:13:23 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWke3-0004KO-Qx
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:33 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so13467955ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yxgDgjmgmGW3nKED9WXaNde7jBU/zR/C5eGqO69DYiQ=;
 b=f8XAGgbSB7+AfpCTBAa3iZ/tqCj5tgOjjX5N/ZP78tO138N7n9xwHtZ7Z6+9yT1ZG0
 GY4N3cscYn7gGSQcJvMYfa94G1KK/X4r2hOMLFJQar1Sf9nHRt3cb9KV5Ht5oEm2TS7N
 3g+t57jLA/jHgYtv9B3guioLWdug4y7dJrh3LuRCn6p1xAsCTlhmSsx3Fg5OauyP03sp
 v65VdpEarudj4lhfGe1bpwt39VCBAMSJB3Nh45rcnfzrFA8+Wufbe8Y/u3u54q6n4r4e
 vKVix30OxonTysGpqczzC+yI60wyRmu883gufkbimRoVIWZT4fY8WSrImOe4LO1PwFsL
 YNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yxgDgjmgmGW3nKED9WXaNde7jBU/zR/C5eGqO69DYiQ=;
 b=KP9UKAjKyhn5npfZfZ30xiZsMH68ukjWo/pCcy1GpNYta0xPYRCCYx8FhC1WbipHON
 LdHV3MbKpAg105LpiOWV4CIAsCkosmCysSZtljmo7Rytwc18BglhDw/UL6M6q64WX090
 vbE9n3o1kzhXY8Gbn0+Z7icUdF+jid1yAK/vP73r/qpO4xh7L76nKoPb+WcrycFFdBX6
 hR4fCyAxFcs5ofiH2N/uK9AdTqYC5jIjTAOJlg2eQ4UcXt7bPKlqaPl/yQcDSTsd2Hsz
 KRIdXRK3oF6IcYl3Y8cP1wY0PB2VG9f/d0ZSA33VfyrQ2F9tOwoqFw4VvOXMc6lOANGw
 gXEg==
X-Gm-Message-State: AA+aEWYNHlV6rxPA2iyDDIv+oNYdG6Jb77Gb6nFI1ZYDIZEff+J8tNt0
 bEYacX65TppADs+q+TnZsRFC8g==
X-Google-Smtp-Source: AFSGD/Xw5+4IEswjVW6MPV2MJFtr+tJl2Y0+UchpwvHAejgXFxYyW/mJQIKkekgiSZuRZuYBlM3hkA==
X-Received: by 2002:a2e:8007:: with SMTP id
 j7-v6mr10250968ljg.22.1544544735979; 
 Tue, 11 Dec 2018 08:12:15 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b81-v6sm2795034ljb.7.2018.12.11.08.12.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:14 -0800 (PST)
Date: Tue, 11 Dec 2018 07:58:49 -0800
From: Olof Johansson <olof@lixom.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181211155849.5t4wwmboirf2iaew@localhost>
References: <20181204183649.GA5716@bogus>
 <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081228_230706_6E575D3C 
X-CRM114-Status: GOOD (  25.39  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 04:33:41PM -0600, Rob Herring wrote:
> On Tue, Dec 4, 2018 at 12:36 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Olof, Arnd,
> >
> > I've put together a script to move the dts files and update the
> > makefiles. It doesn't handle files not following a common prefix which
> > isn't many and some includes within the dts files will need some fixups
> > by hand.
> >
> > MAINTAINERS will also need updating.
> >
> > A few questions:
> >
> > Do we want to move absolutely everything to subdirs? There's quite a
> > few platforms with only 1-2 platforms. I haven't added these to the
> > list yet, but can.
> >
> > Do any vendors need another level of directories? davinci, omap, nspire,
> > etc. for TI for example.
> >
> > What to do with armv7m.dtsi? I guess it should remain and we just fixup
> > the include. There may be a few other cross vendor things.
> >
> >
> > Sub-arch maintainers,
> > 'vendor_map' below is the mapping of file prefix to new subdirectory
> > (the SoC vendor prefix). Please comment if there are any issues.
> 
> Here's an updated mapping filled out with the rest of the platforms
> and using SoC family names in some cases as discussed. The move is
> completely scripted now including include fixups (though any new
> includes could break things). So mainly just need to bikeshed the
> directory mapping. Not sure if marvell should be split up more or not.
> I split out pxa2xx and pxa3xx, but then there's other pxa chips I
> think aren't really related. TI is still all one directory except
> nspire. I was going to split out davinci too, but it's only a couple
> of files. Sub-arch maintainers need to chime in with what they want.

I think we can debate this forever if we want to, and of course when product
families change owners (or when companies merge or change names) it will be
tempting to rename or move files. But I think we'll treat this the same way as
we do with bindings and other aspects of the kernel: some platforms will have
legacy names that might not describe their current state but documents the
lineage of the product. For that, it might be slightly easier to use product
family names instead of company ditto, but I really don't care enough to
request changes.

Also, since the subdirectory doesn't influence install path on 32-bit,
renames shouldn't be the end of the world (but I'm likely to turn down
those requests beyond the possible initial "we miscategorized this
platform" kind).


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
