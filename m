Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80174218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmoMaQ7A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H790KpFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80174218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=brhCxo8qtVMhyvb/I5G+ETgGCBcJDYbeX2LyIExLtEI=; b=mmoMaQ7A7gPntl
	/MP9iYX2/0L6/HKFhNnQO+o7yYlgFVaWbYqm3avWooJVGfj9yGFeQCIU3Gzd0VNTvtddPrT/ft4kp
	BeVvwyRmzDVGIaYT22Pfx+yIbmDa9rhckP1Ej4Pw5aEcBcEyFgn48uVzOPz1tYvIS04FB3HMPFZNC
	k9eJHKZeFf3AVrozUWHs1dpCe27X2pz0BIXdHnkxNAt6pWpGANUL1O2NrbJTknNg9cw+xSww3b2sq
	D7JvdfmppshBrTTavYUReKeoffU2irI3kbv9gXWHi7bVeTw/g5GgoyD9X24QdBJ4jnHwfoEBZOtoF
	yWF/qEsVTaiOjE3d5qYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZIw-0007p5-JY; Wed, 19 Dec 2018 10:42:18 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZIr-0007oM-Su
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:42:16 +0000
Received: by mail-io1-xd43.google.com with SMTP id t24so15265428ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 02:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I6I5jg1KYTO2ZnWGYRIpKrCIH1+bHKYeEMYRuF+H5c0=;
 b=H790KpFAEYAQoQeZjDOttAcOsXVLrqqdPiNnYIFV2Nxb//W/fM+mUYSPhrgN6U/ZPk
 UTXj9hYY6l9NaR+NukYoXtbdq1wIxSt0rMcn46lyx/hbRMtFaMIavl+5CuTh7iQ2Wiij
 B/9ycdQVLsO6qAUn1piM3+8j5ScHSorl5SSqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I6I5jg1KYTO2ZnWGYRIpKrCIH1+bHKYeEMYRuF+H5c0=;
 b=mYZ8d7BOkyN0UKZZs6Wq030xSi7iZGS86VBS3Ph8idGmnsvWqq92YNuqS53js3/ksy
 g6rTi+w9AHE53jmLLw/RCix+qlZgpbZDFNDMbike3yc2GBrvN4l8c1Kh7Nzr80OCC54m
 gem2uGTJftruRGYNbNFkR0/dwMJgvoI0Hopm5qHjC9v8aEk9UJJ+/7XUTgiSN4EiyT9H
 EGeKuR6V2SgW/0ELuCg/jqoZNs76hqAP+MT7Me/IIWJb82M3YZxPVUvZtOeYn4kBsLEX
 Qt+0Wv/YaIc9+a97apzovzqhHb/DfeDLUbLsr5E3duNo0cC2QOQ/V4BBbL9Tu8ifY+zE
 qBKw==
X-Gm-Message-State: AA+aEWbn32qWGop1mBp8YVcy+Er2sktNuAoEP3aOjvDyaBgj+ZRNoRda
 SPQUCzD2pvXAzzopAYew09043rFmgHh1qHexerlpDA==
X-Google-Smtp-Source: AFSGD/XFykBB1VcG+DE/qkaJQ4oV6LcEpMKEafQRWp3DLXpeT3ex0t3KF8X7HeeM7eW3Hwc/7nJeX113DgQ1sUVq0MU=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr17725808iou.252.1545216122223; 
 Wed, 19 Dec 2018 02:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218152122.4zj6wgbukhrl6ly6@flea>
 <CAMty3ZA4xXVLKx-yj+2_iJ700+yTLesjEAgS8Wu2i8otPScpaw@mail.gmail.com>
 <20181219102450.picswsg3yevba23j@flea>
In-Reply-To: <20181219102450.picswsg3yevba23j@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 19 Dec 2018 16:11:50 +0530
Message-ID: <CAMty3ZB04E46kMKVvo-QxpVQBus74at3uKJC_QzS788UiCAeeg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] media/sun6i: Allwinner A64 CSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_024214_399052_1BAA34C6 
X-CRM114-Status: GOOD (  21.65  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 3:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Dec 18, 2018 at 08:58:22PM +0530, Jagan Teki wrote:
> > On Tue, Dec 18, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 05:03:14PM +0530, Jagan Teki wrote:
> > > > This series support CSI on Allwinner A64.
> > > >
> > > > Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.
> > > >
> > > > Changes for v4:
> > > > - update the compatible string order
> > > > - add proper commit message
> > > > - included BPI-M64 patch
> > > > - skipped amarula-a64 patch
> > > > Changes for v3:
> > > > - update dt-bindings for A64
> > > > - set mod clock via csi driver
> > > > - remove assign clocks from dtsi
> > > > - remove i2c-gpio opendrian
> > > > - fix avdd and dovdd supplies
> > > > - remove vcc-csi pin group supply
> > > >
> > > > Note: This series created on top of H3 changes [1]
> > > >
> > > > [1] https://patchwork.kernel.org/cover/10705905/
> > >
> > > You had memory corruption before, how was this fixed?
> >
> > Memory corruption observed with default 600MHz on 1080p. It worked
> > fine on BPI-M64 (with 300MHz)
>
> I don't get it. In the previous version of those patches, you were
> mentionning you were still having this issue, even though you had the
> clock running at 300MHz, and then you tried to convince us to merge
> the patches nonetheless.
>
> Why would you say that then if that issue was fixed?

Previous version has A64-Relic board, which has some xclk issue on
sensor side wrt 1080p. I have tried 300MHz on the same hardware, it's
failing to capture on 30fps and so I tried 600MHz(which is default) on
the same configuration but it encounter memory corruption.

So, for checking whether there is an issue with hardware on A64-Relic
I moved with BPI-M64 dev board. which is working 1080p with 300MHz, ie
reason I have not included A64-Relic on this version and included
BPI-M64. We processed A64-Relic to hardware team to figure out the
clock and once ie fixed I'm planning to send DTS patch for that.

This is overall summary, hope you understand.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
