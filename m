Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC835C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:06:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA352081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mm6wfo3s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZStDF5Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA352081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7tBswQAbU5UzbFtkOXdUyCsEJz2b9MaAvBjGNoa7OBA=; b=Mm6wfo3sOVehHqJhKlAyRTJ20
	Z5jHSQehmkTFkRzu6qJtoBENjFhuOLoQXDepZIHQX4OsVqBbeXwkEKjeoF26ICNdZbBrw5EXXED0y
	xPBrkjj9mSnRX/H2fQNqSNIq5hfs2/pc1FC7+aYeSp4n61KFv1MCARZ8oxitKw1ruHdAyDHb25H5v
	6Vh41JFBbYLTF9kRniKYxJQG/8LtxfBhn/P7FlZyfKjgvTiQ5uuFmEZWIY1fFROUmUt1gpVMDTlUN
	qnQpRRnmuf2j8q3PRujTxDyNRfqmoqzcbzWtf4XJlxmTx3qPpQhEVF2peDq9ZamcqBDftVj3ZWjik
	Jtev+FdsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWevY-0003aE-2b; Tue, 11 Dec 2018 10:06:08 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWevU-0003ZO-T5
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:06:06 +0000
Received: by mail-ed1-x544.google.com with SMTP id h15so12014504edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JhVzsSVTu5/1KUGpEPQdBbgEcXVIhDUjHvu9SEMn77c=;
 b=ZStDF5IbrSXTiKnvC/gCzwThTDxP+1rDl1LafpVD4vYinS8N8QPf7V7o/AjzB+nCk6
 xhu31RY87ywjBROzqt2K1PYvsQLGiIIehqtZ+eGvOvzbP/TUTdTG2hJORednkEXHtz92
 bP/d3ZXWpNso/9/BxHqZB2N25WDP4NpmnzLxlo3NH5aSv00vJEq2q0q0h3PM0vM6zPWI
 xwhToeR0hVOBhl1SYWtPCHM4kcHfYEnqrlvuQvUjnEXG7m2+vGmot+PU2RoO7YT9ZZF7
 6SwhmuRLVsSOjMgyIKjnD7dHeqD8SK5VZjXv/xwNnNouvfQKF1wBU97Yrk8xiRxfsfhG
 ZyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JhVzsSVTu5/1KUGpEPQdBbgEcXVIhDUjHvu9SEMn77c=;
 b=F7Nx4vvHPiZPI1F/Nq2K5RdGbLupzYG9dGBKcy6GB+haBzHxKNA7me0y51rDD976mE
 anrPmRjiLY2+cjNTZv9e20SCiU+834+Q7N05YG9Tv8fM5kjeSj4G8hcvS5ryNuzYoQJ+
 Cjm0xk/BYiltZ71LtK26rB6ieakCLpkDbbOP70AfiLXjh3abD7QscYm6ZEp8s1xb33Y7
 y4A9DuFDV1Bqtdny84o9E+C4DtvDCDO+vl28b+VyLKl8RlYVyMa1sUjEeJ3UmsoCKB+P
 thnm/Y65N4I3vVciYgnDMQ8a9524M4X9+FugPU9VdU84Vepd9YTOrT/Ykrmg0ED956E6
 5v0Q==
X-Gm-Message-State: AA+aEWYMAXDMSw5t0WEps16zWLNlh1j7n+oqvVYc1TPwqxg+9rdLDpN2
 6iO2k1y0nxGzA/DRxQGswqQ=
X-Google-Smtp-Source: AFSGD/UrU59mZ+AB8vW2kGD8PNyuP2hxTMUm/wz/8hLglX058cs0HwP0nM8E+1Y9Xk07683OFKwjPA==
X-Received: by 2002:a17:906:55d2:: with SMTP id
 z18-v6mr1606668ejp.163.1544522752693; 
 Tue, 11 Dec 2018 02:05:52 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id by5-v6sm2163120ejb.7.2018.12.11.02.05.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 02:05:51 -0800 (PST)
Date: Tue, 11 Dec 2018 11:05:50 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Message-ID: <20181211100550.GD14426@ulmo>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20181210215856.2238253-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020604_941565_F578F4B6 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: linux-tegra@vger.kernel.org, arm@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============2866542284342072055=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2866542284342072055==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the=
 function tegra114_gic_cpu_pm_registration() to the (unknown reference) .in=
it.rodata:(unknown)
> The function tegra114_gic_cpu_pm_registration() references
> the (unknown reference) __initconst (unknown).
> This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
> annotation or the annotation of (unknown) is wrong.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-tegra/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm not seeing these. Do I need to enable any special options to trigger
these? Or are these just so new that I haven't run into them yet?

In either case, I see that this is called by tegra_init_irq() and that
does have an __init annotation, so this looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwPi/4ACgkQ3SOs138+
s6FLVQ/+NM4HKqTPuyuEUc0S1R5ieZZ6+FH1S1uUzhJVbjr3yp6GsVL8fkXR6dMv
4A0o92B1GuH8D/JKFi+Wy5U1JIRBokNkg+o2B358cTOHUUhKc4OQ2Q7/3gyNXJX6
0xCI6IBrG7nrsYrgGYuyl4/h0kuyffG2Ot0bxIBxkrfx/YHebKRUKebL6ociI7Q6
ZPYYhmbs7GM1XENuOSRhLvyfADDDHeYmevM3oOPaBHcaYZ5AxrkUlcQ4mhAdL7yh
k+TxI575WuGxSzs4lgRCA9qAjsKjR+BoLeaYA9b1PEW9PNxgoLq6w1EdK+p62ay+
EncuT4kzZmsa5BlY9ADbEIDel6t7PKF+dFljssnmutrB7V1WVav2mjXvbeBIRcl5
t0y7OJtG2+BMCMANxDvIvNZ2mNwI0awHGIzf9j9Dk8M6WsdLXB1og/i9VOFjL6fW
mRoJQRCw15a6xdxwAlOVBN81/+aocrNmF2c1u5kDcSgsjQqhMbGFR2Kq6ZBDQVeF
604EDZyQ/KX7+cn3RnojlCzTPo/ahhrb5kGO0ypJPEXoV8MuuUSXULAFblHmHF5S
Klrv3iPlnxB1xfZ1UubentR8gqZZeArXPJAdYPLZ2V4VA9U/2k6xAM6Mob+Y+dbK
1S7UktZGm9/20Yfq14rZ+DpNoPpjmg/Q/Kkd1VFCrKp5lMospsw=
=QpbD
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--


--===============2866542284342072055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2866542284342072055==--

