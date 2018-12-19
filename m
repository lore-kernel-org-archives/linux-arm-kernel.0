Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8FA218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JC3RWNkF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ox+wyYUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8FA218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0kw+6kRmy3jO6I0IAYWHXl5RMd9HFT8DpofqVameJzA=; b=JC3RWNkFeDPQxG2aWTiFhoM6C
	CEJ784ZnRkE492+NgUmnNgqnI/Yon+bTvb9mjfBLrQ+HrD8CBhPE/l8UA73lxEp0w1pcO66ZKr4bi
	jZoqazuh5s4CRLZhyyXGz4CPZI9JmOkmPxh7SzEeZxWSvG8TPELgbcMZ2zo9rZAaDDBSTBO1Rkaw/
	1PrM0KryTT6YREmfjbOHznJ8X+NNccEwVoxnBPYRd4Zqw18OHI5qAw6iUK4ZgT3l0KLeMgtDOcxS1
	fRjsz7l8ijQq04xEPzf11EfPnnqjEmBOeUpXL46gZP+tZuaY8jEo1jeDvUEPkGwJJbbkvDak2Erbc
	hj3tUprZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZfwq-00019Y-Vw; Wed, 19 Dec 2018 17:47:56 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZfwn-00019G-Qr
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 17:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5OeU8ZYhvHN+mChNjjOuThV1UrRYkdHSJ55kMutHB50=; b=Ox+wyYUnjZ87sT2nVsBU43BR0
 OjShDB0A0Uun2M/QCidQwUUa9VI7hIlqCJinuVKteWlDqhUiJFB4rnZaGVs++iTClLLZNbuW/aml+
 NPk4MqRzkdcIoa9x0RamnK1TC4LEGUcMyObn6e87xW8ZhUeHuYFlOPTUwkfOSfahpuHLU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gZfwW-00056R-HO; Wed, 19 Dec 2018 17:47:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id F416411259E9; Wed, 19 Dec 2018 17:47:35 +0000 (GMT)
Date: Wed, 19 Dec 2018 17:47:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH trivial] ASoC: xlnx: Grammar s/the the/the/
Message-ID: <20181219174735.GJ8130@sirena.org.uk>
References: <20181218134743.13692-1-geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <20181218134743.13692-1-geert+renesas@glider.be>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_094754_065097_1BF1CD52 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 Jiri Kosina <trivial@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Content-Type: multipart/mixed; boundary="===============1842006106692339734=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1842006106692339734==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4IYkFBVPN84tP7K"
Content-Disposition: inline


--T4IYkFBVPN84tP7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 02:47:43PM +0100, Geert Uytterhoeven wrote:
> Fixes: 33f8db9a89200c18 ("ASoC: xlnx: enable i2s driver build")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I already applied a patch from someone else fixing this.

--T4IYkFBVPN84tP7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwahDcACgkQJNaLcl1U
h9DzNQf7BOUwzoVwK7vcxh3IXa8rveokxdiW5VZcQWw9KA/iWn3RaeYn4xGEtxJI
5aPPTo3F+dEYViV3qolHMrC4MGOKKG8HdZIBoUFkb/t684OSfEGcq43+yxA9pF5V
0mTPfdfQcQvJxsxyTMmjn6Ysw0YIzo0JnRwiQ8DShcl+N0o+dBlL29yxQu30G7G4
YWih+WX5KoUFPrrCnxdkF5iecje0HfZ+YmT0GZo2pGrEe0aMBk27si4OLZiCNUlb
FsUrMLVMnpsylSMrCjZ1kam4+WRyOBtyMt6rk+UhZSTpWJbrcUgCHMcSNi31X1wk
/4U70V1kHBFn+ZTAjYSlng1PsM7HWQ==
=TyWN
-----END PGP SIGNATURE-----

--T4IYkFBVPN84tP7K--


--===============1842006106692339734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1842006106692339734==--

