Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B057DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2DF2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LBlCE9st";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAck+mNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2DF2229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8eK7uZvPSnBmjrH65JXyqpwyibvsrkuJl3wKmvV7NRQ=; b=LBlCE9stZJrGzh
	8gG0j0XBEal6uBZX/RZEPVTJFYbce1o1P1rLPHwVohvNRBuwX3/1CuJ32jGqrbxEO4jgvtEk+8RiN
	AFB+QNc+SZi8Eb9qOxsIlcKIEZtUAE5qWnJJYe1kHO9+ostizg48g0FT7pMLyUnsTvQO+cI4eND2u
	EZ5BS9AUB7tZ64D/8nqltetTmK0nxF2ung3/Sp9G8G1itvUptGSS8PJJNzuzMZqCe6XZWch7sg7T6
	fvLr1cZFHufSVIcZLzLc1fja9uu6xd7HUIhDqTwzXsJLxW5XcOq3BeTtMrqWafGkQpmGCkkZU6eb0
	EV+SltNiVD8ebskpB2hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIND-0004V3-AT; Thu, 14 Feb 2019 14:52:23 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIN9-0004UK-OW
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:52:21 +0000
Received: by mail-it1-x141.google.com with SMTP id l15so2123757iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+EGt+v5ZyVvPKwVW3emNjKEWeGsO2xJtAz1zaHUXrBU=;
 b=YAck+mNs/CPhSATtPY3A+HQ1SQVRWX6LVgVNMp3RMAlrd36W4KQ0FybFxm5aco7jPl
 7ohcscM3KZrSCLBBeZJxxigV7BmH6OlqlOsiOuxDHTp3sd7utq+Abvf6zKtFd0pix/SN
 /xecmi5kYK67GEgq7DW9WdNHMc40SkJqtexz6KjtAJ+MMS/CbaDqerur98Y65j68cTD9
 j6YHk/mU0lHLAhVKpmAlvDf/SUmJhBx5xeYeIJwCs1oE5GKeIKEmJySWd5+8TOfL/GMk
 obARw/CmdSQa3ESsdgu1w7JaWNzVv+MtoQ7iApfRutp0sKlhexqjp0ORfontJEam8vI1
 IdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+EGt+v5ZyVvPKwVW3emNjKEWeGsO2xJtAz1zaHUXrBU=;
 b=qtRvoR8ROBVRol0vQ4Wu0+rZS9BhwfqfOGLe69z5HiWCBKBgNjCJ4/MzXSNKzddBwc
 RrqD63WzDcxmUE3i81YyCLAxrPx8rhMwA8+6HsHgxhKMwAaxJca9lBeYG3SiDzxND3HR
 OdDLFb+h8fL7kczoxejSVNocDXU0byq5p0CUqTFZUc7jqjUY716ifJTervzqIuT8g38n
 T5eRb3QynluURxvXly3INr/OySckhksmwEpFMxb9DDZwflXASdTnZqKl7Fbtzl3atpAq
 7WnTXAFoT7R2tSouynrMCDEdH8AUYSl27EvhKlbgOX0C2CKmw+aRaJ0KLnLU39p/DJn9
 oPGQ==
X-Gm-Message-State: AHQUAuZdUyIAxPb6pqS92qa9FigoEmOlDkQPh+RKj7692iap2IKJ0M3k
 o1kolBOkg8g7jSimAd1aIzc4mj/MdjwHkL3KWTQ=
X-Google-Smtp-Source: AHgI3IY0C6Q/oztInKZQxwyd8k+COA306ww4jbwsIY03ZnBRkG6j/9fn3yyHQktGFWb1K6Y0nT0EJ+UQIh8nft81mcY=
X-Received: by 2002:a6b:c545:: with SMTP id v66mr1752509iof.40.1550155938783; 
 Thu, 14 Feb 2019 06:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
In-Reply-To: <20190214143842.nqsh6trwdjxq2ecd@flea>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Thu, 14 Feb 2019 22:52:16 +0800
Message-ID: <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065219_805618_F77F8C55 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 10:38 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Thu, Feb 14, 2019 at 08:09:10AM -0500, Yangtao Li wrote:
> > Add an OPP (Operating Performance Points) table for the CPU cores to
> > enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
> > information comes from github.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 61 ++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index 57a1390ecdc2..46a4a69eb38f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -28,6 +28,8 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> >               };
> >
> >               cpu1: cpu@1 {
> > @@ -37,6 +39,8 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> >               };
> >
> >               cpu2: cpu@2 {
> > @@ -46,6 +50,8 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> >               };
> >
> >               cpu3: cpu@3 {
> > @@ -55,6 +61,61 @@
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
> > +             opp@480000000 {
> > +                     opp-hz = /bits/ 64 <480000000>;
> > +                     opp-microvolt = <800000 800000 880000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@720000000 {
> > +                     opp-hz = /bits/ 64 <720000000>;
> > +                     opp-microvolt = <800000 800000 880000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@816000000 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <800000 800000 880000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@888000000 {
> > +                     opp-hz = /bits/ 64 <888000000>;
> > +                     opp-microvolt = <800000 800000 940000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1080000000 {
> > +                     opp-hz = /bits/ 64 <1080000000>;
> > +                     opp-microvolt = <840000 840000 1060000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1320000000 {
> > +                     opp-hz = /bits/ 64 <1320000000>;
> > +                     opp-microvolt = <900000 900000 1160000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1488000000 {
> > +                     opp-hz = /bits/ 64 <1488000000>;
> > +                     opp-microvolt = <960000 960000 1160000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1800000000 {
> > +                     opp-hz = /bits/ 64 <1800000000>;
> > +                     opp-microvolt = <1060000 1060000 1160000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
>
> So we definitely want to have that tested, especially since cpufreq
> can lead to all kind of hard to debug errors (brown-outs, CPU lockups,
> cache corruption, etc.). I good way to test that would be to use
> cpufreq-ljt-stress-test here:
> https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
>
> I'm especially worried about the higher frequencies that will probably
> make the SoC heat too much
Indeed, in order to avoid this situation, it is best to have cpu cooling
support(But now it does not support thermal driver? ).


In this case, perhaps we should remove the frequency beyond a certain
range to avoid the CPU being too hot?

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
