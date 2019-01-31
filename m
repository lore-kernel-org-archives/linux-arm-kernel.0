Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084BC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:28:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4189320989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQgK73Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4189320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AXNgQ7hFI4g81ahE+r9cnl5ie1tbeJET0VD5u6srEHc=; b=cQgK73YnRJjTmw
	+v4T5dKs5UA3tsOv8KvkJM1387wKJwT6CjxuujK/7Fgp6uLyeIX5vfBzvP7rFR0fjB6qfnhcpfwWD
	UgBDGmTvTPyU29UfraXFr/sNAk8reWz2DKJq9DmxEq0SWNfahKK8lQUa2sCGY3foU3V4FWGnI+DGg
	i6cv/IBRqoFQ7NOFTKOxsWbsqTEQxFZn4OdU+1EeRnz+eAWJCbdf0FLODWKmtN7zhtozfE3CcSJ1g
	nvEezWGk2hjUfrQALASMc7ETwsFD5dzoVDDc16Z5W4DJSF9AHvRP9BpLlPZf+Ic8PkFZyGq/AXS2I
	VRSQ/60U1f8otwGoscSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp31t-0006Vn-VX; Thu, 31 Jan 2019 03:28:41 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp31q-0006Uk-2k
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:28:40 +0000
Received: by mail-ed1-f66.google.com with SMTP id h15so1420448edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 19:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=15XSS+f8Da6LSGwP1uW4xYq3+UFXhrjBBfi+sQNl2lY=;
 b=EPtV59yC7oDNQOlYS6vzgCpqXUlh8StPWDYfNn3L1TE5iIBZHV8nffMy/R3sxGHOPu
 h6kvEUswMXMCCOSYvXrTSpd9M4FFzC7iywzm/7DqpknGvidh0YRFm/kTge3nDBsdd+gD
 xIUo9ICLVx0Obpez9hTlJudokHNur/sJp3HjQwPEtVieOFYdxQsWdky9yegIBm/kIu1P
 ZXNotKus77eteaHriwE/eR+JZmRGgtnWM7545diFxv2dt4Haic6Gthtw5/pyHXbAuAtX
 zwgh0laRoU2AkG1tsQscoYy2MpdaHOxIBuIfGmgqxt+v5p5fnxvwhbFmh7JV/qzMxeaY
 uVpA==
X-Gm-Message-State: AJcUukfzkg1bdNQ41yg3LZtguyQkfvbjKLRppT0VMdJbMMcqv87/OOqS
 3lG4Db/9hGypaLe6MTjgIWdgzINV+yo=
X-Google-Smtp-Source: ALg8bN7mtZHw4ZyqDpTVEUQyRZ1zHfM8DPOOCfR2sMCC2oIcYBpZ60/EPrOqtd1D+7+1iuxHkS10mg==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr32602824edj.145.1548905314746; 
 Wed, 30 Jan 2019 19:28:34 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id i7sm589180ejc.62.2019.01.30.19.28.33
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 19:28:34 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id y185so1061130wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 19:28:33 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr27581378wme.111.1548905313480; 
 Wed, 30 Jan 2019 19:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20190130084203.25053-1-wens@csie.org>
 <20190130084203.25053-11-wens@csie.org>
 <20190130092927.x65ihy3je5n6324w@flea>
 <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
In-Reply-To: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 31 Jan 2019 11:28:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v670VszWfTNK9vtoBFWAuHVVHXmwrA84YfBFLLM5XX_6xg@mail.gmail.com>
Message-ID: <CAGb2v670VszWfTNK9vtoBFWAuHVVHXmwrA84YfBFLLM5XX_6xg@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_192838_122437_954EC2F0 
X-CRM114-Status: GOOD (  16.85  )
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

On Wed, Jan 30, 2019 at 5:41 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Jan 30, 2019 at 5:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
> > >                       enable-method = "psci";
> > >                       clocks = <&ccu CLK_CPUX>;
> > >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > > +                     operating-points-v2 = <&cpu_opp_table>;
> > > +                     #cooling-cells = <2>;
> > > +             };
> > > +     };
> > > +
> > > +     cpu_opp_table: opp_table {
> > > +             compatible = "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp@408000000 {
> > > +                     opp-hz = /bits/ 64 <408000000>;
> > > +                     opp-microvolt = <1000000 1000000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@648000000 {
> > > +                     opp-hz = /bits/ 64 <648000000>;
> > > +                     opp-microvolt = <1040000 1040000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@816000000 {
> > > +                     opp-hz = /bits/ 64 <816000000>;
> > > +                     opp-microvolt = <1080000 1080000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@912000000 {
> > > +                     opp-hz = /bits/ 64 <912000000>;
> > > +                     opp-microvolt = <1120000 1120000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@960000000 {
> > > +                     opp-hz = /bits/ 64 <960000000>;
> > > +                     opp-microvolt = <1160000 1160000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1008000000 {
> > > +                     opp-hz = /bits/ 64 <1008000000>;
> > > +                     opp-microvolt = <1200000 1200000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1056000000 {
> > > +                     opp-hz = /bits/ 64 <1056000000>;
> > > +                     opp-microvolt = <1240000 1240000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1104000000 {
> > > +                     opp-hz = /bits/ 64 <1104000000>;
> > > +                     opp-microvolt = <1260000 1260000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1152000000 {
> > > +                     opp-hz = /bits/ 64 <1152000000>;
> > > +                     opp-microvolt = <1300000 1300000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> >
> > What is the frequency and voltage that U-Boot sets up?
>
> 1008 MHz, and whatever voltage the board design defaults to (typically
> the higher setting).

FYI I got this wrong. U-boot's default is 816 MHz. However it seems even
this is misleading, as cpufreq in Linux reports:

    cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 792000 KHz
    cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
to: 816000 KHz

So there seems tp be an off-by-1 error in some multiplier calculation.

>
> > We've had the issue with the A33 that it's started at 1008MHz, with
> > the matching voltage, and ramping up the frequency to 1.2GHz on boards
> > without PMIC support would increase the frequency but not the voltage,
> > resulting in a brownout.
>
> Which is why I added the regulator to all boards before this patch. At
> least for Linux, once the regulator supply is described in the device
> tree, if the driver is missing, regulator_get_* and thus cpufreq should
> fail with -EPROBE_DEFER.

I believe despite the above, this still stands. So we should be OK.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
