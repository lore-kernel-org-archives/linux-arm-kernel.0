Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A246206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sXDANmgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A246206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SWLpTmv+nQ9Uo+VIVn53km/EJGqqY1Vr86fRT7uMt5k=; b=sXDANmgE8zXcE9uJseHtg0569
	/g4+ANd8Dt2ONc1FO71RcQFILVfVJeX0wBEJZnWUODHNG3wW2T/04ugbgfdM30cx8VVg1YUDH36AT
	wHk1+MQFjMY9ERJg2JrwQYFIGmvyeXecRR+Rpjts0WtwvgtPzQkTykTcG1PYjxebveS/LvhUPVrNy
	+ZTbJ5aGd4RnA/VTOpg4FsqsiyYvgqQey5quQTkcR7id+TbMz+if3GKemYd3IWatu2Lxr5jVZCh6/
	wFpqOkbOnMTEQSx5YWVLCimi+3b45j17N4lTiEM3ChvgZPYND8RjEAXObXMF41RKDeSQpMP82oN3g
	YJSNLLeFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEcm-0005IA-4q; Wed, 09 Jan 2019 14:14:28 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEci-0005Gz-M0
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:14:26 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 21E3B8094D; Wed,  9 Jan 2019 15:14:13 +0100 (CET)
Date: Wed, 9 Jan 2019 15:14:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Message-ID: <20190109141417.GA8529@amd>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_061424_872922_CF163430 
X-CRM114-Status: GOOD (  18.54  )
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
Cc: len.brown@intel.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1429352504956176774=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1429352504956176774==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support to check if platform's power will be cut off in suspend.
> This will help drivers shared by multiple platforms to take only the
> necessary actions while suspending/resuming (some platform may not need
> to save/restore all the registers if platforms remains powered while
> suspended). In this way suspend/resume time could be improved.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/linux/suspend.h |  6 ++++++
>  kernel/power/suspend.c  | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 3f529ad9a9d2..21f19b167fe2 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend_=
stat_step step)
>   *	Called by the PM core if the suspending of devices fails.
>   *	This callback is optional and should only be implemented by platforms
>   *	which require special recovery actions in that situation.
> + *
> + * @off_in_suspend: Returns wether the platform's power will be cut off =
at

wether -- spelling?

> @@ -185,6 +188,7 @@ struct platform_suspend_ops {
>  	bool (*suspend_again)(void);
>  	void (*end)(void);
>  	void (*recover)(void);
> +	bool (*off_in_suspend)(suspend_state_t state);
>  };

Dunno, should it be per-regulator? SoCs commonly have more than one
power supply, with some of them off during suspend...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw2AbkACgkQMOfwapXb+vLmQgCgqAUamz2/knUA9Lf1Tl4BAceL
vXEAoIbw66S7wi6alwJxvhCaPmHDkJyA
=BZfz
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--


--===============1429352504956176774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1429352504956176774==--

