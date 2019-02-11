Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B83C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:11:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93056222B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PbeG+K2H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="chJGF9Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93056222B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+nnoQCnFFysgBcB4OE0qHpf8jBcb7zYS14Xx/WBdWaQ=; b=PbeG+K2HuUG3yC
	+kL+tiNqMiqmXZJAieCYnbRGNCn5fvT4nJW3DGt+oAP24WnIhrW06+ut6ONpqV16nmDr+OtJSBEjI
	yhyAVKoYK3XtK+elJub9e+mZzkmgyyjh6XduY8OiuJchMmr86qYxv38wQNbk42CHcsUqkHLV694Lb
	iMWEJphW03mLiw/adAAUM5h4fMyukcCslX00S2pHpx8dmOmNF6+y5d6+U97MgXVe7J6k1js6Eb9C0
	mI87GQhk+Chsi/ABQu0pJr78h9o/sUteGybDmQgvGoKFZ0FuGIF8yivlTQYjYdG1VX+E66n0zyivL
	7LMFCWlvA4gDRroO1y0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCIV-000255-PM; Mon, 11 Feb 2019 14:10:59 +0000
Received: from conssluserg-03.nifty.com ([210.131.2.82])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCIS-00022B-21
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:10:58 +0000
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x1BEAGet002240
 for <linux-arm-kernel@lists.infradead.org>; Mon, 11 Feb 2019 23:10:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x1BEAGet002240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1549894217;
 bh=Ddm3RVPs+99BTjqrALyXAj1R7WQCUvTiXfq5LNFNpd4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=chJGF9XdmsH8ZCxYlcpQ7Cw/QIl2foerTD5Q1MlSAQWITcJRWAUIUQA/HJr+tyg+G
 H6X63NWnReRrk5eLO7HeOnRTVL1Nm96pf/JagyUXGHUlrynU5Vw81/tdy27FAjcrK7
 a3RA4ddRVHqZ1bWpjnqKMhUVyb+CRie3Dky6seX8GkXxiZqYkAiee3GDS3B33DOqci
 1yBGx/PjeLGTtZtSaBxETKRKeZpmgOFTDUWa7XUPT2OfRIWYyvJmkVpmVsAr302rMq
 50txzTA+sX9tHYgFLpNZD+yTUZoY+MSUdvQ7Mh8zLabantKClQ+314tK5ME7t1D+/b
 kPXMaA8d092XA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id z18so652104vso.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 06:10:16 -0800 (PST)
X-Gm-Message-State: AHQUAuYRq5whQTP0Bu7P/8Qidy5aats/TmzyjcmXqKbnyed8leR/w9To
 BOwc0hK+kod5Y0YAWhdh3n62mYXNI1cTUKnMXbY=
X-Google-Smtp-Source: AHgI3IZqdzRTG6E3sfZ1JwMvMHMlytVdk21phNy5hgAKmioNsAos9rOoPGu9X2q51/W7DH91fHNU4WMGOxDALQAloGU=
X-Received: by 2002:a67:3e97:: with SMTP id a23mr1027719vsi.181.1549894215478; 
 Mon, 11 Feb 2019 06:10:15 -0800 (PST)
MIME-Version: 1.0
References: <1549628897-32345-1-git-send-email-sugaya.taichi@socionext.com>
 <CACRpkdZCpyJDL+zy-NftXJNah2u6t75cVCDmh_L0+ZyXv7J2LA@mail.gmail.com>
In-Reply-To: <CACRpkdZCpyJDL+zy-NftXJNah2u6t75cVCDmh_L0+ZyXv7J2LA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 11 Feb 2019 23:09:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQx1Ee7a5CAhbaxKv8wiiuX_aP4ie7+_BqBSGh-dmchPQ@mail.gmail.com>
Message-ID: <CAK7LNAQx1Ee7a5CAhbaxKv8wiiuX_aP4ie7+_BqBSGh-dmchPQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_061056_340140_5A6CF7B0 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

On Fri, Feb 8, 2019 at 10:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Sugaya,
>
> thank you for the patch!
>
> Since Masahiro has previously added the Uniphier pin control driver
> I would like him to provide a review of this patch, if possible. I also
> want to make sure that the hardware is different enough from the
> existing Uniphier pin control so that it really needs a new
> driver, else I suppose it should be refactored to be part of
> the pinctrl/uniphier drivers (we can of course rename it
> pinctrl/socionext if only naming is an issue).


Milbeaut and UniPhier are totally different platforms,
so no code is shareable.

At most, they could share the directory,
drivers/pinctrl/socionext/, if you like.

I know you prefer grouping by SoC-family
instead of by vendor-name as you stated in the
"Moving ARM dts files" discussion.



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
