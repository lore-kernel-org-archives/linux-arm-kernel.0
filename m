Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C711C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:54:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E236020881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GJUZFK3G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKSlG8vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E236020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=liM5Lk8HebAwns/CC6tdqbLY3UgyDo8QAuXY4VRhf+g=; b=GJUZFK3GbKEdt5hR7gE+SX4UO
	Q6a02KSKuKJ9EYd+6sIo64pwpvrmzHaKWx0QhSUsVMPLvOIBF0SoShokYL8CUwgTDkiPa5RqTkjn5
	OumlCZ3S3N/YZGKz9RBX4zdQFSSoCn700cs0SVgJefj+v6IPeR2QUnBzmeB/D/dVXEoQw5/VWMEtF
	vZbDtWkgNg61vJEbfWQBPNfRf/RIIL9w2AQj4NuZhoO4wwpXuyqwYP9+SZz6/lwvs5atI3/Q0Nr/O
	8KmbPSs8FbHkdceGrbsgIhID/VkWdUib77Oc107laOLZVWGq/yh1h5mK1X6VSSFXy63xyKAF9V0AY
	XNfHmtg2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go1kq-00059Y-6Z; Mon, 28 Jan 2019 07:54:52 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go1km-000594-9P
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 07:54:50 +0000
Received: by mail-wr1-x442.google.com with SMTP id p7so16908186wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 23:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eA5f6I1VAm2kyYWjD9gr0mMAEDgi0RtfPocfuKN4L30=;
 b=jKSlG8vSbS1sREG/DuPnXwLcf2OXD4Uwwqj0vFJt0c9dMuuxgehL9YSeXgpsl2gGg6
 dVMJI/laAEzln6oo1kfdvQYZs2/TZsAcUhjD2DcrjhkxdyxO2DPFUlpqCmd9ibnMr0In
 TtQsiWbDvi1UWEgrfVtcvvCZMWCt/oKaL2ohprL/QvIvB1scHef95PpGJvPurYQw5Yby
 AGZrEtLx4idlnY/M4qVny4eWEv/yAMt82r3K1hBvSXxV2BaVzdcJn5MTIUwKtBNqI3jo
 RJF5VM6zL0M3barxe+LrAc2mKvkpDG2pGPoqFVHGjRx4TLeNxM4RUYRel5qrWpdgy5t2
 jmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eA5f6I1VAm2kyYWjD9gr0mMAEDgi0RtfPocfuKN4L30=;
 b=cBS3m28cbtneljw3ieQx/xNKxIkOlzmokEazdhARMeDoZ5msiAwvcGhkuw6slaCvke
 jm8jOM37wxX7aeKZWBYCATq0oxK3P2QEceEv8lSBJvAYlH3f2wyS6Yr9sB6Tq7w24dNH
 7PRKg7W5YSC0ZzwUYUIriGue5gO8glpUq703Op0TNsR5cddFZUVVBBLCE/y7ECa0ORB9
 kk2BBcSsI+e3JnoPt+AwYkviQPeQ5f3n1rF98XzTjLEIM4ZGzIL31MtFS39HnKIkF+vf
 VytvZL3Uw4G7r430U+r0DCXyetFGwY8F6Ubl2InhqMQmU+8atAUb3tHEUlfVDFB7Ovgc
 8/Ug==
X-Gm-Message-State: AJcUukdUJtbTlDG7supPXzVE5/4hdSay1yoEUN21YqnFkTK/FfNxKDW+
 cJvUtZGITP5J+PdHEoJ9g9g=
X-Google-Smtp-Source: ALg8bN6syRRMqV22GTzrKPD3a246sE8vKfBxwA5n/tFoXWY/GE7Qylt2CB2t7ot6hRl3h4/nXDKntw==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr21596340wrr.39.1548662084432; 
 Sun, 27 Jan 2019 23:54:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id g21sm7122195wmd.0.2019.01.27.23.54.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Jan 2019 23:54:43 -0800 (PST)
Date: Mon, 28 Jan 2019 08:54:42 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
Message-ID: <20190128075442.GA18124@ulmo>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190125134617.GE22565@ulmo>
 <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_235448_331834_100C80AC 
X-CRM114-Status: GOOD (  36.14  )
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
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8459993079152616582=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8459993079152616582==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 09:43:00AM +0800, Joseph Lo wrote:
> On 1/25/19 9:46 PM, Thierry Reding wrote:
> > On Fri, Jan 04, 2019 at 11:06:42AM +0800, Joseph Lo wrote:
> > > This series introduces support for the DFLL as a CPU clock source
> > > on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
> > > is driven directly by the DFLLs PWM output, we also introduce support
> > > for PWM regulators next to I2C controlled regulators. The DFLL output
> > > frequency is directly controlled by the regulator voltage. The regist=
ers
> > > for controlling the PWM are part of the DFLL IP block, so there's no
> > > separate linux regulator object involved because the regulator IC only
> > > supplies the rail powering the CPUs. It doesn't have any other contro=
ls.
> > >=20
> > > The patch 1~4 are the patches of DT bindings update for DFLL clock and
> > > Tegra124 cpufreq, which add PWM and Tegra210 support for DFLL clock a=
nd
> > > remove deprecate properties for Tegra124 cpufreq bindings.
> > >=20
> > > The patch 5~10 are the patches for DFLL clock driver update for PWM-m=
ode
> > > DFLL support.
> > >=20
> > > The patch 11~13 are the Tegra124 cpufreq driver update to make it
> > > work with Tegra210.
> > >=20
> > > The patch 14~19 are the devicetree files update for Tegra210 SoC and
> > > platforms. Two platforms are updated here for different DFLL mode usa=
ge.
> > > The Tegra210-p2371-2180 (a.k.a. Jetson Tx1) uses DFLL-PWM and the
> > > Tegra210-smaug (a.k.a. Pixel C) uses DFLL-I2C. So two different modes
> > > are verified with this series.
> > >=20
> > > The patch 20 is the patch for enabling the CPU regulator for Smaug
> > > board.
> > >=20
> > > * Update in V4:
> > >   - s/nvidia,pwm-period/nvidia,pwm-period-nanoseconds/ in patch 1 for
> > >   DFLL DT bindings update.
> > >   - remove parenthesis in Kconfig of DFLL driver
> > >   - add more ack and RB tags
> > >=20
> > > * Update in V3:
> > >   - Squash patch 9 in previous series into patch 7 (ref. [0])
> > >   - minor fixes in patch 6 for geting alignment data
> > >   - more variable type fixes in patch 7
> > >   - fix the error handling in patch 8
> > >   - collect more ack tags
> > >=20
> > > * Update in V2:
> > >   - Add two patches that suggested from comments in V1. See patch 9 a=
nd
> > >   14.
> > >   - Update DT binding for DFLL-PWM mode in patch 1.
> > >   - Update the code for how to get regulator data from DT or regulator
> > >   API in patch 6.
> > >   - Update to use lut_uv table for LUT lookup in patch 7. That makes =
the
> > >   generic lut table to work with both I2C and PWM mode.
> > >   - not allow Tegra124 cpufreq driver to be built as a module and rem=
ove
> > >   the removal function in patch 12.
> > >=20
> > > [0]: http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D8=
1595
> > >=20
> > > Joseph Lo (17):
> > >    dt-bindings: clock: tegra124-dfll: add Tegra210 support
> > >    dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from required
> > >      properties
> > >    dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required
> > >      properties
> > >    clk: tegra: dfll: CVB calculation alignment with the regulator
> > >    clk: tegra: dfll: support PWM regulator control
> > >    clk: tegra: dfll: round down voltages based on alignment
> > >    clk: tegra: dfll: add CVB tables for Tegra210
> > >    cpufreq: tegra124: do not handle the CPU rail
> > >    cpufreq: tegra124: extend to support Tegra210
> > >    cpufreq: dt-platdev: add Tegra210 to blacklist
> > >    arm64: dts: tegra210: add DFLL clock
> > >    arm64: dts: tegra210: add CPU clocks
> > >    arm64: dts: tegra210-p2597: add pinmux for PWM-based DFLL support
> > >    arm64: dts: tegra210-p2371-2180: enable DFLL clock
> > >    arm64: dts: tegra210-smaug: add CPU power rail regulator
> > >    arm64: dts: tegra210-smaug: enable DFLL clock
> > >    arm64: defconfig: Enable MAX8973 regulator
> > >=20
> > > Peter De Schrijver (3):
> > >    dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM
> > >      regulator
> > >    clk: tegra: dfll: registration for multiple SoCs
> > >    clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210
> >=20
> > Joseph,
> >=20
> > can you detail the dependencies between the various patches. From a
> > brief look the CPU frequency driver changes are completely separate
> > bits and it should be possible to apply them to the cpufreq tree.
> >=20
> > The clock changes also seem independent of the rest.
> >=20
> > Are there any dependencies at all that we need to be mindful about?
> > Or can individual maintainers just pick up the subseries directly?
> >=20
>=20
> Yes, no dependence with each other. We can apply them separately.
> Please let me know if I need to inform cpufreq or clk maintainer to pick
> them up.

Rafael,

the three CPU frequency patches in this series were acked by Viresh
already, but unfortunately you don't seem to be Cc'ed on these. Are
you okay with me picking these up into the Tegra tree and send you
a pull request in a couple of days? That way we can get the whole
set tested a bit in linux-next. If you'd prefer to pick these up in
the PM tree, here are the corresponding patchwork links:

	https://patchwork.kernel.org/patch/10747943/
	https://patchwork.kernel.org/patch/10747947/
	https://patchwork.kernel.org/patch/10747953/

I'll go and give my Acked-by on these patches if the latter is the
way you prefer.


Stephen, Mike,

the same applies for clk patches. Stephen's acked all of them and I
think all of the series is good to go. How about if I pick up these
up in the Tegra tree and let this all cook in linux-next for a week
or so and then send you a pull request with these? Stephen already
picked up a couple of fixes for clk/tegra, but I don't think any of
those would conflict with this series.

All of that said, Joseph confirmed that there are no dependencies
between these subsystem subseries, so if you'd prefer to pick up the
patches into your respective trees, I have no objections to that.

Thierry

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxOtT8ACgkQ3SOs138+
s6HBcRAApHy2CW/WZBXKOmNovh29XJrNWIDxMREUrfkdrCI0oa8ugHPZ2Zhp75Sz
zFYnM2PgMF0uyfLz4a7zbEVEVZgt6LWOKU1AYtTjHSPpMcfo6A0CD1gOutT8CsVu
uIBKaTGECl3bJjMq6ohwWw/nTOW3IaObe+3yWfUbtsEhFRRjzxEQ4D1MPqF8o3U4
xWsDgRiZ8rZt7r7mZIUSJnp4ZTPF+5xIpMu2uUbgZPnQCCfzvHcFyp2P/QCN65u/
FyoqPV9ISZYQDGYCemdJJi0fN3ZYgaqjmFAGW62EPowsnZGqpqAp++AtEcU476n3
KH+9PwVKokOdBQFFGPwjyyhm8AD7eAltXhzd0yPL0x4da3pfyFzZPZ2KQQTm21Uu
SF1j7IuuPSQg9ML8riKD2hYERrcR1cpL1RPsrej3uyqFRVpLxC3potKVTqi7gKtX
Y/JqdXfPeocivOYHUUth3PYLNWguODNoZYVVn07Pm0GijaP5xg6o8eGyC/or/NiZ
phoiK4LOFC8S+rDhhqEb8sooWW4vNbFupK0rxfWGpDWTBb3iu0o5K58UqHU2ZHDw
Xv9ifwCkQS36MrmfVmT0W0fZlfTYf33NoqkmXH6XV+70zbD55NsnpJWxMlE2p71o
n32O9QM2UZPV4o3cPbKzSxgxAFgY31G1bUnnZWEqvVBryi66h38=
=kzjf
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============8459993079152616582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8459993079152616582==--

