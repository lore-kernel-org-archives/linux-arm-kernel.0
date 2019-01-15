Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:56:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA9F20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="igf9Y5RI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gJ8YHs+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA9F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rmpujD8zZ+3iN1gNgJRRGE8qayNhGzp8InpVxvZF/dQ=; b=igf9Y5RIb7Kifb3W7AXzlDMwO
	BC68XzAVXQKz0T4hYg3ZDvFUjR9skKPx+GLzIxVA7uN//SmMjesFPeRgGZ3iVQqfF2LER2EQr8o4K
	RngeLO7A325FgpoipU7B2MHrKnddJwuoUdnsXmfr7LAbt+cyNeQVBH0Zc7ekSOrKNb54mKxyBn7s1
	HOWQSkD+FkkEn8aesDQro9ZB6gyZnmeOixP5PdLl4Sl8kQoaFi0+7XlG51OYyf6lOp96W9h5HW5DF
	zAir8B8ZNa/54hgt0qRWLvIe6pD/jvIssgeS1apgN1p/20wgJC7/g47HWNhuDk+LPUiR/Go+Mujin
	Km8lUsvVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjTsx-0003IZ-Bn; Tue, 15 Jan 2019 18:56:27 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjTsu-0003Hf-E7
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 18:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8gQl+s990M05cQ3VvFBXgmmgX5ItsFAnYvqIt4lCjGo=; b=gJ8YHs+hVdxUvFXd8wbum4D5q
 Ou3Is1tSUAvPhFxx264bFdyw99OiXyvou12Rg3N8II6vTO2sUoKvpcac9vuR1kR9N4zsd0idOY14v
 eG2f+EcEcfy0pjKiAqLN9OmqxtZAVn8qQkxQ14SScgi8geieCPdwZM3vfNapCFTHiqDhA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gjTso-00026T-W0; Tue, 15 Jan 2019 18:56:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 580AB1127848; Tue, 15 Jan 2019 18:56:18 +0000 (GMT)
Date: Tue, 15 Jan 2019 18:56:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson-gxl-s905x-libretech-cc
Message-ID: <20190115185618.GF5522@sirena.org.uk>
References: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
 <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
 <7ha7k1ker7.fsf@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <7ha7k1ker7.fsf@baylibre.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_105624_620663_306D0E97 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: "kernelci.org bot" <bot@kernelci.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Neil Armstrong <narmstrong@baylibre.com>, guillaume.tucker@collabora.com,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Philipp Zabel <philipp.zabel@gmail.com>,
 Paul Parsons <lost.distance@yahoo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5677858583122724899=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5677858583122724899==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 09:33:00AM -0800, Kevin Hilman wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

> > I hope there is someone else with this board on CC since I don't
> > know how to ask the robot to test patches.

> Both Neil and I have access to this board, so we can test any fixes for
> you.

Given the amount of work Linus is doing at the minute on GPIO API
cleanups that affect lots of boards I'm thinking it might be sensible
for him to have a tree in KernelCI where he can test things before
posting them upstream?

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+LNEACgkQJNaLcl1U
h9CAIgf/e3XRiaQczcaUDTJTgNuwiabeZh2dgTzlJfwCfJb7t9SlNLBONGLAJtVs
+Nz4Uqgk81jrt0M2YbbrrTBWEKk3gK5VvIiccSSQMigSTIo17GzqacWmFxh6cPIR
/nrPFHGylL9R6X2ig4dWKouTi375Q1AmnDCZSDFImiSbVWensHk4n/ujOYbtey/9
Cu78J8MkaTak7q/aMYc5UDccSULGvmCxUdmc3d5qChGLwaTaypKb42JBFYXyQdO2
9WXzJ2bq4b9WXw0KXQT5dZWQeF9r8cvIEI79YvZkE1Ox48E1QoMLlabjqHkoTwB/
p1m7bbJadwPZmXKGX74sbFMkaTbXwg==
=aTRy
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--


--===============5677858583122724899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5677858583122724899==--

