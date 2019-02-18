Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E101C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:14:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBA7217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DIImmxPZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3KC353I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBA7217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qb8aiDmjB5SCi2wax3C/EWRx2m3Yutk2MZSX0Fjt4nI=; b=DIImmxPZPKD7We9DPPb/QNRHJ
	BR8hcLBnyfFgZxc6X6+E8wUgrWqyp1+PlV3YpTSdZuFbFLPMJSOKiVl8NiJzHTc7To0Q4ygo6zeHM
	L83+STw4QoHaX9/JFFREjNgRqq0gUCFgMDjXwvM+1bxtcwXdo06GygXSlGWuZlj/Ka7lvbI3AmKTW
	GnWw0hTSwRNpDeeKyDQ4dvpkrrz1k6CQcZF3LglNZ5xZM6JQag8BEqWIfIN22yQZOX8gisX9lSlUm
	YK+bPQwEKd1ntwq/ck55ncr3WLxs2B8YfiMUdbW1oAVUwVDj31VMNnT5QmmneFm3V72XVvxZubyIO
	IIcy7etXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkcW-0000RB-FO; Mon, 18 Feb 2019 15:14:12 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkcL-0000B1-4q
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:14:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id r5so5399711wrg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FaVIp3EH7BD3M8O4nettVSMYaVOAjqNG6yeAMP4uUHA=;
 b=Y3KC353Is0r1aSbMMpYBEw2bal9YiKUXk/iefW/EW1i4f6KlaMt7MI9QMIOPiv02g6
 R34zwdOT8SFv+AseZlo9OKev6fhFVehvGqkLZU2gDIkv2P40/aohTjRDt2DJYxV3np3I
 HVWARi9/BXMzgdciehO9ZIqvwjbz0Y0EQ7jD1LrgtgPMXVYN+8whMupxC4+8aWe8b6rO
 Nv08ifueDfaB7eNKab5KWdKAKxsaY4Vwh9DQqsUHertLo+iWWaVXbVWNP8hPbFfAJPPR
 MLcd8P6942lGEKHMjeTkxEFNwBcBVniVN57nFy0ayXpOl0wELVjzfGXnC5NYCXGCHg8P
 inng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FaVIp3EH7BD3M8O4nettVSMYaVOAjqNG6yeAMP4uUHA=;
 b=dRXwehEbGaI+Pjms9alP0tqwvONYHiEeoWXmmS4zXgg3e+e9hOde5u37SKDyhuYI/l
 xGeBdLfYmma5/N0EJ2yx3mDB9kAakvFmeBP5aegEiFnrZ/FSAfREwtD86sqeylyJOgQ/
 5aavcp4csyIe+HmlT77njnwyLykhb3PEv6/+2NmWLSa9J/WdbH0LKyDccX6grVHFc1pX
 IPaGCOVt1vfKX/MpubYhkYa56Bzoh+Yk9TZduJDUNX0NGiq51ZhGKb0exJdWoobGUHn5
 RBK7a2dTBweTFvHXdjWxptjDl8Cow3q+5V1yyD2ICHuEnZ4EEdnSNALROTVRJOiB4/mk
 n0jA==
X-Gm-Message-State: AHQUAub1Ef3aK5PVBPu4Kg7kny8WM03vFvZL8BFhR3NXi/ESA9H+7REc
 J+kgWJlCCCQcq3zywFtRH3g=
X-Google-Smtp-Source: AHgI3IYDEureKZE7+j3kvn7W8CwGJCk5c3HSDJeBW8og+1hXIuvUlwEcTdPQvMdbA3CRACPsKo9DXw==
X-Received: by 2002:adf:f786:: with SMTP id q6mr954669wrp.125.1550502839140;
 Mon, 18 Feb 2019 07:13:59 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
 by smtp.gmail.com with ESMTPSA id r14sm10646285wrv.77.2019.02.18.07.13.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 07:13:58 -0800 (PST)
Date: Mon, 18 Feb 2019 16:13:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: Re: [PATCH v2] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
Message-ID: <20190218151357.GA21562@ulmo>
References: <20190211110919.10388-1-thierry.reding@gmail.com>
 <20190211204452.Horde.-B4_UgJoWHc85yxQZVtc9wu@_>
MIME-Version: 1.0
In-Reply-To: <20190211204452.Horde.-B4_UgJoWHc85yxQZVtc9wu@_>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_071401_712763_96E4977E 
X-CRM114-Status: GOOD (  30.39  )
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
Cc: linux-tegra@vger.kernel.org, Tristan Bastian <tristan-c.bastian@gmx.de>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============1611701629079689294=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1611701629079689294==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 08:44:52PM +0000, Tristan Bastian wrote:
> Thierry Reding =E2=80=93 Mon, 11. February 2019 12:09
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Commit 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings
> > for /memory") inadventently broke device tree ABI by adding a unit-
> > address to the "/memory" node because the device tree compiler flagged
> > the missing unit-address as a warning.
> >=20
> > Tegra124 Chromebooks (a.k.a. Nyan) use a bootloader that relies on the
> > full name of the memory node in device tree being exactly "/memory". It
> > can be argued whether this was a good decision or not, and some other
> > bootloaders (such as U-Boot) do accept a unit-address in the name of the
> > node, but the device tree is an ABI and we can't break existing setups
> > just because the device tree compiler considers it bad practice to omit
> > the unit-address nowadays.
> >=20
> > This partially reverts the offending commit and restores device tree ABI
> > compatibility.
> >=20
> > Fixes: 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings =
for
> > /memory")
> > Reported-by: Tristan Bastian <tristan-c.bastian@gmx.de>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - remove memory@80000000 node pulled in from tegra124.dtsi
> > - add device_type =3D "memory" property
> >=20
> > arch/arm/boot/dts/tegra124-nyan.dtsi | 17 ++++++++++++++++-
> > 1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi
> > b/arch/arm/boot/dts/tegra124-nyan.dtsi
> > index d5f11d6d987e..bc85b6a166c7 100644
> > --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
> > +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
> > @@ -13,10 +13,25 @@
> > stdout-path =3D "serial0:115200n8";
> > };
> >=20
> > - memory@80000000 {
> > + /*
> > + * Note that recent version of the device tree compiler (starting with
> > + * version 1.4.2) warn about this node containing a reg property, but
> > + * missing a unit-address. However, the bootloader on these Chromebook
> > + * devices relies on the full name of this node to be exactly /memory.
> > + * Adding the unit-address causes the bootloader to create a /memory
> > + * node and write the memory bank configuration to that node, which in
> > + * turn leads the kernel to believe that the device has 2 GiB of
> > + * memory instead of the amount detected by the bootloader.
> > + *
> > + * The name of this node is effectively ABI and must not be changed.
> > + */
> > + memory {
> > + device_type =3D "memory";
> > reg =3D <0x0 0x80000000 0x0 0x80000000>;
> > };
> >=20
> > + /delete-node/ memory@80000000;
> > +
> > host1x@50000000 {
> > hdmi@54280000 {
> > status =3D "okay";
> > --=20
> > 2.19.1
>=20
> Thanks Thierry
>=20
> Tristan
>=20
> Tested-by: Tristan Bastian <tristan-c.bastian@gmx.de>

Hi ARM SoC maintainers,

I had almost forgotten about this. Ideally I'd like this to go into v5.0
since it fixes a regression introduced in v4.19, so we'd keep the number
of versions that it needs to get backported to fairly low.

The patchwork link is here:

	http://patchwork.ozlabs.org/patch/1039743/

I don't have any other fixes for v5.0, so I don't think sending a pull
request would help you very much, but I can prepare one if you prefer.

Thanks,
Thierry

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxqy7UACgkQ3SOs138+
s6HnJA/+PHzLYvNy0GVO2MraG3qTgVD/d+p6gMp9W1C/9XaTG1Sd+RXmQXB7h9aC
UCoSuyu9dCg+fupe3SB9K0NXZi0nIf48rKLMUcDe928B+7LCP1pc2ovcjUn+cbc8
dAzvEZmnfksgnzs+oWQ8ZwfZVGVdb29DsloWssvJ/WW6dTpps27CXD9CbTLCJa/1
v+mxJcvxKP1h+b6bdVtg47r26Yr1zW2NuNuXJey6WyAwqzJxplXTVznkhm4HcfOz
jhMAMmCa8h88fmqp+d4s098LgCNrHRDf1S13cNa7jLo1esciSfVM+pDWm1NlO4uM
g+hceh0thLuiQnGx4kTWZqlfmZ7IWUjYLQeQ5CikmBKrzcgKwmQEJIQu3oy4OsIo
IxyxSJqwQAaHMKoKUmLCTVzM9XRMbdljWIHV5gFgxKCdkKfuCrDEa/pm2Zxk4lO4
D7zs+xGujTUX9sqJ8Nkc3zWTLHnETsykCukkxwmineq34bUEOe1qW9OotqUYsXd6
2VoHhTfxZrKev24g40462MZjds9ZXSnxAocpBczfuK/j2Hsx1MhHC3683KshniyH
xCGBZlvwsbjGcxKZbuBIfnl+ryEbJ4jBqZFt/faos4FR4jKUU5/igQO+7HZrfKft
sdgOhJonMgpN5Cibw3YvWTQ4nTi7QCLmN4QheY8+GKu41LpzibU=
=cvh6
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


--===============1611701629079689294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1611701629079689294==--

