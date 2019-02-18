Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D16CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0C92173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s5Vsb/Q0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Av+uPNv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0C92173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xGGXKz7yTthn24PqjhUVfSvTGXF3cXgZmmNZC3KkTYA=; b=s5Vsb/Q05osx0PSzzRAxwXtu8
	qa0TORrOPAxVT2ZSzhhTq3ERyr/kNrAEAF54k0m3aJ+ZCVAZRxnzBTYVTqdCPGYS5EYlYvtr8zrm1
	R0KEx5S6RGWDQgkrhTkg6yGM6TmJus/FgCLz8fUfesJQ8AFpy0tz2yIDjByaV5qRJ8+Fy5T0GOpg3
	pufZq+DYMGgrS6xkE+s0qPSzSOcUTIxkX/7VkG2HNfpDugFw0jh61GAhL1Uqo2E4Z2LN9UHKn+Mmw
	TxL3aweLKuiGWsFDIGgPk9NR6ZPLnXCeZAePQpjo/eFm9qg1RLbRGTmlDbDmAW99XqNyF8FPY61Z1
	OJwQBxLoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvh9x-0002WM-RX; Mon, 18 Feb 2019 11:32:29 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvh9s-0002VA-0h
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iPvEHPP2LSGvubraJpXbu7wXWqSeB4PNpHW98Smh0GI=; b=Av+uPNv5njhzfbHFJQLv1UNuR
 6fqSrgVG43wlcnykmhMxzzQpweE9o9VBKRId10IkOcEUIkJSjkxeZy862JdmyjTob6HfMnVf62YsS
 Hj9+Wb7PHrhwJ+ikX02BuLZek0TYp7dEOL2qyJn3Cin+CQF/g4apHJnyOezJNlbXus85g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gvh9m-0008Bm-5O; Mon, 18 Feb 2019 11:32:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 8890D1128008; Mon, 18 Feb 2019 11:32:17 +0000 (GMT)
Date: Mon, 18 Feb 2019 11:32:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <treding@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: next-20190215 build: 2 failures 19 warnings (next-20190215)
Message-ID: <20190218113217.GA10794@sirena.org.uk>
References: <E1gukSa-0003kX-JD@optimist>
MIME-Version: 1.0
In-Reply-To: <E1gukSa-0003kX-JD@optimist>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_033224_292867_4E073275 
X-CRM114-Status: UNSURE (   7.96  )
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
Cc: linux-tegra@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============2059302755894988631=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2059302755894988631==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 08:51:48PM +0000, Build bot for Mark Brown wrote:

The build failure with mbox_fush() in the tegra-tcu driver that was
initially reported two weeks ago is still present in -next (this report
is from Friday but it's also present today):

> 	arm64-allmodconfig
> ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
>=20
> 	arm-allmodconfig
> ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!

Is there any progress on getting a fix merged?

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxql74ACgkQJNaLcl1U
h9DmWQf+Jwn7t3M0/f1ZRBUbAIw+nDhllLRpfiRToLELVVl8fYmtpxBeNvCeeyJE
nldgoWfQ5jg52ABt352S1DhLKtOn1bKo9vvk2FPe2hRQ4TN/2B/b0X7/FZdmHT6D
yIaDjCqTbWR5qNKLwNWNHPbRY3rewUZIqBKe6q0OAANwO0L3Q6/hZHRPdMvwq3P9
GkqRDyAI5TT7WvwnQ0DkgmkNQqH3r0/sYfw9EB0o7JBVepihX/lVcxKmQJpNfhCn
uP5fCWjwyjd2MGikbmPUzy5hWvYUS9e9Qk3J1VhoEZf0Oxu3qNr6bIgIbpIZyL17
wZsECJXoQ+9Fgo09uy4ptnFPArhDxg==
=1XPq
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


--===============2059302755894988631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2059302755894988631==--

