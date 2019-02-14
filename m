Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339D9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F4B222D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QM+yUqQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F4B222D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z7sk2J1mVBII4OCG4Lm4vCR/hlauQAJu+etcI6SnkK4=; b=QM+yUqQktiHdVA
	c5i/TQTxPNtyk5Bwf+lHpBgsK+FwMvT4McfFwX7yhcqSfoYrp480itDGCdIXJwFxwOdPOPvQro7gv
	lvkhZLC6iBSiBwY5QlKuz17s4Ah1G1YBR6i1DLy3Iz0ztLMoHP1Jdo89hjTO5VUfaRNLjaBaAvwLE
	ClpLwsTRoxHKuhY1C/EFAj7mIU3SPC2kWHbsh/NHjCDCGISX/m6uBysOnit8iSvxLpGqPm03xl7ZP
	c9aOUTq78EKflODaJ9Ik+twRnnVf9XEegzZQKS0/UBmengSLAuJqdAQIUwD6DWFw1TM9LF2tQnayV
	ya3W7KCnP7xK+Bs2phlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guD3U-0001PH-HF; Thu, 14 Feb 2019 09:11:40 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guD3O-0001MN-Cx; Thu, 14 Feb 2019 09:11:37 +0000
Received: by mail-lj1-f195.google.com with SMTP id f24-v6so4585081ljk.0;
 Thu, 14 Feb 2019 01:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qlyVzDfEA60OMhAyNzY62j15XTWQJaeweNTh+9Jieis=;
 b=FVCSWx0Z4Haz+SsWyR1qA8eEQf96qJvl0lxkImlWHrehnlTHzia/5Y/SKM/PRYvuzc
 zR9J4fa4SN8uJd5knYQCi4UiDQS8kb0bORQOIDn1hl9ZRij2kXzX2Sg0VbFQmtvhUbxp
 u+jcFJVwiG3uPP2BUar1WmGvFsD4t1QWDl/RFvzEHKfWOfLxJyS/VSspeZOGZaBoS/eu
 8iB/GTF3+eDzqN9h838EHdEOm5NkK9Xwq8B5+hX40xUG/4OIvEsILCe+xMON8rEgLlyn
 BKcWl4y6weHRTfaxrojzC5ANXchwqh/EHIbh1+TjOw8PJx7SNRBaXMaKyoKgRDgIbzDZ
 Ldyw==
X-Gm-Message-State: AHQUAuZD9qg+jj4EpJj77QL8bvehJR2YqyCUU0klLPxpdqN2DOwxHOGP
 8MvwlsGJ28aid8YFsI1nezw=
X-Google-Smtp-Source: AHgI3Ia8DWAGct6WEUKkC+jWEuKtY9LMdSV6z8iJhbdm8yHF8nLHZ6XVyGrDF8EL5vEnUc408+gbtw==
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr1724017ljc.97.1550135489021; 
 Thu, 14 Feb 2019 01:11:29 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id j12sm350468lfg.47.2019.02.14.01.11.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 01:11:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1guD3B-0007qD-5L; Thu, 14 Feb 2019 10:11:21 +0100
Date: Thu, 14 Feb 2019 10:11:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190214091121.GI28278@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
 <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_011134_442159_63C3FD82 
X-CRM114-Status: GOOD (  12.23  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:24:00PM +0100, Loys Ollivier wrote:
> On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:
> > On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:

> >> Right, but please do look around for other receivers using this chipset
> >> so that we can make the binding generic enough to cover those as well
> >> (e.g. by choosing representative resource names).
> >>
> > OK will have a look.
> 
> The only mt3339-based receivers I have found are:
> - [0] Globaltop
> - [1] Locosys / Pololu
> They both only provide the UART interface and do not list the I2C/SPI
> interfaces.
> 
> [0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
> [1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf

I found tree more:

 - Globaltop PA6C

   - https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6C-Datasheet-V0A-Preliminary.pdf

 - Linx RM series
   - https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-rm.pdf

 - ublox IT530
   - https://www.u-blox.com/sites/default/files/products/documents/IT530_DataSheet_%28FTX-HW-12008%29.pdf

All with uart-interface only and similar pins names, although the ublox
device do have some additional features we can worry about later.

As all but the ublox device use VBACKUP for the backup supply, do you
mind if I change the binding to use "vbackup-supply" instead of
"v-bckp-supply" (which is a ublox-ism) when applying?

Thanks,
Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
