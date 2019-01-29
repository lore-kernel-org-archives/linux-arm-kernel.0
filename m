Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D77FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:15:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9D22175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DyGl6+tY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="I/M1J8Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9D22175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=43LwP0gvTdVW9dA/MtnademCdBRZlB1YkDMyFFOmqp4=; b=DyGl6+tYXLuJ+nmBX+DxVEUOM
	8SVJ2LMGfjcVjnRSmJFl1kzyvos7BDayISOL88PmkfjS/CizVQTxNZuhu8G+vqc7pw4qafGms3OJG
	QRfzpppkd5ziHlmO2RzJOEmEzsbXcSfFqkPHemwR/1ZtK7Z7ZgJRXhib15EyaqzFGEj1EWpoxtrgZ
	nxvKRGBbHz2FOKDyv5zBuDOUoZQ/ywfNSTbuCTghejKYkAgypWv+Ay1OVEBbUFMrIrt7uS7O0YrRW
	+IFbAKsaLjQUsC6BkcXlEIqtLX9VOz9EXgiCeQ9JvWU+U+7r3353po2hn+372vGD5HD5DA21yHV6W
	iKi/sJX3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWzK-0007g6-7k; Tue, 29 Jan 2019 17:15:54 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWzG-0007fT-2j
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N/XmHESboUUMJJBSD+32AfmHQP/9IBFP/cJxLE6FwcQ=; b=I/M1J8Peo7tXO9tySrEQX1WYX
 RGQG+qPY7kKRvw+MzqFWBxfq2ZypNA44s/f5T+VEZW5wbor3mcqUXYv8vkkTIP7RhIB9T3UMBxjk6
 KN+8JZB+luQ3hFcyO8W3UHZx+wIX/JlgWa7/tXKYsBnHILb5fvLXPUQ+XdX9HMMkyzrFw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1goWz9-0000jO-SL; Tue, 29 Jan 2019 17:15:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 3ED1B1127D50; Tue, 29 Jan 2019 17:15:38 +0000 (GMT)
Date: Tue, 29 Jan 2019 17:15:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171538.GH10524@sirena.org.uk>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
 <20190129171151.GC5720@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190129171151.GC5720@atomide.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_091550_960513_F74272A3 
X-CRM114-Status: UNSURE (   7.85  )
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>, Doug Anderson <dianders@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Reichel <sre@kernel.org>
Content-Type: multipart/mixed; boundary="===============0100663274327803157=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0100663274327803157==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 09:11:51AM -0800, Tony Lindgren wrote:

> OK. Let's see if Sebastian spots where pwm_vibrator_start()
> and pwm_vibrator_stop() might get called multiple times
> or something similar.

Given that nobody has noticed that the driver stops working entirely
it's possible that the pattern is something like:


    pwm_vibrator_start()
    pwm_vibrator_stop()
    pwm_vibrator_stop()
    pwm_vibrator_start()

so it's a temporary underflow that gets corrected (or it could be that
not many people are using mainline kernels on these systems).  On your
system it's the dummy driver but presumably some other users have it
connected to actual regulators.

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQijkACgkQJNaLcl1U
h9A4cwf/aclPNONX4zH51MhkLG5+5pZu6gbqGvweUIvCUzuMLek/X/ryb4N6TYlo
ku47rPQwnXAif8zc1WEHu3cbPxoPW5duseH8192orcrGc0KPSGnFkJVhU6fvNVu4
qIlZRwy7EMzWsPq/BXIz6WEQCMa/RcRGL0I7jpKd136ROJRQbrQxWF2iixSMHOuU
qtMyEgni1HZMFYt1nB2EUlkwMiWdJmMBQgfMzQMORKoiPWWZvebeayTohFsjbGIM
mu8Bu6AkJ/BEOpH4KKlC4FA+8SVHc0bGDvrfu/BG0ykfh6O0m/uC3f4aUztfIrLe
1Si0xmVD0bI64+AYC2bQUMmB0g0Gag==
=9aT2
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--


--===============0100663274327803157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0100663274327803157==--

