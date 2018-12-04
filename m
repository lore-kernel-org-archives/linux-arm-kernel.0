Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13763C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:11:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C786D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lzUMtJk5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5S11r9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C786D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=in1zUop5c829XejX18L4m5uBE2JLrkeV1MrcoqkHWvc=; b=lzUMtJk5SXzCaSWKzQV+P1mH4
	t6h3ffBoGwydcNoNS6RleUz4HPjOY2z5LZPyZQ72AVmgFzyHd1eKTf+CUZG9YT5CUgabFTX7lEBba
	uha1lkJWJwP/5AKlZeX8wg7RiPsaMJIj/fSWlHzgM0D+67NWU4MdaAa6T7vE1bCCpC1n4WKlPYlRE
	xMCXkDldIdnvobZgTOk1NC1UGNU5DxrN3oxWt0qjgUWfgCmiQtjA9qSoxu5stV0gTuXAKfBgKzBgV
	mOgg1555vKSm9ZJmKIjeCAS69akhhpuC6MR3REVwRJMCVV3r2Q0rOfaBATqSAe3yZn7MgT9bdkoHw
	9mjZ9NOHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCM2-0000Sa-AQ; Tue, 04 Dec 2018 15:11:18 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCLy-0000Rf-Vu
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:11:16 +0000
Received: by mail-ed1-x542.google.com with SMTP id y56so14177284edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EiAuwGdXxqVyFaM/QXN0E/CNsdsOyesjSsZb0+N3pJs=;
 b=n5S11r9Ci1FOFT7P/kITlBOAE6SpKg3fAG8wS2XxuLHaO+rC4O9zuGSAFwwYNqi9N6
 sEYlaGwK8QNIDJSuRUvKvd74ECG/PcephRnv0BUnumC+2wZ1lbbFKdDcI97cEvRUCnoi
 cKybvnq3Dshsbg5t6krqsxCDR/MGmWF1r5MJNVxLa13h+tn7273Xv9piEowRjVGMGvHs
 xaX1FxPEqG61uNRlpIm9ph2AtNhFS+2jZHKVa0G3RH4LxDlJ2hwoV5vUApSAqvx0EZgU
 4ItmVYgp6WhYJsMrcMJt4cVa9Vgy5vPf5gNtFDT3DIhSww/cKV2lHX1C0GyHD8jti87q
 CD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EiAuwGdXxqVyFaM/QXN0E/CNsdsOyesjSsZb0+N3pJs=;
 b=bn52yhRiFSbW8qYqI8jnRs0mMWni3nokXwEBA6twft4iKiYevH8IsjCSyxb2KnLWFp
 Owb+DRUS6Ig1PmgI3te7b+9pKTG84uNgObOpPNB+4gnRC6lbjpaMMlZhHRMXNSZsYfP1
 GYAECrVGJNg3Qk3H7DD192gGbXJHOqNrVxT8r4n/tnr1whEIWx3Zwznf37l7yObUBMBa
 a0hNvbcUmkWVhls2nw/Fli1vA7teQnev62qF7brujEGA+Pxde1725FRQ3iuVGQ+EfWCE
 gp0edm6il7W5MWi5FklbfZL7CmbFJhbl3jhclXVGIcyo1rxrRto7pLgo/q8Yp22F/h5h
 yHNQ==
X-Gm-Message-State: AA+aEWZ8IFJcAkZQoy+Whzj2iC8QtAGqmFP3Yu4sLXtj2BshKax7aupm
 ipexvOSXSQde/US8yZ3snjk=
X-Google-Smtp-Source: AFSGD/XbTlJd7cixRdqOR9KOY07CPxNWYYKxb/VIdCwRWGNl5/PYHot2Ride5BNgZGLoQdzYa3jPfg==
X-Received: by 2002:a17:906:4447:: with SMTP id
 i7-v6mr16019926ejp.190.1543936262950; 
 Tue, 04 Dec 2018 07:11:02 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id h47sm4914095eda.8.2018.12.04.07.11.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 07:11:01 -0800 (PST)
Date: Tue, 4 Dec 2018 16:10:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 00/19] Tegra210 DFLL support
Message-ID: <20181204151059.GA23827@ulmo>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_071115_052261_B47480F0 
X-CRM114-Status: GOOD (  22.67  )
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
Content-Type: multipart/mixed; boundary="===============0432848204952352486=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0432848204952352486==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 05:25:29PM +0800, Joseph Lo wrote:
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
> The patch 11 and 12 are the Tegra124 cpufreq driver update to make it
> work with Tegra210.
>=20
> The patch 13~18 are the devicetree files update for Tegra210 SoC and
> platforms. Two platforms are updated here for different DFLL mode usage.
> The Tegra210-p2371-2180 (a.k.a. Jetson Tx1) uses DFLL-PWM and the
> Tegra210-smaug (a.k.a. Pixel C) uses DFLL-I2C. So two different modes
> are verified with this series.
>=20
> The patch 19 is the patch for enabling the CPU regulator for Smaug
> board.
>=20
> Joseph Lo (16):
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
>=20
>  .../bindings/clock/nvidia,tegra124-dfll.txt   |  77 ++-
>  .../cpufreq/nvidia,tegra124-cpufreq.txt       |   6 +-
>  .../boot/dts/nvidia/tegra210-p2371-2180.dts   |  20 +
>  .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  14 +
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |  31 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  25 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/tegra/Kconfig                     |   5 +
>  drivers/clk/tegra/Makefile                    |   2 +-
>  drivers/clk/tegra/clk-dfll.c                  | 455 ++++++++++++---
>  drivers/clk/tegra/clk-dfll.h                  |   6 +-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c    | 536 +++++++++++++++++-
>  drivers/clk/tegra/cvb.c                       |  12 +-
>  drivers/clk/tegra/cvb.h                       |   7 +-
>  drivers/cpufreq/Kconfig.arm                   |   2 +-
>  drivers/cpufreq/tegra124-cpufreq.c            |  29 +-
>  16 files changed, 1095 insertions(+), 133 deletions(-)

Hi Joseph,

can you highlight the build and runtime dependencies between the various
patches? For example, can I pick up all the arch/arm64 patches into the
Tegra tree without breaking anything?

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwGmQEACgkQ3SOs138+
s6HGIA//QprwVZ1gLLeej9HHBlkKBlBSrNsrvmcVHsnuRvHPFEcKNgCQ60ubl7cL
KQAYcTjV8n1wZXpMo6oCRdEuk9/I9ZnOixaLp2b0XoQYetFwC3h0oHTKTyAR7Qol
KVOyeHFpleCEHhuFcePJqdg0a2SSVD+FHFc2DWut2IPS7UhLnUYB7BnimwCOmpEO
lQ+0+wj+w4P922YcZgc66VUgyi+pbeokAwu1h890sUA+VdeimKXQZ4Cd8zz/kJ79
3QO8z5Lcp4iK0Pswjv/hoW/z+VA2ZpXK4BRKwq00e/xhVVb4LBgJZAxpkm1uki7d
HcacuVPAEWygMmwRPbIviHeuNreMVbgt9pC8qOrzjcYu6vbW10drxSfUtiXFclYh
kw8yjuUlw1kdMWCfHUvcF3YKjQZYvrvTZ2b5GpG/7/N+hEGWj0mWVct5kDCO/tZP
jNGGsqBmdepHH6fVrhFE9rdIsrN/nhCFsgWAVJKh0wj/CT/GbemjrHgX/4lC5T+k
tOsiv/xtAxy2F9aVpNar6EBlo0ZAhRdFa7vcQFjfrloPSTkxg/6Zri3cykuIx7N9
R8Zy/oxOsAWObP+geZmMH/FP4/MCUH/lM7buoOj4OtKY1KYHavjcU9OBdmG/a+m6
6Cup6sxChs84o43SpiFf+93A6KHFv3Fq28lAnJ9rWAxIvJRs8M4=
=PgS1
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


--===============0432848204952352486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0432848204952352486==--

