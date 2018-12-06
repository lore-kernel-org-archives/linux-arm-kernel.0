Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8AD20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQpaVFyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8AD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eGF9jsDoMP8qDwqt/YEHVW0YnAtiH/swcrd6t4eoOwg=; b=bQpaVFyffXYhfq
	ryH20bpJAuxG0R0Ysp7eFOpADPLKxWIqtB/5PXqm4rEZ+3mLdQQWhxOufvHifu32WyZT6ygjBU7ir
	iNKWaH2E8+SOU/5jVhG2s/A8fxKA7EMdISZ1ttOxjW+sWOH6FRd+0b/bD26rBtgH6+SULB6OvKuWC
	2pBSWDQfJdnN4yn05uZ6rZdcbOmG0aAJM0RQvo5vir0YI6ERO88SGhVkWDLkaGHgVpzSp2txobbw2
	E5RTPYuQYgIiipuXXEbi0NmbtsTOt5oXJYYM+8a2hC3uQRe8HQq72zKWAnVglmrUuqkluQhLObkak
	uKWmVfYP5R6JZ5IqNBTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV0Lz-0000SX-Kz; Thu, 06 Dec 2018 20:34:35 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV0Lv-0000Re-9F
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 20:34:33 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A4A3920731; Thu,  6 Dec 2018 21:34:19 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
 by mail.bootlin.com (Postfix) with ESMTPSA id 486C220510;
 Thu,  6 Dec 2018 21:34:19 +0100 (CET)
Date: Thu, 6 Dec 2018 21:34:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
Message-ID: <20181206203419.GD8952@piout.net>
References: <20181203145825.20511-1-wens@csie.org>
 <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_123431_612173_8C259602 
X-CRM114-Status: GOOD (  28.43  )
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 13:49:10+0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Dec 3, 2018 at 10:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi everyone,
> >
> > This is v2 of my rtc-sun6i clean-up series.
> >
> > Changes since v1:
> >
> >   - Collected tags
> >   - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
> >     output"; already merged
> >   - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
> >     overlooked
> >   - Only export IOSC clock for A64/H3/H5
> >
> > Original cover letter, with patch numbers corrected, follows:
> >
> > This series was started as part of enabling Bluetooth on various
> > Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> > clock fed to it to correctly detect the frequency of its main oscillator.
> > This clock signal is provided by the RTC, either directly from a special
> > pin on the SoC, or some clock output function from the clock controllers.
> > I found that the clock-related properties of the RTC on later SoCs were
> > incorrect or missing.
> >
> > This series reworks the compatible strings and clock parts of the device
> > tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> > the same sun6i-rtc variant, when in fact they do not. The differences
> > that matter with regards to clocks are a) the A31 does not have an extra
> > external output for the RTC 32K clock, while most of the others do;
> > b) the clock frequency of the internal RC oscillator is different on
> > some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> > feeds the system HOSC. The last difference, and by extension the H6, are
> > not covered in this series.
> >
> > Patch 1 cleans up the clock-related section of the RTC device tree
> > binding. This would make it easier to read and easier to add additional
> > clocks.
> >
> > Patch 2 adds compatible strings for all identified variants introduced
> > prior to the H6.
> >
> > Patch 3 deprecates the external clock output for the A31. The A31 does
> > not have this output, so it's introduction and usage was an error.
> >
> > Patch 4 adds a clock output for the RTC's internal oscillator to the
> > device tree binding. This feeds the PRCM in some SoCs.
> >
> > Patch 5 adds a default clock name for the LOSC to the RTC driver.
> >
> > Patch 6 adds support for different hardware variants to the RTC driver.
> >
> > Patch 7 adds support for all known pre-H6 variants.
> >
> > Patch 8 exposes the RTC's internal oscillator through the device tree.
> >
> > Patch 9 through 14 adds an RTC node or fixes up the RTC device node
> > address ranges, clock properties, names of existing clocks, and adds
> > accuracy properties for the external fixed oscillators.
> >
> > The clock names require fixing because the sunxi clock driver implicitly
> > depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> > "fixes" to the clock hierarchy introduced in this series means the names
> > must also be shuffled around or the in kernel representation would be
> > incorrect. This has been the case since the sunxi-ng drivers were
> > introduced. There are plans to address this, but the code is still in its
> > early stages.
> >
> > Please have a look.
> >
> > Thanks
> > ChenYu
> >
> > Chen-Yu Tsai (14):
> >   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
> >   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
> >     variants
> >   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
> >   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
> >   rtc: sun6i: Add default clock name for LOSC
> >   rtc: sun6i: Add support for different variants
> >   rtc: sun6i: Add support for all known pre-H6 variants
> >   rtc: sun6i: Expose internal oscillator through device tree

I've applied the above patches. However, for whatever reason, patch 3
didn't apply without some fuzz, please check.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
