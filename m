Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C173C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:26:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8C72148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZkoyslY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8C72148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=64q5sDjCDJHSCQ4YjE4j5Goz8fVsHKwWMkB0A3WuXUM=; b=ZkoyslY2o8sGLumdboR53eNma
	Iug2lxxKqT7HoLgVsFtCWbt0N2OC2IaZQo0z22qykBYX7UqZgY7NrWDimFK8CxWWmwze3mF7sCX5x
	58WdIZpphn5e2OlXBaVwqf3cK8WxCkORFpwH0HFeoODgRqbq49FJQ50lSnZQpAo3XAgmmDxMH0H5U
	+qINt8alG5dNtqKx3ayHSDuU1Z+ShOcvC6WEM6k5Cjlp4+i+Svg86KRDrN2fly6eOycfbu6bQ+hwo
	NWLABs8+wguvX2jTSg0uuGm9Dmoe66a11sNoMpap/QFmFXK64Omsk9k+NG917sDEwnUkh8WcTiq7L
	phxL83HQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd1Vs-0007Bl-CH; Fri, 28 Dec 2018 23:25:56 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd1Vp-0007B6-9g
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 23:25:55 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id EE1DC80785; Sat, 29 Dec 2018 00:25:32 +0100 (CET)
Date: Sat, 29 Dec 2018 00:25:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181228232536.GA7355@amd>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181228222805.GC6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_152553_645211_30BD2ECB 
X-CRM114-Status: GOOD (  19.11  )
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
Content-Type: multipart/mixed; boundary="===============6094598972485181619=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6094598972485181619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Pavel Machek <pavel@ucw.cz> [181228 20:46]:
> > I have ofone with direct AT access --
> > https://github.com/pavelmachek/unicsy_demo/blob/master/ofone/at.py .
>=20
> OK thanks, that shows some of the commands I was wondering about.

I had some luck just googling AT commands. They are somehow
standartized.

> > Now, ttyUSB4 provides quite a rich interface, and you can actually
> > select what if you want messages in text and PDU format, and if you
> > want modem to auto-acknowledge messages for you.
>=20
> So which AT command configures auto-ack of SMS? I don't need it,
> just wondering what all these commands do.

So this would be "text mode": AT+CMGF=3D1. And I'd actually expect
auto-ack to be the default on ttyUSB4, but in any case this is the
command that controls it is: AT+CNMI=3D1,2,2,1,0.

>=20
> > What kind of battery life do you get with all the optimalizations?
> > IIRC I was getting 7h with ttyUSB4 in use...
>=20
> With droid4-pending-mdm-v4.20 branch in the following state:
>=20
> - UARTs idled
> - LCD blanked (well no drivers yet droid4-sms-read.rb)
> - MUSB and EHCI USB modules unloaded
> - OHCI loaded with all the children in autosuspend via sysfs
> - WLAN connected
> - busybox acpid stopped (yup, it keeps polling something???)
> - MDM6600 online with AT+CFUN=3D1 on /dev/motmdm1
> - MDM6600 notifications disabled with AT+SCRN=3D0 on /motmdm1
> - droid4-sms-read.rb running
>=20
> I'm seeing droid 4 idle at 119mW according to my power supply.
> So I guess theoretical battery life would currently be
> (1785mWh * 3.8V) / 119mW =3D 57h. But in practise things are not
> completely idle and monitoring sysfs POWER_SUPPLY_POWER_AVG
> every 10 seconds I'm seeing something along these 10 samples:
>=20
> POWER_SUPPLY_POWER_AVG=3D138938
> POWER_SUPPLY_POWER_AVG=3D134571
> POWER_SUPPLY_POWER_AVG=3D505802
> POWER_SUPPLY_POWER_AVG=3D240412
> POWER_SUPPLY_POWER_AVG=3D134252
> POWER_SUPPLY_POWER_AVG=3D132694
> POWER_SUPPLY_POWER_AVG=3D571569
> POWER_SUPPLY_POWER_AVG=3D132694
> POWER_SUPPLY_POWER_AVG=3D190456
> POWER_SUPPLY_POWER_AVG=3D518288
>=20
> So the average based on that sampling is about 270mW and the idle
> time should be about 1785 * 3.8 / 270 =3D 25h, which is quite usable
> already :)

So... 57h would be very nice, and even 25h is cool. IIRC original
motorola firmware does something like 100hours, and cyanogenmod is
closer to 24h...

Note that there's something in the sysfs that allows "precise"
measurements. Aha, it is "charge_counter" on droid4.

(I even have some software to do the monitoring and display the
graphs. unicsy_demo/monitor/batmond).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwmsPAACgkQMOfwapXb+vK2WwCeKIea4YAGqvay75E9BHuB1r73
cgEAoIGlkRXIcPRq4N40FeroyIRbuCWV
=Gb00
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


--===============6094598972485181619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6094598972485181619==--

