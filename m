Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CACC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:52:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5899720848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lf+wdJpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5899720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ciss01KaRgqsK92o4NJSKLOWGgIwtqorVK72TrvPD/M=; b=lf+wdJpUKPQwCw
	DKXDX2KdEg16z7lGZKUVQQToIOmjX3CFOBmT6Um7iRb+UZFV4CInnkyE7i5lEU1je1CAtQRPH7Ara
	yl0w8ItTR0RCVUGGi20YOJGM/WYocWQuhp58i4TVquAp7z63umOA7lLZeMAhMSRqMEPyRwu8XeQ2e
	Lzim5vB2Jo2kFzCVbDnmyHyxUm7hMyvXsalJIiozH+cK8xnsoqiROEAEsIN5zRXxQwtVRhbetcRLf
	sOG0tSWfzD0RrSNurA02JsTqKYBUl/YUx1Lxr5IEn9xE5XP+eQk2lcgM1NA7iyKQ/XEk0ZSMSl/CB
	X+iFr2EMSwCn0SldDTlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqVy-0002bI-LN; Mon, 03 Dec 2018 15:52:06 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqVu-0002am-NS
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:52:04 +0000
Received: by mail-ed1-f67.google.com with SMTP id f23so11186054edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 07:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OFzo/slJm2cznF0olPEsCEDt0PV7/qxQRkqsEszYN7k=;
 b=njLKyZs1S7ETm/Qw5ipH6KdHdeNwtRj2RQyZgNGUr3+jJTnZ7FPmX76xQu3YBxOILR
 DWBMVJyyw1GU1BjzW2Na9wel6TyXc0lanxY5KoFzJeKm+kMM/2+vkjPE9P5qsH+rdb4x
 BBYkzuO+R86BnT3GtEO/Ikh2qfw4AzWT0oiBvjrApjuSplDDE1Qo3F4mJ3nAQsLDbDy3
 l7ZtMt/O/kr/mytaFrpj7RfsQVshm0FRLa1bjUqOHWxhPeIc57aa8SeSzN/eFMLGwwck
 L347KWLRBhKmPEwaBrrox0ucG0XOJS+iJtSc3zJy15jpRf5cS5aRRDNia9hM9Qr1jj6L
 gKPQ==
X-Gm-Message-State: AA+aEWZ61/DWzHyVYk+UlRJK4Nt7zapC22cYOkXmcOKj/h8Xf+8KegnD
 htQIcZGa2tE8X+WWRBI4TLS5L8qw6tfb2w==
X-Google-Smtp-Source: AFSGD/XlXqzNnMsKO6TYR5BU4n2aS2IUQH+Wsf9omloovPcovCBZOssVyUGUbYnpX5IqyGldkyMrfg==
X-Received: by 2002:a17:906:7057:: with SMTP id
 r23-v6mr13322010ejj.113.1543852310706; 
 Mon, 03 Dec 2018 07:51:50 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com.
 [209.85.128.51])
 by smtp.gmail.com with ESMTPSA id l51sm4070997edb.36.2018.12.03.07.51.50
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 07:51:50 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id c126so6188607wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 07:51:50 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr9273856wmc.116.1543852309542; 
 Mon, 03 Dec 2018 07:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20181115093603.26729-1-wens@csie.org>
 <CAGb2v66YJ8tkd8wMsBBHETO3UfQDNdmDtgy6SrUXSYergsSUTA@mail.gmail.com>
In-Reply-To: <CAGb2v66YJ8tkd8wMsBBHETO3UfQDNdmDtgy6SrUXSYergsSUTA@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 23:51:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64CdrT44H0pf4RYXON4d145kMz0DnWQL-+4hT-MOx935Q@mail.gmail.com>
Message-ID: <CAGb2v64CdrT44H0pf4RYXON4d145kMz0DnWQL-+4hT-MOx935Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_075202_759901_AFB911FC 
X-CRM114-Status: GOOD (  29.21  )
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
 linux-kernel <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Loic Poulain <loic.poulain@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 12:25 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi,
>
> On Thu, Nov 15, 2018 at 5:36 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi everyone,
> >
> > This is v2 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> > based SBCs series.
> >
> > Changes since v1:
> >
> >   - Collected tags
> >   - Re-organize dt binding clocks and clock-names properties
> >   - Simplify check for deferred probe when getting clocks
> >   - Add explanation of Cubietruck's clk_out_a pinmux setting placement
> >     to commit message.
> >   - Add missing "uart-has-rtscts" property to Cubietruck device tree
> >
> > Original cover letter follows.
> >
> >
> > On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
> > module from AMPAK. Inside is either one or two Broadcom chips, depending
> > on the model. This series enables the Bluetooth controllers for AMPAK
> > AP6210, AP6212, and AP6330 found on several boards. More will come later
> > as other SoCs require changes to some other parts. I did not cover the
> > SCO PCM connections from the controller to the SoC's I2S interface. It
> > seems no one is actually doing this, so I was not sure how to proceed.
> > Any suggestions?
> >
> > I deliberately left out the netdev mailing list and Dave Miller, as the
> > only thing that is under net is the binding document. Maybe we should
> > move that out of Documentation/devicetree/bindings/net/ ?
> >
> > Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
> > any discussions.
> >
> > Patches 1 through 4 are device tree binding changes:
> >
> > 1 - Make the external clock name unambiguous, and add a second entry for
> >     the LPO clock.
> >
> > 2 - Add regulator supply properties for the VBAT and VDDIO power pins.
> >
> > 3 - Add a compatible string for BCM20702A1.
> >
> > 4 - Add a compatible string for BCM4330.
> >
> > Patches 5 through 13 are changes to the driver, either improvements,
> > or updates to handle the updated device tree binding.
> >
> > 5 - Make the driver handle deferred probing for the external clock.
> >
> > 6 - Simplify clock error checking for subsequent clk API calls.
> >
> > 7 - Handle clock-names for the main external clock.
> >
> > 8 - Support a new external clock, the LPO.
> >
> > 9 - Support regulator supplies.
> >
> > 10 - Wait a small amount of time after toggling the GPIO for the device
> >      to settle.
> >
> > 11 - Add support for BCM20702A1, including its default address.
> >
> > 12 - Add BCM4330 compatible string to the driver.
> >
> > 13 - Handle default address for BCM43430A0.
> >
> > 14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
> >      boards.
> >
> > 15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.
> >
> > checkpatch reports an error for both patch 11 and patch 13:
> >
> >     ERROR: space required after that close brace '}'
> >
> > I followed the existing code's style. If this is undesirable, I can send
> > a follow-up patch fixing the entire code block.
> >
> > The first 13 patches should go through the Bluetooth tree, while we, the
> > sunxi maintainers, will take the last 2.
>
> It's been close to two weeks. Any comments or concerns from the Bluetooth
> maintainers? I'd like to see this in 4.22 if possible.

Ugh, I meant 4.21.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
