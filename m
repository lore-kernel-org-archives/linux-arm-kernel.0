Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0557EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6C02084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FXNmqPPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6C02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f4tmbgunsgstuhn5xglXONRx+hsnUUggGrsstvJBbc4=; b=FXNmqPPr/WSeGaqqzSc2e+MQ2
	x0balFVnugDsy1+LpfAjGVhu3obI9XbCgjaAeyOoy/UkSOEZlAoliu+ezVt4MQpm+BzEdob55YGuZ
	QnAtColC2ntvmoT7t9iiH3uw5Z6h8rZddgbLZYEoDuHV7oMjHaefUFFJRv2Uphren1A7qBTaNbVtl
	GD0p4tTjER80LLWDQy/eg/0casTQzx4SbEBsViCkMja3V3PCpSQeqMZyVemJCT1LNtk5N8cOnKzMq
	dwbQwSzHvvAjZYKQvhJztJzJINyxxx89ae8kvJHHhLWjNi5EHLXrlOspBL4JR84ZpdpBVZxurnfi8
	ryQAkXx+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbCz-0004u1-Dv; Wed, 05 Dec 2018 17:43:37 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbCw-0004tB-Ev
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:43:35 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id DE92D2700D0
Received: by earth.universe (Postfix, from userid 1000)
 id 5ED383C08D6; Wed,  5 Dec 2018 18:43:17 +0100 (CET)
Date: Wed, 5 Dec 2018 18:43:17 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH 13/14] power: supply: axp20x: add missing include bitops.h
Message-ID: <20181205174317.wm5wuxrhy2tbkjih@earth.universe>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <9547ef8e8e6fe9f933264119bd186bdd83974999.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
In-Reply-To: <9547ef8e8e6fe9f933264119bd186bdd83974999.1543245984.git-series.plaes@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_094334_629748_7D114486 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, Olliver Schinagl <oliver@schinagl.nl>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6545995695566778127=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6545995695566778127==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6r73kfzavaa5p2y4"
Content-Disposition: inline


--6r73kfzavaa5p2y4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2018 at 05:27:54PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> The axp20x_usb_power driver uses BIT() operations but lacks the include
> for it. Include the bitops.h header file.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 42001df..f52fe77 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -10,6 +10,7 @@
>   * option) any later version.
>   */
> =20
> +#include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> --=20
> git-series 0.9.1

Thanks, queued to power-supply-next.

-- Sebastian

--6r73kfzavaa5p2y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIDjIACgkQ2O7X88g7
+ppZFg//W2oPevm8Wr3ZHLF2wdiahU1to0KiH0CWpU1x3nQILUUq9PDsX3y98tng
1DINy6cuzj+ikTkuQz7fvqfVDIx5vphKA/8M+XmhkjtnC0qm7ExnUUGY2+7ZQJ8c
UT+M04fk7/OnV797OzZbuXlC7pixYXLfSAR312RZBuh2h5pO8jUOpaCofhkm5yuh
eQaB84w4FWLfTg9jTkfoA0IrOVYPSYH3mV/q+dew9IWEXh3lQhgagR7KAmr2tzLv
kHxCvOAdUYksAJvCZJ2cibhoD1Fn+N8HuyjipXAgracM70cjfUq0OZb++3yDUbeD
9oJMOW42aheaChUQvHsnRtEeUJLlEvD9OZLmqF2Fxc1g3gitStnTqFO9q0m4/S/3
60xxKoq3wIOpSLa/neMmyvstWjd/704O5fpQFqufitWxb4XNwuxx1wGIv5ch/XT8
HjsG9HYFQhG/Rx1v6t5uBL3aUXw3cY+zdl6hnyKxuRL4SMRR0pGoaQvMdv+Jm7GA
r1QPmY3+9/SGUa3xBq4WoglvrSLFKNlQ8hEuwRSeXOrhW72WLPIUbd69jAgexhDh
M1ZFjg7DiI4UPD4rfQNqKLkZ40xlCaf0ely4uC8aHpQLLznE0MQDCEMiad26Xw3P
YqLcoUybwdQNlVTs5W4vjIzxtkOVWk2V5LcCnXUMN3cuze43/N0=
=tgm4
-----END PGP SIGNATURE-----

--6r73kfzavaa5p2y4--


--===============6545995695566778127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6545995695566778127==--

