Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:49:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E56E21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGzTO9Fc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJVf1YKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E56E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7C1xfWZ3DEwnkrhQNY/pZFy1aOUNTXi4BCgp1Fz8ub0=; b=IGzTO9FccinNMBN4RDkRyuUjPs
	3GEDn+tAbk6hYGMpuQgIDqgKBGqtlJ4IPO/37A5SzDMzGxdX10RJO4wvGlaOY+qXZkLQqi0YggcEE
	F02sOk/IMvTTaqoudAlbV3Y8jqf63nTYPzxGeqZPfm+OuUky05R4KpUPwrchFAWsqo0yLSeT1Gu2K
	tIo296abMMq9KE6DHYzVINrRnczWS99CKADEDdFzS9A2euorQGaxwdDSBUZ6j+nXyx13BBbXx/Rvo
	Vzdv9b0KZUPegayP9/9qAiteYVSTxfjY3ViSNKx/o3RZoWOd4c7QAMQGVs9bw36HfRDi2pMpxJE5V
	OmroHpFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMpt-0002LX-I4; Sun, 03 Feb 2019 18:49:45 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMpq-0002LA-Q5
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:49:44 +0000
Received: by mail-ot1-x342.google.com with SMTP id e12so10380297otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=QWkuor+4Z3V9vIFqJSfnNp+6j0j81CDNv2vxUAjFvgs=;
 b=XJVf1YKefTPuMyPXQKLaluQ4hLaUEvL5aeHOLM9WLhUix/GFoVbmdBPM0STNjl9uxZ
 Jv72zOVzKxhKLnPTfhJy/QlZzM8qaGZLTMJUeWYl3qsqyGcpXkpv7H6U5x5RXHF1TY5q
 5bSgYjc8Q+qM380bAljP7QatScC8ziWNhYL9I/wPFYwh93xO7l9Lfn3UqdcJXigmHdjD
 Si7eBrm4mSIOlpPBq5MoP3/ZzrSeNByBcymlP0/kHG0I9cZcfVzMGISvZbynIiFwiK46
 SoekFP8VcDK5msbLhOCq3s3Dd1FA4xuGg2YaHzwYdAtRyJMaaFSTj4DcUzuC9wT7fusV
 FesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=QWkuor+4Z3V9vIFqJSfnNp+6j0j81CDNv2vxUAjFvgs=;
 b=qSfmZcoe6+xXv9qkmi8J19eURvA5HwoCy2Y8CofO1alMYxEdyUPOd92p3BX0B3lk9g
 lArbWjKPvqOfklk2ycKhNxyIKm4wbdXb7GjYmde4QdEK2d++sGYKVsd5kOC/13WLcM7G
 2HyzTyqdiQcOoBGEQG9JOrsbLA/4/MRP5Xd3oMrMXLtRtq6E7l/cjYIglMFpBwi9jcI1
 oQ6y4iOqBiEVPeruJdNnUNAEnBkYnRUFd3NJunAVaLjU/dKc+x7eYjgYOdrgTwGBXj0g
 7q/OCaq8OVDAc3yVq7QWdsuzFLj4x/y7gmZXzUbC3bXFVTJlKEZ7uOmFns2sj2fVvNcg
 LJiA==
X-Gm-Message-State: AJcUukcu+EB12G8xVSFGpbNCmFpV94w3Z1DfV+cNFQl5YAwn95BPcGxr
 55vy0RoXnTxhtK5kNgxIDUovNUAkD1iP73mrKSA=
X-Google-Smtp-Source: ALg8bN45Pe6ARuTMWwrXAZab21lGwdhvi81b4S5Ugl+3+dRgeIIrlToBx03CdLlqykr3iZne2VmiK0rTWvxQTj/6JlE=
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr33509033otf.111.1549219780911; 
 Sun, 03 Feb 2019 10:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20190203184450.8050-1-anarsoul@gmail.com>
In-Reply-To: <20190203184450.8050-1-anarsoul@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sun, 3 Feb 2019 10:49:14 -0800
Message-ID: <CA+E=qVexoHVt1SHFeHqdqjuj_x79yNvMLJeEch1Qu-Az3t9dfg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Analogix ANX6345 RGB-(e)DP bridge support
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, 
 Chen-Yu Tsai <wens@csie.org>, Archit Taneja <architt@codeaurora.org>, 
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 devicetree <devicetree@vger.kernel.org>, 
 arm-linux <linux-arm-kernel@lists.infradead.org>, 
 linux-sunxi <linux-sunxi@googlegroups.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_104942_858674_2B8787B5 
X-CRM114-Status: GOOD (  19.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Oops, looks like I screwed up with recipients list.I'll resend the series.

On Sun, Feb 3, 2019 at 10:44 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> This patchset brings support for Analogix ANX6345 RGB-(e)DP bridge, which
> is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> TERES-I.
>
> It reuses some definitions from ANX78xx driver that already exists in the
> kernel tree, but the driver code itself is rewritten due to significant
> difference between ANX6345 and ANX78xx.
>
> This patchset also enables the bridge on Pinebook and TERES-I and adds 1%
> tolerance into dotclock check in sun4i driver in case if bridge is
> connected
>
> v2: - sort Kconfig and Makefile entries alphabetically
>     - remove panel supply from anx6345
>     - add support for panels into anx6345 driver
>     - add compatible and binding for generic eDP panel
>     - replace patch that adds 5% tolerance for dotclock check in sun4i
>       driver for panel and bridges with patch that adds 1% tolerance
>       in case if bridge is connected.
>
> Icenowy Zheng (8):
>   drm/bridge: move ANA78xx driver to analogix subdirectory
>   drm/bridge: split some definitions of ANX78xx to dedicated headers
>   drm/bridge: extract some Analogix I2C DP common code
>   dt-bindings: Add ANX6345 DP/eDP transmitter binding
>   drm/bridge: Add Analogix anx6345 support
>   arm64: allwinner: a64: add pinmux for RGB666 LCD
>   arm64: allwinner: a64: enable LCD-related hardware for Pinebook
>   arm64: allwinner: a64: enable LCD-related hardware for TERES-I
>
> Vasily Khoruzhick (4):
>   drm/sun4i: rgb: Add 1% tolerance to dclk frequency check when bridge
>     is connected
>   drm/panel: simple: don't fail if we don't have panel desc
>   dt-bindings: add binding for generic eDP panel
>   drm/panel: simple: add generic eDP panel
>
>  .../bindings/display/bridge/anx6345.txt       |  56 ++
>  .../bindings/display/panel/panel-edp.txt      |   7 +
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  74 ++
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  71 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   9 +
>  drivers/gpu/drm/bridge/Kconfig                |  10 -
>  drivers/gpu/drm/bridge/Makefile               |   4 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.h     | 719 ---------------
>  drivers/gpu/drm/bridge/analogix/Kconfig       |  25 +
>  drivers/gpu/drm/bridge/analogix/Makefile      |   4 +
>  .../drm/bridge/analogix/analogix-anx6345.c    | 845 ++++++++++++++++++
>  .../bridge/{ => analogix}/analogix-anx78xx.c  | 146 +--
>  .../drm/bridge/analogix/analogix-anx78xx.h    | 265 ++++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.c   | 169 ++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.h   | 258 ++++++
>  .../bridge/analogix/analogix-i2c-txcommon.h   | 240 +++++
>  drivers/gpu/drm/panel/panel-simple.c          |  24 +-
>  drivers/gpu/drm/sun4i/sun4i_rgb.c             |  16 +-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
>  19 files changed, 2049 insertions(+), 894 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
>  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (90%)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
