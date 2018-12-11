Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5594C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:29:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F9620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lr6vkMvH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxtX7Ph1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F9620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WekGUwWOpj8w52Znhuo1ft3/hG9LPHQicBTgq70f/mM=; b=lr6vkMvHEFfXlsKu1HM9zvE6I
	jdvlU67k+lRS/8UqOoG9BaQb+Y07JuzzfpPW5T5Wum7ZjtxQejK23tw/3VporgytXYMzwlb6mOhRA
	AlXVVtOgD9MNTfoZrRXzu/jlh1+5ZfUim7IfJPEILDLZGvtZmkV7sR+C6ym1r9QKhEkOsTrQ6JJfP
	w0Eqq0nojlI6JuV9VLCyr9r8vxJ0V2930PrTk2jzZRRJWFKadtRFkt7gxARap0bT9d+xnov5WZW4e
	5yRUxzwBxz40kOTELqCZDyOWlKd1DZA0N9otSmIJvRAUoxVDSFnxkmRbFN82pg2luZjJdBZ+yOqIn
	L7Y/2pe5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfHs-0005lw-Ic; Tue, 11 Dec 2018 10:29:12 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfHp-0005kv-CE
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:29:10 +0000
Received: by mail-ed1-x544.google.com with SMTP id p6so12094466eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QSPrtZQYZXN39pKVzh92qREJOV/EYg+x0RyqoXiL8OQ=;
 b=PxtX7Ph1nHq4RVANc6gL0DxPkrwU1lLsxH5Pz3K2z9TMHOS57mYFGbSEZ0jTxF1keC
 +vNRAGuCuusFTN24EtaBKTMY8qvAWj3pKHySLRm6MaQPeDmWiczLQgAaKEbwX8V6KJ4q
 CVOzK1a+/KL3rmId7gPCGCXbBtAz1uoFeaRloeUs5euUC5HCBkyv/6IdRv+wLzH6fzzo
 UloL96HZ8KJ1rYYxHlL6+yMx2nrQa+YjuHx4o6FVSh9dXWUcIqLbUX6LXrqOrap28+Im
 +fBwpEb2kmPgUFPIrwF6xaoc0oux+l5f1i8vyrIMQOfrz8qLRq5mOfvjm/gG8GtwJPtc
 yjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QSPrtZQYZXN39pKVzh92qREJOV/EYg+x0RyqoXiL8OQ=;
 b=KG/MQg+K2qibwuOn6CsZAR2Uk/EmfIXL3dJUbO5dnrFv6rWf/qJeq/0+GKm8yJFb4t
 X6m9ORQfhtoClblMHo1W4p/8UFbh6fJfGe475+uPOh61TCGSc2ipDm0Tad5+V7MM1Q26
 HNDRkIxXV402RwMVFAAFGfU5tqNzOp8FzlJSoFaUNgkvctgHpn957tPUt2ktC9PdguXB
 QAj/YzMrP+KhfY1PBgSImNuvfneiGpEcmjDoQY07eNnKxxfb7p40HTiNS3B9ndAZxD9f
 JUUTc5bUMU6tX5s2WP61biOgYjkBrX8h6hDS4WaJUkGcbsUGzccTWZmNygsoM97tyf77
 6OvA==
X-Gm-Message-State: AA+aEWbRNvnZ7/yInIN6J6NfpcvHwrEEVQKhoojpaXAwNvlFCUOByNAV
 ti3xKcEHs+o4s9HZUTvxTXNJ9JUm
X-Google-Smtp-Source: AFSGD/WFCFry5EVCc3sgebol5+ZtN8VHWQl8peA9+Woyc9EiYDXanZOeoch3AbHM8hIs/oFaKW77gw==
X-Received: by 2002:a50:e0cb:: with SMTP id j11mr14587211edl.195.1544524137646; 
 Tue, 11 Dec 2018 02:28:57 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id t15-v6sm2127812ejt.0.2018.12.11.02.28.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 02:28:57 -0800 (PST)
Date: Tue, 11 Dec 2018 11:28:56 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Message-ID: <20181211102856.GI14426@ulmo>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
 <20181211100550.GD14426@ulmo>
 <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_022909_435550_99A70CD0 
X-CRM114-Status: GOOD (  20.30  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============2130465750455079562=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2130465750455079562==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:08:53AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 11:05 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> > > WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from=
 the function tegra114_gic_cpu_pm_registration() to the (unknown reference)=
 .init.rodata:(unknown)
> > > The function tegra114_gic_cpu_pm_registration() references
> > > the (unknown reference) __initconst (unknown).
> > > This is often because tegra114_gic_cpu_pm_registration lacks a __init=
const
> > > annotation or the annotation of (unknown) is wrong.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/arm/mach-tegra/irq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > I'm not seeing these. Do I need to enable any special options to trigger
> > these? Or are these just so new that I haven't run into them yet?
>=20
> My guess would be that this is a result of the CONFIG_NO_AUTO_INLINE
> option that is now available in linux-next.

Okay, that would explain. It's not set in my configurations currently.

Do you want to apply this to ARM-SoC directly with my Acked-by, or
should I queue it up for v4.22?

Thierry

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwPkWgACgkQ3SOs138+
s6HFnRAAi5OjsnSOJjvHFV0izhJIfhiufCH8ED7aqLMBkYuDJK5t5cKaiSNqeZyy
fpCTBk4mjNBx9MyrDDhZB0YyDs8wDtf6keaBI/7eE+2YOj1Va8o5vMbNWP1EJS3V
3/8O9dXwjEHOiA0aPQ6Gea854Yi4z14aEeH67OqC9UTJ1jIGzYjrYZloV1qSwIUu
o1NVD175zaSK6aFFYWUiDwvTwgA0gnJvho7Uj+zmJ3jdg5vyQxcvqRG41bAdyuZ4
gKksCTnUMT22gyJm0q/w5MHOGekoX4ZmnHJD/H5L47kcjzCqEyjz3kt4ukuRnYIa
aYSe12zAmEE8zrIDn/csSt/FJGgATFBzg3ab0rrUqLP5tLUgE/DOz8RQTeXlF/xN
OrJjrc+0JpiwUiDLcoeAFO0MEf+Z7viPWDNae0X3LQ4Vp4qqrUQW9AlvLtjphAx9
hKMfWbNjEn3w2jXabQ4611nMT8ThIn5P0Mj4y8gTPWFNBb+ruc4t1HBDrZlAKTw3
pIigbiqPp7idDXCu2ybbDe2VxoVi7QnB65L0zj9spF5GfiwkJXelI3G9IjPuwU12
2sN6KZcZ8UcHKMbyOZcyVDuYh0cZn+z9LdGc8HyO5gvwewR1XD4yJ4NeGTNSvF+1
xLcHRPsrRj2AS4g4WYk8P8FKZd8LydwGTbwI4a3uh2tt+IIFFYk=
=INA3
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--


--===============2130465750455079562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2130465750455079562==--

