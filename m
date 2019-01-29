Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39CBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:01:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A852087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jr34ljpq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mKiPSk+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A852087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=esRsN4mXcf/c9GLfoxPrdLMvSfo5i7+5ibGblUx7Y0E=; b=Jr34ljpqmNYXxfI/rvGRVFReu
	uqb4jxv+73NGQQX+yTkC+XM+AwAObzTL38SeEKqHxcY1Au/KiLuMYFP5xcz9aBRqnb775cREo6sfq
	JzdLis6KeBDKouigggQLDLnsGUSolhB22mzllCSr0ycIFCYtAYS0dkuv+w+BO/SV7KvrHIzBql+37
	0efkMKjAMf3ZJrPwUgWIQFRKX+omnNEhhD5tuJGWTLZV5PuVPt3uzZK9Y3T7rzZ6vSfNFnfr3kPIf
	xjJn4dYwKtUTqf6etaHOwtprDjByF+jglV4W7Llnz7UeDxfSpIUCOQ5RfsKReRBsBL6Op+F8/TbbY
	PD+AYs43w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWlb-0001IG-Mv; Tue, 29 Jan 2019 17:01:43 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWlX-0001Hv-2e
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hXaj3tL9W7EKslzzjYnEL47o3TGvZn2E/qmJYjuvx90=; b=mKiPSk+c+3aYabz5XJ1CrAAKu
 LmyKycUX99QuKFV5cXoifl1kiBC1XPnY1OoJZvqHbJalQcgwERt7lSc0TpmTpX8Yh/fOLDJb2kXy2
 rbzZbUOW5yCVRW849r6srfvK9q46camOm/S1vFdF9Vd6IwX99tpMJ0DK04oM1FatncEBM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1goWlM-0000ft-JD; Tue, 29 Jan 2019 17:01:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id DEF8E1127D50; Tue, 29 Jan 2019 17:01:27 +0000 (GMT)
Date: Tue, 29 Jan 2019 17:01:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129170127.GG10524@sirena.org.uk>
References: <20190129164813.GA5720@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190129164813.GA5720@atomide.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_090139_270277_0C2FD4F1 
X-CRM114-Status: UNSURE (   7.00  )
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
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Reichel <sre@kernel.org>
Content-Type: multipart/mixed; boundary="===============3574133752279171937=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3574133752279171937==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:

> regulator-dummy: Underflow of regulator enable count

> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

Given that this is a new warning my first guess would be that it's
legitimate...

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQhucACgkQJNaLcl1U
h9DvNgf/afV1Q9dfKEBi5X3uqIODf6E85oTYa+NZvgVWnAWdwnUWzNtkeevo/L7z
kbDoRiyhz8txKBiwZqyh46yWeTDKJepSfunaqT/1ZQfbkr2SnNDDncEB0W/TOk8g
PMLIGlK5rw9Y1P2TGWuCel/XAXF64fdlMz7HiM0PJco6RFbZgnMa85i8IfYCL6p0
IzC/dC3XQ6NeczMa9qLnrNHMp4iMF27OsNKgB1VLLzcb7TePFJDQUJAB4GDWvl4s
WrKl/MqQhQNfWPsQ+DRSYVnAphWyQZe+6RPInZOEVEBVZ8AKpAXnYz8g/aSyyQpU
L9r597E1hN+WOn4igpiu7y8UTEle7w==
=waLs
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--


--===============3574133752279171937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3574133752279171937==--

