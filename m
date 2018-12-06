Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0D2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:49:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9C22146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgJk1D86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9C22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qRftBxs9BOAFnE45s8em7U0+I61nsnnwD4B7hdFDijk=; b=PgJk1D86o86Yal
	9hGBIsi9CPeJRXz9szKsy7kA1n6w9jQ7E1DrgC6ZYYNo8JN8J2WRZF6+CPi6XYf+qwRnx6ytFGGkw
	CXJzuX5j4A7w+Vg9Xliuyn/nKDj7w5aNEFAiDgsdS6qLH7KhHSBNXu0jdCyEbyNcBVDJyJLEJzhhm
	sQPyndULQQ8AU0gIITDTBSRH9Qmbo/IExHkz+obO3rxbd9pkkK7vmKGdiqvSVtdj5gus6QXUpKveo
	XPZhpSaWoyI0TPzwMObMX5pJhAU+RGG4pNYHhUNGiIG8hecrtM8gLLhxdoSxRwPMnINibdtYsQsro
	3gwA/HxZitivAoQlUV1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUmXd-0003up-QO; Thu, 06 Dec 2018 05:49:41 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUmXX-0003tN-TB
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 05:49:39 +0000
Received: by mail-ed1-f68.google.com with SMTP id z28so19024237edi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 21:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d6PNw/h9KlBN0w0kHSPz8pJtvfB9D034KTZ05omJ/0U=;
 b=A8I+Q1P/nUvMI6fHEs+EQI0/jEt/Kc720ovg5zkLUrRSzm4hEqGR6Pb2Rct3mEdKyZ
 UvQHQwbMuIoVe2td8WBCImqFLfMre/Sg2SKpuZvPgcpyghLRPSfxrPatqCh1mIQ0vFJX
 6sIuxNKqS/VeaQqW66mw9pDwofc+WzL+Lw1OADSOPSeRiu+K9h3aaSpgXGSrh5arJi5Q
 Q2Tr/Wl3rLtaEEfKEQtG7MUoRPVsV7YJ0zOjeJxlPeJkwRilxAQmbHWskNqdrbO0cbeL
 FRlDJHHv3AKyqsOQZGhvTLd2g6U8mCoFHKLOvi9G64klQM1pHg3uABICX6dp/ked4T1E
 OfDg==
X-Gm-Message-State: AA+aEWbSVQevKBNXJtb8wY2Fvlpej4YIkDgNshaCEhxmptYfe9snezJ5
 wJZUGWC9SBcJFp4mu3Lftj7fj+VEhRU=
X-Google-Smtp-Source: AFSGD/U9rKLYqJ9dOX4pSuyTiF2plubJi2fsYPivhtEZ0BKbrTp2IZljHLiwWH1hvn6zbk9zRM16lQ==
X-Received: by 2002:a17:906:495:: with SMTP id
 f21-v6mr20584496eja.95.1544075364056; 
 Wed, 05 Dec 2018 21:49:24 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id m1-v6sm3348177ejz.64.2018.12.05.21.49.23
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 21:49:23 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id m22so15187102wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 21:49:23 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr16583620wmf.99.1544075363170; 
 Wed, 05 Dec 2018 21:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20181203145825.20511-1-wens@csie.org>
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 6 Dec 2018 13:49:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
Message-ID: <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
To: Maxime Ripard <maxime.ripard@bootlin.com>, alexandre.belloni@bootlin.com, 
 Alessandro Zummo <a.zummo@towertech.it>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_214935_945069_7AAABC94 
X-CRM114-Status: GOOD (  29.94  )
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
Cc: linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Mike Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Dec 3, 2018 at 10:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi everyone,
>
> This is v2 of my rtc-sun6i clean-up series.
>
> Changes since v1:
>
>   - Collected tags
>   - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
>     output"; already merged
>   - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
>     overlooked
>   - Only export IOSC clock for A64/H3/H5
>
> Original cover letter, with patch numbers corrected, follows:
>
> This series was started as part of enabling Bluetooth on various
> Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> clock fed to it to correctly detect the frequency of its main oscillator.
> This clock signal is provided by the RTC, either directly from a special
> pin on the SoC, or some clock output function from the clock controllers.
> I found that the clock-related properties of the RTC on later SoCs were
> incorrect or missing.
>
> This series reworks the compatible strings and clock parts of the device
> tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> the same sun6i-rtc variant, when in fact they do not. The differences
> that matter with regards to clocks are a) the A31 does not have an extra
> external output for the RTC 32K clock, while most of the others do;
> b) the clock frequency of the internal RC oscillator is different on
> some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> feeds the system HOSC. The last difference, and by extension the H6, are
> not covered in this series.
>
> Patch 1 cleans up the clock-related section of the RTC device tree
> binding. This would make it easier to read and easier to add additional
> clocks.
>
> Patch 2 adds compatible strings for all identified variants introduced
> prior to the H6.
>
> Patch 3 deprecates the external clock output for the A31. The A31 does
> not have this output, so it's introduction and usage was an error.
>
> Patch 4 adds a clock output for the RTC's internal oscillator to the
> device tree binding. This feeds the PRCM in some SoCs.
>
> Patch 5 adds a default clock name for the LOSC to the RTC driver.
>
> Patch 6 adds support for different hardware variants to the RTC driver.
>
> Patch 7 adds support for all known pre-H6 variants.
>
> Patch 8 exposes the RTC's internal oscillator through the device tree.
>
> Patch 9 through 14 adds an RTC node or fixes up the RTC device node
> address ranges, clock properties, names of existing clocks, and adds
> accuracy properties for the external fixed oscillators.
>
> The clock names require fixing because the sunxi clock driver implicitly
> depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> "fixes" to the clock hierarchy introduced in this series means the names
> must also be shuffled around or the in kernel representation would be
> incorrect. This has been the case since the sunxi-ng drivers were
> introduced. There are plans to address this, but the code is still in its
> early stages.
>
> Please have a look.
>
> Thanks
> ChenYu
>
> Chen-Yu Tsai (14):
>   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
>   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
>     variants
>   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
>   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
>   rtc: sun6i: Add default clock name for LOSC
>   rtc: sun6i: Add support for different variants
>   rtc: sun6i: Add support for all known pre-H6 variants
>   rtc: sun6i: Expose internal oscillator through device tree
>   ARM: dts: sun8i: a23/a33: Fix up RTC device node
>   ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
>   ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
>   ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
>   ARM: dts: sun8i: r40: Add RTC device node
>   arm64: dts: allwinner: a64: Fix up RTC device node and clock
>     references

I merged patches 10 and 12 for now. These don't depend on any driver changes.

If Alex manages to get the driver bits merged for 4.21, I suppose we could do
a late PR for the dts bits? It would be nice to have both in the same release,
though I don't think anything would break if the dts bits are delayed.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
