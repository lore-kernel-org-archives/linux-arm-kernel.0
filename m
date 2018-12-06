Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:30:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EFD20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FX0lEKcA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Xp+np2u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EFD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xpTW4YSYw8sK4HXbWDEFRVleYQW+hu2aEhgxb5OhJME=; b=FX0lEKcACECyC9giUseu0eLzp
	9QxzVcfMR7qfH0NYaOKKin8XmSTS3HEZJhpjCYyUtI8GRNgiqjx8f2c4WhHmRxCOGhj7NN6N1XdWK
	8qtFIG6KCj+fVctfFwHgTPCQtcKJfOjEv9Je2kjx/bhSiQJWSjTc84uIVjTxDEdVwKN5DnBmI+jzk
	A5bRiWBLgKP7TGrMywO9A2MGeBNdfkER3JAahin36TbXS9WZ3r3GrWx3TUYSCaLOZ0hK2atAlwHRX
	I0lrVJgTYlN7I3REdwJA3fQZVug6t2w0GeWEizwDQzlH6GC1Gnx36+ZxE4ecHd+cJUUxxJ9yXWeyQ
	LKHFFPNRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV0Hm-0008Gg-7b; Thu, 06 Dec 2018 20:30:14 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV0Hi-0006vs-VI; Thu, 06 Dec 2018 20:30:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uu0YAyYEY643TdPRgWmAazr8rnR98z/B40PCWyaIBew=; b=Xp+np2u7RM6rG0Qw2EL4rocPb
 bI7CqIr31ebzaMMymu5Gve8N7vpum7popVYA9MlS7E/ilKo0uinzlfY0tOzA3sZHKTAaz7sUH8LeW
 s/Hf4ZbuQ1OwTjKPw5wF9BXd9lGPG1AdHhD7PEQ4DcYztcZUkJlwwa2QVYtWv4UEZvKVk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gV0HU-0001jG-Fd; Thu, 06 Dec 2018 20:29:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 0FAEE11252F7; Thu,  6 Dec 2018 20:29:56 +0000 (GMT)
Date: Thu, 6 Dec 2018 20:29:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181206202956.GG3084@sirena.org.uk>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
 <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_123011_152315_B4C4F63F 
X-CRM114-Status: UNSURE (   8.06  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Vignesh R <vigneshr@ti.com>, "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5998697335345750214=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5998697335345750214==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2018 at 06:49:08AM +0000, Yogesh Narayan Gaur wrote:

> Sorry for ignorance. Did patches needs to be applied by Mark Brown, should I resend the patch series again?
> Also can you please review the series [1] and add your Reviewed-by tag.

As I said in my reply earlier today in the same thread:

| I don't have this any more, it looked like this was stuck behind the
| otehr MTD changes which seemed to have problems.  If someone could
| resend?

so please resend.

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhsMACgkQJNaLcl1U
h9BxUwf/VXXXtAILeX5fLDCHtNVLqX9fo3DPdIf/7DKJkI4KipztYRdwnXr1gyWL
PR//PfTDevtSYPomTWiO4oFiJ6dq8AKfE9HZl4SYBvNVO5W5DQwfa070uPVc/jGh
Il9aC3h1wwb1de9+Y2x+Nfy1YJ485Em7sboYr6Zqra4viyht3EqXRcNup9JKsSUN
IU3/wVOq00MFhxhqdevBClFHBQ8O/YfDQeRRU/yUcrTnr3L+x1OGoGMtkQKb+1M5
jhTQd97LgT0Unlh69N67ofameyu+nVtp1HkgU2JbgF9eKZUqDq3ANGpK7XFRzmpU
hBp/WucrDVjytmprJvexzb4Fz8BDbw==
=rcQD
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--


--===============5998697335345750214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5998697335345750214==--

