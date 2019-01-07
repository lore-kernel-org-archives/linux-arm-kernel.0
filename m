Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F02C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5815A213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HDKv1nk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5815A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6EnDqxrL+5ksZXl0dvfbOUGAfealKHVkmGj9eNoKN9k=; b=HDKv1nk8PCRO0K
	CNilW9rfb7kf4fiQYi2YOmyTFUWWpg90HU3tdIWxZtOY1p63nzT/6qgScqdTzWlTPUsbgDSPS2n4x
	qaIxdcEezy7t9pjtXVwRioqgzdXLsxhu39OS317Y9++GyY0SFxk6E5FPYKZ3lWH8X0kqKiHCe1ssg
	LGYr1AU0py+Qi2PUAaVb3QjlfIp/jMK21H0WtR4ttjNHyMclhAZsobXsXsFh7PAWtLpPpFd147oC3
	CNsrg4TZPn0wX5peaD+DOA3wkTa03jgEm/qCRCidpc3j7Jze5xSDVEEGyO8H/FjfF/aTfEeF7pTpn
	Y3lfZPdUGbL3gCyrOcDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggNKw-00023X-Qe; Mon, 07 Jan 2019 05:20:30 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggNKt-000238-DF
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 05:20:29 +0000
Received: by mail-ed1-f65.google.com with SMTP id g22so36699260edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 21:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z3MYpxG11VE2ZJ1b3f4Z820yibm6Cz7qhfanB0XAw6M=;
 b=CDebi0/zb16YRXVaEltdWhNVOqM+XnSnEVZO0xDEiPcHPMpVghuOZEmdaf7DhbWfSQ
 JqS4dw2Ad0TYTqv75Azq4LI5tE/1iD/NIy9YzXhetF11Dw7ghixyyJCoeUeChCtDbgsG
 nrTWx6ObE69N18fhpK0+54W2Yb4lsTH7kbT8tTSaG+JZJWwIUTX6xy7yAThUTynXT4mj
 aGuARoGXURZcPKwtIUevw9bG8lsc5B45kgTN8ZRF8/Kzfv5AI/QBMk49vZ23z9xHD3rj
 jcApYjitp45vyEK86yuonrzp02fYMqaSrFbTshqs+AL1L4f2oKDWhH7Rewv2o/tmKtVT
 CI4g==
X-Gm-Message-State: AA+aEWZhtmWBFyynQfNOX7gTLML0GpRVN54r/gSqc9XfT9ds5YSUJOQV
 RibOe052/UGJ9Wo46pR8V9I2NTiCtxE=
X-Google-Smtp-Source: AFSGD/Wri+Ci7g7vyg8Wk5Z6HFbDTFK1lGY/qCDbc8wSPocfjFbefFJlc7Choh48qMrjgyo+HeHxcA==
X-Received: by 2002:a50:95b4:: with SMTP id w49mr53584241eda.186.1546838424589; 
 Sun, 06 Jan 2019 21:20:24 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49])
 by smtp.gmail.com with ESMTPSA id b45sm34742710eda.34.2019.01.06.21.20.24
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 06 Jan 2019 21:20:24 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id z5so41869038wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 21:20:24 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr49988560wrs.44.1546838423934; 
 Sun, 06 Jan 2019 21:20:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 7 Jan 2019 13:20:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66m-BtUaWkOvjiaO1LybikqxVn-S7uOE9zV6QW9KHLL8Q@mail.gmail.com>
Message-ID: <CAGb2v66m-BtUaWkOvjiaO1LybikqxVn-S7uOE9zV6QW9KHLL8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Deal with per-bank regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_212027_448142_4872C27F 
X-CRM114-Status: GOOD (  17.81  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Mylene Josserand <mylene.josserand@bootlin.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 10:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The Allwinner SoCs have on most of their GPIO banks a regulator input.
>
> This issue was mainly ignored so far because either the regulator was a
> static regulator that would be providing power anyway, or the bank was used
> for a feature unsupported so far (CSI). For the odd cases, enabling it in
> the bootloader was the preferred option.
>
> However, now that we are starting to support those features, and that we
> can't really rely on the bootloader for this, we need to model those
> regulators as such in the DT.
>
> This is slightly more complicated than what it looks like, since some
> regulators will be tied to the PMIC, and in order to have access to the
> PMIC bus, you need to mux its pins, which will need the pinctrl driver,
> that needs the regulator driver to be registered. And this is how you get a
> circular dependency.
>
> In practice however, the hardware cannot fall into this case since it would
> result in a completely unusable bus. In order to avoid that circular
> dependency, we can thus get and enable the regulators at pin_request time.
> We'll then need to account for the references of all the pins of a
> particular branch to know when to put the reference, but it works pretty
> nicely once implemented.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

I'm getting a warning on my Bananapi M1+:

[  +0.004918] sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply
vcc-pa not found, using dummy regulator
[  +0.009931] sun7i-dwmac 1c50000.ethernet: PTP uses main clock
[  +0.005764] sun7i-dwmac 1c50000.ethernet: no reset control found
[  +0.006111] ------------[ cut here ]------------
[  +0.004640] WARNING: CPU: 1 PID: 1 at drivers/regulator/core.c:2054
_regulator_put.part.8+0xf8/0xfc
[  +0.009065] Modules linked in:
[  +0.003085] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1 #5
[  +0.006179] Hardware name: Allwinner sun7i (A20) Family
[  +0.005252] [<c010eaf0>] (unwind_backtrace) from [<c010b854>]
(show_stack+0x10/0x14)
[  +0.007755] [<c010b854>] (show_stack) from [<c089ac28>] (dump_stack+0x88/0x9c)
[  +0.007233] [<c089ac28>] (dump_stack) from [<c0127450>] (__warn+0xd4/0xf0)
[  +0.006881] [<c0127450>] (__warn) from [<c01274ac>]
(warn_slowpath_null+0x40/0x48)
[  +0.007576] [<c01274ac>] (warn_slowpath_null) from [<c03fd25c>]
(_regulator_put.part.8+0xf8/0xfc)
[  +0.008876] [<c03fd25c>] (_regulator_put.part.8) from [<c03fd288>]
(regulator_put+0x28/0x38)
[  +0.008446] [<c03fd288>] (regulator_put) from [<c03c5f2c>]
(sunxi_pmx_free+0x38/0x48)
[  +0.007837] [<c03c5f2c>] (sunxi_pmx_free) from [<c03c2444>]
(pin_free+0x9c/0xfc)
[  +0.007402] [<c03c2444>] (pin_free) from [<c03c2fb0>]
(pinmux_disable_setting+0x118/0x184)
[  +0.008271] [<c03c2fb0>] (pinmux_disable_setting) from [<c03c0060>]
(pinctrl_free+0x13c/0x144)
[  +0.008619] [<c03c0060>] (pinctrl_free) from [<c048c6a0>]
(release_nodes+0x1bc/0x200)
[  +0.007839] [<c048c6a0>] (release_nodes) from [<c0488964>]
(really_probe+0x110/0x2cc)
[  +0.007838] [<c0488964>] (really_probe) from [<c0488c84>]
(driver_probe_device+0x60/0x16c)
[  +0.008270] [<c0488c84>] (driver_probe_device) from [<c0488e6c>]
(__driver_attach+0xdc/0xe0)
[  +0.008444] [<c0488e6c>] (__driver_attach) from [<c0486d44>]
(bus_for_each_dev+0x74/0xb4)
[  +0.008184] [<c0486d44>] (bus_for_each_dev) from [<c0487edc>]
(bus_add_driver+0x1bc/0x200)
[  +0.008270] [<c0487edc>] (bus_add_driver) from [<c04897ac>]
(driver_register+0x74/0x108)
[  +0.008098] [<c04897ac>] (driver_register) from [<c010270c>]
(do_one_initcall+0x7c/0x1a8)
[  +0.008187] [<c010270c>] (do_one_initcall) from [<c0d00e14>]
(kernel_init_freeable+0x13c/0x1d8)
[  +0.008705] [<c0d00e14>] (kernel_init_freeable) from [<c08b08b8>]
(kernel_init+0x8/0x110)
[  +0.008184] [<c08b08b8>] (kernel_init) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[  +0.007570] Exception stack(0xef04ffb0 to 0xef04fff8)
[  +0.005054] ffa0:                                     00000000
00000000 00000000 00000000
[  +0.008180] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  +0.008179] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  +0.006654] ---[ end trace 2bdb4a597b3c54ef ]---

Note that sun7i-dwmac probe is deferred here. The instance where the
probe succeeds shows
no warning.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
