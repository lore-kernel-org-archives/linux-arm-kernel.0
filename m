Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E72C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:24:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7242E2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rRrw6+5Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umtSxrGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7242E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=al8cnwIQC4OXpFlqz4sDh7NShzKnC7OBzBCUiictvgw=; b=rRrw6+5Yixo1QpxcKOpKeW3+Z
	At7vjYP5KejVIh9ALyR/s6DhGS6UP5qtD7l5uyL3TCO+cIDki1bdEFLsBwXl9E9cGfQprX1t/vgPl
	1UGOhkK9bi3toiR6KXOJN1MMK/6t7CE/LtouhtVsIPVlfHmS/oyjhpAksZjGilh5oKKyuc7bGWM/f
	tJRqZHBIXd5O/ND13w9kAtTCPbOYZwg9OjhiLkykvfUuiW+BviDyBdmtDS+9FfEc4/8f83Tpc2KoP
	1rU/wewvi4ohtYXgqZhoMMpbQ58+lQ54E+YuOhTs695z4auPuFVNlIczMcpmkiKpBw2CpkQ2sUVxg
	cwPff+l6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxu0-0005qd-Cu; Tue, 05 Feb 2019 10:24:28 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxtw-0005qK-3X
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:24:25 +0000
Received: by mail-ed1-x542.google.com with SMTP id y56so2356789edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UczFIitonvS/h+kD4r7MvR8KHE0gnO1dR+yVaCi/5jY=;
 b=umtSxrGt8+Y4t2gdP16MlaMOhUiCiyR5vZ2yqCGrlyk78pE5OGb85HOwEsrs4JiaeV
 SuVz640azp70I5KMgkR+GiqaxBagl8BGZsvhtpB/U0ylwN3UUFWGl926mifow9bnScjU
 s3+6Qg/d1des38N/h8YTllZHI9K6UVDK5xCowjyEgFbOwI4xV25HXpksAZJJJw3Y4qR0
 NwaG/z3QNizksCy3Er67DFkkh18xT4YOhJ2IKOMlMGM/5qlcp01p+D6Y90QIkG20lpC1
 pZXtYQEXgt0+MMm2b0EPYHw/+4Y14K28IBMXKcZk7cnVedP6BXRphD9u1fNzzCmIjite
 YNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UczFIitonvS/h+kD4r7MvR8KHE0gnO1dR+yVaCi/5jY=;
 b=UUDta2lC+z5ikpA9hhSwyLyo8ien4FiZsHOrGGu2yRcTbquKagVy0MyCw1qSjktyk8
 BXfjiqpgiGPMiiFdjFXk5XaQXdMjeBOZm4Nl7Whrk5M9FO1SzLegMtGNl2QqcmecFj/8
 crf0qBUCgQRasiOQG+qlMwm5LOLItrUE9TtIktiSN6XpS79y2/HrsGyO5lZGMfsPTwPR
 xuIMyS3wjAmBlT/5bNr/VCk/YM2o+I9AV1g7nFiVEP9Ieae9kzT7y2BaDCD7hgg4IvUa
 KJWxrXHiQpkCW4LM7jpNcTQCjFq8Sv9CBnuxeFH3IrZSLVJMMfgkFmrT8FpLqYoUuDjd
 yPgQ==
X-Gm-Message-State: AHQUAuZNlhtJhFgvncXyi5GcELTtzpBXVodOHN8rKl+AVXEFkx7PB22e
 eugM7eTplgIejykk8VnrpC8=
X-Google-Smtp-Source: AHgI3IaU4al29ywJAI1jwRlAY5I7cCMfUMGjkVIgX5Ywfn1K3baIQRJi0/EweqhPQP8sMou0PaVW0Q==
X-Received: by 2002:a17:906:6acb:: with SMTP id
 q11mr3010856ejs.22.1549362261569; 
 Tue, 05 Feb 2019 02:24:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id c9sm355946ejf.14.2019.02.05.02.24.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 02:24:20 -0800 (PST)
Date: Tue, 5 Feb 2019 11:24:19 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190205102419.GA591@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <20190204094012.GP3271@phenom.ffwll.local>
 <20190204112218.GB10412@ulmo>
 <20190204155909.GU3271@phenom.ffwll.local>
 <20190204162258.GB25476@ulmo>
 <20190205085737.GY3271@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <20190205085737.GY3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022424_173088_672C09F5 
X-CRM114-Status: GOOD (  51.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============0421966743728035810=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0421966743728035810==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:57:37AM +0100, Daniel Vetter wrote:
> On Mon, Feb 04, 2019 at 05:22:58PM +0100, Thierry Reding wrote:
> > On Mon, Feb 04, 2019 at 04:59:09PM +0100, Daniel Vetter wrote:
> > > On Mon, Feb 04, 2019 at 12:22:18PM +0100, Thierry Reding wrote:
> > > > On Mon, Feb 04, 2019 at 10:40:12AM +0100, Daniel Vetter wrote:
> > > > > On Mon, Feb 04, 2019 at 09:23:59AM +0100, Thierry Reding wrote:
> > > > > > On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wro=
te:
> > > > > > > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.redin=
g@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick=
 wrote:
> > > > > > > > > eDP panels usually have EDID EEPROM, so there's no need t=
o define panel
> > > > > > > > > width/height or any modes/timings in dts. But this panel =
still may have
> > > > > > > > > regulator and/or backlight.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  .../devicetree/bindings/display/panel/panel-edp.txt     =
   | 7 +++++++
> > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/dis=
play/panel/panel-edp.txt
> > > > > > > >
> > > > > > > > Please don't try to make panels look more generic than they=
 really are.
> > > > > > > > You're going to have to provide a compatible string for you=
r device that
> > > > > > > > is more specific than "panel-edp". You claim that you don't=
 need any
> > > > > > > > extra information that is panel specific, but you don't kno=
w that now.
> > > > > > > > We have in the past thought that we didn't need things like=
 prepare
> > > > > > > > delay, but then we ran into situations where we did need th=
em.
> > > > > > > >
> > > > > > > > Just do what everybody else does. Provide a specific compat=
ible string
> > > > > > > > and match on that in the panel-simple driver. Even if you c=
an read all
> > > > > > > > the video timings from an EDID EEPROM, you can still provid=
e a mode in
> > > > > > > > the panel descriptor to serve as a fallback if for example =
the EEPROM
> > > > > > > > is faulty on some device.
> > > > > > >=20
> > > > > > > Pinebook used several 768p panels that have slightly differen=
t timings
> > > > > > > and recent batch uses 1080p panel.
> > > > > > >=20
> > > > > > > What panel descriptor should I use as fallback?
> > > > > >=20
> > > > > > You don't use panel descriptors as fallback. The simple-panel d=
river
> > > > > > will bind to a panel device and use the corresponding descripto=
r. If
> > > > > > your device tree contains the correct information, the descript=
or is
> > > > > > correct for the panel you have.
> > > > > >=20
> > > > > > In other words you need to ensure that you have the correct pan=
el in
> > > > > > device tree for the board that you're using. This is exactly th=
e same
> > > > > > thing as for other devices.
> > > > > >=20
> > > > > > One way to to this is to have separate device trees for each va=
riant
> > > > > > of the board that you want to support. Another variant may be t=
o have
> > > > > > a common device tree and then have some early firmware update t=
he DTB
> > > > > > with the correct panel information.
> > > > >=20
> > > > > This would defeat the point of edp, which is to standardize the m=
ess of
> > > > > panels (at least somewhat) and avoid having to change the DT/ACPI
> > > > > tables/firmware for every board you ship. Also, we do have DP qui=
rking
> > > > > infrastructure already (using the OUI), I think if there's someth=
ing that
> > > > > doesn't work then we should quirk it there.
> > > >=20
> > > > The problem is that while the attempt may have been to standardize,=
 it
> > > > failed. It doesn't take into account any of the details such as tim=
ing
> > > > between things like powering up the display and enabling the backli=
ght
> > > > or similar. I don't know how you'd want to "quirk" those kinds of
> > > > requirements because they are highly panel specific.
> > >=20
> > > Hm right, we get these from some firmware tables (and mix them with t=
he
> > > spec one, since some of the firmware values are nonsense). I don't ev=
en
> > > know whether we can read the timings over dp aux somehow (you can pow=
er up
> > > the panel with some pessimistic values to figure those out, and you o=
nly
> > > need dp aux to work, which is much simpler than the entire panel).
> > >=20
> > > > > What does make sense though imo is if we try not to stuff the edp=
 panel
> > > > > into panel-simple, because it's anything like a simple dumb panel=
=2E There's
> > > > > also some integration awkwardness since with this panel you need =
to do dp
> > > > > aux/i2c transactions to get at the information (edid alone isn't =
good
> > > > > enough for edp), and I'm not sure how exactly that's supposed to =
be
> > > > > instantiated. Maybe a special function to instantiate an edp pane=
l, which
> > > > > takes both a DT node and the dp_aux controller would be much bett=
er,
> > > > > instead of trying to auto-match against a DT compatible string an=
d load a
> > > > > panel driver which is almost all fake.
> > > > >=20
> > > > > Or we teach dp_aux to register itself and somehow teach panel-edp=
 how it
> > > > > can get hold of the dp_aux channel it needs.
> > > >=20
> > > > We already do that. drm_dp_aux registers as an I2C adapter that can=
 be
> > > > used to read EDID EEPROMs using I2C-over-AUX transactions. We alrea=
dy
> > > > use that on some platforms.
> > > >=20
> > > > Also note that simple-panel already supports getting video timings =
=66rom
> > > > EDID. If a DDC link is present in DT, the driver will load the modes
> > > > from EDID and use them.
> > >=20
> > > Could we extend this to dp aux somehow? For edp you need the dp aux (=
which
> > > then gives you the ddc link automatically).
> >=20
> > I suppose we could do that. We could introduce a new property that would
> > allow the panel driver to get at the struct drm_dp_aux that can access
> > the panel. I'm not sure how much that would buy us. I suppose the driver
> > could go and use that drm_dp_aux to do I2C-over-AUX and ignore any
> > ddc-bus property in device tree. A drm_dp_aux object could also be used
> > to access DPCD if that's helpful.
> >=20
> > The driver proposed here doesn't need access to DPCD, so I'm not sure
> > that would immediately help.
>=20
> You definitely need dp aux to drive edp. That's where a lot of the really
> important stuff is stored, and it sounds like on non-broken panels even
> the timings (we've never implemented that on i915 somehow).

I'm not sure I understand what you're saying here. I haven't worked with
eDP panels in a while, but my recollection is that you can use DP AUX to
read video timings over EDID. We provide support for that by exporting a
DP AUX controller as I2C adapter (i.e. register with the I2C subsystem)
and then that I2C adapter can be used to read the EDID. I wasn't aware
that eDP panels additionally stored the video timings somewhere else.

What I meant above was that aside from the I2C-over-AUX for reading the
EDID, this driver doesn't do anything else with DP AUX in order to turn
the panel on. Looking at the eDP support we have on Tegra, there's a
DPCD register (DP_SET_POWER) that needs to be written in order to take
the sink device (i.e. panel) out of the power saving state. We do that
as part of the connector implementation rather than within the panel
driver. There are also additional registers such as DP_LINK_BW_SET that
need to be programmed. I think this is also relevant to regular DP and
detailed in the specification.

Given all the above, I'm beginning to think that Rob's right in that
perhaps we shouldn't be treating eDP panels as panels, but rather to
make them look more like DP monitors and make all this code part of the
connector implementation. I think pretty much the only differences to
regular DP are that we might require some lower-level resources that a
DP monitor would usually have built-in (reset or power GPIOs, power
supplies, backlight, ...).

I'm not sure if that's enough for eDP panels, though. For example the
AUO B133HTN01 panel, used by the exynos5800-peach-pi, seems to be an eDP
panel. But the driver also specifies a couple of additional delays which
suggests that either it violates the eDP specification or that the eDP
specification doesn't define any power sequencing delays that would've
been needed. Or perhaps these delays are specified somewhere and the
driver just doesn't use them?

Thierry

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxZZFAACgkQ3SOs138+
s6Hy8g//Y3J7LpurPMPM65PrgKuiXb8B2YbNLA1rrdVt+xmP0j05QI3k/9RMkR2t
K9OZz15RbfulYl6yspYfeuYAlp8YFX1Wt9dApVH7MzJ7HTEkpprKXtWc1AkzuM85
Gjh+Dud5SGZYQzlUqEjO5wpDAX+K4+sQQxJQeLykoks/rAwp8X2O4afxYnhU7U7m
37IP6zwEHc4dCmXBPVmdVVB8x2sSG+el4NzfQlN3lVU05gn9utTG1Ee87T+0l5VY
ftuYeRey9WpP+9qcW/130H/za7lpLJGnuoOzsxXMEv9WxVrU+ngFJ/W5Eo9YaD1q
Kx7R5hLzuKXX0aYgdidLCteI7qRdFdOeIxHnQvYhWPywCw7eNrbAiyjdu3SlMfji
FKOGG6rdowZ4bc4BhdsnhS1Wn3cpCG2MPGAVF1j/DvkcHGQajo+0yDYiRqN4MAts
yf42Zq9pvD9Fn+T4Xc7KQgBxXt4JAO+ZHTLk7K5LED/TRbpaO3uMKNYLGrAuFP5f
XyL39l50SDdxPladWCr67m1YmSzINnKB0aRtsRuKPw6i6AZ2ExkaYiLz2eupAhDe
XxkEsIcZBu0T/dBPMmMZunsZzM81iXZSyy35twHuLexB+HbOcqreYrWhbdSNNOdM
SrAScYYPe5Sq+oGMmCr/UnIk8cr9K666uD17jEfg3KyFVLJPWg8=
=a+/I
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


--===============0421966743728035810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0421966743728035810==--

