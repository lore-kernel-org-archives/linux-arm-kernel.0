Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3F2C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FDC218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AwrNxm00";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHTFFR3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FDC218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eTwkLFd2GrZgVpWMk35VEpNhB75YaeKeU/uXtboNLGk=; b=AwrNxm00khQl8F
	t71QfYQGZ2w5Rkq5Kho5sniEOZZ/MWDgh9naNbNONHaUMJEyPFSt4JN21Vwi6kQCpyKdZwUGrP8Cc
	jkRcmm8zvziDcdIkGjg7wUzFgud521DAK1w370OlJjaQ2IoOWD4wVbkr/Q/1IXHiNPJjVg3xyWa2E
	NAlHGBcybBMMrxwKE/owqcfaI7LZPksH5FnpBz833rRu/3ALdPIhDD5MPJsN6nGIpzTUevL/j40BN
	jqgbOMnvfsaFwZclWKrPVZquoLR6MoVujRIkMcyFlzKCRtcMOxPPnUHI/p+xb7+lc9HLh5YvoTOF9
	LzYmLaZ8pgtgI4LY3GEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfS3F-0007qS-V4; Fri, 04 Jan 2019 16:10:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfS3C-0007pf-E8; Fri, 04 Jan 2019 16:10:24 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1D7E218EA;
 Fri,  4 Jan 2019 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546618222;
 bh=nTaQpQiBruavmbR2hIkJLXAjgq+PPgj4FZEDF94KIlY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OHTFFR3X96s4a63cgoE3/MxfqnkE6fizzSfVVfNZVKoKklKkZkqeFAErRQ1v20dBO
 GIAkv40CLcz0zxDArfrl2bssaBq/i+tgJdX7rMMiI+PYuXhDITpScEJZFSbupK0XAN
 NFmgebUi0e+r4dbWWhEER42crdhQbd0kbFqhxjn4=
Received: by mail-qt1-f173.google.com with SMTP id l12so40807161qtf.8;
 Fri, 04 Jan 2019 08:10:21 -0800 (PST)
X-Gm-Message-State: AJcUukd5XvwwKuf8EfU9ejY3xwLpC1qOhrcBA0dOFv006jFBUYeALmah
 mzYIcNduRJn+MLSLxHVMwfE7DEII6krcaV8ZKg==
X-Google-Smtp-Source: ALg8bN7FQZhVmdiK/UO10+dik3k6PM7Pw9UzxPOGWYBkjuzr/JOTDnai0t523prqpoz9264Q4x8sKdQAd/wfYWSCGiQ=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr50455640qve.246.1546618220971; 
 Fri, 04 Jan 2019 08:10:20 -0800 (PST)
MIME-Version: 1.0
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com>
 <20190103221414.GA14639@bogus> <1546570807.585.31.camel@mhfsdcap03>
In-Reply-To: <1546570807.585.31.camel@mhfsdcap03>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Jan 2019 10:10:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
Message-ID: <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek musb
 controller
To: Min Guo <min.guo@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_081022_515231_9551180C 
X-CRM114-Status: GOOD (  20.98  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Bin Liu <b-liu@ti.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 9:00 PM Min Guo <min.guo@mediatek.com> wrote:
>
> On Thu, 2019-01-03 at 16:14 -0600, Rob Herring wrote:
> > On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> > > From: Min Guo <min.guo@mediatek.com>
> > >
> > > This adds support for MediaTek musb controller in
> > > host, peripheral and otg mode

[...]

> > > + - interrupts      : interrupt used by musb controller
> > > + - interrupt-names : must be "mc"
> >
> > -names is pointless when there is only one.
> The MUSB core driver has two interrupts, one is for MAC, another for DMA,
> but on MTK platform, there is only a MAC interrupt, here following the binding
> of MUSB core driver.

You should probably be listing the same interrupt number twice if 2
interrupts are combined.

> > > +Optional properties:
> > > + - extcon : external connector for VBUS and IDPIN changes detection,
> > > +   needed when supports dual-role mode.
> >
> > Don't use extcon for new bindings. The usb-connector binding should be
> > used instead.
> This is used to detect the changes of the IDPIN and VBUS, the change
> events are provided by other drivers, such as extcon-usb-gpio.c, and
> then switch MUSB controller to host or device mode, but the
> usb-connector can't detect these changes.

To repeat, do not use extcon binding for new bindings. It is poorly
designed as it reflects extcon driver needs, not a description of the
hardware. If you have ID on GPIO, then that belongs in a usb-connector
node because that GPIO goes to the connector. For Vbus, you should
have a vbus-supply in the connector and use a gpio-regulator if it is
GPIO controlled.

> > > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > > +   dual-role mode.
> >
> > The controller is powered from Vbus? Probably not. This belongs in the
> > connector or maybe the phy (if the phy is powered from Vbus).
> The Vbus is used to provide 5V voltage to the connected device when the
> controller works as host mode.

I know what Vbus is. Unless Vbus is providing power to the host
controller, putting the Vbus supply in the controller node is not a
accurate representation of the hardware.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
