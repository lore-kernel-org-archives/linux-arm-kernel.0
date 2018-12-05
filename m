Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D376C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E085B2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L2dSCMUK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dD+NCeUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E085B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R0lXTSoRDWNW0fSYOV/B2B1xWhY1QcoofyMejtS9m5Q=; b=L2dSCMUKIeNhIv1C7hsO0K6kH
	fjXjTyu/L76JOaMnetIf7VkhxAiRt0h/lnjL0Pvh2MV0qng+o8k77+mpJ8DBGqtFGn2acSo60yd8T
	KthYHjVd7tlgW9zLIgLwM6QvQ8MwrvOj4FJyAuJVbd+CAhaQyczZ8SzMqKz4CG9qeacakoFV3eaZz
	puxu9r2c86gp88DGN8WTRn51ufE/sylU0W/3mjLuP2q8ZrwsOwTL8mI3iLs11TnQ4S5k3jDMDaCZq
	iiyQm8fsb9p1wjg+7/8Y2atwP6cHqSTU8eAmj7wd0lKk+fulICLzsT0fNwSgBF3GTmy8MNte1/+t3
	2F0S6544w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUY0Z-0001av-EE; Wed, 05 Dec 2018 14:18:35 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUY0L-0001Kw-4n; Wed, 05 Dec 2018 14:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fHQHdmahNzrGjYVZ+awsbF7yYhxbw1T7tG6H4aZKH1w=; b=dD+NCeUZx7SaP391pc+Zlwj/Q
 /cxFGnBfCj52xdX7EgSdKaiK8LJrIIdT9ZQtHJiCsjGEA4LJhZCHQdwBPZsafjQdQ48XMEW35j2qn
 jE6lBuDp5Q+ghbA8GhkbFnXLv0iab0HarqX3E8mB5egbT1k2JZpByeaKPjoXqzTGq0y98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gUY04-0003sm-D5; Wed, 05 Dec 2018 14:18:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id C0CBE112533F; Wed,  5 Dec 2018 14:18:03 +0000 (GMT)
Date: Wed, 5 Dec 2018 14:18:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181205141803.GD6205@sirena.org.uk>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
MIME-Version: 1.0
In-Reply-To: <20181205134618.56223758@bbrezillon>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_061821_464158_BFA8D1A2 
X-CRM114-Status: UNSURE (   8.57  )
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============7342009358988732521=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7342009358988732521==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 01:46:18PM +0100, Boris Brezillon wrote:
> Vignesh R <vigneshr@ti.com> wrote:

> > >>   spi: nxp-fspi: add octal mode flag bit for octal support =20

> Mark, I think you can pick this one too.

I don't have this any more, it looked like this was stuck behind the
otehr MTD changes which seemed to have problems.  If someone could
resend?

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwH3hsACgkQJNaLcl1U
h9AQ7gf/aJLlaDvMy6aZuK7FrotyfySX7CJt+US7KUsb63DCSjupYyNQDjrU+hY+
MkA22EG1ml0RP1q5rOL+fgDnWtogzWGPApXwhT/R2prcgyK0YKqhk8eM2dAhzT6L
JfO+E9rGSM3rBYu5XaGZ7h++3H8mgH9GwkK/GQhgdSc/rOsUJtFZWpBr0+9AYlgi
UvQunc+4z95nlS73u7ZB+LOvC4L+h8vSp6yPIeN+TIpWc7pwSpbbCcYc3Rv81Usw
KqmpkRh9/rgai7zX844+tqa9KqPIZ++29cZHd2vmItMO0PMLcG+fk3S0jps5q27x
ZdLFbvdUupJ3Klk6uxPk8REewVaDog==
=6Sez
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--


--===============7342009358988732521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7342009358988732521==--

