Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54382080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="inRXc5ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54382080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UuHkNcImkVLiVjdSYSgGiJ8GE8BLt9db+WTac35eANw=; b=inRXc5ti2pjAedgHAmQk2S5Qb
	IBj70zZYejXL5DoQeTMJRSDk0Ui9d/rq+H5E7tk60JuyHoZ2dLNY/59Q80+jgkJM1mLSD7tmrbVtC
	PGEVOjexm2Ds7KcZaZ1pe7lMcCKmhHbNGyJ1c5njZRA/J2ddOcczRDHtfK1x8d9TwznglziUy2vJV
	okmP3bWqzsDEgdGcZuxgS841auVa201gpd1lnRde8gKFSFsGD85Gi36D+P/9cXFZuCkSN9YeBMdm7
	AcXAFwNnTyF95WlTS4yA0Nl/sj6mukDGyKBjE6WEb2Vm4dlizo5te54NbpGN0YmpT3cKD+9WJKsgM
	qSP34+/5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geHD4-0003Hw-JZ; Tue, 01 Jan 2019 10:23:42 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geHD0-0003HA-No
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 10:23:40 +0000
Received: from localhost (p4FC2385E.dip0.t-ipconnect.de [79.194.56.94])
 by pokefinder.org (Postfix) with ESMTPSA id 1D11D4A577E;
 Tue,  1 Jan 2019 11:23:32 +0100 (CET)
Date: Tue, 1 Jan 2019 11:23:31 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190101102331.GA1687@kunai>
References: <20181227151311.20107-1-ludovic.desroches@microchip.com>
 <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <20181231105348.GV10650@smile.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <20181231105348.GV10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_022338_925946_0D9FF328 
X-CRM114-Status: UNSURE (   5.71  )
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
Cc: alexandre.belloni@bootlin.com, me@jue.yt, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, linux-i2c@vger.kernel.org,
 Juergen Fitschen <jfi@ssv-embedded.de>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0550264607625365442=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0550264607625365442==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Perhaps, you can use SPDX instead of boiler plate license text in the files?

I think we can do this incrementally.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwrP54ACgkQFA3kzBSg
KbbE2A/+PijOZlG7bdPITEsWTqpQPCRFC3Q/mIjNjArm2EVWEkEOT4fIdD/O3X/h
DLv9TfpHkoJeaqywzO3/Ej6KHGCKlugAnBoddd6PeVVZd/2bm0wEwu9CoyOwsv19
bFiUaRad2VZHO4cZgfefYQ58Hsc0Iir5NAsyC4Je09Um1rZDoVK//Mal43UJRLFw
HCeN7IDnmCCBa1/GKMcYNIsLVhwprmx1sQEF1Z6YWPnf3ro9cSACLSSxbug8a1sX
N1XTOm9D3OpM1NAbD831dZqz+YEGeUx6TKg89DA24E5EXYsHJu5EsrJ9doEb//3O
tk4ngskiv/Rxlt/+IZsQELV9pnTBOhDUPOMal+/TVvQOkTAb5TrUn9aNO90AdqIX
YxKqffIhBX7e4MAZ23nEKr1BASf2dNpExpUSqrYDlhyXR2LKT8qlMAWzi18pzSU9
XYDl+q6okz8Fe0d7pJVK44G96hw1X5ZlQX5e4z54XG7kv7JdD2CajTWS1XMkoQ4G
oIk3waB5IpZmCdi6hw5BONRoYu7/hnm+rZzYn3Dn93mcNO8vjnDVvoN/2v1SmXE7
SXWP2L6OVckmZ17cPI6HiQmDG26oel7/AcKeHX3b7oQUqV521acifR7LHps4+tST
qCzIJ4vMrbCRMSYComRORM3yR+zMYp7FaayA1sX0Gqk3w5WsxyA=
=JbS7
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


--===============0550264607625365442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0550264607625365442==--

