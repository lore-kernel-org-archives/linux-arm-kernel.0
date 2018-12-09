Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 09:00:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BB320831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 09:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YcOm3lPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BB320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=978vjOWYJ7lGo9/u0D/0ww4vLK7iHLsB4XkgSWHaOAA=; b=YcOm3lPBezsEWf34ORGiRvEvP
	FYplA/ID5mFh5GSxyFsphHO1PXFE/Mbn80HPlp2ZeALUwcVXOO7LN00CFVbX7G/tvc9mIkumB01pQ
	kyx598LYIkuh6EQlFQJLb+jiHLyXIhxeMhkBvpTmAyLrMLh38Z3O616QKfBeq3iP6avjFfL3dhf6E
	A74wYz1GT1MJMeIN9PmFegyK+fDVCj8ZO+i+9Yjmg2rMdmtCxgfzPICRqUDPPjodR/sASYZfwq8KT
	YbhH/VK4P91d0dRdMx/d1MtBft0Rwt4V7Z/qcQjN/tzV18jB9AKQ5xbebJMyGdAwv39TA9mexaZws
	XIh4vkLpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVuwv-0002Dj-5s; Sun, 09 Dec 2018 09:00:29 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVuwr-0002Cd-56
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 09:00:27 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 71E8780845; Sun,  9 Dec 2018 10:00:04 +0100 (CET)
Date: Sun, 9 Dec 2018 10:00:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
Message-ID: <20181209090007.GD7561@amd>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com>
MIME-Version: 1.0
In-Reply-To: <5C06124B.5030409@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_010025_354900_D41B6043 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: mark.rutland@arm.com, anton@enomsg.org, len.brown@intel.com,
 Lukasz Luba <l.luba@partner.samsung.com>, m.szyprowski@samsung.com,
 linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org,
 myungjoo.ham@samsung.com, devicetree@vger.kernel.org, keescook@chromium.org,
 linux-pm@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, tony.luck@intel.com,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com, kgene@kernel.org,
 ccross@android.com
Content-Type: multipart/mixed; boundary="===============5083534928013763962=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5083534928013763962==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-04 14:36:11, Chanwoo Choi wrote:
> Hi Lukasz,
>=20
> Looks good to me. But, I add the some comments.
> If you will fix it, feel free to add my tag:
> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
>=20
> On 2018=EB=85=84 12=EC=9B=94 03=EC=9D=BC 23:31, Lukasz Luba wrote:
> > The patch prepares devfreq device for handling suspend/resume
> > functionality.  The new fields will store needed information during this
>=20
> nitpick. Remove unneeded space. There are two spaces between '.' and 'The=
 new'.=20

Yes. And that's because two spaces are okay at that place.

https://www.writersdigest.com/online-editor/how-many-spaces-after-a-period

Please don't cause unneeded noise on the list with trivial
comments. If the patch is okay, apply the patch, no need to find
trivial nit everywhere.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwM2ZcACgkQMOfwapXb+vKjzQCcCsUqmaYo8aPuD0m/JrfCBl2z
ZaUAnjMt+1X+vuWarQhgVM/LXGeYdeLw
=2woN
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--


--===============5083534928013763962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5083534928013763962==--

