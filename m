Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F73AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:51:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB672089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="li/jrJ9M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2HAmE+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB672089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6Hnh7fv7SCypGAAPm9xhq1Zv3gHTJTJ8bJLaFjqhLWs=; b=li/jrJ9MWdXm7DZKKAIyMwSSJ
	7cVsKL46aZwQwRuu+rKfe7+qXzyParvtwjyBaIL9c6Wf2WSgryksB148JggKq1MNraaWKXiGsLy8W
	Oumqsvx5FobI3+fjy9VHkMQflYElFJM8l+WY6SqSiqqPKF51PPZ/XV5NCKw8pYAUInKMT+bn1zz72
	R1qIDMR8lPq0z467c4X/SMj4U++yr4rTiMvihI3FYsKgkMUO5KmjgbWyGNMAdjBjzlLv6fpCp0xG4
	Ep/JPORZ33nHW8iQiyQCKPiVGtRYVaup+gPeOpuj/rl1YzPWlKllpFeK+yAXeVtCL2uChWe4nhsut
	1EFMuah/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvee2-0000Uv-D1; Mon, 18 Feb 2019 08:51:22 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvedy-0000UT-CZ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:51:19 +0000
Received: by mail-wr1-x442.google.com with SMTP id q1so17368939wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mamwhN/sM3mQrY82dAd8MPDO7H3lOgfK1aKDxaHtUpg=;
 b=S2HAmE+GS4oTZQ1lhburgbsWfgxkUIHHFXEL/V+LQry3pM411kSmNPaUPsmarYi4dF
 rJexYF+vqw1XOEUHWbDYIkrN5QFKHzvn4D4C39bn8l9m6DYjTmwT9M+cotAofNtUGVOX
 /j6MJy8UskoL5oYhGbmSgrLD/DbEltBw1y2eHTjgw24EsiO0Pv9zypfqC2KZJAco8CwL
 77oGNd7Pu4tWlMKbBVYQhcguFjEFvYkkdP0mdB9Dio8kwp4xmW4fzqElHdyxs6ddPR8V
 HTu1z4NsZWwtNV7SMRktnNl/7uAdexvvTM8o0eN/soY+ZnkY6vlTTJ+Uc+/G6KEOK9PA
 YNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mamwhN/sM3mQrY82dAd8MPDO7H3lOgfK1aKDxaHtUpg=;
 b=IXUuG1Nb9nbkae/r7Bprqc453YnJurIYS/3VQl8VY+1GbJz0p4YPaMCJoDXPSpT112
 VuYAoYXr4PTfooxr6R0HEgO7xUMuJ+S8Fsbvd0c4paIvybFdeGFTL32xvcZZYbedXQ0b
 SS1ZoLHqaIWZo4m6AW5nB5uLAbOtFEeswWgRobaR4TyGcaEdjP6jnTjgtnyx8EZM5kF2
 lmi6SOff3rekMiE5EJXjSf8ptlfKilVJQnaXacKKOhDJ+MSnhTCo1b3V3SXAtbW1ROP9
 5BQNtzjMFLdL9C81jy932pdcUaj3b2WA+ftf9asAfhjJovVy9Pz3de0xa9SbeR1mmPvS
 DdKQ==
X-Gm-Message-State: AHQUAuZ5kNc+1NnjcYO0niubTEpEPrckE+/iYoc3XYOffj86BqnD39Bw
 6WnD3W3W/zLoWM6eF4r5QL8=
X-Google-Smtp-Source: AHgI3Ib7MopIQiaqFCGcEdaR26sE3L0rZcj0k03vZ5T4WaSNicX2HYkC2z5GlDR3DqHIB2Ci8LCWhg==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr15978800wro.283.1550479876227; 
 Mon, 18 Feb 2019 00:51:16 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
 by smtp.gmail.com with ESMTPSA id n3sm14351671wrs.10.2019.02.18.00.51.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 00:51:15 -0800 (PST)
Date: Mon, 18 Feb 2019 09:51:14 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190218085114.GC19363@ulmo>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_005118_478392_3043EC33 
X-CRM114-Status: GOOD (  22.46  )
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
Cc: linux-kernel@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Robert Yang <decatf@gmail.com>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2382605904099222479=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2382605904099222479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:17:18AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This patchset adds support for the Trusted Foundations firmware on
> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
> firmware and upstream kernel can't boot on those devices without the
> firmware support.
>=20
> Changelog:
>=20
> v4:     - Fixed Thumb2-kernel hanging on Tegra20, turned out it was not a
>           good idea to switch CPU into Thumb2 mode right after jumping in=
to
>           the reset handler.
>=20
>         - Moved LP2-mode-set firmware call invocation to a later stage to
>           better replicate what downstream kernel does. This change was
>           suggested by Robert Yang and fixes system hang on Ouya game
>           console.
>=20
>         - Added references to the original work made by Micha=C5=82 Miros=
=C5=82aw
>           into commit messages of the relevant patches.
>=20
> v3:     - Implemented suspend-resume support.
>=20
>         - Reworked arm/firmware/trusted_foundations.c a tad. Now cache
>           is getting properly initialized, cache enabling / disabling is
>           supported.
>=20
> v2:
>         - The "Don't apply CPU erratas in insecure mode" patch got some
>           cleanup, in particular resolved the messiness in
>           __tegra_cpu_reset_handler_data.
>=20
>         - Added a comment to tf_cache_write_sec(), justifying the warning
>           message.
>=20
> Dmitry Osipenko (8):
>   ARM: trusted_foundations: Implement L2 cache initialization callback
>   ARM: trusted_foundations: Make prepare_idle call to take mode argument
>   ARM: trusted_foundations: Provide information about whether firmware
>     is registered
>   ARM: tegra: Set up L2 cache using Trusted Foundations firmware
>   ARM: tegra: Don't apply CPU erratas in insecure mode
>   ARM: tegra: Always boot CPU in ARM-mode
>   ARM: tegra: Support L2 cache maintenance done via firmware
>   ARM: tegra: Add firmware calls required for suspend-resume
>=20
>  arch/arm/firmware/trusted_foundations.c    | 80 +++++++++++++++++++++-
>  arch/arm/include/asm/firmware.h            |  2 +-
>  arch/arm/include/asm/trusted_foundations.h | 13 ++++
>  arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
>  arch/arm/mach-tegra/pm.c                   | 50 ++++++++++++++
>  arch/arm/mach-tegra/reset-handler.S        | 52 ++++++++++----
>  arch/arm/mach-tegra/reset.c                |  3 +
>  arch/arm/mach-tegra/reset.h                |  9 ++-
>  arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
>  arch/arm/mach-tegra/sleep.S                | 11 +--
>  arch/arm/mach-tegra/tegra.c                | 10 +++
>  11 files changed, 214 insertions(+), 23 deletions(-)

Hi Russell,

I'm not sure if this is something that you have a vested interest in. It
looks like Tegra is the only platform that uses this, and usage is
limited to two generations (Tegra30 and Tegra114). Do you mind if I pick
this up into the Tegra tree and send this as part of the pull requests
for v5.2?

Actually, Trusted Foundations is the only firmware implementation left
in arch/arm/firmware, so how about we move this file over to
drivers/firmware (perhaps even the tegra subdirectory given that nobody
else seems to be using it) and get rid of arch/arm/firmware?

I can prepare a patch that does that on top of this series, just let me
know how you want to handle this.

Thanks,
Thierry

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxqcgIACgkQ3SOs138+
s6GX/w//W+g1W1nxSBXL3svlE2qwDtpUVy7dQayozIareXJOzKQtUWv024Df4KKN
nbP841bAkpdJ60BQTAsmBg22uHgSU0EMm+lEUoqw1PlUXxTip4z3EEvqCShA+489
bDRwXYFFW0vC9b4ModO6o10DMeqcbpUn8kHRXtKXcK9W/H6XHbyDxNArwu9iov7t
AFT+1g+tNctC9BTHmuk982IPpP677Kf+DWoTnfaSROylxGL4vVLi6pgc8LSDPG/N
mQssOAFbZygKdFk6Ee4cxfKxjIy3D91AG7jk2NYeD6+8N4CtsaDQVgL60KOjjQdJ
oruj/k7vD72ol4SvX+PIJouV6orgauRGQOAVBQuLta1GoXF5XXF+n0U7/VhhPW8y
A6knDLy6RqvWtW1sD/mTOTH9TSuS1ru/DFBiOZXsnA2qAxiYt6vw0K22wwn30rFW
9LxqS29GRhu0Xh4UCV567pBMpOpa0qIpJ175OWTu8Bm9ai+ac9UYpPINfamaTLIp
j9grXhklN4mJ062zuTPV1SO37zcRhzfeMp+Ci1b52CZdnUl0gkFYzjdvWMSyu6PI
fN/lrKI4oEEPB4HuwYX0nsXbB96pFAEks2da6tgG2FTMN8uyUGZaZv1xuHqqJkG/
dWu+JEuOmD8JjPddH2fPZ6/JhpZxMUmhFhdQw+cADQTB4v50v7g=
=FU2G
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--


--===============2382605904099222479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2382605904099222479==--

