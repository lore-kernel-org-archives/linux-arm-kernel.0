Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD2FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:20:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E552064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8wgOgLj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZnrblm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E552064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Ynn5DQzsZl+Ui75KAOlzKK/kUTiaX2bVv8tOzotPLk=; b=W8wgOgLjnarg4i
	e14nnP2159kB5ZAf/keQlaBIJyF0D+jQ2ri18Y5hYRydK8C1y2dMJh6Nenyy7nceSJWKCzfMf7bAG
	5janAQRJeDcBKqlPGCBcrsOO3tr9ABFvUZHKoHunISEntvkv+2SvN33+9sDmEWQuweODpCz5JUhU/
	WTRS9KCZ6VWDoXdgGYVp4qupAYZseaIGoHDhLdlgzjF9BQHCuuzD6guiONK1RfiukAIB//WY9/LFR
	7Fk0ZLI9L3ZM3UmBmabDoR+mXxxZ7bYU3e6PCvsc/7U1NJ3ze9IM0ouJrsUt4M9IDRawKFJYdCMwt
	Ehtx+5U6ZoKTp/86KQLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZuX-0006lj-Hn; Wed, 05 Dec 2018 16:20:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZtv-0004vg-U7
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:19:56 +0000
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 73FAE208E7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544026781;
 bh=ttjQTMKxQvSDqL8gME0wiXdDgWnR5tM+j3N9lxclCVs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VZnrblm5R+r/55KWnoca/t0eMM4ysKM4ry/QR+jBhu9ZEekWo+Afckw7wz8DGPiKY
 px067SYGt5nVmSDnDJUKj/8XwEhO7ant7dgOT9ad0VsFuUuIped+FbCBWa0b9skpyk
 nOU0I3qTTMIM16m6+oLSG9U7E6Mv7ohJEhYbfOD8=
Received: by mail-lf1-f43.google.com with SMTP id l10so15142601lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:19:40 -0800 (PST)
X-Gm-Message-State: AA+aEWbAFOu4S0mr77BJRiroWzSaBr4y3Pt8HkndZRR9jE7C+4/wI45P
 ffREgRQO4WE7BTgJW10iDoT8d0XtDhJkidLZWt0=
X-Google-Smtp-Source: AFSGD/WHw1+Py/HOJjAETk5XM+k1FjWg3UNAPsi//LGMhzHj9oJnT4S41PIjrIKmlirlvE7xmvSl3ytPQWSE7tqBw/c=
X-Received: by 2002:a19:2d16:: with SMTP id k22mr14105095lfj.12.1544026778560; 
 Wed, 05 Dec 2018 08:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com>
 <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
 <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
In-Reply-To: <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 5 Dec 2018 17:19:27 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
Message-ID: <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: linux.amoon@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081952_508524_5036A51A 
X-CRM114-Status: GOOD (  35.82  )
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
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 17:11, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Krzysztof,
>
> Thanks for your review.
> .
> On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Add suspend-to-mem node to regulator core to be enabled or disabled
> > > during system suspend and also support changing the regulator operating
> > > mode during runtime and when the system enter sleep mode.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > Tested on Odroid U3+
> > > ---
> > >  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
> > >  1 file changed, 72 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > index 2caa3132f34e..837713a2ec3b 100644
> > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > @@ -285,6 +285,9 @@
> > >                                 regulator-min-microvolt = <1800000>;
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> >
> > Driver does not support suspend_enable so this will be noop. We could
> > add this for DT-correctness (and full description of HW) but then I
> > need explanation why this regulator has to stay on during suspend.
> >
>
> Well I tried to study the suspend/resume feature from
> *arch/arm/boot/dts/exynos4412-midas.dtsi*
> and them I tried to apply the same with this on Odroid-U3 boards and
> test these changes.

Midas DTSI clearly has bugs then.

>
> > >                         };
> > >
> > >                         ldo3_reg: LDO3 {
> > > @@ -292,6 +295,9 @@
> > >                                 regulator-min-microvolt = <1800000>;
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> >
> > The same but with suspend_disable.
> >
> > I am not saying that these are wrong but I would be happy to see
> > explanations why you chosen these particular properties.
> >
>
> Well I was not aware on the regulator-always-on cannot be set to off
> in suspend mode.
> Will drop this in the future patch where regulator-always-on; is set.
>
> > >                         };
> > >
> > >                         ldo4_reg: LDO4 {
> > > @@ -299,6 +305,9 @@
> > >                                 regulator-min-microvolt = <2800000>;
> > >                                 regulator-max-microvolt = <2800000>;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo5_reg: LDO5 {
> > > @@ -307,6 +316,9 @@
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo6_reg: LDO6 {
> > > @@ -314,6 +326,9 @@
> > >                                 regulator-min-microvolt = <1000000>;
> > >                                 regulator-max-microvolt = <1000000>;
> > >                                 regulator-always-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo7_reg: LDO7 {
> > > @@ -321,18 +336,27 @@
> > >                                 regulator-min-microvolt = <1000000>;
> > >                                 regulator-max-microvolt = <1000000>;
> > >                                 regulator-always-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo8_reg: LDO8 {
> > >                                 regulator-name = "VDD10_HDMI_1.0V";
> > >                                 regulator-min-microvolt = <1000000>;
> > >                                 regulator-max-microvolt = <1000000>;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo10_reg: LDO10 {
> > >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> > >                                 regulator-min-microvolt = <1800000>;
> > >                                 regulator-max-microvolt = <1800000>;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo11_reg: LDO11 {
> > > @@ -340,6 +364,9 @@
> > >                                 regulator-min-microvolt = <1800000>;
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo12_reg: LDO12 {
> > > @@ -348,6 +375,9 @@
> > >                                 regulator-max-microvolt = <3300000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo13_reg: LDO13 {
> > > @@ -356,6 +386,9 @@
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo14_reg: LDO14 {
> > > @@ -364,6 +397,9 @@
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo15_reg: LDO15 {
> > > @@ -372,6 +408,9 @@
> > >                                 regulator-max-microvolt = <1000000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo16_reg: LDO16 {
> > > @@ -380,6 +419,9 @@
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo20_reg: LDO20 {
> > > @@ -387,6 +429,9 @@
> > >                                 regulator-min-microvolt = <1800000>;
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         ldo21_reg: LDO21 {
> > > @@ -394,6 +439,9 @@
> > >                                 regulator-min-microvolt = <2800000>;
> > >                                 regulator-max-microvolt = <2800000>;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> >
> > That's unusual setting... enabled in suspend but not necessarily
> > during work (no always-on).
> >
>
> I kept the regulator required for emmc/sd card in
> regulator-on-in-suspend in suspend mode.
>
> > > +                               };
> > >                         };
> > >
> > >                         ldo22_reg: LDO22 {
> > > @@ -411,6 +459,9 @@
> > >                                 regulator-max-microvolt = <1800000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         buck1_reg: BUCK1 {
> > > @@ -419,6 +470,9 @@
> > >                                 regulator-max-microvolt = <1100000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> > > +                               };
> >
> > This is seriously wrong so I have doubts whether you tested the
> > changes or you know what is happening with them. If you turn off
> > memory bus regulator off, how the memory will work in
> > Suspend-to-Memory mode?
> >
>
> Well I did not find any issue in my testing but I might be wrong.
> Ok I will drop this changes in the next version of the patch where
> regulator-always-on is set.

It worked fine because regulator-off-in-suspend is noop for buck1 but
it is clearly wrong from logical point of view. Do you think that
memory should be off in Suspend to RAM?

> > >                         };
> > >
> > >                         buck2_reg: BUCK2 {
> > > @@ -427,6 +481,9 @@
> > >                                 regulator-max-microvolt = <1350000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-on-in-suspend;
> > > +                               };
> > >                         };
> > >
> > >                         buck3_reg: BUCK3 {
> > > @@ -435,6 +492,9 @@
> > >                                 regulator-max-microvolt = <1050000>;
> > >                                 regulator-always-on;
> > >                                 regulator-boot-on;
> > > +                               regulator-state-mem {
> > > +                                       regulator-off-in-suspend;
> >
> > Looks suspicious as well.
>
> Ok I will drop this changes in the next version of the patch where
> regulator-always-on is set.
>
> >
> > Best regards,
> > Krzysztof
> >
>
> Well I have tested this patch as following
> with only one issue, before enable suspend number of On-line cpu is 4
> after resume number of On-line cpu is 1.

If before your change number of resumed CPUs was 4, then you
apparently break some things.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
