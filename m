Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F3C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:19:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6887D20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGHXWXI7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rRqBGNYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6887D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ubQ0dztsdn9Ot+BwIbQmBCNQTuEl5czLBskdwqK7ufY=; b=IGHXWXI7YIW1Co/Jd+3Zsioge
	yuqQNCK41MOv22Rb/T7vydeteWn5x7RmDzzjoOoklHFNBEUB2HRv4u7r7qNaE3KTR98O3DXObtxpr
	40C0I2upzip3cKz+4ggdlau3WOBTCyY0ildLn3HfrR+S4OpFaqNN9YVXyrSWPRIDpg+HZcKAkk0/B
	8RjjvY5kNktpBK7V368IG8F9VVjJrlWU55UUkLyU1x3GHNiWd/fuQIZVYfe8B7DhkorKVqB6BaXxT
	S/9lW4H6YQCoc9yq3Fut9LRX3NoPHni2JV5zwwuHl40XLJlcCHKoCLy9abfLq1gfcUr4pr/HQ8t0j
	+VGydrt5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSlw-0002Az-QF; Thu, 13 Dec 2018 15:19:32 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSlt-00029v-I8
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BZ8s3NeEtJegPWgo8FJVejvAEnmL+/6CnIWx8+1aVvg=; b=rRqBGNYOzyJJ1XqvhuMIXL8Pw
 7HIY1l1VJ1yn+En36iTTgdF3fTsHIOasomag+USc/qlgpJIfS8hRpecledJSpX1/ATmYq7GTirYtc
 0A6uTRuZcvadsXATNbGiO2D6ZZnrIF4nAm/ssUNuR4Ibrj9bJNn2jG/wGzgI2XKqEfZUs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXSld-0001fD-Te; Thu, 13 Dec 2018 15:19:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 962A611254D1; Thu, 13 Dec 2018 15:19:13 +0000 (GMT)
Date: Thu, 13 Dec 2018 15:19:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Message-ID: <20181213151913.GL10669@sirena.org.uk>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
 <0291f79e-b8df-f7ae-1ded-cacd404bc5fc@microchip.com>
MIME-Version: 1.0
In-Reply-To: <0291f79e-b8df-f7ae-1ded-cacd404bc5fc@microchip.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_071929_742308_C97E99B6 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5024764624326649078=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5024764624326649078==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:59:00PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Hi Mark,
>=20
> I saw that previous version of this series was applied to your tree just
> after I've send this new one. The only difference b/w them is in the
> documentation patch where I moved the new header. No functionality change.
>=20
> Sorry for the noise,

No problem.

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSeHAACgkQJNaLcl1U
h9ACcwf/f1jbeM50E48CoRS/p3byESPME9qFXzlzSPlBieoND1AP4rYAg5rZK7Dh
8GqyVtXBN5kUU201y0DRmsxgM7C6qGvi5YEHZGx87e7ty7H5hbc+ZjySMSjZRs4n
fONSaIP1v9owsc0JLafzy2U5N+nAs5m+tbFKmXwb3+8WImGCpmD6SKOgoT/xV1Ds
Hn0/UjuQeivg3z+uPUrAjRRlqPk1nztYvp77wxwuUq5nxPUIa8yr8bnPTTzurNsZ
M/cJKyW8THH68yh4le8f4p0TNWIjCl9yNWjsBlOjfS0xEwsn+HUb2CM85Vxe/MUz
yf0BSk/EqpFl9pKKPs+oS9D4vcpMbA==
=C7zy
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--


--===============5024764624326649078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5024764624326649078==--

