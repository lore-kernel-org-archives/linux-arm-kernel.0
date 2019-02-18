Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A888820C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CS5sETGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A888820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JxhastmtcLhasIZth7RPVNaPQ+kJ2xb7nzLKuFcjfD8=; b=CS5sETGpuvdj81
	F+71PTNp0bokbG4QeuC05f5mS2mU2Ua2vpPXXW+vXODjSgG4NP5mDi/B7jR3lVcqxk2v2xFhPiTjY
	sDMuam1oIz5KjA6rBTIgga9J/uMtaDu8lt+o0oz/zSZS2C2URXi0lzXEm6Purw5Ns708MpFoOAfAd
	hwJbyjYvsDEy1E8Iz26qQEf6yIDyp+kZWtY4ewf/P11xCyx4LmFSXXZSIak7mRRrdvkUmiyD4Bzob
	Mdv5UfY3oC7wQ/+raAzFA1zLGbdH0XIvnDKgqZNDobMqr9eZ96RhRWCDDYHKr9N2G//lQpTDyOAXa
	4LOS/qnrfhy/Nstjh3OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvl9i-0005TU-AT; Mon, 18 Feb 2019 15:48:30 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvl9e-0005SL-1Z; Mon, 18 Feb 2019 15:48:27 +0000
Received: by mail-ot1-f65.google.com with SMTP id g1so28909894otj.11;
 Mon, 18 Feb 2019 07:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Y6yxkg7qrm3Yj/JlHLGtkgFxQYAdQMcxpMZZhqrjvyc=;
 b=GfuBsMb0GHtsQx9MUvm4B7Rp3Qn0K8CXFG66R7o4k0UY8Lx3MvmrnDmvz4EwC4QcbV
 nLNd+5jOWFoHi9JMh/6wQACfNP94+oTvuMeJE3cNQvWZ+Tl13xY4/q/P7NANDkcVRZHs
 6bdCYP/wavOQFJ5i699mb/jhYbuaCwyX7ioBMKN2QvFCIZv5+KeHPOO+HlaVVV9aUJ2v
 N9kPzAR1tbPOvHAm2hxMK6eTbH5/ZoA9LsEkt+fMewbrBHkuJOU3yeZpCOlHRYXlKaC8
 NoZoHqMlwPL5zI7wM19CwJcYF47AtXiTEnVYJ4N8Ccyuu765lsJcLixxSCkSGUl2kl0k
 gzwg==
X-Gm-Message-State: AHQUAuae0Wxo1PvYn7jhfF+gYC1cH1KMQ0oW5FjOjYGkT9VaDruEjRUh
 enTpq4ByCT9pMULSRU4HJw==
X-Google-Smtp-Source: AHgI3IYwDLG9UKzh+4ytyV2W6xeyPi2GNZirFS/yQlzqBnFYv4s5jdqzanKWrjRhfZY443wznRPRiQ==
X-Received: by 2002:aca:4a15:: with SMTP id x21mr14156415oia.122.1550504905275; 
 Mon, 18 Feb 2019 07:48:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k16sm5814336otl.58.2019.02.18.07.48.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 07:48:24 -0800 (PST)
Date: Mon, 18 Feb 2019 09:48:23 -0600
From: Rob Herring <robh@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
Message-ID: <20190218154823.GA2714@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
 <2b221339-3933-2a25-ab60-d4d772d2873a@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b221339-3933-2a25-ab60-d4d772d2873a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_074826_080778_8E74A35B 
X-CRM114-Status: GOOD (  22.68  )
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
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Zhiyong Tao <zhiyong.tao@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, mars.cheng@mediatek.com,
 yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
 eddie.huang@mediatek.com, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 10:35:39AM +0100, Matthias Brugger wrote:
> 
> 
> On 15/02/2019 07:02, Erin Lo wrote:
> > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > 
> > The commit adds mt8183 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > new file mode 100644
> > index 0000000..364e673
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > @@ -0,0 +1,115 @@
> > +* Mediatek MT8183 Pin Controller
> > +
> > +The Mediatek's Pin controller is used to control SoC pins.
> > +
> > +Required properties:
> > +- compatible: value should be one of the following.
> > +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > +  binding is used, the amount of cells must be specified as 2. See the below
> > +  mentioned gpio binding representation for description of particular cells.
> > +- gpio-ranges : gpio valid number range.
> > +- reg: physicall address base for gpio base registers. There are nine
> 
> s/physicall/physical
> 
> > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > +  0x11F30000.
> > +
> > +	Eg: <&pio 6 0>
> > +	<[phandle of the gpio controller node]
> > +	[line number within the gpio controller]
> > +	[flags]>
> > +
> > +	Values for gpio specifier:
> > +	- Line number: is a value between 0 to 202.
> > +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > +            Only the following flags are supported:
> > +            0 - GPIO_ACTIVE_HIGH
> > +            1 - GPIO_ACTIVE_LOW
> > +
> > +Optional properties:
> > +- reg-names: gpio base register names. There are nine gpio base register
> > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > +- interrupt-controller: Marks the device node as an interrupt controller
> > +- #interrupt-cells: Should be two.
> > +- interrupts : The interrupt outputs from the controller.
> 
> we are missing interrupt-parent here.

No, because interrupt-parent is implied and may be in a parent node.

What's missing is how many interrupts and what are they? 

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
