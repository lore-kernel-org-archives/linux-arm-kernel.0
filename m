Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20185C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD537214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sirTQRLD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BW8nSzLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD537214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FgZnNs4Bmq/dytGXXMo6WN8nXmC/0K2/rMQmJSfNMWk=; b=sirTQRLDkyOcc3YXbdUJV8YeM
	yxYrvSCv/Ph7nynTdHRRLk0QBUH82ng0kBqpP92KaqyMao2q55xKUDDtCM4lg0jCzgCnBLaup9h+Z
	cnvfY5PLFzshAJKgL57K+g6JVpUG1u6NnwiQ7fQG/zAu0tgnkr7K91gfHlf0sfgj2T24UbtNatfYN
	gRa/m6ObHI93q9YBIWaA2Aa/dGTiYl48IeUL4LoDjrZGdYn5WxZ786MVz7LBS7kwjZBbDxiLXLb+M
	lNIOKDQv1V6rMfiOtxDvH5xlfeMcmQv6AlM0nYisM6/sQD0rRKddC6kYPSNzMudnwARhz/GPC0dYx
	7J/RzBXsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV4W-0000fQ-Fo; Tue, 29 Jan 2019 15:13:08 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV4T-0000f5-Q4
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2ab61Ucv4TZdNzr2qrI1pTdorm/SpkcZzp3RVh0U87E=; b=BW8nSzLbVYx6KvzV+hRkSlMWx
 yvvFAddCNAFVbdV54BkCgatacjJkCT+tb3nBh3oCRfp83qTbgSpvk7tcKFKVfx7DoRW5ckNsQLNZ3
 YC4LaIyN32D6+67c2CdPnmK9yr7EbE2lqVB0XhQUGO/Now2YmScelurKmjCSbdUPdBV7g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1goV4L-0000F6-7n; Tue, 29 Jan 2019 15:12:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 978111127D50; Tue, 29 Jan 2019 15:12:56 +0000 (GMT)
Date: Tue, 29 Jan 2019 15:12:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [RFC v2 2/7] domainsctrl: Introduce domains controller framework
Message-ID: <20190129151256.GD10524@sirena.org.uk>
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
 <20190128142313.17036-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
In-Reply-To: <20190128142313.17036-3-benjamin.gaignard@st.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071306_009349_12CF196F 
X-CRM114-Status: UNSURE (   7.54  )
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
Content-Type: multipart/mixed; boundary="===============7924761832222792107=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7924761832222792107==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 03:23:08PM +0100, Benjamin Gaignard wrote:
> The goal of this framework is to offer an interface for the
> hardware blocks controlling bus accesses rights.

Reviwed-by: Mark Brown <broonie@kernel.org>

> +static int __init domainsctrl_init(void)
> +{
> +	pr_info("initialized bus domain controller subsystem\n");
> +	return 0;
> +}

Not sure if this print is really helpful?  But that's very minor.

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQbXcACgkQJNaLcl1U
h9BhlAgAgtnMG3VwPygyUGhKoxtF8lC8VpQc0oSSGDZjdS8oehhCkd76c6Cw1dLJ
3xHiKpAMDIAloKGN/HyhWpAyHWS0nMXy+/8HyQyWtYD2/FvbkMPRZC8AXoIv82rj
6Z2c+LW55y9jeogvOFbnvkAwbijIvnAtMBeZF89Xap0wDJqFWL9v4PLs+ckoTBwf
o1DVmxdVzLtGo1QEuhOD6JsX8EV+Hr9e0MHXbzSfMVnuiaZ38GMWNTZxCAn6NvW1
SDI3T41Key1APDYGEJqLaXYCmlFq64IGyRtxbFZAJ2ZlkStKtnGLW7y+fzcQSiZf
hMAKI7jtujN3AG3pC6WVDVqhOvqPLQ==
=VPVA
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--


--===============7924761832222792107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7924761832222792107==--

