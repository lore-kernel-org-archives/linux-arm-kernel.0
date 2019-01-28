Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A04C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CE5214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iZooiXJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CE5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/mZs0+BXYxovnenJTUw7Irc1rjhCMLCDjBdIDbJxcw0=; b=iZooiXJ0fFIh7SoPBzfOO+oT5
	BM7LPsfHMz1yU7CM4kOeD7U8fzhY9BR9z1Wnkae2FT92OM5EnC99/m1GfZZ41zv5KnDYZVcmR8yhv
	ftR5bwxrCk6Z0c7uv/jvStYmfZR6P+N2R2Xu1PXBUxgXxk+loLgiK7Mcrb+KbBzLf2nAF2A5+mn2+
	BF+PMBfszBf77G4dod90EDmAz4IYYflwmMmp94+km5rifPc8SnIhumTP94Uv/HfsknTrxxHYfRaxG
	dFYF4k3V5+MGMyYIZfWG5v49DaQNA5rDim0k2kx9PoCLODvKE2TwJHhz6z8qX4plhiOUEX8of/A5+
	qbznE0Gdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Jd-0002HT-Fh; Mon, 28 Jan 2019 10:38:57 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4JZ-0002Gq-NQ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:38:55 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 985722078F; Mon, 28 Jan 2019 11:38:44 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 61011206A6;
 Mon, 28 Jan 2019 11:38:34 +0100 (CET)
Date: Mon, 28 Jan 2019 11:38:35 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Message-ID: <20190128103835.ibgze6vbkk642dkv@flea>
References: <20190127145054.3770-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190127145054.3770-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_023854_032878_28E23903 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7614058178885072449=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7614058178885072449==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7z7natm2nbelfsf6"
Content-Disposition: inline


--7z7natm2nbelfsf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:50:54PM +0800, Chen-Yu Tsai wrote:
> gpiod_get_value() gives out a warning if access to the underlying gpiochip
> requires sleeping, which is common for I2C based chips:
>=20
>     WARNING: CPU: 0 PID: 77 at drivers/gpio/gpiolib.c:2500 gpiod_get_valu=
e+0xd0/0x100
>     Modules linked in:
>     CPU: 0 PID: 77 Comm: kworker/0:2 Not tainted 4.14.0-rc3-00589-gf32897=
915d48-dirty #90
>     Hardware name: Allwinner sun4i/sun5i Families
>     Workqueue: events deferred_probe_work_func
>     [<c010ec50>] (unwind_backtrace) from [<c010b784>] (show_stack+0x10/0x=
14)
>     [<c010b784>] (show_stack) from [<c0797224>] (dump_stack+0x88/0x9c)
>     [<c0797224>] (dump_stack) from [<c0125b08>] (__warn+0xe8/0x100)
>     [<c0125b08>] (__warn) from [<c0125bd0>] (warn_slowpath_null+0x20/0x28)
>     [<c0125bd0>] (warn_slowpath_null) from [<c037069c>] (gpiod_get_value+=
0xd0/0x100)
>     [<c037069c>] (gpiod_get_value) from [<c03778d0>] (pwm_backlight_probe=
+0x238/0x508)
>     [<c03778d0>] (pwm_backlight_probe) from [<c0411a2c>] (platform_drv_pr=
obe+0x50/0xac)
>     [<c0411a2c>] (platform_drv_probe) from [<c0410224>] (driver_probe_dev=
ice+0x238/0x2e8)
>     [<c0410224>] (driver_probe_device) from [<c040e820>] (bus_for_each_dr=
v+0x44/0x94)
>     [<c040e820>] (bus_for_each_drv) from [<c040ff0c>] (__device_attach+0x=
b0/0x114)
>     [<c040ff0c>] (__device_attach) from [<c040f4f8>] (bus_probe_device+0x=
84/0x8c)
>     [<c040f4f8>] (bus_probe_device) from [<c040f944>] (deferred_probe_wor=
k_func+0x50/0x14c)
>     [<c040f944>] (deferred_probe_work_func) from [<c013be84>] (process_on=
e_work+0x1ec/0x414)
>     [<c013be84>] (process_one_work) from [<c013ce5c>] (worker_thread+0x2b=
0/0x5a0)
>     [<c013ce5c>] (worker_thread) from [<c0141908>] (kthread+0x14c/0x154)
>     [<c0141908>] (kthread) from [<c0107ab0>] (ret_from_fork+0x14/0x24)
>=20
> This was missed in commit 0c9501f823a4 ("backlight: pwm_bl: Handle gpio
> that can sleep"). The code was then moved to a separate function in
> commit 7613c922315e ("backlight: pwm_bl: Move the checks for initial power
> state to a separate function").
>=20
> The only usage of gpiod_get_value() is during the probe stage, which is
> safe to sleep in. Switch to gpiod_get_value_cansleep().
>=20
> Fixes: 0c9501f823a4 ("backlight: pwm_bl: Handle gpio that can sleep")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime
=20
--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7z7natm2nbelfsf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7bqgAKCRDj7w1vZxhR
xfndAP9l8ziOquk7/+im/vyCRkkkx8BUdtaHT/UNrJzybBggygD+KZOftP3cZ5As
vpNwIM8ohyvw0yMrbuWWkz0rJvxKDA8=
=tEBo
-----END PGP SIGNATURE-----

--7z7natm2nbelfsf6--


--===============7614058178885072449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7614058178885072449==--

