Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F302C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC6221917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kggvRp1r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSUMi63y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC6221917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rNBel5JO5vi3DzTIvG8RQU8PJ69DDepAVtcbXsfgpV0=; b=kggvRp1rNAgnCySzqye5zPqSN
	M4LhTAjPuafxIH4erWM6/IyWBYTFOo7x5WFXV3TNt62WkN97XnI/4BGsIgLFtR318DGOtzDWVwtfw
	hAvyAxczT8+M0BBA9H5UeFGiD3xhAxk1oljhkUbCoj/Yg9iCyDOiNv7U6v4dQkEOxI6vKtPIqrfLL
	QSxD+ier71FQmjZQMpprt00Pd7gwxUbnZiohUUPBYQ6fX5xU60rQQUpLk96TrMXo6vk/ehEpN/Zhq
	i8RvciX+n6077HFPkj9NuYtk6X+FfwNJV9zEotaBktwY9h5zsonO+pGa7ZUPWegRT5KXjfFjHc+A2
	LPY+BOzjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9c5-0003X9-DM; Mon, 28 Jan 2019 16:18:21 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9bZ-00034m-VD
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:18:04 +0000
Received: by mail-wm1-x344.google.com with SMTP id f188so14482040wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=m1WiVpso5x1xBVUxmLjH0VSxUW1HDcRaj1rhGSoI6JY=;
 b=aSUMi63yh2pX/jfsvS5/wXeZHl7Na+5pmQbmspgJ+TIEbezZpMNsJxQQboUuW7WQNe
 Itn1FjvVqV+u0Bn8YS6Ss/c42qsM75BoXHsg4+4eFGBhhjbKfQQcaz5FVMK+NVNRR9rd
 dVgOvrzgdKh/1AQutAS2/bqXVq/GmuDA4/F/VuCf2ZTIofzAmlGru2SqOHGlJbMT4e6l
 JNUHiB6SOhRB94vaHakDRMAHxZ1yBFPh1RmRw71h1vZvB5nbhtTeRXiGroxUEYo/jM2f
 if4eqMxyKiOJiuDM8nH3hgcviMuk1FLRsaTEbTBqN0E/iJYki6Y3qHYiMjQ+llOwLZOy
 sdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=m1WiVpso5x1xBVUxmLjH0VSxUW1HDcRaj1rhGSoI6JY=;
 b=kpj128LfiYWG8S6WbqLp/olZCYF/A7lBjXYE1UGQb+Xj8v3iR82yWCltiJSQpe6XaG
 3F7hOJD3HMnusSk6cJ9qrtgIgut7PyBTToTbbYx2tCpkGC2GluA3hb5AlDpoob20xHJP
 ufsNofU3IUb41TvRQvJI0I9A8TyRdP03INtUbVi0Ppe1hr8lprEWGXo3ZlHtOkJT7Tw2
 +JIomZUAfRt4get9cyoIVGuFSWr56+NblK79WoNFBQhPjsc3O/6Ggdfxu+n5qE2fOZ4l
 WE/iJ3jVVJetA5z7hVX1l8SbVT8THocBGHFsBLWCCDI2J8GTIVaE2ZujDKZbZTui5/x+
 qJxg==
X-Gm-Message-State: AJcUukfdrFZVhIPFsqfvbcYsmrJiA/IcRTj4UCBPBaEwFIdJ8HEOuKVu
 ocoGcTqsK0tpCEEA4XAn5MBfLho66/Q=
X-Google-Smtp-Source: ALg8bN4YOa0O7+ofIYVAMBz9v9LgWOVDM0yeL63AOhY/p6P8aMrjTRUdnCzoXoMUej1McfL+1LTyJg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr18443201wmf.117.1548692268276; 
 Mon, 28 Jan 2019 08:17:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id w18sm113601795wru.54.2019.01.28.08.17.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:17:47 -0800 (PST)
Date: Mon, 28 Jan 2019 17:17:45 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/panel: simple: add support for
 PDA 91-00156-A0
Message-ID: <20190128161745.GH26200@ulmo>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_081750_425426_B0060A52 
X-CRM114-Status: GOOD (  12.70  )
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
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh+dt@kernel.org, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7991791300593195151=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7991791300593195151==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:43:28AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
>=20
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> Adding Device Tree bindings for this panel.
>=20
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> [eugen.hristev@microchip.com]: specified backlight and supply bindings
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - added binding explanations for required properties from simple-panel:
> backlight and power supply which are mandatory
>=20
>  .../devicetree/bindings/display/panel/pda,91-00156-a0.txt  | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/pda,9=
1-00156-a0.txt

Applied to drm-misc-next, thanks.

Thierry

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPKykACgkQ3SOs138+
s6HlEQ//fZonuiZIonlMiwGhVPmzmd+XQNGGtRXIuqmjSUUoK++wYhFu8Ys0R/1+
eT0l6pdVmETBUIp+XIWWWhUqSUqBrG+DLQhDFtCxEFDWkV+qodcE0C4Ms+lz9GVf
RVE0v1efNCZXEsS5/YqoxTse91FXlm71MIpzmRf+NTh6zeSCM2hR0fdrRfLMvmCS
GiJn0MFqbvMPuZvG2sClOrAt7vrkoLsyAAY4DrYHvHksqPCQGnwizyeTo8flFOla
alT9hnrRbplwmIQ5yTFDhSQZQ1rsBlyuLVHwOOHabLCiwJYs/XoyVsAwEQ4617DP
W/mmHL6fTLkqWU8EcJ2mZVRPG10fqHkc//iKez6lta/uPy0ckKNEarS5x7Jd9SzC
UTLAGdBI4CMXQ1sfRY2CTj5IFZe+MiZ5ay66/jXbMob/fuloYBmDFtwECkKQZwzx
NG9iJo8plIISX2r+pKfLPAKGPKlIlzDUNFd9mZJNG+CnzMhwxudYJ9M2s4T+AZWu
7J80Xcka48F07VCiBHNfnRG/r8Z9r6zDpKVAPAcJMwo2Qi26nLaU35UTCosSLVrY
WYtS8YoEsnc7nMrJm6stpwEahNAE5vsXKeeMU22ziGkpRpgpnRA0049yhmU8V1jj
qItsaF2QrihE63oDhuJnOD+16Zje9ALV6ecum07EI8N0CPJ4YQM=
=rNwQ
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--


--===============7991791300593195151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7991791300593195151==--

