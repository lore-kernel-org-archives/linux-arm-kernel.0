Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2874AC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:22:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8282086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O/JzWhyE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Rr4WWjlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8282086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lj8p5HKRFPpiFcTF4loK54MPjprZW+4/XD65ejA+zCQ=; b=O/JzWhyEdXEtCtMGpJ5WTFTug
	aWkT0IHJB9Hb3j/hkyU0FXU7PLAC8ozp3HHIlbrpJQ1u8TApOOQtoJzyvrM7hhUdqdpqq+nuJf0/M
	Tj0DYTV/2arOKHdMRtd06dcqZRdg/e69avyAi9DYUzqPQpRy4YexljXNrPYPxc13EAvQ6n2bCc4nm
	M123OO7R5PAROY3GLmlmVBtjjNsXf8LV/7xNkKdWO/cBmBpHJtIGPyMo89YuDtNgOQQX/6Dos0ftx
	Y6fA7xr6ZXh16ehfvgJOYc1y0Jf5pD49MKZaDzSyQO0y/HF7MSrl1tW7SbuJ8gJurtN18iiXMPtMU
	gTAkkPibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTkO-0000Tt-7w; Thu, 13 Dec 2018 16:22:00 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTkK-0000T0-Do
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:21:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ZPyUi+NucTkUmx5MvjHpi6IlZV+xVgDeYM4R4Ictdo=; b=Rr4WWjlgkn1w8MTqQ/Em/Fp27
 ZSxWWEBhl7i+BbJrHhux/uArMuCno/gmJyjz2pXdaCrBuytw/B8gSEG91BynaFt/uwKcXva7dyaou
 oewlXjj+BAhQFQI9atxGKOjy+VlA9Mt25WTUUrwCcJxDZbyrLnoKkoko8a3/m0K3T011M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXTk6-0001s6-6J; Thu, 13 Dec 2018 16:21:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id C5D4711254D1; Thu, 13 Dec 2018 16:21:41 +0000 (GMT)
Date: Thu, 13 Dec 2018 16:21:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrei.Stefanescu@microchip.com
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Message-ID: <20181213162141.GQ10669@sirena.org.uk>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181211164706.GL6686@sirena.org.uk>
 <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
 <20181212155502.GD6920@sirena.org.uk>
 <2f24d81a-5271-6ea7-32a2-bc2e708521fa@microchip.com>
MIME-Version: 1.0
In-Reply-To: <2f24d81a-5271-6ea7-32a2-bc2e708521fa@microchip.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_082156_612195_9E5FA760 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
 andr3i.stefanescu@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com,
 Cristian.Birsan@microchip.com
Content-Type: multipart/mixed; boundary="===============6367605277370426982=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6367605277370426982==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KHqYxKoy+XnO4RVf"
Content-Disposition: inline


--KHqYxKoy+XnO4RVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 12:19:16PM +0000, Andrei.Stefanescu@microchip.com wrote:

> I tried with both suspend_late/resume_early and suspend_noirq/resume_noirq.
> Everything seems to work ok.

> Which one do you think is more appropriate? I am guessing that during
> suspend_late some devices may still need to be turned on and that it would
> be the safest during suspend_noirq.

I agree, noirq is going to be the safest option.  Can you respin with
that please?

--KHqYxKoy+XnO4RVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwShxUACgkQJNaLcl1U
h9C/zwf/Q9S+epb2YtPqpjlyCkUDkJehQHR8TCNGVpUBk2xmCbAb2Fl9ggO3wMFA
l7rsBe74p6O9e3j0eKXlCXhK/t+PwgLYDnF5s8a9mTRtCxJ5o36xQ2HaNd9RiONu
gglSeDYP2j9GSvwj5phIBYSe2YlhIm616SHLOTMx8GMZCwtU1Vf0HxO5itpelnuM
3EJOd/jE31Jzmjsmd2c0hneaAReu8S8NaC28wX8gRPtF7nVFyVHxKhGlWTRCWxWr
tTpfIMyuN2RPdWRYM0HbLH1qfFpfdDHHe/vQbF8H8Euw/RWFIciEprNfWuoN4en4
PiX/rGxZYtRyD1/3Sk96iufnjs74XA==
=9cSY
-----END PGP SIGNATURE-----

--KHqYxKoy+XnO4RVf--


--===============6367605277370426982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6367605277370426982==--

