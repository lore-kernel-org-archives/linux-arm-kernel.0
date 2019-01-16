Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:58:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D785620657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjzF0GPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n4cK0n7pW/Zw5AYwCknbVCFS6DUUgKa6dAojphLHowU=; b=SjzF0GPpabRX/S3E8qQeLQkMV
	eaXPHiQibzcYBa2Rqqfs0k4/URmpyAE4lIVo83xQzoT9SeOjoLlU4nnxhB4Ees8hNv4M1l1/ZXqH6
	z0b9bG5mfawCGe0SxfpW/5M2HCJHYjfoiemtwhWYmHPXjNyvDrNXXdura8J6Jx3gFaw/CjpbH+QOl
	FIMo3WwXwZvWhmx3SESBxRVNRJVn076Y1C6MgnjvT2f1zG7qtRGblGhvXidp6sDOMejarLesSuXxs
	ANZgEbiz+KtQC0pFpM4ipO87/liYnD/FwmpBWpgDbXIGeHy5m5/OaFz41LsIfL7FKnQJAETXBoig0
	1Z0xCBpJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjliI-0001kk-PY; Wed, 16 Jan 2019 13:58:38 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjliE-0001kF-Iv
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:58:36 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 9F207808A5; Wed, 16 Jan 2019 14:58:24 +0100 (CET)
Date: Wed, 16 Jan 2019 14:58:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116135829.GA10426@amd>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181228193105.GW6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_055834_773535_C1B34E26 
X-CRM114-Status: GOOD (  18.62  )
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
Cc: Rob Herring <robh@kernel.org>, Marcel Partap <mpartap@gmx.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, omerlle@gmail.com,
 Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 NeKit <nekit1000@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Michael Scott <hashcode0f@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
Content-Type: multipart/mixed; boundary="===============3653101470062967934=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3653101470062967934==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Pavel Machek <pavel@ucw.cz> [181227 10:17]:
> > Ok, I really need SMS messages, too.
> >=20
> > Fortunately, they are on /dev/motmdm9, in PDU format. Quite
> > logical. And you probably need to acknowledge them, using PDU,
> > too... (because otherwise you'll just get the same SMS over and over
> > and over). Which is also logical, but hard to do from shell/python.
>=20
> Yeah so I found that Ruby pdu_tools module allows decoding PDUs
> properly while I did not have much luck with other tools.
>=20
> So I wrote a hasty script to read SMS, copy it to a Maildir and
> then ack it:
>=20
> https://github.com/tmlind/droid4-sms-tools

I could not get that one to work.

/var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in
`class_eval': /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:
`@@{' is not allowed as a class variable name (SyntaxError)
/var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47: syntax error,
unexpected end-of-input
          unless defined? @@{:default=3D>true}
	                              ^
=66rom /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in `block in =
cattr_accessor'
				=09

And I wanted to ask -- did you figure out how to acknowledge the
SMSs? +CGNNA does not seem to do the job:

07912470338016...
AT+CGNMA=3D1
+CGNMA:ERROR=3D9

> > Fortunately ttyUSB4 still works, so I can still use my old code... and
> > I started logging motmdm1 and 9 to a file as a backup... that should
> > be better than my existing solution. (But I don't get power benefits
> > etc.)
>=20
> So what are you using to ack the received SMS over ttyUSB4?
>=20
> My logs show that Android uses two different commands for ack.
> Either AT+GCNMA=3D1 or AT+CNMA=3D0,0 gets used depending on something
> that I have no idea of.. Maybe the network connected?

I believe I tried both... but for some reason I think you need to
paste back "acknowledge PDU"...?


Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/OIUACgkQMOfwapXb+vJbkgCfZqQ749WAy9iVhYjTZLaBv7Pv
IaIAnjGYv3zjXtJ4rv6LEZLE41PhNmip
=fBDo
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


--===============3653101470062967934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3653101470062967934==--

