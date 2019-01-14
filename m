Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B01EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:53:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953D2063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aq1OaX/p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qyx6qokO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953D2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HiKtJrT0qMqr2mgGGUBPgLDT70uCtzI7+YbDKPyCTbM=; b=Aq1OaX/pRodwaJ4JztKqdRStJ
	UQhnAUmfGq3HaVk8ZoDrmBIezjjgdpDE0qfCXm66b/kM8HBPiE7THW85eTlOzC0WVi0iN8m6pKJJV
	n2YrqDF3/T2vpSg/sbqKqQjy6gK9h5Ek++AkI87aEpTfgBWVDmSLOkrb9jiwpqV1bFJPLeb6QBkGO
	57XV8FzYk8oMH9WRLqH39j3QWspxsG5ryQkdFtvYRQZnzhlFXxqt4RBJuxSPGxizHcDa+nevJAkO4
	bkdO7pr1LL2F29AAKDJR5N24KQBdKgPpJaNVOw5mULX4mLTfkQZDJTqxCjiMM2iRZQttxqjS2pn2W
	BDexUPriw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjB6q-0007UC-NL; Mon, 14 Jan 2019 22:53:32 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjB6n-0007Tt-6L
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 22:53:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kG964s3QJ6dVq0pAT4r1IAmzesInDHvBIVsbqE/lZvo=; b=qyx6qokOfbJ8Lq29u8BAL1fdc
 h3NANVm4qOtgAXCqNYquS3UEsy3tcW5LEgoPQDNbt8VCIza/OGyt51PuqIoH2v5EZ5MXokNAepH3x
 LTcJEsEs5XAfbOE2pvexOrlFDYfwKxWuqv5FKDNibyyK8XO+VRSvI6lAhBY3McS0/cT2M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gjB6b-0000OE-3q; Mon, 14 Jan 2019 22:53:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 6F47A1127AD1; Mon, 14 Jan 2019 22:53:11 +0000 (GMT)
Date: Mon, 14 Jan 2019 22:53:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Message-ID: <20190114225311.GJ11073@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
 <20190111123913.GA2804@sirena.org.uk>
 <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
MIME-Version: 1.0
In-Reply-To: <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_145329_382369_5A2C24BB 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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
Cc: len.brown@intel.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, pavel@ucw.cz,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0686652998473354990=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0686652998473354990==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
Content-Disposition: inline


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:08:19PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 11.01.2019 14:39, Mark Brown wrote:

> > Like I say I'm working offline so I can't check the links but it sounds
> > like you're saying that the existing suspend mode configuration features
> > are enough for your systems?=20

> Yes, if we rely on the fact that core's regulator device tree bindings for
> suspend-to-mem/suspend-to-standby were filled correctly.

> The function I added here was to double check that core's regulator will =
be
> off in suspend/standby based on what was parsed from DT.

Ah, so it's being used as a consistency check?  OK, that does make sense
to me. =20

--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9EtYACgkQJNaLcl1U
h9AV+Qf+OscuST0WWOE2flYrj4veE7kRdI2nnKYgIWKwk1OvlpNJ4kQy4ZvDXITG
oUMIOLImOSCAMHh+RnSP9ee0inU38wsnbLEnjGBhGf6l/Jybe8ARemNoPO4KJ3tj
Sb4zJjhkrxN66N0KqJM5vh6mqrzz7jA1sfktIxRffRGTEZ4hx3gxVrH3Zwk7xUth
NQIxW9YF8pXZ1j2jnf9NZ3sF8ZRkL9GjN5JdYoS6sRvFcsSF39Of6Nmh3OA6o1rP
g77Jh2rns/BLphp3566eaDBE35QLq+tFELEc0oNWe33x/Dqok8rmC8+nWrOfIYC1
A0pfshgAEcqeDQLac9tYXo6h3sfvfA==
=KGpl
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--


--===============0686652998473354990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0686652998473354990==--

