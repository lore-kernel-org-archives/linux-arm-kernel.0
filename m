Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:37:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDE420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mym/vI0R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="z9W+ByU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDE420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K9W1CmnwTaxzNbv/0zSYkgc+KkD1odq2GNFF+r5HLEo=; b=mym/vI0RpzZFIs
	nbjM9ZIW6Ib96Vs9PZ5wZfGkwVcCosjFrW8+txTZ+40g1OboTEskVgyqgfFxbsWq7CeZfbBlaiAaP
	csxughyPQTAF4nKfdmh2pu+uzliuKapBgYjZ9RKF8lo0sjICbohT1pF5BwMLvhivUpCRaj/T/y4lZ
	PxKQUDJHCMCLIVaK7+UQ/0SRBkpE72CgBI59mjRG7QjpEYFjou3PMGyYXjNqGfva86wZeORWSPFkD
	OoHNjVCVI57UXsgm9W0mMOpr6r8wRpvu/1oJ2Lo9myz6QOcEuGXFx56vroa715AobrpUO/x9iSS+S
	o5qwnpoRiywT8nuBMx3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcPT-0000NM-AW; Fri, 14 Dec 2018 01:36:59 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcPP-0000Mm-Lv
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:36:57 +0000
Received: by mail-it1-x141.google.com with SMTP id x19so6755066itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 17:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KailU4Gc8p2XIAPTeGM+qSOnK3rvNuZuKnmoMhqPtbs=;
 b=z9W+ByU6Tmewsu9mqYy/LSyZvNDglZb7BFBOjMTgAl2NeKR8epXLVbHdZgaJXIfVEr
 V2lGJ5Fy58qRMhcWOupOarUStqoYfIcnFV+WiwXTU72MA/SsEE14bHwnnoxC4LLyr242
 JrN7wIbF9sAMTvse+055CgAOymIKYmX1LQnd3jc2yUYhdg56pvCXigFBc3XGzcMdPYWf
 WWsVKj5/8BWgWhdHUaWwxocbGmMZC3XAeg9WAI8QlrboZ3YDK3yu+BKMaPEScgT/PaoN
 xKLBDAwCrG9UEhUrgchigkuRcR8XNXPQ6yfAx1aRg5EdjQvntqAUzdtaMuPZzJFo+uC+
 Mtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KailU4Gc8p2XIAPTeGM+qSOnK3rvNuZuKnmoMhqPtbs=;
 b=Eayg5ngKCxVvksxxpV5KMhw8Te8gvWfOiJo4K1tmH+2SaZB7utsIhaGUTJkoxG+SXo
 fUggt9iPExJbu05SDI4XyLp9x++UgQ5BYj2naqkgt+Zko3BFkOqQ49ok9p9nWE3oeWr5
 Z6/eq7YsbGI/kSsJ1uefSG9dijri9QN1Mw1Paf2iJ8cpad4tudyFg4BEfUSBByeBhyw5
 qWVHCFzKWXMItBDjiLMAbSJAwqssueoJQRicCmglk639c/iTBUogkM4x2cnB6E0OodRZ
 h/6kOGStv0MU3CDNnNM8zu0xlifADwtsLFxcOIo4cr9axucTvlE7lq4yjxj98jyCMkN2
 iOHg==
X-Gm-Message-State: AA+aEWaj60BVsesjLsIZCw037svDo5FJhRNm8j0C18AqvC3YEPVuPD28
 CAyTBNpaazAys/X44tD3/xeNM+OcB4SADQOUNJRilw==
X-Google-Smtp-Source: AFSGD/V3k3UI0YpA/yfSE5+R2+FYe+B08Jm4KQBR7Wl6H3nFuV6G10o4UIpG+UASB1cCwy680AJMVCQdxyoaM7RT4CM=
X-Received: by 2002:a24:2104:: with SMTP id e4mr1526625ita.59.1544751403655;
 Thu, 13 Dec 2018 17:36:43 -0800 (PST)
MIME-Version: 1.0
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
 <CAOesGMhFtawJLpHmXbxvs=z+S1jVW8n2VQVv1gMcWicrOxDWdA@mail.gmail.com>
 <20181213081239.GB12458@dragon>
In-Reply-To: <20181213081239.GB12458@dragon>
From: Olof Johansson <olof@lixom.net>
Date: Fri, 14 Dec 2018 09:36:31 +0800
Message-ID: <CAOesGMictB3QQOazbd0y1k5ijJjbx_8DL76XHWEQnKH3mxmXNw@mail.gmail.com>
Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_173655_769899_D541A093 
X-CRM114-Status: GOOD (  24.03  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 4:13 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Dec 13, 2018 at 04:02:34PM +0800, Olof Johansson wrote:
> ...
> > > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > > index a47430b..8a9440a 100644
> > > > --- a/drivers/clk/Makefile
> > > > +++ b/drivers/clk/Makefile
> > > > @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            += davinci/
> > > >  obj-$(CONFIG_H8300)                    += h8300/
> > > >  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
> > > >  obj-y                                  += imgtec/
> > > > -obj-$(CONFIG_ARCH_MXC)                 += imx/
> > > > +obj-y                                  += imx/
> > > >  obj-y                                  += ingenic/
> > > >  obj-$(CONFIG_ARCH_K3)                  += keystone/
> > > >  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> > > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > > > new file mode 100644
> > > > index 0000000..37478ba
> > > > --- /dev/null
> > > > +++ b/drivers/clk/imx/Kconfig
> > > > @@ -0,0 +1,5 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# common clock support for NXP i.MX SoC family.
> > > > +config MXC_CLK
> > > > +       bool
> > > > +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
> > >
> > > Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
> > > been in linux-next for a few days. Having such a config symbol is highly
> > > unusual for arm64 code. Has that been accepted by arm-soc? I don't know
> > > why it would be because we don't add SoC specific config options
> > > anymore. I imagine it will be rejected and we'll need to have this new
> > > MXC_CLK config be enabled in the defconfig instead of selected from the
> > > arch layer.
> > >
> > > Given all that, is there any damage if this is just a def_bool ARCH_MXC
> > > right now? If it's enabled on the platforms that don't use it because
> > > they have SCU, does it actually matter? Or we just get some code bloat?
> > > If it's just some extra code, then even more reason to make a user
> > > visible config option that can be selected in the configurations that
> > > care to save some space.
> >
> > On arm64 we generally add an ARCH_<family> and leave it at that. So,
> > ARCH_MXC would be suitable, but we shouldn't add more finegrained than
> > that.
>
> Olof,
>
> I'm just about to send pull request for i.MX8MQ support, which
> introduced SOC_IMX8MQ option.  It sounds like we should rework the
> patches to get SOC_IMX8MQ killed?

Yeah, I think the suggestions downthread are good approaches to avoid it.

Some platforms create SOC config options if they need it under
drivers/soc, but it will depend on your platform if you truly need it;
for most cases I think it'll just make dependencies more complicated.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
