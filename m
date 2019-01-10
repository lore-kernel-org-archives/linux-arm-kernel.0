Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:34:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17658206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pOqzvtbe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="QXUi9YeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17658206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2IoQae3t2Hb6ntlddIrE6A9bO5IYf1ucmxI2DflCL1o=; b=pOqzvtbe8sK964
	uxSptMsf70R3/z6/1Nlxrjifz92uLwmL320bUEurtLe+DbC4aPND2Yo9zOBwnTXQwNjxl/y6MMQm1
	DBHDz2IRhPlOeZ/OnuxMXjYy2rvW4WA6xO8MTAqy7QPqSP9MahZsfxTmYyeulLRqJpEcNxphTwjHf
	O79aBT5Il6xsANeW+OjtM1m+gDvRMhyOkgWBb+196Hoh1G0+S78oqsCyru6Q+zNoAN5Qm2Cc1Frcz
	dgeyl5bhKGaVfBXGM9l2LGXyqmV5KiIUwlfSI529F8WB/qWA0KzhWTIqD09ubIIjiMoAF664XglA9
	Y0G9/ZbS+SiwlaDu/OQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdHR-0001qO-2A; Thu, 10 Jan 2019 16:34:05 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdHN-0001pw-0a
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:34:03 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so10280326ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=SILPKsssX93B2bCq9HZjULce0uDqO6Q10m7kNrgqwYI=;
 b=QXUi9YeW3unQmzoXtqNe3IB3+S5MFGteLRCy0Kwe6/pFc9Jmqm16in6HmByVWDIRKl
 6f3kuaV+Hh3b0K590egVDWxC3EU9IOQI6JuAV9ovtcXzu7hFKe8+1mx9XzOAwEq54iCE
 fML1LgdvPLufVrgPnhe7DXqhDIWyaDX6yBjsACzxiUxxE0i9+V/Q2paoLVGXPtarkqeh
 rCXSxKU1UEDjFrzrL5QbetyBm7NvL96HUXX0FFAuJX9f6M0f7+5SGf+3BNEtYTJLza0/
 XOVfs30FE+SreGAM7btblL82dShuFjdp/nzC+mQ8sRqNaHCSV3hOMtWhNutggiA0VfYz
 rkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=SILPKsssX93B2bCq9HZjULce0uDqO6Q10m7kNrgqwYI=;
 b=RABZZW7TFQJJNIgMWJTfu094gE/jfTTYotqHbumDWoNM9X206RnLW0AScZZGu61rZr
 A0ZpOoTSXnztmXTDa3Teh0oR4dj1V8k8Ny4HazFBVsnfiX+jRdFJmrGcby/I3se7x0BR
 JUFSheIYxZZ70xj9yuZTMNQbX9dip5ZpAN3+zUwS39i+iXTxMtUe7X3iI50/3ZPBOR6C
 Zaa5rmEKdOkOyMg14zZ8AMQChlQz8a9ARAgAFxIDO3UVa0P7VNzZE94H+xyvVCLu2jZq
 +4iiLjad2Afc/XlYNEWNO2ROXug+iaEpA5iz9SinnVjvbnIDq1YRhLjJvNlbXRZjJB8N
 icPw==
X-Gm-Message-State: AJcUukddnNDpVkd40q4DV4KW0JolqxmcepUiN7nZ9EYxIEkYvD1pY3Cl
 WiDLX+YVawe27Is0pLRe9vJeUw==
X-Google-Smtp-Source: ALg8bN40Dwqt2DdMJ2jk1c/vrgkqNq2maRTL2zAtHeSLyqteGi7vJvrtg0u2HTWaoUmJZNNswxQ+VQ==
X-Received: by 2002:a2e:90ca:: with SMTP id
 o10-v6mr6296756ljg.134.1547138038210; 
 Thu, 10 Jan 2019 08:33:58 -0800 (PST)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
 by smtp.gmail.com with ESMTPSA id p77-v6sm17026542lja.0.2019.01.10.08.33.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 08:33:57 -0800 (PST)
Date: Thu, 10 Jan 2019 17:33:57 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a7795: Create thermal zone to
 support IPA
Message-ID: <20190110163356.GF24252@bigcity.dyn.berto.se>
References: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_083401_108442_D4781D40 
X-CRM114-Status: GOOD (  23.07  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Keneko-san,

Thanks for your work.

Comments to this patch applies to all patches in this series.

On 2018-12-21 05:49:39 +0900, Yoshihiro Kaneko wrote:
> From: Dien Pham <dien.pham.ry@renesas.com>
> =

> [dien.pham.ry: arm64: dts: r8a7795: Add support IPA for CA53 core]
> =

> Setup a thermal zone driven by SoC temperature sensor.
> Create passive trip points and bind them to CPUFreq cooling
> device that supports power extension.
> =

> In R-Car Gen3, IPA is supportted for only one channel
>  (on H3/M3/M3N board, it is channel THS3). Reason:
>   Currently, IPA controls base on only CPU temperature.
>   And only one thermal channel is assembled closest
>   CPU cores is selected as target of IPA.
>   If other channels are used, IPA controlling is not properly.
> =

> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> [gaku.inami.xw: fix the trip temperature for cooling-device]
> [gaku.inami.xw: fix the power coefficient]
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
> Signed-off-by: An Huynh <an.huynh.uj@rvc.renesas.com>
> [takeshi.kihara.df: fix W=3D1 dtc unit_address_vs_reg warnings]
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> =

> This patch is based on the devel branch of Simon Horman's renesas tree.
> =

>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 64 ++++++++++++++------------=
------
>  1 file changed, 27 insertions(+), 37 deletions(-)
> =

> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/d=
ts/renesas/r8a7795.dtsi
> index af9605d..dd52b50 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -155,6 +155,9 @@
>  			power-domains =3D <&sysc R8A7795_PD_CA57_CPU0>;
>  			next-level-cache =3D <&L2_CA57>;
>  			enable-method =3D "psci";
> +			dynamic-power-coefficient =3D <854>;
> +			cooling-min-level =3D <0>;
> +			cooling-max-level =3D <2>;

I can't find any documentation or code which makes use of the =

cooling-min-level and cooling-max-level properties on v5.0-rc1. What is =

the intended usage for these properties?

>  			clocks =3D <&cpg CPG_CORE R8A7795_CLK_Z>;
>  			operating-points-v2 =3D <&cluster0_opp>;
>  			capacity-dmips-mhz =3D <1024>;
> @@ -207,6 +210,10 @@
>  			power-domains =3D <&sysc R8A7795_PD_CA53_CPU0>;
>  			next-level-cache =3D <&L2_CA53>;
>  			enable-method =3D "psci";
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <277>;
> +			cooling-min-level =3D <0>;
> +			cooling-max-level =3D <2>;
>  			clocks =3D <&cpg CPG_CORE R8A7795_CLK_Z2>;
>  			operating-points-v2 =3D <&cluster1_opp>;
>  			capacity-dmips-mhz =3D <535>;
> @@ -3098,58 +3105,30 @@
>  			polling-delay-passive =3D <250>;
>  			polling-delay =3D <1000>;
>  			thermal-sensors =3D <&tsc 0>;
> +			sustainable-power =3D <6313>;
>  =

>  			trips {
> -				sensor1_passive: sensor1-passive {
> -					temperature =3D <95000>;
> -					hysteresis =3D <1000>;
> -					type =3D "passive";
> -				};
>  				sensor1_crit: sensor1-crit {
>  					temperature =3D <120000>;
>  					hysteresis =3D <1000>;
>  					type =3D "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&sensor1_passive>;
> -					cooling-device =3D <&a57_0 4 4>,
> -							 <&a57_1 4 4>,
> -							 <&a57_2 4 4>,
> -							 <&a57_3 4 4>;
> -				};
> -			};
>  		};
>  =

>  		sensor_thermal2: sensor-thermal2 {
>  			polling-delay-passive =3D <250>;
>  			polling-delay =3D <1000>;
>  			thermal-sensors =3D <&tsc 1>;
> +			sustainable-power =3D <6313>;
>  =

>  			trips {
> -				sensor2_passive: sensor2-passive {
> -					temperature =3D <95000>;
> -					hysteresis =3D <1000>;
> -					type =3D "passive";
> -				};
>  				sensor2_crit: sensor2-crit {
>  					temperature =3D <120000>;
>  					hysteresis =3D <1000>;
>  					type =3D "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&sensor2_passive>;
> -					cooling-device =3D <&a57_0 4 4>,
> -							 <&a57_1 4 4>,
> -							 <&a57_2 4 4>,
> -							 <&a57_3 4 4>;
> -				};
> -			};
>  		};
>  =

>  		sensor_thermal3: sensor-thermal3 {
> @@ -3158,11 +3137,18 @@
>  			thermal-sensors =3D <&tsc 2>;
>  =

>  			trips {
> -				sensor3_passive: sensor3-passive {
> -					temperature =3D <95000>;
> +				threshold: trip-point0 {
> +					temperature =3D <90000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};

What is the usage of trip-point0? The label threshold is never =

referenced anywhere, or am I missing something?

> +
> +				target: trip-point1 {
> +					temperature =3D <100000>;
>  					hysteresis =3D <1000>;
>  					type =3D "passive";
>  				};
> +
>  				sensor3_crit: sensor3-crit {
>  					temperature =3D <120000>;
>  					hysteresis =3D <1000>;
> @@ -3172,11 +3158,15 @@
>  =

>  			cooling-maps {
>  				map0 {
> -					trip =3D <&sensor3_passive>;
> -					cooling-device =3D <&a57_0 4 4>,
> -							 <&a57_1 4 4>,
> -							 <&a57_2 4 4>,
> -							 <&a57_3 4 4>;
> +					trip =3D <&target>;
> +					cooling-device =3D <&a57_0 0 2>;

We have 5 (0-4) cooling states for the A57s on this SoC. Out of =

curiosity why allow states 0-2 here and not force it do more cooling or =

keep the to max cooling (4) as before this change as this is set to a =

trip point with a rather large temperature? Not saying this is wrong =

only curious :-)

> +					contribution =3D <1024>;
> +				};
> +
> +				map1 {
> +					trip =3D <&target>;
> +					cooling-device =3D <&a53_0 0 2>;
> +					contribution =3D <1024>;
>  				};
>  			};
>  		};
> -- =

> 1.9.1
> =


-- =

Regards,
Niklas S=F6derlund

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
