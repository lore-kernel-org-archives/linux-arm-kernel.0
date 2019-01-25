Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD53AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99543218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ByDJYIl4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8PvQIpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99543218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AUNY1TkYGdSBMg5UeIdL6mNAlKYZMSJuCkx0hju3C+E=; b=ByDJYIl4qp9vPkyW+u8aDLnu+
	e6QSTKe+cpx/DLTXQOIxbqekezjNbJ9Cyvw6IUS0XK92/P3OgLGyejI8B+EfCPsqmbDrXwErNY0qp
	9ItqBwK93yvXTXyiVrpOMlKsgHnkP/lvJ41J6XmwPtl1kgSrpYpVeGj7RKzrx8yeSeIAOWbnXy/bw
	n0x4UDdrUIZVdkaIxerDMC306DzTL3wVO0P0jIYMkswBLULySoZvhHUocG6H0R47rLv2onTrf+J/f
	6O5pyVXQuuxEzyO/xebQnsH+68a58+pR680O28TD3tfACHPQD3EhIFPLMYAKLNaptDvMvylf5dAbK
	lTH4uUPRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn09J-000507-QG; Fri, 25 Jan 2019 11:59:53 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn09G-0004zi-7f
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:59:51 +0000
Received: by mail-wm1-x341.google.com with SMTP id y8so6357144wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 03:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yd2KRYj/O/ViMY7CmOjQrj2f5W2R7/yOkhtD/2v9Xdc=;
 b=Z8PvQIpdFqv6wootbCs4Bo/GGMd7i6rnovN05hB+/flwOSzAkr8qcDPVQBbn6Vpcur
 +qkkd2nidyOu2UShgH+Yc/GvBl010zGRV8fsZ7jBPxzJ2vDhdetNpk/y9EIbMcwrOY7t
 18KLBQdzSzVbPGYYYyNSpqSm158FADFaN2InjK5tSpOkQctPH7KKWS2jgjiDAKH/DBbW
 rvCF9YQQFR/KaQMciVW+1Hm0vfbDvXE34YMng+WnxYE2oFnC3P23OBwlJKSXv7F7FBj7
 +3ZrrFDHTV0f7rVLt/rvirvlQS4xs03byk96eplexIsvPzIh7JzLdeEJZXiiRxBWtv0s
 /jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yd2KRYj/O/ViMY7CmOjQrj2f5W2R7/yOkhtD/2v9Xdc=;
 b=VDe3Wqy1SQwM8vjr+SjSQrW3EW7JOovlLKNSzqUispQR/ltgQxJ3cK0gGE3qajSCKO
 2kd21k4L0R5w5pnfZGxqo+b9p58Xlw+ZdzzS4SgZTEZcc5GDamzG3BxZfWGWZIXiet0j
 W5AuKyxqPUHCx85fU2ntOh0SCMKm3Fiauxwmpk4DXqzw6ejRkpIBSsjRKcrpUsL4T6sS
 KBA/vCl0IRlpw+pFM45pacEnfzWvS8zSnc8hc6+qbS2dMSDqiGFsRuvYasFbXQZImxAJ
 fjtaF/VHXCOnrf1DGyPuvBVF/y+l/MODg2clLLWKwYGfpt1Z/hqXWCfJqnbk1CZjFSrI
 gNjA==
X-Gm-Message-State: AJcUukdsA9D9JCjDTnwgmskbpHVJ0OrEpXOnLAqkQeJz+KhUFafByfaY
 mJudzwrkN+lnSexsnMPELNc4xIcZyJ4=
X-Google-Smtp-Source: ALg8bN71kvl4q5YoVrgmhPN4TRHx577P240v/PRUrELV7sGVdEAiu9gqABjtZ1LUGD1Q8yICOJvxAA==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr6752469wmb.139.1548417588605; 
 Fri, 25 Jan 2019 03:59:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id q12sm95368032wrx.31.2019.01.25.03.59.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 03:59:47 -0800 (PST)
Date: Fri, 25 Jan 2019 12:59:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] arm64: dts: tegra210: fix register range of apbmisc
Message-ID: <20190125115947.GC12353@ulmo>
References: <20190104071646.15828-1-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190104071646.15828-1-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_035950_273467_B8EB3EBF 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============4413789738620697983=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4413789738620697983==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 03:16:44PM +0800, Joseph Lo wrote:
> Fix the register range of apbmisc, that originally inherited from
> Tegra124.
>=20
> Reported-by: Mark Zhang <markz@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-5.1/arm64/dts, thanks.

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxK+jIACgkQ3SOs138+
s6GouA/8D/bsNHcnYXiE4VfrWvuS3FLtAXgkmHzZ7d97ANdNpcUER67An301oDk8
2JR3YWhD+a3eH21gSpHH4pDRN8jLtv8SMf+/zKEgahSnG21pFx+vbYxIK99VIFXu
13IIMcZKcTnrEF9lfE6Qn/3t655YEKUr70rLbK3SZsnVeusebH0NAIXQpqKJBG1p
OoWk15+7lbSRLOVGLSOXZmyiyTk4dBJYazA+M6YNfpSkL9h342cLc4UMo8evAdqe
3s5OPfP5m0Pmia+CkFYnhuNAriUyemhrqTP4KMQLQLONZ5dy9yb2tRIXqsrsPRG5
BeTryt4qMPxUS40HX9grPMHASCOey7+jHytYyIiHGLhyLtNGLLW7ryQAZb05OUuq
tO+2d7Gx2Xy5XXuhbwz71znG3LkPDRQbY7aYJbEdtV4UiEAFx1NH76DqazXU0SuC
aHLIERgA4urg/EfFXjpCFNkkMKbBGTAEfaDYHmzl5LJa+FSlt3z496g7m7koRNy7
MApQ4F/GoRPCR65LNtYwD1vHVgJbg696UxVZi0ZgmNT5Uo70hBZpWTALG2ira864
4r9pbgQDLnENjNo/i1D/6Wgbo4kOXFrVS6dNuO1Bdugm+x3VfqV/+Yi8AW86F/nM
+U81t136RVrnoK8g9Ugkq6vA24omPmSShA6zqcHOI8KHSicvGAc=
=FlW5
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--


--===============4413789738620697983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4413789738620697983==--

