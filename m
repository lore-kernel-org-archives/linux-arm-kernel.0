Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52764C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:15:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172D4214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iRxVGy5/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LUrQPK8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172D4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rV9eoyQK1sPgexkskSfqAWYcs3tRDc6355U8YVYRbOM=; b=iRxVGy5/mwNfUrwW23MKRJeoJ
	UndCqrMkSv4Bf2lAjHxRALr8tErQkN3Gou+rual+5BYcAyQdQLT5o5rfb3FOU7/iuDAJlJ6rsrWip
	zS3uAgZcMvj4xVkrL/xr0ztLzoFbLjZ6q2iPtPoNkYzeASo+N2JfzIDSmNMG1QFu7BesrUUam38sV
	ETtQdHlwfDJFg8PwCg0O+9L0v2KuGafXCF/kmaQyHcIb3hv7hhCFjN9m3ugUy0gqtuDKrrcL/r1io
	ddhXl0jPf7AguhUpFtuFlC2XNF79xDBVrSmKAWAH9+PS9wLiT1FBnKLrvC6K1mrahA5BimAK8tc76
	7cQ1Ile6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV6b-0002gu-Oe; Tue, 29 Jan 2019 15:15:17 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV5c-0001Fd-Sl
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kxe6B1ZPPpK71Dtzz77SOfIh1bqQtnCe+lYOVpujU4Q=; b=LUrQPK8YBqfjFaCnJhRCmlY0V
 3sdLZPltOS9OshuAmYBBEUgXWO3bXnARopu/5Aed4jbhEmGl38ZePM1wZfz/AMRe7yXEY9ttzIVuw
 EuI8trLdZC+7xCBtr9COdgwDH+8nX/dg1seJskZassCv6JQxql4QBP/SDyvMJjuGffDbY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1goV5Y-0000FJ-Rx; Tue, 29 Jan 2019 15:14:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 5F6C91127D50; Tue, 29 Jan 2019 15:14:12 +0000 (GMT)
Date: Tue, 29 Jan 2019 15:14:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [RFC v2 3/7] base: Add calls to domains controller
Message-ID: <20190129151412.GE10524@sirena.org.uk>
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
 <20190128142313.17036-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
In-Reply-To: <20190128142313.17036-4-benjamin.gaignard@st.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071417_512349_51DF2B5D 
X-CRM114-Status: UNSURE (   6.46  )
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
Cc: robh@kernel.org, loic.pallardy@st.com, arnd@arndb.de,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 benjamin.gaignard@linaro.org, fabio.estevam@nxp.com, shawnguo@kernel.org,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6776186233694004533=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6776186233694004533==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 03:23:09PM +0100, Benjamin Gaignard wrote:
> To avoid modifying all the drivers call domainsctrl_set_default_config
> before probe to apply the configuration define in device node (if any).

Reviwed-by: Mark Brown <broonie@kernel.org>

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQbcMACgkQJNaLcl1U
h9Cl8wf+JpsNxX1JRVEl2fJvIehYJu5fP2mrjIUJhnGmIvGCBw4Nw6NQ0irTqQhI
nOuxPifbFvi041T5us1no16XSaIgdcT9wMI9pKw3B9rFH2oDhUXaE3/+1D12feHg
ywFA7juUqVw29kLsY8Njy8o71K4sn3rdIoirQnobfRBXazVJc6AI7NcJYt93E30a
tBXHC0QI+Zod3dohU95E5TH5krm3nMDm10k59Gg65Nkfm5HNHvZMVNjbv7fBPruF
gFmFK7YFc1pTmrgE8kz03xWABPCfFKSAldjIgPGoKCcy/DOdFzQxT2OszgsdOKxv
HUdieELD3Rjsroyq6uk70KwpXSNZGA==
=YpV9
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--


--===============6776186233694004533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6776186233694004533==--

