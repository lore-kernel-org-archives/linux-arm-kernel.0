Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3642C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A093920818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SbV1/yjS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH2222xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A093920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g0ChOukXh1/iNtpt6l9nlBySbVJeLA+Z4raufZeoh8w=; b=SbV1/yjSFED6AK
	zPwqCpWZQowuTJje0NhU23OTxna1Y/FhKsRD/H505LBq0HwUwCsctlNpg5+VPNDx1Sxod2wvhWUX2
	823mZXTT5/xPP7zsbMfD9qErRKdXn2IbjV+VK9B2sk+vYl+l2xPc9rqP0i82bqwaK4nWZ0fKKfjZu
	6udW5CtSOOW8THiatO5Ihr1VKQaS1vWF65DsIoz0UjcwMtP6FxyAKZ13+BlscFHk5aXaV8WCpjiZH
	vVK4w0UcrmLoOpR5U39GLAoxNQHBpfcvOxFLfhvNHmCOcenY9GRsAuAjeeXGM/0rP6icpqQdoklNu
	hwaLPe4oarWMftoYgu1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw7Dp-0008JC-WF; Tue, 19 Feb 2019 15:22:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw7Dm-0008Im-GH; Tue, 19 Feb 2019 15:22:11 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A468121903;
 Tue, 19 Feb 2019 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550589729;
 bh=nWrp3hRt+m/nWI1jpFziRhc1dk8W/7e+eu+0/lLsSuk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fH2222xkFAwQphhNO87XJwKnDMy6hs/hiOYFc7un/JyK0Dng3BcSyJWLXskIl/1j/
 Y/RRpjwvzhecmFG/3r+jJvbxHYegf8MR8ev73KRu6AQLwinJ94EFXkr/9nshp4E9va
 u3t1+1esuPBWmd+wxQla7hyAkaNoKxz+h3yA/fyk=
Received: by mail-qt1-f170.google.com with SMTP id v10so23513477qtp.8;
 Tue, 19 Feb 2019 07:22:09 -0800 (PST)
X-Gm-Message-State: AHQUAuaT0xnfJZX9WQckg7aXHwYlTfXwBWxBpUWQdmllcxKvWQmagG+A
 ieSoV7BKR8zo6UrwsSZgxU4GMTs9kOjzRICuOg==
X-Google-Smtp-Source: AHgI3IZ8hSkfBrnjFm51aMPEPzA4H/4KOCD8rtwWi0pAdp5c6cvDqtwNDEyLJmh2A82Vjgpo1ZygklPp5RoOslsWz3Q=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr22638752qta.76.1550589728749; 
 Tue, 19 Feb 2019 07:22:08 -0800 (PST)
MIME-Version: 1.0
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
 <20190218163211.GB2714@bogus> <1550544357.4739.32.camel@mhfsdcap03>
In-Reply-To: <1550544357.4739.32.camel@mhfsdcap03>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Feb 2019 09:21:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgp615eJZnSu6aogzLwubnBKdxdU8+19hj=hS1aOWefA@mail.gmail.com>
Message-ID: <CAL_JsqKgp615eJZnSu6aogzLwubnBKdxdU8+19hj=hS1aOWefA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_072210_574068_686A53FC 
X-CRM114-Status: GOOD (  26.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erin Lo <erin.lo@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Mars Cheng <mars.cheng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 8:46 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> On Mon, 2019-02-18 at 10:32 -0600, Rob Herring wrote:
> > On Fri, Feb 15, 2019 at 02:02:35PM +0800, Erin Lo wrote:
> > > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > >
> > > The commit adds mt8183 compatible node in binding document.
> > >
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > new file mode 100644
> > > index 0000000..364e673
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > @@ -0,0 +1,115 @@
> > > +* Mediatek MT8183 Pin Controller
> > > +
> > > +The Mediatek's Pin controller is used to control SoC pins.
> > > +
> > > +Required properties:
> > > +- compatible: value should be one of the following.
> > > +   "mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > > +- gpio-controller : Marks the device node as a gpio controller.
> > > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > > +  binding is used, the amount of cells must be specified as 2. See the below
> > > +  mentioned gpio binding representation for description of particular cells.
> > > +- gpio-ranges : gpio valid number range.
> > > +- reg: physicall address base for gpio base registers. There are nine
> > > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > > +  0x11F30000.
> >
> > You don't need to list out each address, just what each address is. (Or
> > just '9 GPIO base addresses'.)
>
> ==>ok, we will change it.
> >
> > > +
> > > +   Eg: <&pio 6 0>
> >
> > How is this an example of reg? Seems something is missing.
> >
> > > +   <[phandle of the gpio controller node]
> > > +   [line number within the gpio controller]
> > > +   [flags]>
> > > +
> > > +   Values for gpio specifier:
> > > +   - Line number: is a value between 0 to 202.
> > > +   - Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > > +            Only the following flags are supported:
> > > +            0 - GPIO_ACTIVE_HIGH
> > > +            1 - GPIO_ACTIVE_LOW
> > > +
> > > +Optional properties:
> > > +- reg-names: gpio base register names. There are nine gpio base register
> > > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > > +- interrupt-controller: Marks the device node as an interrupt controller
> > > +- #interrupt-cells: Should be two.
> > > +- interrupts : The interrupt outputs from the controller.
> >
> > outputs? More than 1? If so, need to say what they are and the order.
> >
> ==> there is only use one interrupt in mt8183. we will change
> "interrupts" to "interrupt" in v8.

No, 'interrupts' is always plural. The problem is 'outputs'.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
