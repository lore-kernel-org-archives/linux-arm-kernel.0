Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2ECC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:09:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7462087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p00vVreN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdKG+B9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7462087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=27c6yHzeIzmjiWvWJgV3r5+213+k6Uz97nlRBdtNAnY=; b=p00vVreNfjy/cdrTWIep9kjwC
	Em6oxPnxJSr6vrja9GoYlZxdmnoqmjvKRIRIVY21grAoVels7676CmW7Fb7cFo7hP4nlZcVWsa29r
	HDU/pR+C6G40YdZGrU1qKYKlyJCe/72wPHYgWwlaVtvIFV0xlAYFBvBvxX5tzDzfmc9/N58kbbMKb
	vKI/HeV7gPRm01kZE+y3/mVVLdQ/zzLQoJr3lMXxy8MXTRI6dAspbZlaWOVtcFU9UjK9hFolvRKkU
	BFS5raQlk9tkiFwjXBNlCG46s/iQb0aJJTcYpgAJgLZfgiYyHxus3nWM2PqoRfffo9V9qqekR6Tmk
	p7f01G33g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqmI-0003l2-NV; Mon, 03 Dec 2018 16:08:58 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqmD-0003ix-Eu
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:08:55 +0000
Received: by mail-ed1-x544.google.com with SMTP id x30so11244558edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3HOgXG8Cr5YsERV2T5rvhw+4316QgprwNLvsEggZMvs=;
 b=RdKG+B9PB8ntar0iej8TXhgUNUvyRcfSbCHZ6zdaP1QzA2c1q9W3/pVdmCoiUpo0Lg
 VryQyxeuCFQJ05QuKRvw6Fosc9ABmbsRCrli6z5Crs9UumjoNwF6r3xNK2MYrFET0e0C
 PYjoJbygsiVs5lSqlGKwRdShcrMmKX9c+S26EDarv6W8sG3KBubSoBprs0QPzDksrSMA
 vgWk6MiFKXHaUiytyrDMAzU6yVrAZQ3lhPOdusArSEfc/jxs9xHpfHQbIhJSC5MzHbHK
 F+YyUcGFEwlPUfcFtwuRAnuX4t8+EV/HvOculES6yQRM3mKD2C6VPoTrRVCfngRI7VaZ
 bItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3HOgXG8Cr5YsERV2T5rvhw+4316QgprwNLvsEggZMvs=;
 b=KsSPecejj/Q4qLFWSqiWc/HT1WAICcI6NtV8LbIT1wyb15lcMwTU2dsYEk3Na+uVfp
 dt+aBNvLAReXpqPx1UcRzeD7RIhZtu2zr8w+Sqvwz+runVc7sGTpZTNyOyjvUZHMH5OY
 wmBQ7+1XVISLZl2QheIWI1ZkwgyDJVnzYtWBH91cX4IGBKHjDIT2R4aUCa8KrmyvWYvS
 af9sKi0G1Z9+Y9kAGi2LE/OvrpgyKq/++zI1YmHJheMEpgqSbF5YEj/zljX/KL/Bp7yt
 dt8NuTfmHv3j802uwCIMVUNzqciM4IGdXnzXg2wzdfiFtWFQTrKcGQZ1b3Ad/MY+ai8S
 9Lug==
X-Gm-Message-State: AA+aEWb3RfdwAB/EG8iU+Bzw7Gi2y7wUYhSI/vefHtI78GxrwpAbl8nD
 c0AdpnRshM9DB4gsjMiBhpU=
X-Google-Smtp-Source: AFSGD/UKbV42t8DqyXyt4zru21D+THZXiIYKtVxajtvdQxAWbreLtTYO+wpJmvKMlE8GPp/DcroC5A==
X-Received: by 2002:a17:906:2009:: with SMTP id
 9-v6mr13782442ejo.2.1543853320074; 
 Mon, 03 Dec 2018 08:08:40 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id k24-v6sm2202838eja.60.2018.12.03.08.08.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 08:08:39 -0800 (PST)
Date: Mon, 3 Dec 2018 17:08:37 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Alex Gonzalez <alex.gonzalez@digi.com>
Subject: Re: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel support
Message-ID: <20181203160837.GA10037@ulmo>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
 <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
In-Reply-To: <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_080853_503598_39C762AF 
X-CRM114-Status: GOOD (  14.69  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7531613945779259717=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7531613945779259717==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 05:09:30PM +0200, Alex Gonzalez wrote:
> The change adds support for the AU Optronics G101EVN010 10.1" TFT LCD
> panel.
>=20
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  .../bindings/display/panel/auo,g101evn010          | 12 ++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++=
++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g=
101evn010

Two things to keep in mind for next time: please split up DT bindings
and driver changes into two separate patches (checkpatch.pl warns about
this) and keep entries in panel-simple sorted alphabetically.

I fixed the sorting myself and also added a .txt suffix to the DT
binding documentation for consistency with other files in that
directory.

Applied to drm-misc-next, thanks.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwFVQEACgkQ3SOs138+
s6Gt/Q//fW3RY8o0MJeeWb5pyty3d3BVcUWDLS9phurF90m/1HbMIWE7/8d53bBV
DavgsKBPmhRlqy1Lu1O3940r+xS6WtlDXzFbt5Iiqd5DtwP+gftTzLND71wohAKc
Pc9lGjzdbeIndY8VcB/oBAEd62DD5BZsn6gMewARCpvT/VcLRCo5Ks/pkGl8QGbe
Ze3tzeAQwWMumzrdJLqbyBE72QA0/9/1ql8iqujmyFHZ5A1vlMozihUcnQ6cyyAt
p9MEJ/TVfKGu42sLc5OW+oPb9f3tLO+G/jVoZ9lLgfRyQH7nyucJPqZ1SPXmI9AR
OI9g34RCqnldcEjh2QPtCchpZBT9Ip55B/GJxZpFonZVjK1Fty9bpSQ5ZZLo03cT
OL1psLujcsLAb3TrkKfCt0fROv9xix0qo954o61E5LjmOx3o8OkKvsM68CuSvUVC
1CrjVZzacco5DeGO5z8NZ4SsmF2hRyzmGNvSAv19toqjXvvrZMasUmSrU+pdBYgW
aZipFthJkw/jlXnk1UTVvMfd/OHfrwDBiXuLvQSfMJ4aVpti2Kq/q8NF2eZw1OWU
cJngTfAVPVD1uHVjJSSDv93u/A43hvJMHcVD0gd0Rpu+AXePbHdfPje5Nmni+QZK
b4S2QNnwsTHZP5pvKP7ai1/OXv/Qjo2DSBQAFLR2Gi7gcRcVRXw=
=/9Nx
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


--===============7531613945779259717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7531613945779259717==--

