Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2AAC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF9C20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lENoOOa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF9C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TmJL0Ax2kNIob2rxvO9DHz8qJdJ/ffNxKbS+HKihq4A=; b=lENoOOa4lH84HAGO9B8N8EJgN
	gDaEqM1GYaRu59uqg5xZaLIvsZ5P6ZHbkuIAunHfV8orBVDHHheRplAAvoQnP/an53lTd+Vl86E4O
	Mf83hnujXfQ8nkLLHaIk4qC/I9ErAQhsxFtZVdcm2sOSHV4X+ZQD/gbl47LmBy3xebXlHzI51x+7h
	+O1QuoY9firQidLsJ4R5G/PdNAuDIfX7m/fG75VDLeLqzIj2Cz9eFMy5UNBeHfzXkA95k+z7TKLEO
	J3DA9ewM10tszeS6QMHWvoip0GeUZv7oKNDdgq3x9e7oDF0Aj7N8Hj+LblDiqc2EUZhNsXwjkBtX7
	HeRdHo8Mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnhi-0006Tp-3b; Tue, 11 Dec 2018 19:28:26 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnhZ-0006Q5-No
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 19:28:23 +0000
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
 by pokefinder.org (Postfix) with ESMTPSA id 2CE544C0E8F;
 Tue, 11 Dec 2018 20:28:06 +0100 (CET)
Date: Tue, 11 Dec 2018 20:28:05 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 me@jue.yt, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Message-ID: <20181211192805.qsxptzkmczmm5vlz@ninjato>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
 <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
MIME-Version: 1.0
In-Reply-To: <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_112818_072461_BE1993D8 
X-CRM114-Status: GOOD (  18.02  )
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
Content-Type: multipart/mixed; boundary="===============5102105349086558863=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5102105349086558863==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3px5u5ztkeyr3oy"
Content-Disposition: inline


--u3px5u5ztkeyr3oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ludovic,

> > >  - fix checkpatch errors
> > >  - tests:
> > >    - hangs with a SAMA5D4 (master and slave on different busses) afte=
r about
> > >    100 transfers. It's the firs time I do this test.
> > >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> > >    I don't know if it's a regression. I don't remember having seen th=
is
> > >    behavior previously.
> > >    I think it's worth taking those patches even if there are some pos=
sible
> > >    bugs. It'll allow to get more people using it and so to consolidat=
e the
> > >    slave mode support.
> >=20
> > I really want to see those patches go upstream, too. But I am also not a
> > big fan of delivering the user something with known issues. Especially
> > not when they affect the main feature to be added. My rationale here is
> > that someone who is able to fix the issues remaining will also be able
> > to pick up and apply patches.
> >=20
> > Maybe, maybe if it was to be enabled by a special
> > I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> > think twice about that, though.
> >=20
>=20
> I understand your point. The experimental mentionning could be a good
> trade-off. Let me know once you make up your mind.
>=20
> > Speaking of Kconfig, I think this series needs to place a
> >=20
> > 	select I2C_SLAVE
> >=20
> > somewhere.
> >=20
>=20
> Ok I'll update it if we go further with this set of patches.

Ok, I give in. If you:

* add 'select I2C_SLAVE'
* make slave support selectable by I2C_AT91_SLAVE_STAGING or
  _EXPERIMENTAL or something alike (default n)
* and add to the help text of that symbol the above known issues
  and 'not for production' and 'help wanted' and where to get more
  info and all that

then I'll apply this series soonish. Promised!

Thanks,

   Wolfram


--u3px5u5ztkeyr3oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQD8UACgkQFA3kzBSg
Kbbv5A//XSrxh8si+e3AU5T8HE/y/l3i9dreOYqcMS6joBcoIIFocbC8PSVpOWRR
jk7BxI87bfpTe2kDxpmHq37jvjy886tXJ8fcAx8YGvaWgnF5FjMrcZGJ0GYoIOQ4
04nEXdFgGb1NACMZGyT3Q4C0ov4HBy62T9K/sN99AznxLQkfDRB0kCE/TdQhtpcC
F8XCfSUjrEhfs04ey2poggUHjne2zVmOjATnip7X3CZF4LTE2ktGtOY8lZHeqWjl
falbb/xTGMNIrTr6keXzwiBN5pvy3ijwzZbFtF7MThLWIPMsPPK/Y3RbltauT4SQ
/AilFdJIeheddTPPTFpMw6tC1FA7VwJAEM87M5uEk7TUlc97LBl25uUH8cEHaYKg
HNlOACMkg1U94lJWPk4dWvTHT4e4PTHCQK2fIegaeZnTKWw+FluJEqUPr9cAANEj
8z++hdKxsWK4MLNBvziTu7yfrw9/k6/sMbDd8bB/PoPak9YoGTlKX+ogdJtsSyPK
/uUZlVkIptK/sGaCIKMbCjmrxbAuhuoPSjSi5kEkX558T6tjCXRK8hDkqvqQbW/Y
wLKRfQpqeOHmfAECHG1/jPISVcZA5Pp4DjMTOvuyiZbFEKFLQ7p3lkmMoZ6zuR23
p0mpNpPYww/rQL8rUm6+Ej9yUrmzmlfyDlEZxdVVFTBw66BXCZA=
=Mkqk
-----END PGP SIGNATURE-----

--u3px5u5ztkeyr3oy--


--===============5102105349086558863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5102105349086558863==--

