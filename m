Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A43C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:18:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412ED2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+winu34";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biaBHwIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412ED2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tuInpyjs9c+hED1VaQH7Guk27CF7XiBO8QcLh9bHKOc=; b=a+winu34QxI3FX
	/k5xpwpRawPaVDE2ZYFe2vr7hrSuUG/5Wv03bIPIjVrNLKgOUZOV85WY2YhwBUitn1nqVFuLT/N2c
	Q2smgpWme1MRwhdCdCZn9CZuAff9Gi/t94HtMohRHBXZrrBiyMupG+YiXkMBAD/4iR9y1LBN6zyHK
	PHj+hkOsz8D2EOlsEcmEn8PGPROKW7sDkVtRfgYLOpTT5GLr/40BiVFFR1TA8ohqONUAYO+bue5N9
	2kVM6Io4CcSjQrE2K8aJ0sLr1ZBjOZ42zMF+r1pgHPotPwuVyGadHipiiCfO/0QVq/ODcwM5DO/TY
	SBtKA+fbjwFj+J9xXVEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldDj-0002kw-7G; Mon, 21 Jan 2019 17:18:47 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldDc-0002Tb-G6
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:18:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so24307963wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GLubUMh6PlP9saBR6986m6AeRD4UHvuJpXRztDGsJOM=;
 b=biaBHwIsBrP+3GwyVpH894j0NSZCxh03SDp4WCX2EWKokyGnJMSX04gLjzKkeprfUr
 AWUJCRCX6WRtksEI/2erKf1O9rNqxeyMYeeaAcoKTreeFZb4IEMFYoKN8XE9jwnIuL1w
 SS38ITKsqfq7SUQ6wyfYnt+AwBsn8Th281RhZHtMhau3h13+9XnFnCll1sjBDjOD1V2v
 NV5Y3NDj8oma7dWrXvnpCSm+0+jTdOivcyiJZ3O2jN8610/hKfa4x4FzrvUCfzeZ2QF1
 jlHI7MY3D7VtCerZGYxFucN9NN66qoNsRHXcNswcy/RTpIZtCDC7u/W2SPQHSf61YRMD
 K2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GLubUMh6PlP9saBR6986m6AeRD4UHvuJpXRztDGsJOM=;
 b=M6cHXB9mjhlnD40auljfer6marP6+QV5TXwcj+m6/I6Y2lfMXtFCfj0qsh7kMVQQ9O
 RJqs73Ds9F3mu8FL8+IGN63H2DuRxvxHqRwoYw1VZya4DQjQtmZLj3JE+0EV1XCIknKs
 0XhxcyyuT6rXUeLlHRBgO/p5+6w2APMYvGa7kEWLtqimz0S6GoYIy/SpfzsIphqdSvRY
 u2N5zw45Y6QnUra3HlzGEv06+KKbUEPO4ycmPB/K2XnuLzd7URWbZyaOg0WQMcbfubji
 Z4ftqZzJM0j5cV+dQoltHaEn30k4I1CUnlJdC3rzShUwMkfkiMNHZmFYfC1xKnu4genu
 TllA==
X-Gm-Message-State: AJcUukfghEgJkrh0RBSAkq8i6rC1wADlCULd6V16wKFOfvZv5raHCths
 P+ZqhogW2QBhCvujnMasxUg=
X-Google-Smtp-Source: ALg8bN7a8NING0fUiQ3ztZNkrM+Yf9S7V4c/zxP4HNeBIsF8fSUL4pGv20J13AMUPlTdAvm9ssR8fQ==
X-Received: by 2002:a05:6000:12c4:: with SMTP id
 l4mr28545481wrx.134.1548091113578; 
 Mon, 21 Jan 2019 09:18:33 -0800 (PST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net.
 [213.161.8.82])
 by smtp.gmail.com with ESMTPSA id j24sm116892745wrd.86.2019.01.21.09.18.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 09:18:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@googlegroups.com, plaes@plaes.org
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Date: Mon, 21 Jan 2019 18:18:30 +0100
Message-ID: <3373528.ybUWJjoEmk@jernej-laptop>
In-Reply-To: <20190121150728.tw4ryjgzzbxh7qmc@plaes.org>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190121132517.iv2v3hug4uihefnk@flea>
 <20190121150728.tw4ryjgzzbxh7qmc@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_091840_622980_5DCBB526 
X-CRM114-Status: GOOD (  31.50  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Liu <net147@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dne ponedeljek, 21. januar 2019 ob 16:07:28 CET je Priit Laes napisal(a):
> On Mon, Jan 21, 2019 at 02:25:17PM +0100, Maxime Ripard wrote:
> > On Fri, Jan 18, 2019 at 02:51:26PM +0000, Priit Laes wrote:
> > > On Fri, Jan 18, 2019 at 03:04:18PM +0100, Maxime Ripard wrote:
> > > > On Fri, Jan 18, 2019 at 10:10:53AM +0000, Priit Laes wrote:
> > > > > > > > > > It doesn't look related to the clock rate itself, since it
> > > > > > > > > > doesn't
> > > > > > > > > > change between the two cases. However, in one case the DDC
> > > > > > > > > > clock is
> > > > > > > > > > enabled and in the other it's disabled.
> > > > > > > > > > 
> > > > > > > > > > Was it taken at the same time? Maybe you can try with that
> > > > > > > > > > patch?
> > > > > > > > > > http://code.bulix.org/z7jmkm-555344?raw
> > > > > > > > > 
> > > > > > > > > Thanks, after doing ~50+ boots I haven't seen a single
> > > > > > > > > failure.
> > > > > > > > > 
> > > > > > > > > Previously I had following failure cases which are now both
> > > > > > > > > fixed:
> > > > > > > > > 
> > > > > > > > > a) Linux without u-boot HDMI, where one in every 6-7 boots
> > > > > > > > > failed.
> > > > > > > > > b) u--boot with hdmi enabled switching to simplefb and then
> > > > > > > > > switching
> > > > > > > > > to kms, where previously all boots ended up with garbled
> > > > > > > > > screen.
> > > > > > > > 
> > > > > > > > So it's not really a fix, but it really looks like the clock
> > > > > > > > is not
> > > > > > > > enabled when it should.
> > > > > > > > 
> > > > > > > > Can you describe your test scenario a bit more? What are you
> > > > > > > > doing
> > > > > > > > exactly, just booting? When do you start using the display?
> > > > > > > > When did
> > > > > > > > you capture the debugfs output that you pasted?
> > > > > > > 
> > > > > > > Display is already connected via HDMI to the board. I don't
> > > > > > > really
> > > > > > > remove it, I just boot the device and let it start Xorg.
> > > > > > > Meanwhile I just ssh into the device and capture debugfs output.
> > > > > > > See my 3 testing scenarios below.
> > > > > > > 
> > > > > > > Kernel also includes one extra patch to fall back to DDC, in
> > > > > > > case HPD
> > > > > > > fails. Mostly the same I already submitted last November [1].
> > > > > > 
> > > > > > Do you have the same issue without that patch?
> > > > > 
> > > > > Can't really test this display without this patch and I do not have
> > > > > other
> > > > > HDMI/DVI screens. And this issue does not happen with other HDMI
> > > > > displays
> > > > > that I have here.
> > > > 
> > > > Can't you just force the monitor to be reported as present? It's not
> > > > great and we don't want to merge it, but that would allow you to test
> > > > that setup without too many interferences.
> > > 
> > > Baseline is clean u-boot / linux. U-boot does not detect/enable display.
> > > 
> > > 1) Booting Linux with drm.debug=0xe
> > > 
> > > * Linux does not detect/enable display
> > > 
> > > 2) Booting with drm.debug=0xe video=HDMI-A-1:640x480@60e
> > > 
> > > * Linux detects display, but display is garbled, and proper edid data is
> > > detected:
> > > 
> > > [snip]
> > > pll-video1                     0        0        0   327000000         
> > > 0     0  50000> > 
> > >    pll-video1-2x               0        0        0   654000000         
> > >    0     0  50000> >    
> > >       hdmi-tmds                0        0        0    25153846         
> > >       0     0  50000> >       
> > >          hdmi-ddc              0        0        0       89835         
> > >          0     0  50000> > 
> > > [/snip]
> > > 
> > > 3) Booting with drm.debug=0xe video=HDMI-A-1:640x480@60e
> > > And also one extra patch for Linux where HDMI DDC clock marked as
> > > critical
> > > 
> > > Linux detects and initializes display properly:
> > > [snip]
> > > pll-video1                     1        1        0   327000000         
> > > 0     0  50000> > 
> > >    pll-video1-2x               1        1        0   654000000         
> > >    0     0  50000> >    
> > >       hdmi-tmds                1        1        0    25153846         
> > >       0     0  50000> >       
> > >          hdmi-ddc              1        1        0       89835         
> > >          0     0  50000> > 
> > > [/snip]
> > 
> > I guess you'll need to track down when the hdmi-tmds and hdmi-ddc are
> > enabled and disabled, and if it makes sense :/
> 
> OK, figured out the cause.
> 
> Apparently, for each ddc poll we enable ddc clock which is a child of TMDS
> clock. After transfer is done, we disable the clock and this also tears down
> the parent because its only user has gone missing.. :(
> 
> 
> So basically, patch below also works, but I guess we should override
> the sun4i_tmds_ops.disable to properly account for tmds clock use.
> 

As far as I can see, nobody called clk_prepare_enable() on tmds clock. I had 
similar issue with TMDS clock for H3, since I based code on sun4i tmds clk 
driver. Although clock doesn't have enable bit, it still has to be done to 
have proper reference count and to prevent issues like this.

BR,
Jernej

> ---
> @@ -225,7 +235,7 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
>         init.ops = &sun4i_tmds_ops;
>         init.parent_names = parents;
>         init.num_parents = 2;
> -       init.flags = CLK_SET_RATE_PARENT;
> +       init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
> 
>         tmds->hdmi = hdmi;
>         tmds->hw.init = &init;
> 
> > Maxime





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
