Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6356C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:47:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B539B20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvagTTlG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="m2A+jHn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B539B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lZz14w3Jl7gGORV33TDo7oKhr6WMofLNw0Hq/ffByFQ=; b=QvagTTlG1mHOh5N+sXtDfTpUV
	/hjNzW6fHXic6rt0e5CLQ5uh1fRWxlAfMxOLm97BTQHqKj0GVxMwvdGBTqXjEeSL3ulDUeVjuB8rV
	/BEzZAsOhnSfPv2zFpQqFefta/vSXef3OZPdNcdO1OHuU+1+FfALOtmUzFWkcH4t8tu1uVDr3tYpH
	dtZAVWOeSyrQO0sgfZ7GAomde+VDJ7fSNdqMw4YyIdzhgqCJumS+PK+SY5iqcbM/nY/Dd/oiAB25j
	SoLbgVpwluWd2trR2GAiT2nrudL7tuHquhBCihsiQmDyvxRSV57et697fe6PDWp3vCNbWY6W6Dkb+
	D5DVthDCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlBs-0006Dj-MI; Tue, 11 Dec 2018 16:47:24 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlBq-0006D1-4M
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqiz+wkFzBYV7aW60asqBnJ9KnKUJwPszxanHWrGxeY=; b=m2A+jHn1sFFHKLdIKuazg5BTX
 oRntLbzTEhwG9b33OHcpp5wC0J8DmM1yQOAoxcKo+6h4QaYG3urs83jcv1NsmT0GRAeq0qzUG+IbT
 5XHq7cpmzWnH2n5j7ApXIN3xvQtIR3OtrxnO5qtRq/yNfIz9Os2epEwRdjd40sGHmJA70=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWlBb-0001Gg-0Y; Tue, 11 Dec 2018 16:47:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 76B69112540E; Tue, 11 Dec 2018 16:47:06 +0000 (GMT)
Date: Tue, 11 Dec 2018 16:47:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrei.Stefanescu@microchip.com
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Message-ID: <20181211164706.GL6686@sirena.org.uk>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084722_315111_E4266D7D 
X-CRM114-Status: GOOD (  15.12  )
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
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu.Beznea@microchip.com, Cristian.Birsan@microchip.com
Content-Type: multipart/mixed; boundary="===============5057328152336489073=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5057328152336489073==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 10:09:15AM +0000, Andrei.Stefanescu@microchip.com wrote:
> This patch adds a regulator driver for the MCP16502 PMIC.
> This drivers supports basic operations through the
> regulator interface such as:

Overall this looks really good, just a couple of comments:

> +++ b/drivers/regulator/mcp16502.c
> @@ -0,0 +1,555 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * MCP16502 PMIC driver

SPDX headers need to be C++ comments - please make the entire comment
block a C++ one so it looks more intentional.

> +#ifdef CONFIG_SUSPEND
> +static int mcp16502_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mcp16502 *mcp = i2c_get_clientdata(client);
> +
> +	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
> +
> +	return 0;
> +}

This puts the device into low power mode when the suspend function gets
called but this might not be safe - devices using the regulator may not
be suspended yet so could still need full regulation.  Normally a GPIO
triggered transition like this would be being done by hardware as part
of the process of suspending the SoC.  Is there some reason to do this
manually?

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwP6gkACgkQJNaLcl1U
h9BHwwf/cHsTUWUp5ToG+Kb4Fuv/H6ZxHsx3rArRbP6RrZs8AcV8P59bDdcVWgjQ
Jvrzl5wA1njl0bXYYCyNXWAsApqj5396NAHrZJhzpjYDTZu8rLQnqpJoyHsc6nUJ
UptK/vhhmZEH78iiEqBIUcQY/JzYxz4cC3iVl24+O3l30AvbrHiXeMALUGr1fJ80
RutTjPkvA67Gq1ogrfhy8IALDzFDGM7bX+Xe4jha//+23lf1f8HRTCXf3dMydP0A
Lk3z/8C4Dz2p4c7GZZMzwhjKrsp7AVGIH29SX0BAvM9cp6EnTv0B2l1xLQv3oXV3
OAviYfR1XwagJG5wcHyko6KGnNSjtQ==
=9bae
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--


--===============5057328152336489073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5057328152336489073==--

