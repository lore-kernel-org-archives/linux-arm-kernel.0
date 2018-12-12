Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08150C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:55:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E1A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GlRRbGva";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wT77kI/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E1A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XsY6cehEAHBpbaFVAbfV4LZCwtjbAa+D485EeHQAyZw=; b=GlRRbGvaPJkGTHrSMsTv/7fa+
	2GeMGQXyGuRseXGkrLnn7ff6gHnKIqaOp5HA+0Qc+I+ZSYvTEn96sy9h+S5Gzmc2sRhmwghDdCrLv
	3LqhfbOdWNe5tNB0wvJWRvBtm3v/DTmU5doONLAcJwMsGy0zzpVUmfrBfu0lqRA/xd86q5Kb8nD3R
	BqUET0qC3L7Quq4O7dtHZ4NWzVvwX3xmMo7jr36WO/hR7T2BpjpKZsZBTyt/7w56JhIhJgNvulnbB
	QbkY03tfD8AqqCszuJIPZByh4N4TE7Nex0hzSONAopbljpv9AXb8Bg5qIN+GjMseD0XQVDYeMau0S
	o44eJwEQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX6r3-0005tn-71; Wed, 12 Dec 2018 15:55:21 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX6qz-0005Ve-Vh
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MxRJpaEmCq7pl5aHRVnXXQnL4V8VTjtBmPWkYK1fRgw=; b=wT77kI/qD1QiWQ7BKsScLBWuL
 sA9XlEuKO84+09F1Wu62349eHWDmTqcDHNaJr8dW/Nk+PtplDJenc4zzHmhGEl/Og3/WgL0ghpMjP
 rsfiGGpLXcmVyiHiaBiNaROT2y/IYyRADgsJibAsxJWnBpwiet+7lU5EIL/bafhvmm4L8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gX6qk-0004Fd-T2; Wed, 12 Dec 2018 15:55:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 465C21125535; Wed, 12 Dec 2018 15:55:02 +0000 (GMT)
Date: Wed, 12 Dec 2018 15:55:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrei.Stefanescu@microchip.com
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Message-ID: <20181212155502.GD6920@sirena.org.uk>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181211164706.GL6686@sirena.org.uk>
 <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
MIME-Version: 1.0
In-Reply-To: <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
X-Cookie: The greatest remedy for anger is delay.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_075518_179404_4025400F 
X-CRM114-Status: GOOD (  15.25  )
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
Content-Type: multipart/mixed; boundary="===============2393582251040625762=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2393582251040625762==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 08:01:07AM +0000, Andrei.Stefanescu@microchip.com w=
rote:

> > This puts the device into low power mode when the suspend function gets
> > called but this might not be safe - devices using the regulator may not
> > be suspended yet so could still need full regulation.  Normally a GPIO
> > triggered transition like this would be being done by hardware as part
> > of the process of suspending the SoC.  Is there some reason to do this
> > manually?

> There is a line from the MPU (SHDN) which goes low only when the MPU
> turns off. That line is already connected to the PMIC and it differentiat=
es
> between suspend-to-mem and standby. To switch to low-power, the PMIC must
> be controlled by the GPIO pin LPM.

> The suspend sequence is:
> - LPM pin goes high (PMIC enters Low-Power <-> Linux standby)
> - SHDN goes low (if target suspend state is mem) and then PMIC enters=20
> HIBERNATE

This feels like it should be being controlled somewhere else, if it's
actually causing a change in the PMIC state it seems like it wants to be
done as late as possible in suspend to minimize the risks.  At the very
least suspend_late() for the driver seems appropriate.

Could you submit a version with this feature at least split out into a
separate patch please so we can apply the rest of the code while this is
discussed?

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwRL1UACgkQJNaLcl1U
h9AOAwf+K8t0YPz/fYY45FbWktz2aoX3ECrcgy5r25ACJVOjG7tBhTelZLbGkitB
314uampogG8tT6s8WObZbEJjQL+VUbyt7bgcpTI7YamUdPSwkXSJDsfjpPOVVLoa
2iAHn+GBi7O63sKNUb9s+D4q7K1xbMs1vxcpQoV+I/SZx33z6GaoJPBUI8CcDes3
UmC9aaIMUMva/RuKtPSEomI/+qAhiuMdZ1e4SQyZ/AZLxThOPyXJvh1hs8fa2IQg
qC4heudi00SNdZj0dGl6GlyYLetqaYKamlZ8aYf++xJPwI6hH/bsSP/Tiq2iaWTE
wnP4HNcX1dCaLvgGy84OxUTV9fmiOQ==
=8c4e
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--


--===============2393582251040625762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2393582251040625762==--

