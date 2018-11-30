Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D9120863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pb3s498d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D9120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ad4J/uGOKYMJtjUFpMSetUnX6M5GaIDfQqhfdgBR61I=; b=pb3s498ddfeAMfANAyQeG5JtJ
	B6W6Oo/rCVBLSAULdhDVVhjPpSf9dS8D/rX/3G2h6hMavFngcQDfSEwsVeRLEa/kPEa588+h7UK18
	xxT6Ir3drismrA6eEbtqqjXlLLnB0bp/LObi2wOugcHVZRpdwVfr9EDcD7WziS1i0aztQ4h8oMnvQ
	QjsIPvHjlygoSPRnFYOQ2vjWx7RDy3cPasZWmqEYo8DvYDuk6qQVnavDCkzi3V3HK2BNU6hABTsqN
	Biu5iSwZbE4c+i4MHYjrLtQpOCR0hbFXa6gCmOSjxIN0huAJ0eLK/c0iMsiTYCJX8IGyP+Yn+CKNv
	idA8spzXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSs1E-0005mm-LU; Fri, 30 Nov 2018 23:16:20 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSs1A-00058M-SG
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:16:19 +0000
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
 by pokefinder.org (Postfix) with ESMTPSA id 6794D2E3542;
 Sat,  1 Dec 2018 00:16:03 +0100 (CET)
Date: Sat, 1 Dec 2018 00:16:03 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v3] i2c: i2c-stm32f7: add PM Runtime support
Message-ID: <20181130231602.GB860@kunai>
References: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
In-Reply-To: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_151617_070651_4A75829E 
X-CRM114-Status: UNSURE (   6.65  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5107737660899377492=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5107737660899377492==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 03:35:31PM +0100, Pierre-Yves MORDRET wrote:
> Use PM Runtime API to enable/disable clock
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-next, thanks!


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBxLIACgkQFA3kzBSg
KbbFUBAAh8qdHFxWwwJtTmJtHchfy31L3bwIYg4O9x4mHdo6CcAyBWQ69gSaFM1Y
S7cUti+/UyNj61umr6rXiy7/FlOSGKOOvV3KeSEfvJ9ElEiMtE9fRdNcft2NOGin
aAy9O2gm7TuIRf2V/kmylQkCyVbMUxH9J8N3huwM99/BcBmxl9IDTFMtWCL3GLel
cckpFJ3c4ZbF1VRfFPVKhYJ4gvGCt3xG2EdTUNvf6lHizZShIuAFLXlnyVnxh0+o
qKFWTBaDQNnnwiBQXV3FYyrpSpHrJwkcDf9QQoaL1uvF+ngh47W8cY7GPOt2sAtI
46OxieAkBte8fitAavZAI5WArtMY4IPITAuwrQyqEpErKQTNhbXM7nNUUsG5XLwK
1h86+cvOTZawSAuoMqdmnxAocyLIq0AvxIT5gxf05JUjZrQ4hIOO5CzTUe/Yvq1T
8PQzyuvCYjDbHae2lhOGUhffdLRyoWwwEqD9uFGhmxXoSMsIEN0UsRi7+XRvifcc
ulMjVNTaV/3HQY2aMl0Fv86LLCMboHJudO03tOeWTDA1rD6b1lJQI1WBydYfVJaB
Yf+T7kmWydYCzYIhT8kr91ALPitBGGIeIYt0ZxkkEPTKonGfty93tBgzWuGxCwJX
mPJt3W8jm8uWUKxzvbRSB7b3IV2qcsEHxlJjVI33C4kWvNMQU88=
=Zt3W
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--


--===============5107737660899377492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5107737660899377492==--

