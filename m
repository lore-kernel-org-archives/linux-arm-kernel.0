Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25FEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5604218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cYmmTdtI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdVEgXVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5604218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FXoS3pjTDlghkIbevxO8ELpOGHfvq0xihgvTzAWM4gk=; b=cYmmTdtIggkDbLhDcxrmm7Qkv
	1XYQFjOPLQLcY9CYyZd9Ex6bpU8UIb4dsDbcR4WJJKsKvUzvy6AxeZ7+46eFONUi8reLa2xBw6bvw
	t4zkw4Mebk+L2qE9hiy5domCUSYnyKkEvCQvenCl+Z+jBoxnopopxhw9X1xk8mfZDjtTIGXckckN4
	GS/0OiA1KYYCYJLuTQoLxJhrbkRFlb957i++gvYJdFgrkQYwiUPHSI/xjHhxpJzjaG/Y70MsDx/9i
	g+I/vnfq6NnvGHrR9WBmnewR6IUg9yxt4nG4HQVZZUerV0in00NfoOPHIJ2mcVsT+WZ+1YXL2VJQf
	W/r6QUNhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn1oP-0000Rw-IX; Fri, 25 Jan 2019 13:46:25 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn1oL-0000RY-To
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 13:46:24 +0000
Received: by mail-wm1-x335.google.com with SMTP id m1so6837334wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OXhukp/dyN3JCCSOA+snc8wagVwhPEcgOEWTq5bZfp0=;
 b=XdVEgXVeuGYMbbOrXTawZgTlDYtkvt38l1/PBe99pfzyZMps1Pyt/Ayfbfv0gMJI4g
 P1FPEY3MQTjFTis8mUdvG0gpubd86XSWnHdpQvgbvG0YMY6UDZ0UK1WzQHC/5kVpdir8
 IzW2YqKLC1eP9ZYdJnvBT3f8VNcc42aPiMQ+CiBHh3OuG/INEHpzc1uOfJbiO6aUN83s
 eUeXNVMgQxVagD4PAXZ+9S3zuLCgcl7UUIKhUZEN2MHES4OzkC6k1qVnhJLMifX7Upuj
 9bKLahezRlkh1xAYUOPmule220DZXXFgxdSN+vGlNQCHFiFleAB9ugpqn80Rbu8v8dmM
 5bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OXhukp/dyN3JCCSOA+snc8wagVwhPEcgOEWTq5bZfp0=;
 b=V1OwSqYdLscJ0i2TD/LCmCxU0bpslRZgDoonzeGZRgbiVakJvhZMPeiATh6QsYxTuf
 CV5i9Rc7dCK6Ipae79mZlEDErxrbkhIw2bft0bqZSSEi62Kndw5rSWAl7eKQFnMHUyux
 H16RxsxmkJQ44sVcmwvbPXCxZhqnS9Gt97z2obn11Nhp/YyWCsDs6s2XZr0yCQ9V/YPH
 gVq/q/23Afl88su+s0W2DXtjzvH5Wp5UoBPB47kgvlOl+ig+JSrUN7jeUJJGQ6Y1wxbO
 tqNf75btEfuqPzK4xcD4I49hJ3au2UJZn+P2Htr0cDYpoNb/JzTW3V0f3Nq4g8FWM8Jz
 2rtw==
X-Gm-Message-State: AJcUukcvCD0VMjK6KiuOVKNKKjFmsUrldcCVJUuiWFAyM8kb+uvZTXaK
 8Ube57Dyfwjw6sDkiHfZgr4=
X-Google-Smtp-Source: ALg8bN4aecN+6d16UnWgpvMK65aR4VITS735HO4JAlfG2l7lrUhvFV+KLtFaEVDNItA22L89abx8FA==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr6329746wmf.99.1548423980004;
 Fri, 25 Jan 2019 05:46:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id 67sm164193447wra.37.2019.01.25.05.46.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 05:46:19 -0800 (PST)
Date: Fri, 25 Jan 2019 14:46:17 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
Message-ID: <20190125134617.GE22565@ulmo>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_054621_982813_8514FC67 
X-CRM114-Status: GOOD (  24.40  )
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
Cc: linux-tegra@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============2998387882393220254=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2998387882393220254==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 11:06:42AM +0800, Joseph Lo wrote:
> This series introduces support for the DFLL as a CPU clock source
> on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
> is driven directly by the DFLLs PWM output, we also introduce support
> for PWM regulators next to I2C controlled regulators. The DFLL output
> frequency is directly controlled by the regulator voltage. The registers
> for controlling the PWM are part of the DFLL IP block, so there's no
> separate linux regulator object involved because the regulator IC only
> supplies the rail powering the CPUs. It doesn't have any other controls.
>=20
> The patch 1~4 are the patches of DT bindings update for DFLL clock and
> Tegra124 cpufreq, which add PWM and Tegra210 support for DFLL clock and
> remove deprecate properties for Tegra124 cpufreq bindings.
>=20
> The patch 5~10 are the patches for DFLL clock driver update for PWM-mode
> DFLL support.
>=20
> The patch 11~13 are the Tegra124 cpufreq driver update to make it
> work with Tegra210.
>=20
> The patch 14~19 are the devicetree files update for Tegra210 SoC and
> platforms. Two platforms are updated here for different DFLL mode usage.
> The Tegra210-p2371-2180 (a.k.a. Jetson Tx1) uses DFLL-PWM and the
> Tegra210-smaug (a.k.a. Pixel C) uses DFLL-I2C. So two different modes
> are verified with this series.
>=20
> The patch 20 is the patch for enabling the CPU regulator for Smaug
> board.
>=20
> * Update in V4:
>  - s/nvidia,pwm-period/nvidia,pwm-period-nanoseconds/ in patch 1 for
>  DFLL DT bindings update.
>  - remove parenthesis in Kconfig of DFLL driver
>  - add more ack and RB tags
>=20
> * Update in V3:
>  - Squash patch 9 in previous series into patch 7 (ref. [0])
>  - minor fixes in patch 6 for geting alignment data
>  - more variable type fixes in patch 7
>  - fix the error handling in patch 8
>  - collect more ack tags
>=20
> * Update in V2:
>  - Add two patches that suggested from comments in V1. See patch 9 and
>  14.
>  - Update DT binding for DFLL-PWM mode in patch 1.
>  - Update the code for how to get regulator data from DT or regulator
>  API in patch 6.
>  - Update to use lut_uv table for LUT lookup in patch 7. That makes the
>  generic lut table to work with both I2C and PWM mode.
>  - not allow Tegra124 cpufreq driver to be built as a module and remove
>  the removal function in patch 12.
>=20
> [0]: http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D81595
>=20
> Joseph Lo (17):
>   dt-bindings: clock: tegra124-dfll: add Tegra210 support
>   dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from required
>     properties
>   dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required
>     properties
>   clk: tegra: dfll: CVB calculation alignment with the regulator
>   clk: tegra: dfll: support PWM regulator control
>   clk: tegra: dfll: round down voltages based on alignment
>   clk: tegra: dfll: add CVB tables for Tegra210
>   cpufreq: tegra124: do not handle the CPU rail
>   cpufreq: tegra124: extend to support Tegra210
>   cpufreq: dt-platdev: add Tegra210 to blacklist
>   arm64: dts: tegra210: add DFLL clock
>   arm64: dts: tegra210: add CPU clocks
>   arm64: dts: tegra210-p2597: add pinmux for PWM-based DFLL support
>   arm64: dts: tegra210-p2371-2180: enable DFLL clock
>   arm64: dts: tegra210-smaug: add CPU power rail regulator
>   arm64: dts: tegra210-smaug: enable DFLL clock
>   arm64: defconfig: Enable MAX8973 regulator
>=20
> Peter De Schrijver (3):
>   dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM
>     regulator
>   clk: tegra: dfll: registration for multiple SoCs
>   clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210

Joseph,

can you detail the dependencies between the various patches. From a
brief look the CPU frequency driver changes are completely separate
bits and it should be possible to apply them to the cpufreq tree.

The clock changes also seem independent of the rest.

Are there any dependencies at all that we need to be mindful about?
Or can individual maintainers just pick up the subseries directly?

Thierry

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxLEyYACgkQ3SOs138+
s6HBIg/8DTm4DsCp+vntQYd8NXlB0cqjVentmwKMUHCGFHaUW8FllyOSZdtaoV9E
hxpAjUv5J28PRGGuUbL31eeXfvdyhTDh2+bkH7ND7IV43sLnGM5LPwTHZks+Sp8p
5mh/OjNDFZ2FOykcILtKJJiEHU6Fi9pDrw4xIMU3juZJgP1+csDoQm6Ae9Fy4Yb4
2fDwZ6QtSadf1ddvvdXcBcNpIdnTD2tfSFLg8m7yiDsAY3oc9g4NH+3Jbp0SsRjo
MBIGLNijy+hcgJL2gjmIMFubVGfT5CkJocs63bUv/dGjM9mbpBt28tCQhoRq/C6d
YPzF2Awz7FgJdw83ifumuPusTaXRF5z/p8FJKitDqUpxvZ049l8z9U3SMsptoHq3
4HF0F59EPEqX3GNUZZGke4I9Dmtc4mZOL8rSIJd2QGFVaTaPBS/Bgz4wQQ9vsDEB
AlvwbIK66oiklX6JjM3DtgVsZRLLEClQAImkI9RjXG/bS9RtJWP8Ywl4thrbYPbq
JQ9e3pe/KsGf0fsXCFxAeQ7cmBO2ktHn957iebw/pcF9KaJ3QFsEAEful6yLN8Om
TImsJKOyFPVtG0bNKwVuOCazIRN0KQem8RGbS5qB70kWfwsB2rb/gb4BTEi+VHsK
oAlS34t1G/mprmR0cXYH2iLuF63//M8yNwygQYXlUGXGqcmLFsY=
=6hYF
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--


--===============2998387882393220254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2998387882393220254==--

