Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D84C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:07:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10162082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k2G2G1rr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuL2qdnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10162082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0xKm/j8LemGIvsEALrheBxPj576S07XsDDZOBOucP3Q=; b=k2G2G1rrymBQF+
	164muznyDOguW589VKT4W8MgYKd71I9OP0Qy2LTHmSOgyI3b5KolQ7cIGBgBJJTio0nj780RvHNEY
	6mixXOub1ucomfY61nUNTbMIfu3GlClowCz/Zlg5hk1oB9RSSrWCWahajTgsZGd6GWDP2e+T3ao+I
	PLa5Ou1zzsDDhiicqhqIG2zR20inviBtFd6XAkjJwX4DBsfw/ymleFdQ8JbMuetJMT+HirDqQmUHd
	6fB+QHjVHSA8Os2v65EoF/xz23sEP0BsmZhTw+FLXj2mQAJCbSTQFPCAaawSMLvF+Eea8e/OSJlWG
	l1hqz9QNCpr9qtoAIKIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUXpY-0005XI-AB; Wed, 05 Dec 2018 14:07:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUXpU-0005WS-Bg
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:07:09 +0000
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5E0D2082B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544018816;
 bh=qyYD9nSwLer4Uz87oUIOgQIAIclr96yNjXhXskrf75k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LuL2qdnECboiMVoxi0gkKg4Y5leqvVyIuSGDqOULwQSa17sWGKEYAY6iHnwpbgTn+
 CgDebYdEWRT6p3mWK77jgdut+TYjtrnSo5v1ejP+2yc+wsOFK7Qd/si1pOHUQz26gO
 BbJhgKqArbwbfOdd4e6JbxfDyDOKs0VkcaGHjpBE=
Received: by mail-lj1-f169.google.com with SMTP id t9-v6so18428535ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:06:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbYVtzX29lg+vP60eLfdpIdb87NnrBRXSRsxTUCSjCCFwkiIxQx
 xsNgtlt7sHc+Bzgl4BeAEXJnCC/lL7+qq9h5LsY=
X-Google-Smtp-Source: AFSGD/XWzW66RRyUKV9tYJD5ySQMIUjJxTjzdYfF87BgIYchP/GSFSnlNHUrEw5gkZQpee6ZxWKjPunbhNfmi/jBqJk=
X-Received: by 2002:a2e:990e:: with SMTP id
 v14-v6mr17640562lji.60.1544018813993; 
 Wed, 05 Dec 2018 06:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com>
In-Reply-To: <20181204194025.2719-1-linux.amoon@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 5 Dec 2018 15:06:42 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
Message-ID: <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: linux.amoon@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_060708_476099_73CEDCF8 
X-CRM114-Status: GOOD (  22.69  )
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

On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add suspend-to-mem node to regulator core to be enabled or disabled
> during system suspend and also support changing the regulator operating
> mode during runtime and when the system enter sleep mode.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Tested on Odroid U3+
> ---
>  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 2caa3132f34e..837713a2ec3b 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -285,6 +285,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };

Driver does not support suspend_enable so this will be noop. We could
add this for DT-correctness (and full description of HW) but then I
need explanation why this regulator has to stay on during suspend.

>                         };
>
>                         ldo3_reg: LDO3 {
> @@ -292,6 +295,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

The same but with suspend_disable.

I am not saying that these are wrong but I would be happy to see
explanations why you chosen these particular properties.

>                         };
>
>                         ldo4_reg: LDO4 {
> @@ -299,6 +305,9 @@
>                                 regulator-min-microvolt = <2800000>;
>                                 regulator-max-microvolt = <2800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo5_reg: LDO5 {
> @@ -307,6 +316,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo6_reg: LDO6 {
> @@ -314,6 +326,9 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo7_reg: LDO7 {
> @@ -321,18 +336,27 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo8_reg: LDO8 {
>                                 regulator-name = "VDD10_HDMI_1.0V";
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo10_reg: LDO10 {
>                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo11_reg: LDO11 {
> @@ -340,6 +364,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo12_reg: LDO12 {
> @@ -348,6 +375,9 @@
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo13_reg: LDO13 {
> @@ -356,6 +386,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo14_reg: LDO14 {
> @@ -364,6 +397,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo15_reg: LDO15 {
> @@ -372,6 +408,9 @@
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo16_reg: LDO16 {
> @@ -380,6 +419,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo20_reg: LDO20 {
> @@ -387,6 +429,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo21_reg: LDO21 {
> @@ -394,6 +439,9 @@
>                                 regulator-min-microvolt = <2800000>;
>                                 regulator-max-microvolt = <2800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;

That's unusual setting... enabled in suspend but not necessarily
during work (no always-on).

> +                               };
>                         };
>
>                         ldo22_reg: LDO22 {
> @@ -411,6 +459,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck1_reg: BUCK1 {
> @@ -419,6 +470,9 @@
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

This is seriously wrong so I have doubts whether you tested the
changes or you know what is happening with them. If you turn off
memory bus regulator off, how the memory will work in
Suspend-to-Memory mode?

>                         };
>
>                         buck2_reg: BUCK2 {
> @@ -427,6 +481,9 @@
>                                 regulator-max-microvolt = <1350000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         buck3_reg: BUCK3 {
> @@ -435,6 +492,9 @@
>                                 regulator-max-microvolt = <1050000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;

Looks suspicious as well.

Best regards,
Krzysztof

> +                               };
>                         };
>
>                         buck4_reg: BUCK4 {
> @@ -442,6 +502,9 @@
>                                 regulator-min-microvolt = <900000>;
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-microvolt-offset = <50000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck5_reg: BUCK5 {
> @@ -450,6 +513,9 @@
>                                 regulator-max-microvolt = <1200000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck6_reg: BUCK6 {
> @@ -458,6 +524,9 @@
>                                 regulator-max-microvolt = <1350000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck7_reg: BUCK7 {
> @@ -465,6 +534,9 @@
>                                 regulator-min-microvolt = <2000000>;
>                                 regulator-max-microvolt = <2000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck8_reg: BUCK8 {
> --
> 2.19.2
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
