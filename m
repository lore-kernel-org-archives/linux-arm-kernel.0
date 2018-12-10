Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CAC2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Skh1GdIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CAC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hFiF3qcP90+d1sk9shYnhaGw6fCjQLHogJNzm2q0rgo=; b=Skh1GdImKWr9xwU5fuDLyWP85
	oOm7O+drtqpeFLVtPYfbO5nEsBHVK7KuWmXjOUOkBiSBmIrANsk+F8VCK8RmTd03Ei3Q6Y4s+fIZm
	wKr3eDskcZsImszOYnjUFBd4X1fh32kTEqHkofs7RKc+/KJmDPjGnT97OipMyS5b7YPeG8zFtABdM
	ha/QyV4G4PEggxzeeKN6T7CSCbZL4u+7E8CysCFq0UPfkcwYi/inVnxgZsGXW+tOCGXydBuDAy/ci
	wsujWCLkaF0UElJojhUPp+KDI36ODwfhZCyeJhsYfVXCBYe6W0dw8vpqGvwq98h4LJoepwXNgtPOF
	nUh0RtBkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGxJ-0004UQ-2l; Mon, 10 Dec 2018 08:30:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGxE-0003XJ-Ob
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:30:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3655820D17; Mon, 10 Dec 2018 09:30:03 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id E546220CEB;
 Mon, 10 Dec 2018 09:29:52 +0100 (CET)
Date: Mon, 10 Dec 2018 09:29:52 +0100
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210082952.llwrrm5gxpxghtvi@qschulz>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
 <20181208150526.uceviwfwqskfwovm@qschulz>
 <20181210062718.GO26661@dell>
MIME-Version: 1.0
In-Reply-To: <20181210062718.GO26661@dell>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_003017_076289_79F395CB 
X-CRM114-Status: GOOD (  25.54  )
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
 devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5957866315179872308=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5957866315179872308==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2vjrlgfvleyxcdo"
Content-Disposition: inline


--x2vjrlgfvleyxcdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Dec 10, 2018 at 06:27:18AM +0000, Lee Jones wrote:
> On Sat, 08 Dec 2018, Quentin Schulz wrote:
>=20
> > Hi Lee,
> >=20
> > On Fri, Dec 07, 2018 at 07:22:37PM +0000, Lee Jones wrote:
> > > On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:
> > >=20
> > > > On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wro=
te:
> > > >=20
> > > > > My OCD-dar is going crazy.
> > > > >
> > > > > Why haven't you used the same alignment as is already there?
> > > > >
> > > > > If it starts to run over 80-chars then bring the others back.
> > > > >
> > > > > Also why is there a single liner shoved in the middle of the
> > > > > multi-line entries?  Please move the singles to the top or the
> > > > > bottom.
> > > >=20
> > > > Hi Lee,
> > > >=20
> > > > Could you please reformat it in the way that makes your OCD-dar hap=
py?
> > > > It would be really nice to get
> > >=20
> > > I'm afraid not, for a multitude of reasons.
> > >=20
> > > The most important of which surround testing.
> > >=20
> > > > AC and battery support for APX8x3 merged -- it'll make Pinebook and
> > > > Teres-I pretty well supported by mainline kernel.
> > >=20
> > > That's great.  A worthy cause indeed.  So I'm sure you guys will want
> > > to turn the patch around in short order so that it's applied in time
> > > for the next merge window.
> > >=20
> >=20
> > Aren't the MFD cells probed in order?
> >=20
> > In that case, it makes little sense to short order them for this
> > particular device (X-Powers PMICs in general). It will just make the
> > system boot slower because of probe deferring.
> >=20
> > Why? As explained by Chen-Yu in v3[1], axp-gpios can be muxed as
> > regulators, thus should be probed before axp-regulators. axp-adc is
> > often used by axp-battery, axp-usb-power, axp-ac-power, thus should be
> > probed beforehand as well.
>=20
> If there are inter-dependencies between the devices, it makes sense to
> keep them in the most efficient order.
>=20
> > For the alignment that also triggered your OCD, I can send you a patch
> > the day you merge this one if it can help. I sent a few patches for this
> > driver that didn't respect the alignment so I'm fine fixing the mfd
> > cells (and eventually re-order them as I saw a few axp-gpio cells being
> > declared after axp-regulators).
>=20
> That's fine.  Please send the patch (based on this set) right away.
>=20

Since Oskari sent a new version with an alignment fix patch and you
merged that version, I assume I do not have any work to do anymore on
this matter.

Thank you all for the patches,

Quentin

--x2vjrlgfvleyxcdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlwOJAAACgkQhLiadT7g
8aO/9g//XbaEfLywwIVvqMBV+QwKVC63R6Q3c7r15PIUDU7l76N7J/ifmFhHuSF7
RAYFpvf07y3REQrB91krRRfXyJ08CmyLkYAlqDqiU03b7weuMrN3fnbnzQdKaFl8
CgWbAJ629B6HG2mVyIvMXLq1Yunf30cjFKmZg8P1oMQL2H6Ibaxvct92U1yBl9eS
NE5Wsq+YCYHNCOnN6slIvpOG+lYmja5vHA4Ln7PFeh324AOsyT1ezw9R9ZHuO+Mi
PJ6i4z2PCZvE0kd+0aD0ke7UN4PqAJ8CflCAjrxw8dCOYjxFHmXsodt3buJAueIN
ZicpPoAxlmMxd32TAPSngqON5FCgnfha3W4GRwUb8SiACSluS8nG8Z8cf+hQnHYx
Iu0LsF9DjIjxfpbnjueCeR775jWWKF7Y/ynVp9/5JPcGxbstwabJYUlax9HTSRdT
8a8a/DxIPMjB7WBXQmvF1ONMT/Y9d0Tjv0Pts6IEMic+g84s1P+hnhzZwCwj5rtS
lqggCQC8OiZ1wJBqhi9pxeC7UEgr2wlqe7GefuvP9CeruptZAs5PqMXPb5ArTEGk
KIG/jLaveLpQo1preLiTXfPDYvn1XeXscv0uZ1sXG4Xkp6kEVkrxp80d8gc4xSFE
1nTnNYyLMOYhkoBl+0zw7t0KmqAl1tCccBabFo245ptjDwo5ZXc=
=3euG
-----END PGP SIGNATURE-----

--x2vjrlgfvleyxcdo--


--===============5957866315179872308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5957866315179872308==--

