Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC768C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE432087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qRF1YRVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE432087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hfI3Phr//9J1isrNE5ErH565Q4aLL2GwQarDKvkZFUI=; b=qRF1YRVYz+SPYs
	pDPUMGfQRohybMw+avbboWHhjFkpUtaWUONBWtkjTRu4pftKGVhXIRznat02xFLxqClC5OKkA4pZY
	ida60Lyn/KR5TKa+KZAJhvJXV1L0mvjW6skrZ5DSXscrxwWtSXZGdjTVbPxbYGjqy5mPg/m7plzJ3
	LVVe0X8CItT4X2BSUVjbYVtin1RwcEsak/PczsuRfz6ShpGtOikyQVoo/bCqgIC9EuBf26rxUdTlF
	p6Xj7X6nUy82RW+DGn5XFuZRgtsNe7uXOgy1K41V3e5XeVRyhLUwpfZGZDCEJwEHXSmfIh4j5gcVO
	rZh7hXVlUHrDOIJLIyxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomNT-0006BR-Pa; Wed, 30 Jan 2019 09:41:51 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomNB-0005vW-BG
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:41:36 +0000
Received: by mail-ed1-f68.google.com with SMTP id b14so18445145edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=buxflIHyotlTgXFeXzNxI+t8izXs+EpCHmUVPB6PVhM=;
 b=PwwMa28KMVYp4a5mQ42D9U9aU9g1e3KyOO+ztC4B2J9A36R94uLnrD5tGvsg5CxxxR
 NJecwgvR4arFxQSL71DqGbryKzARnHcSOdvA2OT/24TTFt8d2LLMpgem0oXvfvCdsufU
 NuZfv/TfzK7xy7qXQgPOMNdhvrr/M9WgC6vERyvBf/7+IFfWdH9NXizvnDDeS6I4ix0q
 7lH9WQ9plOuQUf1XqM9FqWdPy6Sl3unxLt6D1W+tiUMrrmTzZ+UUJnDhrEiCDNCixUb4
 p/S3yhXLtlFRXsB/qWR7oNJvVMQjI2hYasVsNJFi4WY3C15FBmA+yCUPqi/qAIGuJStX
 coOg==
X-Gm-Message-State: AJcUukeeh+fhu2v21V4a8ELo/pnuARv6bVmY2M5+EkucDCaq3W5ydSFR
 ITJMz2xLipXIxp8Xawr+Dky1BtgLyRE=
X-Google-Smtp-Source: ALg8bN6yiBy8MlN5WD9QAFlzOLuXsWccD/KeDqadZ25dvL52IuHH025TSlMgloK9b7R9xbeVvc0PPw==
X-Received: by 2002:a50:b1af:: with SMTP id m44mr28720170edd.47.1548841290639; 
 Wed, 30 Jan 2019 01:41:30 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44])
 by smtp.gmail.com with ESMTPSA id p25sm242691ejn.6.2019.01.30.01.41.29
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 01:41:29 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id p7so25312789wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:41:29 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr30349882wrv.188.1548841289046; 
 Wed, 30 Jan 2019 01:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20190130084203.25053-1-wens@csie.org>
 <20190130084203.25053-11-wens@csie.org>
 <20190130092927.x65ihy3je5n6324w@flea>
In-Reply-To: <20190130092927.x65ihy3je5n6324w@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 30 Jan 2019 17:41:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
Message-ID: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014133_807715_91C9019E 
X-CRM114-Status: GOOD (  14.10  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Emmanuel Vadot <manu@freebsd.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 5:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +     };
> > +
> > +     cpu_opp_table: opp_table {
> > +             compatible = "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp@408000000 {
> > +                     opp-hz = /bits/ 64 <408000000>;
> > +                     opp-microvolt = <1000000 1000000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@648000000 {
> > +                     opp-hz = /bits/ 64 <648000000>;
> > +                     opp-microvolt = <1040000 1040000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@816000000 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <1080000 1080000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@912000000 {
> > +                     opp-hz = /bits/ 64 <912000000>;
> > +                     opp-microvolt = <1120000 1120000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@960000000 {
> > +                     opp-hz = /bits/ 64 <960000000>;
> > +                     opp-microvolt = <1160000 1160000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1008000000 {
> > +                     opp-hz = /bits/ 64 <1008000000>;
> > +                     opp-microvolt = <1200000 1200000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1056000000 {
> > +                     opp-hz = /bits/ 64 <1056000000>;
> > +                     opp-microvolt = <1240000 1240000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1104000000 {
> > +                     opp-hz = /bits/ 64 <1104000000>;
> > +                     opp-microvolt = <1260000 1260000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1152000000 {
> > +                     opp-hz = /bits/ 64 <1152000000>;
> > +                     opp-microvolt = <1300000 1300000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
>
> What is the frequency and voltage that U-Boot sets up?

1008 MHz, and whatever voltage the board design defaults to (typically
the higher setting).

> We've had the issue with the A33 that it's started at 1008MHz, with
> the matching voltage, and ramping up the frequency to 1.2GHz on boards
> without PMIC support would increase the frequency but not the voltage,
> resulting in a brownout.

Which is why I added the regulator to all boards before this patch. At
least for Linux, once the regulator supply is described in the device
tree, if the driver is missing, regulator_get_* and thus cpufreq should
fail with -EPROBE_DEFER.

Or we could drop the extra OPPs.


ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
