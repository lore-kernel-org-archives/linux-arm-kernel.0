Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF71DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:01:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828792082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OhWiRrMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828792082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AtioPdZsYKEUjljX2dgnr6Il15rlcSfLIAb5kp+EbPk=; b=OhWiRrMMN5mCGPiIbrqgemvC1
	FUQAZ1RVFYbPthAIssduscVELUwzOsbgUZ6yS2uXPI8YS4X1tZ3lFjqIt87gUCr1B7Ons0PagyQYE
	9J8SZOYRNfn3XRmXxfdrSN/0ASEA0YhULH8JUeefcZDNVkgzIEuzsQxtY6d0ldmi/W2HAElQjzcuT
	Px7/oi/SiF1CKKoBoCvNUXRTypKNBkkur/ZTadn+xXwpyb6oxJLl0lmtcXanKxZeMOQodS5xFm++3
	5vajdq0i/c+4VfdXupIliYvT+oQge6IGqhq62rkBK6uSeqS6taszmn2bUrMAJiDVaBQAkHrurw9zt
	shqPUV2jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbTq-00052V-3s; Wed, 05 Dec 2018 18:01:02 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbTm-00051A-4a
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:00:59 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 9E7FA2725B2
Received: by earth.universe (Postfix, from userid 1000)
 id CF17D3C08D6; Wed,  5 Dec 2018 19:00:42 +0100 (CET)
Date: Wed, 5 Dec 2018 19:00:42 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Message-ID: <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_100058_445042_E3A7CDCB 
X-CRM114-Status: GOOD (  20.80  )
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
 Quentin Schulz <quentin.schulz@bootlin.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 oskari@lemmela.net, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============2331204595694017636=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2331204595694017636==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xnlkjubit7aft5id"
Content-Disposition: inline


--xnlkjubit7aft5id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 30, 2018 at 04:31:28PM +0800, Chen-Yu Tsai wrote:
> On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
> >
> > AXP813 AC power supply support with input current and
> > voltage limiting support.
> >
> > AXP803 AC and battery power supply support.
> >
> > Changes in v6:
> > * Collected tags
> > * Rebase to master
> > * Dropped AXP803 compatible patches
> >
> > Changes in v5:
> > * Return correct input current limit for values 0x6 and 0x7
> > * Add specific compatibles for AXP803
> > * Change commit messages
> > * Add Vasily Khoruzhick Pinebook DTS patch
> >
> > Changes in v4:
> > * Change order of axp20x-gpio in axp20x.c
> > * Fix indentation and spaces to tabs in axp20x.c
> >
> > Changes in v3:
> > * Reorder ac_power_supply DT node
> > * Rename axp20x_ac_power_set_property function
> > * Split mfd commit
> >
> > Changes in v2:
> > * Reuse axp813 compatibles for axp803
> > * Refactor axp20x_ac_power.c
> >
> >
> > Oskari Lemmela (7):
> >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> >   ARM: dts: axp81x: add AC power supply subnode
> >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> >   power: supply: add AC power supply driver for AXP813
> >   mfd: axp20x: Add AC power supply cell for AXP813
> >   mfd: axp20x: Add supported cells for AXP803
> >
> > Vasily Khoruzhick (1):
> >   arm64: dts: allwinner: a64: pinebook: enable power supplies
>=20
> Since this series has been fully reviewed, and the devices it
> adds/enables aren't critical, i.e. won't cause the system to fail
> if the drivers are missing, I've merged the dts patches for 4.21.
>=20
> Hopefully Sebastian and Lee will get around to merging the driver
> patches.

I queued the power-supply driver changes and prepared a signed
immutable tag for Lee:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/psy-mfd-axp813-immutable-for-v4.21-signed

for you to fetch changes up to 7693b5643fd2d682de90733b67fc8032b9646911:

  power: supply: add AC power supply driver for AXP813 (2018-12-05 18:49:32=
 +0100)

----------------------------------------------------------------
Immutable branch between mfd and power-supply for driver
changes related to axp813.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Oskari Lemmela (2):
      dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
      power: supply: add AC power supply driver for AXP813

 .../bindings/power/supply/axp20x_ac_power.txt      |  3 +
 drivers/power/supply/axp20x_ac_power.c             | 94 ++++++++++++++++++=
++++
 include/linux/mfd/axp20x.h                         |  1 +
 3 files changed, 98 insertions(+)

--xnlkjubit7aft5id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIEkoACgkQ2O7X88g7
+pp4IA//c/ChZY6UHh9Rulc+1lkt/+KeQcJh9PpdFVZFJqr0zC+5B6VtMGXartdt
lswJovpYhjmy4kXT06kqD0MmJHh29s+a76Fj4DV1c+uUglhec1AuRwFviGXBZg7y
ush9s2FgUsPl9JBlQdElJb06oEKqsPDZ5iRssPloJngzMFg3xLdunnLW59Vv5XBq
qg2umsW1UWKKtaSKnYQ8aSQ6wmNBOERPcvYkOjiPRL943Bn0Od73GVxcR0lOtWqR
8v/f7Ah8qtnYWm1QPdNO2O9Hb67/gF6GKhTjI9YqdNe4Qcmp1rVoB0PPVjAlBUBD
XZIvs5HT2YQaqtoFmkSfyHxovYbeu1bIe8ZNaZMF2++UVTRA9kB5pIy2ScMlvYmR
DwiwRSiaJ125tnR8tTtMzJGAnrE36EAT/C9fKhW3+uq7/b0M/pqjgaMorKNOCw6u
1VfCPY8vQN5ke5ib5My/V4HyHaRJ95OdlzOaRwZ9EqjSthOYk1IWx2ehZeTOFIuB
XNLvR1dt4PeyYqpK5G5NG87XCvMjkF7/YWRC+zRu1R8UYHzAFzJMQG+jHXbYd7AO
BGMFtO7cJ1eRcg6VfpigKrs6laFoaScKnhf/Y5yPrBqlkyw7WO35bYqaICush93x
5HfcOMuR/iDnHuNf1aIQRUWc928lq5gaykdewbaWluKI+b7o8aY=
=WNDV
-----END PGP SIGNATURE-----

--xnlkjubit7aft5id--


--===============2331204595694017636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2331204595694017636==--

