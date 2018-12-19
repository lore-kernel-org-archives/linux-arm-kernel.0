Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CADE218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORM0P77t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FrGJrBQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CADE218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KjnetQDNMQi67QARLZ1YMZ4qoDkFuKzmrsNGKMppUG8=; b=ORM0P77t8JGJx2
	ROuRdbvS0p74bhSh02h4dHnb//tblA7L6t1oMgJJkWDCBE/vJzTOKiH6nG6NU1iWQ7uB4K2vUhJjQ
	T7HW6psLZxcK+/UwNMgfNaeoabAVcH0k2Y4GVAIRRYDitY2VNii2Y7SFYqYPoRoMoZQlbdJnP2qZZ
	66BrHHGfy6qRxKdmD8HoV7v6eMW5DF16ucrcgBojd/aAoFvi4Y8fF7faiVtBeyTH9HpOTv/IMmlMK
	g644KiRysrmXPnuNC+OvKSb//lV3r/yThyKQA+Iz7y2vnkwM/awRWvzR6k4tTvx0FRn8AnYrsJKur
	SkyY6GhQYRIDEM27FhKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZ9l-0004Aj-It; Wed, 19 Dec 2018 10:32:49 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZ9B-0003SX-IV
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:32:19 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so18515575wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 02:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UhnBIZYHMR/cYbeYFKc3PaWigVNId4aaU5FOYilDt/Q=;
 b=FrGJrBQuBOIr9FsDUXpaetzaQz2hLymHHJfEmMoLvFmVBSs8jBAWIAS0SpDXTY3QsB
 szUwTJqOYKqP0ayTuBSRVnqoIx5H/Re7/eyZ5QUoGjdruHEKwliNNE4AT8dh7DqOYsVj
 V0nsCCD1i6vJWVPfCR5KVVW7FkLdMzHArHvYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UhnBIZYHMR/cYbeYFKc3PaWigVNId4aaU5FOYilDt/Q=;
 b=AJ4O6KI39wRZog/JfzdCvnyqOu+peaf6ILOivuhcqZCTxGrrB96comSuN5cUKrkIf0
 osPdEEk8nUSk+FTp7oEODl82ylWa3xNw88etG+amVT+rz0I447hNNQBkbnZR/nCRwbCR
 GAaHIEln/ODkI5bsKYE0I1QqdL5tduGcRUHkVbOG2x3V88Ot/WXlEi5RqaZ1xrx1uN1O
 4GToY8rNNSKWhzO9NS+g1k+mclDXa/5vql7+wS1fsY41DU8ZoB7+qbR8iebUceZMp1Ek
 qLs/f1fmX41cobSGONeOwwOGMNiMGjmZdUt2dnMjyiECcWcgeX6YcWEBfi+cUHZsCyN1
 9jbw==
X-Gm-Message-State: AA+aEWZr+Uyd7WJBUWQ3w4EJnf2aio3ueeUpoz08yDOVZYfed+EzdB3S
 uuMSfavDzATzgj/4wRQ3HOPfD7mxZkoT/NPGcGdA8Q==
X-Google-Smtp-Source: AFSGD/XqFgtlWXCVfvm19ylqbfNH1z4ZfKteBxq4j00eANhexFbgADWZiWuhUMuAWhpZ4mFapFmJMUrp2a1sc3zanDA=
X-Received: by 2002:adf:9422:: with SMTP id 31mr19353343wrq.106.1545215521131; 
 Wed, 19 Dec 2018 02:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218152122.4zj6wgbukhrl6ly6@flea>
 <CAMty3ZA4xXVLKx-yj+2_iJ700+yTLesjEAgS8Wu2i8otPScpaw@mail.gmail.com>
 <20181219102450.picswsg3yevba23j@flea>
In-Reply-To: <20181219102450.picswsg3yevba23j@flea>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Dec 2018 11:31:50 +0100
Message-ID: <CAOf5uwnjR8QPeu36+t3Y_19D=+nGXJ6aMiuEzbYs7r_urKzfUw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] media/sun6i: Allwinner A64 CSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_023214_395261_3058FDEB 
X-CRM114-Status: GOOD (  22.70  )
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
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime

On Wed, Dec 19, 2018 at 11:25 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
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

It's simple, we have a full working platform with ov5640 that support
all the resolutions, that can be test by anyone and
we have an industrial product that has some problem on high xvclk
because it can not give us a clear image but this is limited on
another design and another camera module vendor. Problem is not in the
kernel code but it's just on relic design. We are getting
the information on that module and see if inside is really using the
xvclk or it's clocked by some other things. We have only the schematic
up to the connector.

Michael

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
