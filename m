Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45912C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:52:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A8921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a1FbE1eo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d0Rqitjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A8921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MmpGyjK8IsEmdv2D8HzmY4B8Oys/4NcxutpQc3fbLjM=; b=a1FbE1eolz0E2H
	ocx06lcHKuWLpgx49qiaSN0fsIJ33bJN9hm6tKD8oFydOTzzSK3RSHVJ9oDgx4JrmbWRi//wDuLQ8
	zWOczcaPAGjMeAdrI1Yv6/sGsH6kz6rSmBoUGd7yt9A+4uG1ic7uXKIIjea5m44FwGiKinwxfiULs
	cBnaGklb4+wVZ4JQSyR7832WgrnRVbuD4l5ZG0ra+mcCaahskPQ8jWg7BtJqjDYuLnhMMbXGSgmsS
	V7kg6AwzOjDEqOU4UQa4Nz9tBj6pWcg06xtcUGFRmddEzOfIn2355uOL6zZMqBNvzaQ9IT5ydZ9Ni
	zX3NmzyFcWipmnaSw9rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb6q-0004Wi-DU; Fri, 01 Feb 2019 15:52:04 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb6h-0004VI-Nd
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:52:02 +0000
Received: by mail-it1-x144.google.com with SMTP id h193so10373906ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0QFjyQzPSYzw+9+y4qZ/LyQWmOtJ5IEIvYW5d38ofMs=;
 b=d0RqitjpPh0bfgADVQiUErX7Oq0fAVi7hGNyJginAoNMR5mUyrf68ASSNQN7udEOib
 18vCmO/si2kLX3HGaP2XijLSJqdQ1pQgDLrgZdme0pTfQK7zQ60IJ2FzUDEr/voEEOzC
 E/HGtJelMdNvHlcqBENqfoRogdUp9lQzIKh3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0QFjyQzPSYzw+9+y4qZ/LyQWmOtJ5IEIvYW5d38ofMs=;
 b=MGeR4UOsvIgELeEki7BoPhVFUXYYqdrzTfTgPX5wB5ioU6hoBRPLtoRIjqObE86wmD
 9nS3076vqazvROibqv/QQ1vzi6LuG2s4UlcS0oYZU8i6ceG6cw4MTKjSWtI/VViVCBxQ
 GWlWXguOh9c0r1128YdVBttbIlDhP/NsBvnwoq0XsVtLlHnDyNdZxx2p89F5pM2qPtEn
 3C3ohRLKy7DLwd9DTIvAuGzGCviSr5xDsIf2awJgkpatRx+ZJYbNfxdYH8cR9lq+Bm51
 YzaGNPJfiKwyfB9+aGTWLEiS5DC79xFXbdl3vsPsCXSj0/5AezBIs4j3+gJ4pxZnDIOn
 h37Q==
X-Gm-Message-State: AHQUAubutMRDesGPOLGACn9NfSVT9ynH4j/o4NsaqZF94KiYZtwkk5EB
 KVv6VwuvLphhWxfJEkAJSPio6jdO2NmjmR4/yxnndJys6ICdxg==
X-Google-Smtp-Source: AHgI3Iax7m0R3CTnvGhVwQ5NsgaAl+q8ict/I+2M4JaBHhb2jqQQ/mfTJSZi2Vq4cox+x8pAU/3DB/2MXwmBw3pKong=
X-Received: by 2002:a24:385:: with SMTP id e127mr1748296ite.32.1549036314638; 
 Fri, 01 Feb 2019 07:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
 <20190201154858.z6xqdaxccxya2wqr@flea>
In-Reply-To: <20190201154858.z6xqdaxccxya2wqr@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 1 Feb 2019 21:21:43 +0530
Message-ID: <CAMty3ZABvrb+Eu8D7uiGvBALRetnphsRg-RennRSNH5-_q-9bw@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_075155_768413_0DA08E7C 
X-CRM114-Status: GOOD (  13.19  )
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
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 9:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Feb 01, 2019 at 09:12:09PM +0530, Jagan Teki wrote:
> > Here is next version changes for Allwinner A64 MIPI-DSI support
> >
> > This series grouped the changes like previous version[1] with different
> > sets to support three different panels types that can fit into the DSI
> > controller.
> >
> > set:1, for 4-lane, burst mode support
> > - patch 0001: 0009, DSI controller changes that support burst mode.
> >
> > set:2, for A64 DSI support
> > - patch 0010: tcon dclk divider computation based on A64 BSP.
> > - patch 0011: 0017, Allwinner A64 DSI controller changes.
> >
> > set:3, enable 4-lane burst mode panel:
> > - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
> >   burst mode panel on Pine64-LTS
> >
> > set:4, enable 4-lane video mode panel:
> > - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> > - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211
> >   panel on Bananapi M64
> >
> > set:5, enable 2-lane video mode panel:
> > - patch 0021, 0022: DSI hfp and hbp timings fixes
> > - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic
>
> You do realise that pushing through a series while the previous
> version's discussion hasn't settled yet will not get you anywhere,
> right?

Except the clock, I made few changes with your previous comments. Yes
we can still under clock discussion page, no issues on that. just to
group the remaining patches to finalize if any issues on those.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
