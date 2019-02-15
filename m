Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E7BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:02:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7D921927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j8TKicCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7D921927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/5MQY5oRB9CjTGPiTsi+TkN5yn4DcWckd08jw7xnDJA=; b=j8TKicCKZjGW8M
	4SXBSbfWUGScp6z0pMxR9SwxcORexk0xCt/zybW9wdwdC4aNHwza2qcopiUqaE77t4xBQ6rztoZOB
	Yj2koYwHqMVxv8qMHcy2eMiC8UcqNl1uC94d1tmzCSFtbj1B4bwfnYdZlw0I5O7LnwvGAzF75XXfY
	+3aw1p7bUbEbQNYzWoD0F4Rnyf3xGD4iutDbKdobvIaJjxvJX2yJd1k35Km1cT2W2JSr2r4X88+q1
	v1mYJvvHmUJaxywAw9mCWijX5pt/jjDIL+8pgeqr/IvWbaq0s1oa8GqcUjWGYaJcJEM3wLNKGgG5H
	eCR72xFpXNntLKb9ESXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufw9-0004dv-TI; Fri, 15 Feb 2019 16:02:01 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufv5-0004VZ-Hw; Fri, 15 Feb 2019 16:01:02 +0000
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so8741300ljd.12;
 Fri, 15 Feb 2019 08:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+NWvoArQciybMVwCFf3cNk9+s9mCCRZ6I26Z6YLNBW4=;
 b=Cy/B/0u+fpbQd5wSCo5tqO4pQ2kbded5qG73gny/IhqNCqfKwD60O9ek0j2oi6St0X
 BHAxJko47DHkyTr2/akoSB94dWFEfd8Own0kFtNPPI/edu1rZWFE9qUqjv7WtkB2fyGU
 PSaLqk1gu3bU46Bp5hRGyLPslqWj4PftdAAJiqU5I6tBfAebF5EhIDZKPGNmdd7EQ5nr
 QZiFXyBxYYB0lb0rJioIWLCGPhX4rd53IJUJRCENSSkEZWaR3JDw2H8cERg3nZvPnASd
 KpQiOG/J7rnRcPDha1Sv4mtJtbMxNFyxNdCGRK5FWCXUxGD2ECPjywiqESdzBhymRzTy
 XPlA==
X-Gm-Message-State: AHQUAubPaIFGGQmOYvFX0GarK9U1e9OXS1RsWNbDoyvBa/mcDkh0Ofmh
 uUG1v5ZcbvqRwLak7B+y/bs=
X-Google-Smtp-Source: AHgI3Ib6oHOYfq26GpmGbR3UDfA8eUafWcK0ejrDhB+P7gDtjXX2XRyVdlZ0U5DXYITY/hlBfbmU+A==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr5966428lja.44.1550246453203; 
 Fri, 15 Feb 2019 08:00:53 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id c187sm1385203lfg.66.2019.02.15.08.00.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 08:00:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gufux-0000pK-2G; Fri, 15 Feb 2019 17:00:47 +0100
Date: Fri, 15 Feb 2019 17:00:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190215160047.GN28278@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
 <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
 <20190214091121.GI28278@localhost> <86ef89fe10.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86ef89fe10.fsf@baylibre.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_080055_680698_E7F709B2 
X-CRM114-Status: GOOD (  19.21  )
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

On Fri, Feb 15, 2019 at 01:10:35PM +0100, Loys Ollivier wrote:
> 
> On Thu 14 Feb 2019 at 09:11, Johan Hovold <johan@kernel.org> wrote:
> 
> > On Wed, Feb 13, 2019 at 04:24:00PM +0100, Loys Ollivier wrote:
> >> On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:
> >> > On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
> >
> >> >> Right, but please do look around for other receivers using this chipset
> >> >> so that we can make the binding generic enough to cover those as well
> >> >> (e.g. by choosing representative resource names).
> >> >>
> >> > OK will have a look.
> >> 
> >> The only mt3339-based receivers I have found are:
> >> - [0] Globaltop
> >> - [1] Locosys / Pololu
> >> They both only provide the UART interface and do not list the I2C/SPI
> >> interfaces.
> >> 
> >> [0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
> >> [1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf
> >
> > I found tree more:
> >
> Ah nice.
> 
> >  - Globaltop PA6C
> >
> >    - https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6C-Datasheet-V0A-Preliminary.pdf
> >
> >  - Linx RM series
> >    - https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-rm.pdf
> 
> This is a different chip: MT3337; Apparently this chip only provides an
> UART interface: https://labs.mediatek.com/en/chipset/MT3337
> However it looks interesting. I'll look for a sample to test it in the
> future :)

Bah, sorry, I used the wrong link. Here's the mt3339-based one:

	https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-fm.pdf

But hopefully we can reuse this driver for mt3337 and any other
variants too.

> >  - ublox IT530
> >    - https://www.u-blox.com/sites/default/files/products/documents/IT530_DataSheet_%28FTX-HW-12008%29.pdf
> >
> > All with uart-interface only and similar pins names, although the ublox
> > device do have some additional features we can worry about later.
> >
> > As all but the ublox device use VBACKUP for the backup supply, do you
> > mind if I change the binding to use "vbackup-supply" instead of
> > "v-bckp-supply" (which is a ublox-ism) when applying?
> 
> I don't mind. You can go ahead and change the binding.
> For reference, the v4 patch serie:
> https://lkml.kernel.org/r/1550070569-18588-1-git-send-email-lollivier@baylibre.com

Thanks, now updated and applied.

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
