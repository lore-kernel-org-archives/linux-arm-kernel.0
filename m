Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B297721B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qcwrGILS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P78zfATk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B297721B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pEcyqt598xI259WpB4nu3pruSWU7hMSsx/OPoo6L+Bc=; b=qcwrGILS/eTdVyqgvJDavAJqQ
	VcPh23xiZaZSaxDkd/gdoVXdmNDBSDoHMdCNl3Vvm8N9MR03NL9vcxELqAUjlTq5movsiYFl3YBne
	xI21FfmO8a2KBEiDhS22BiilLFrMqIwWdmC29NRpmvz7Kw4pmfU8GVdybkiGIUbNzmkFtz3mahHAU
	+40NRTFe+VO0TovNXnfy3DkUqOFoAyLuuvDeFTJlC0yCoQi5VUOu1V3H7LZGsIB4s8v3h4sRnyA/M
	SXl9/FT5O3S2zuxBxGCe5X5jSsCPfBLcYsQpvGCOUN4e8o1TWD/MjWKK5ocFt9+Mxes0Uzli/8ZX2
	rlM/udRYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gulFP-0006zI-5h; Fri, 15 Feb 2019 21:42:15 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gulFL-0006yo-Qb
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 21:42:13 +0000
Received: by mail-wr1-x441.google.com with SMTP id v16so11772397wrn.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 13:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Zl2ZR9IfKD6QmHBLh1yxrxbATKQ1+0VYAhbSJFfsTv4=;
 b=P78zfATkhv39xpjDe7j7ss+hn4+YlVhOfUmaOMYVIt3OsTWc26jl5DJ7zfWI0r51rV
 ezMWOijnHTBp6kvs3Nd8gwJiTrpHUXZDBvCN2b50NsBEPr2Sp+UszmmzD+RpFDV7mLVV
 3VTu6spA4rAcsLscTXkZwLJJ0X+Hs+EmuHrzPAXyAHVr0/jFo7eNeF8h0v1B48XfjoQd
 lIn09a2SQbZWsOtXs56wq5MFZlPJLY7baESIv++1I2G6E+sAdLJICAhp1gMGijKEVaEM
 Ys0EUKEq4rvl7StLESUHekGTvn7puXwQCILkaBT1IVsOIkKl+jsCbOqm5PRUzTeOFpve
 zwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Zl2ZR9IfKD6QmHBLh1yxrxbATKQ1+0VYAhbSJFfsTv4=;
 b=cSoqM3MHnRbJpQAjwLkiTUbjpejPEM6djKRqr4DIEak2V0+NacnjlNHjvlpew1bSY/
 dbwkTLOWHQe6chuFs3Kgi750t7TXvjwL/+0tcphA3wLAkpDyOv3fk2kB/15Gp1kHFnT7
 L6lcKvlBPzk3cpSg/9PTGu3wZscxdO4Ry0KqPsNauVcErS1T8KHFj1S78odMcOQTgAkv
 RXX+W/Z0ZLCWOJa8T4X6fIRLekd24Y8otpDcp3uJsEF/pbC6dk0KzzNKYk8VaP10mws7
 Vz1B/Qoz7r9qr2dfXFKZgfkkjpI1GB2L+6x/oFlpyTz4prdSobV6va7wOMYIcb2etTdx
 Nl5A==
X-Gm-Message-State: AHQUAuaK8jHEit5qTzT9bVdPnNofiSFGMmuxgAfTnmseZQ4/3lCaJ9Lc
 1+0NBAzR3X74fJY2jGjPcic=
X-Google-Smtp-Source: AHgI3IZ32AG3ypZ3AY2XS7HyQtxYmbWr3KoQUM6ijz1nt+9O19LMOrZDPRWmdaou2z2/e+qBvBxbnQ==
X-Received: by 2002:a05:6000:8b:: with SMTP id
 m11mr7961345wrx.243.1550266929625; 
 Fri, 15 Feb 2019 13:42:09 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
 by smtp.gmail.com with ESMTPSA id u134sm5420289wmf.21.2019.02.15.13.42.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 13:42:08 -0800 (PST)
Date: Fri, 15 Feb 2019 22:42:07 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 4/9] soc/tegra: Changes for v5.1-rc1
Message-ID: <20190215214207.GA12838@ulmo>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-5-thierry.reding@gmail.com>
 <CAK8P3a2tSaHsAOarZ8NHO-N4ZcLQL2rD2ti1rAe4meidWbVNEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2tSaHsAOarZ8NHO-N4ZcLQL2rD2ti1rAe4meidWbVNEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_134211_858615_F66D5B2F 
X-CRM114-Status: GOOD (  18.71  )
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
Cc: Timo Alho <talho@nvidia.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============5455359163277778729=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5455359163277778729==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:25:39PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> =
wrote:
>=20
> > ----------------------------------------------------------------
> > soc/tegra: Changes for v5.1-rc1
> >
> > This contains a couple of miscellaneous fixes for minor issues and a
> > largish rework of the PMC driver to make it work on systems where the
> > PMC has been locked down and can only be accessed from secure firmware.
>=20
> Pulled into arm/drivers.
>=20
> > ----------------------------------------------------------------
> > Jon Hunter (1):
> >       soc/tegra: pmc: Make tegra_powergate_is_powered() a local function
> >
> > Joseph Lo (1):
> >       soc/tegra: fuse: Fix typo in tegra210_init_speedo_data
> >
> > Mikko Perttunen (1):
> >       soc/tegra: pmc: Support systems where PMC is marked secure
> >
> > Thierry Reding (6):
> >       soc/tegra: pmc: Use TEGRA186_ prefix for GPIO names
> >       soc/tegra: pmc: Sort includes alphabetically
> >       soc/tegra: pmc: Add missing kerneldoc
> >       soc/tegra: pmc: Pass struct tegra_pmc * where possible
> >       soc/tegra: pmc: Make alignment consistent
> >       soc/tegra: pmc: Explicitly initialize all fields
> >
> > Timo Alho (1):
> >       soc/tegra: fuse: Fix illegal free of IO base address
>=20
> Should that last one have been marked 'Cc:stable' ?

My understanding is that this currently only happens if we boot the
system using a DTB from a downstream build where these FUSE and BPMP
device tree nodes are sorted differently and therefore cause them to
be probed in the wrong order.

Booting an upstream kernel with a downstream DTB isn't known to work
very well in general. It's something that I hope we'll be able to do
in some distant future when the gap between upstream and downstream
DTBs has become sufficiently small, but I don't think we need to
bother fixing this in stable releases.

Adding Timo to clarify whether he thinks this is important enough to
backport.

Thierry

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxnMisACgkQ3SOs138+
s6H4wg/5Aa7RYMzZepcEY2x+X6Vk5FWr1FRVrEavfuX0Fu/MJdfZXlwcfN54sW3s
oLdZGV9uBTwL/WTyLcpWY4JaYZTYClIl3Li3AlveE2xvU2XN1FX3SHR5/xigrAqF
q3T/3KcJ4XNx0ds0QcaQH3REybadxzih5pGyJYbTL0NxxCaGb52CQbyiLoEQx8KS
SkxAL36leNUqTxkADYH57jyCMpRNiQf6b8lz3tyeCyt7UIflG9LEDTa/PuocTxre
St0BmsnBBUJY+ueIBozfKLl0cINk5zNZ3pER+6WO4xtca5BvLo7H1Gz5L6AQabJc
Go/QmLQ4W0kxk1DLiqsP/8CJR8Jp8l3qw783jPQgaQNntn27fVYC5zfFG3Un8POd
665ROyKdsAijeJ9nnylS5j2b92IunNC+PRGHXAbPT7h4ISjkmoarlRJzbkUw4bmA
vVsj3Mw1VGMA2ERO4mHG2yQtagUBN37Zobd8GUMseHFwghZURdpbFghyV3q9uSlI
13bZhdiS9xlIrjL5pHZIzMGSI7/DC3pnP77CJiNduGsSdAx9U3ICbEFGfZfVMj/d
cJByyVdI9wZJLNrOnwPK66tKnTkYaOf8T+wR7GMofv3pegjPWY6QL1fZccR+qxiD
h86mhtWyjy7+8Vhld9ZE+p5BewrqW5YWXT/CMSv7TZsW/YyHSxs=
=s6w7
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--


--===============5455359163277778729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5455359163277778729==--

