Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:26:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F042147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UYHtShgW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzKgjW3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F042147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zgbi2E4QvCw+Sociuha4hfrEkbLYfFTRBG6U+N56koA=; b=UYHtShgW5xDUvQ
	skJ/SEsYa/YMty+5wmn9ClHMhNmVPOE239IjE9Ge7NcN+fUf3hBkAelmPdA3ZvFWDmhHjemRD2DJK
	a6oineX5y/uEMz8JyJus+8b834mlfFZG3bn1V48pdBZii5aqk3fEOhkpcLwlF2Sfdo2JLr8LQpSNM
	/wgoG7c6Qc2DWfxlXesFMkRNHGpA4w62R/DRgXFb+jUdK/BTgBoV0sRXhNwIdEuqlyVRFMWD3FE4x
	YGvorikQuzrjkdeDUa/jvhUbQKRkKE8uZiyq/7wGFREjRfIQuNTv1ujEcWFRiR4KAHGHHDEcMnQcV
	VhtiBxQXShtCxJjgiG8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwCu9-0007vr-Az; Tue, 19 Feb 2019 21:26:17 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwCu6-0007vP-Ik
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 21:26:16 +0000
Received: by mail-ot1-x344.google.com with SMTP id 98so36933685oty.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tShKv+rCj4cb7oTii69qoiNaguPqqY5jERkY1mOdgTM=;
 b=DzKgjW3Ab2k8LY+wa0b4QdOUykt3EMt1/XZqpstcRerFKA9xBuMKrrdd+72r8XI9yy
 XaajW+aOFG7XEphSg4WkRmeiQDEwlRp+8RxL1vK0qiSHfOoFgdmKyqJWyMHWNMpAsSIn
 81Vp09gttURJG9sFlp8vaFeNp3McRcEgkjVD+BB4b5+nUbu1NKJHmLzaM6Y20eTy2H6x
 UWHbFbE2tfgCofhy4RE3V/65lx94pbnEnfUaWGMCNtOlqBTyLcurLJ3wTUriODulnw4M
 7UV1AtNgTeTLJ8NWMLT5uGj2dx2CHa44rWmMmc5gPnxLbYWIYMogrjB53QcwEsvuZMje
 6VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tShKv+rCj4cb7oTii69qoiNaguPqqY5jERkY1mOdgTM=;
 b=t/K96tCcXa8N2t1h+o6ecSVk+SD2xXpMfAqcOYSsq1m4AaYgeTdJIqorMLAmkzeIjR
 PQLCnRHWlJYX+FAIGECQYPFruizCUemj6VQuoHOjBO4DHiBfeaD28t7hrKiLUnqpzLJw
 Dvj7/JcGD7HwZeqpmWbqvL0wo8qyY8Y856B8GLPJFc7AVVO5SPkz4HgRUXDGvpJb0+vw
 P89pRw+vhsL4LU5d0QXgCOR4Du6sdc4wbqyepj8gT8FRoJGz+u6Xs4+9JtNBPpqV8Hbe
 tlgLBopluSL0BIrk5ZXxZa4iq54/WE5OHJBrrUNEGgra4JJIvQSIS0THKvryqvntYKwJ
 D8OQ==
X-Gm-Message-State: AHQUAuZ6nBkO3R2dFOvvyoOHGjzvmTAovDOlv/oZlsI7bUQy5gkefkJz
 /rhkKMmqngCoR4NUizT8m2KHnv2jYNwUe5GeI1Q=
X-Google-Smtp-Source: AHgI3IYscnf3cOH1ASQ/+LIT3zFXVhlWpKS6nUKk00gm3SV0dcsdihIG+KU/oX1k/KU6jcNTU0Z9MvuT4GcWox8Olo8=
X-Received: by 2002:aca:c142:: with SMTP id r63mr3962109oif.98.1550611573153; 
 Tue, 19 Feb 2019 13:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 19 Feb 2019 13:25:46 -0800
Message-ID: <CA+E=qVf44XBEGHY6NoQZrvkodCs2UX7xFkHZ5vs6A5TCAXr1oA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_132614_651014_F3DE0882 
X-CRM114-Status: GOOD (  21.36  )
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
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 6:14 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Feb 18, 2019 at 3:24 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > new file mode 100644
> > > > index 000000000000..8357f242ae4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > @@ -0,0 +1,35 @@
> > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > +---------------------
> > > > +
> > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > +to upload firmware and change module speed.
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: should be one of the following:
> > > > +   * "realtek,rtl8723bs-bt"
> > > > +   * "realtek,rtl8723cs-bt"
> > > > +Optional properties:
> > > > +
> > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > >
> > > How is this used?
> >
> > rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
> > another is firmware config which is specific to the board. If
> > firmware-postfix is specified, driver appends it to the name of config
> > and requests board-specific config while loading firmware. I.e. if
> > 'pine64' is specified as firmware-postfix driver will load
> > rtl8723bs_config-pine64.bin.
>
> We already have 'firmware-name' defined and I'd prefer not to have
> another way to do things. The difference is just you have to give the
> full filename.

OK

> Also, on other chips with board specific config blobs, there's been
> some discussion of converting those to DT properties. That depends on
> you knowing what's in the blob and having a reasonable number of
> parameter to make properties.

We'd have to RE binary format of this config first.

> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
