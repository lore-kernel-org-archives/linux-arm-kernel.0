Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B43CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:46:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0FB217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sEduiomi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0FB217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3c+TClKgbOsClafQ/uR4nS8MwcDEWyduJlD6ExpItPs=; b=sEduiomitDh9Z9HkYRXBAl0dL
	SXS2jBHnQ079rFquF2VlAPhIl4CFm2YQl5yyaOmlFw4/9psrW8cxEjRHQpxp8d28YcFhN6W867Ovg
	vvsGj4RiGQGz9BTm0GAxEVHCoAW9POX/CBobHk05Ndj9ym0o5MLZ2N63TjZQR8XvDerteiG1L4Bj1
	TLNjPffQY3NGFAzzyalfqQF9MJdTcBKmMUgOsGcEN5+Hg5y+HLy/bAfYolYMczcierRQHwWisi0OB
	4BArKRDP8uM3OGB6PxwoyF2HuMoNzL9k7MTlNbO55R20PTQO0d06vvp+00PjMXzUyC8zirj9ZJyvq
	FaRSpytlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZElj-0007wk-Qw; Tue, 18 Dec 2018 12:46:39 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEle-0007vo-27
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:46:37 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 0A6768083E; Tue, 18 Dec 2018 13:46:12 +0100 (CET)
Date: Tue, 18 Dec 2018 13:46:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181218124616.GA10758@amd>
References: <20181217004450.GW6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181217004450.GW6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_044634_406751_1A3DDEB1 
X-CRM114-Status: GOOD (  18.28  )
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
Content-Type: multipart/mixed; boundary="===============7008139095299571613=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7008139095299571613==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So the little elves have been slowly working to get voice calls
> working on droid 4 with the mainline kernel. And just in time for the
> upcoming holidays, it might be possible to call friends and relatives.
>=20
> I've pushed out an experimental branch containing serdev ts 27.010
> UART multiplexing support. That contains a serdev core driver for the
> mdm6600 modem (that also now idles the modem for PM), support for Alsa
> ASoC voice codec and mixer, and a GNSS driver for the GPS.

Thanks for doing the work.

I'm quite busy these days, but...

# commit	 64cf2bf6b7614da35028a11974acb5a445dcc535 (patch)
# n_gsm: Use const unsigned char * and size_t
# We can use const unsigned char * and size_t. This makes things
# a bit easier for adding serdev support.
#=20
# Note that gsm_control_modem() gsm_control_rls() read the data
# for tty control characters and then call gsm_control_reply()
# that allocates a new reply and copies the data.
#=20
# REVISIT: Check size_t usage vs int
#=20
# Signed-off-by: Tony Lindgren <tony@atomide.com>

Dunno, I see that you might want const there, but u8 -> unsigned char
seems like a step in wrong direction.

# commit	   cd16272060d8100ef0388349cf88f42a1dc667fc (patch)
# tty: n_gsm: Add support for serdev

Is it worth putting those in separate file? n_gsm_serdev.c?

# commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
# mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like droid4

Oh, that is a lot of fun. Especially state machine for parsing modem
responses. I wonder how well it is going to work when modem is
accessed over USB...=20

motmdm_read_state(... size_t len)

I applied it over my tree (I still need patches for display,
right?). I'm getting

/data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: initializer
element is not constant
/data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: (near
initialization for 'motmdm_driver.driver.name')
/data/fast/l/k/scripts/Makefile.build:291: recipe for target
'drivers/mfd/motorola-mdm.o' failed

Oh and that mdelay(3000) is going to hurt... especially because
console is initialized very late or d4.

I did a quick test in my config... and it did not break my old setup
-- voice calls still work when set up over USB and with manual mixer
setup. That was good surprise.

Thanks,
									Pavel

diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
index eea754d..2b7c324 100644
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -1129,7 +1129,7 @@ static void motmdm_remove(struct serdev_device *serde=
v)
=20
 static struct serdev_device_driver motmdm_driver =3D {
 	.driver =3D {
-		.name =3D motmdm_driver_name,
+		.name =3D "motmdm",
 		.of_match_table =3D of_match_ptr(motmdm_id_table),
 		.pm =3D &motmdm_pm_ops,
 	},


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwY7BgACgkQMOfwapXb+vIAIACdFimDv6I3DKxlcmcAmyroAyn2
H9MAoIfC7hqnXVixy+non3E5WJZXClwH
=CINq
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


--===============7008139095299571613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7008139095299571613==--

