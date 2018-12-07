Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:25:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6619920882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sat+MYam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6619920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DYrHZCP1S5CUN64+KAdZ+HeTZN1V7VDGYEwt9HX6uso=; b=Sat+MYamDcgTFZ
	82m/UBHf7xDuZdtKZxHDx+ViPSok/PIpo/IrHxiJSlV3f4LfP/BJNtKMgtRGCs/dVpdmE8gwgchpa
	Nbmw+6M1Lf9KXy/xP3HZOF/K3LVXynMpXnQriFoF/3riWeQTmgxizKYWJE/jv6xxRX3GfW96uefJ0
	FTdVzLogexa3vozu/A5yPhx/djzNpBf5ORA1VRD7pb/HaQpdg+vd5+xeFyHMzDZmipyioNnwPHTE/
	o8eQMyoIU33YSU28kFqV0VWaGsnBWlhqD6HEzdobW4WA/Hl5SFJRNQkj9H8VcoV/91mqnTlzbqFcz
	dwVJ/WOzWSGrM9x6TMig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV5pp-00025s-OF; Fri, 07 Dec 2018 02:25:45 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV5pj-00024P-5O
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 02:25:43 +0000
Received: by mail-ed1-f66.google.com with SMTP id y56so2452338edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 18:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oom8yb8si8YUiMh5VO+md1vrfSvTWSqrwdljfkE47HE=;
 b=uLbka+5WvQhnkDRxRolbdG/D7K0ODmPuk6JGrYQzwitOIVTLKLceA3oxE+PLtK7bRc
 UYWMBUSX69pZtFtQGSXHNaTvMNC/ZMnW3Gxv4i82+PSpbgiafYCaxPBztUloRQjVpKdR
 Y5dnHPttz/fe+1Ri2iLf/xCtAF4x5ebfbyzWWpo49+cj09dsKNU7N7RE2uHR5/wV1GC5
 v2Yy0MjZv8clp/otcbJySJb0KOvtoE9vhVwAtHnL/flELNofmcK86w+snVhKxIpZH4wu
 KBmKD/CKsWUKoKse9BP4KolgcKtC4x2y+trr+MRIAg06n2sLNHiSLKTWEu+ARmC+vg7/
 545Q==
X-Gm-Message-State: AA+aEWalvVHQoTOWX+OShhDV9awTh2m2P6vdzfm9pN/ZJ8seBDzI4he2
 pk48wK/qS8c0e7NnI073zg3J/3zOvsw=
X-Google-Smtp-Source: AFSGD/WWQ+LcUKzUJ4p3UX/TQKApSVu62jwS6dSM9temQjI3dKx7npCLem1Yb//IhBsr0PZifhM4CQ==
X-Received: by 2002:a17:906:cb2:: with SMTP id
 k18-v6mr527939ejh.129.1544149526712; 
 Thu, 06 Dec 2018 18:25:26 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id k13-v6sm322390ejk.50.2018.12.06.18.25.26
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 18:25:26 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id f81so2982998wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 18:25:26 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr562802wmh.124.1544149525598; 
 Thu, 06 Dec 2018 18:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20181203145825.20511-1-wens@csie.org>
 <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
 <20181206203419.GD8952@piout.net>
In-Reply-To: <20181206203419.GD8952@piout.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 7 Dec 2018 10:25:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Fi5EhN10wWaw0kQ2YiAOBT01xgdfXv3XYc64YaE0pgA@mail.gmail.com>
Message-ID: <CAGb2v67Fi5EhN10wWaw0kQ2YiAOBT01xgdfXv3XYc64YaE0pgA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
To: alexandre.belloni@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_182539_202927_FACD858A 
X-CRM114-Status: GOOD (  31.00  )
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

On Fri, Dec 7, 2018 at 4:34 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 06/12/2018 13:49:10+0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Mon, Dec 3, 2018 at 10:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > Hi everyone,
> > >
> > > This is v2 of my rtc-sun6i clean-up series.
> > >
> > > Changes since v1:
> > >
> > >   - Collected tags
> > >   - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
> > >     output"; already merged
> > >   - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
> > >     overlooked
> > >   - Only export IOSC clock for A64/H3/H5
> > >
> > > Original cover letter, with patch numbers corrected, follows:
> > >
> > > This series was started as part of enabling Bluetooth on various
> > > Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> > > clock fed to it to correctly detect the frequency of its main oscillator.
> > > This clock signal is provided by the RTC, either directly from a special
> > > pin on the SoC, or some clock output function from the clock controllers.
> > > I found that the clock-related properties of the RTC on later SoCs were
> > > incorrect or missing.
> > >
> > > This series reworks the compatible strings and clock parts of the device
> > > tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> > > the same sun6i-rtc variant, when in fact they do not. The differences
> > > that matter with regards to clocks are a) the A31 does not have an extra
> > > external output for the RTC 32K clock, while most of the others do;
> > > b) the clock frequency of the internal RC oscillator is different on
> > > some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> > > feeds the system HOSC. The last difference, and by extension the H6, are
> > > not covered in this series.
> > >
> > > Patch 1 cleans up the clock-related section of the RTC device tree
> > > binding. This would make it easier to read and easier to add additional
> > > clocks.
> > >
> > > Patch 2 adds compatible strings for all identified variants introduced
> > > prior to the H6.
> > >
> > > Patch 3 deprecates the external clock output for the A31. The A31 does
> > > not have this output, so it's introduction and usage was an error.
> > >
> > > Patch 4 adds a clock output for the RTC's internal oscillator to the
> > > device tree binding. This feeds the PRCM in some SoCs.
> > >
> > > Patch 5 adds a default clock name for the LOSC to the RTC driver.
> > >
> > > Patch 6 adds support for different hardware variants to the RTC driver.
> > >
> > > Patch 7 adds support for all known pre-H6 variants.
> > >
> > > Patch 8 exposes the RTC's internal oscillator through the device tree.
> > >
> > > Patch 9 through 14 adds an RTC node or fixes up the RTC device node
> > > address ranges, clock properties, names of existing clocks, and adds
> > > accuracy properties for the external fixed oscillators.
> > >
> > > The clock names require fixing because the sunxi clock driver implicitly
> > > depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> > > "fixes" to the clock hierarchy introduced in this series means the names
> > > must also be shuffled around or the in kernel representation would be
> > > incorrect. This has been the case since the sunxi-ng drivers were
> > > introduced. There are plans to address this, but the code is still in its
> > > early stages.
> > >
> > > Please have a look.
> > >
> > > Thanks
> > > ChenYu
> > >
> > > Chen-Yu Tsai (14):
> > >   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
> > >   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
> > >     variants
> > >   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
> > >   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
> > >   rtc: sun6i: Add default clock name for LOSC
> > >   rtc: sun6i: Add support for different variants
> > >   rtc: sun6i: Add support for all known pre-H6 variants
> > >   rtc: sun6i: Expose internal oscillator through device tree
>
> I've applied the above patches. However, for whatever reason, patch 3
> didn't apply without some fuzz, please check.

Sorry about that. The fuzz was due to a patch that I forgot to send out.
The fixup looks good.

I applied the remaining device tree patches. I'll send out the missing
patch, which fixes the register range in the binding example, later.

Thanks!
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
