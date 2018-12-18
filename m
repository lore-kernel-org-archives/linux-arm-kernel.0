Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC93C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:47:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7A820815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZKU6diO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7A820815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6+BmAEvHs46zPuPeJaviuuZjeOPZp2z45V4HsLzrzsU=; b=WZKU6diOXotPm3ZZBqvMNLE5J
	xo8w6HPeuKJ/I2+w+hDfzH0MGwEO8NbGTTvQSM2/K2QVNCHV+qtbzUG9lf3ZjKzy+JmwdWrAthx7I
	qeLqNpLz5Bafr2z+oLUapCYBi9JanrQvkxxiPB/UWnxs/Bx8NyHG16Pn/xPobjFp9KdnFrM+WcwD6
	rXo46r+6pq6IosEDTbTSO914/YfKMnNEGxfXnVDdI2nfo34ttzctFGzpyY3ff/xKmoCntI2OuRMVu
	9S9rmV+6n2tTLMMeny03jP9wcEAxF5+p0uiHbeUgnCPZzDgXliyDhLM4pHqLD8PfAjH+vhBZ3FOY+
	JA3R1JUeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZP57-0005Pr-PV; Tue, 18 Dec 2018 23:47:21 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZP55-0005Oi-EJ
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 23:47:20 +0000
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
 by pokefinder.org (Postfix) with ESMTPSA id 89A3B2E3542;
 Wed, 19 Dec 2018 00:47:08 +0100 (CET)
Date: Wed, 19 Dec 2018 00:47:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC/RFT 10/10] i2c: rcar: add suspend/resume support
Message-ID: <20181218234707.bpagrnelne5xwuot@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-11-wsa+renesas@sang-engineering.com>
 <944a2523-aa40-eaf2-2c4a-d27254e7cbca@axentia.se>
MIME-Version: 1.0
In-Reply-To: <944a2523-aa40-eaf2-2c4a-d27254e7cbca@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_154719_625433_A8B19E18 
X-CRM114-Status: UNSURE (   6.78  )
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
Cc: Hans de Goede <hdegoede@redhat.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============0236370673318452393=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0236370673318452393==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2wd5zy6ly6ev5syp"
Content-Disposition: inline


--2wd5zy6ly6ev5syp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Because the adapter will be set up before every transaction anyhow, we
> > just need to mark it as adapted to the I2C core.
>=20
> mark it as "suspended", not "adapted"?

Sure thing :D Thanks!


--2wd5zy6ly6ev5syp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZhvsACgkQFA3kzBSg
KbbaJA/+Ob1YPSF6Xjksbil3XEOIkN0XoZ3Nj8E89hLT7tS3ctwAGg38gGTkA9jq
oh4UfWpqw6EkGle/mcg2NAzqjZgZssQ5zJnq7CbJKnAQqL5Ss35o7iWle3gCX5Wt
0ebH5rcksESYEsL3a+3r/jw4YRPllAJjna76uhX+rcQ3TeNxRzXfvHOUWErW90SD
PPwZjUQbk5ryO9hLzaHvOFst8eid7Cjv5EwZc6NAfxuHzg3BtDVooSeKdESDhUww
DyejT1aYuDOHbhSNqecz61QYxbORlaVTTbLPaaM8/9DPFnlUrGGDWr1THawwLN4C
0osmhb/MxPA3SFGkWliGbGPvhE4y+fT8+oBucsQWx+Rg8L/4JtqImhu3AY8WrVDN
9TXWFp1u75plrBfnuCrv6zfLE/qgXg8QljNRsBVgBeZe/dwZ2MPhICqxOF2FI3ZV
tblDZUUS7wRWom/eAwHt1+BlZ0IlDfx2+hZNTsDW7Gvdm5P82rQieior4RP7BJYo
f6p0UIJUARj3M3zhUC3frNiYvVF871b9AiBuXuqFElfAEnc29RoXO7PwChHwF9Xo
BLoi5V8t78NMAkOhx5R+FUiTxt2ur4O5qn0xeq9RDkIt1Z/7vNOfgiUeN3kKQLA0
QRnbOjrvBz3X7xxIRWqV/R1YSyGYCP1d56yHYhoT/RLJdDxnnFA=
=mlgw
-----END PGP SIGNATURE-----

--2wd5zy6ly6ev5syp--


--===============0236370673318452393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0236370673318452393==--

