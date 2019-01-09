Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CE1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:59:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5B8206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cepJCxZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5B8206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=afXS9ZaOsPyedmNnROz89KhhT90tgc6uJFIW45y+YuY=; b=cepJCxZv7ALsVlmrRfpvJta4I
	89vU9LZSwMRh/74WKxNt15pLAK73VsDHBA6Qq3yuUWgmmykWMvgNDx/jS4/DI6qMHerZvVH3fIvfW
	KVYf7++GmNbZQlBpPSv9AzdFY25v2FHfZve7mdGigrALBl80zhWqJIx8nNIVvr0C4eTYUKf3Wk9s6
	7nvfETyF2WW6iTohM1kkvBIxzqwtciqulDIeK1+hXOBUoD0y2wEcXp6c5/xTo6GLBLdfmMNfAXvAp
	weCxoHCH8Tdw0QCO4D5HP7fSVHxVm+PmrgvcyIHuiBJK3h0DVJH5hO48b1pSlICSJmJSL9pSCfxIu
	RIPjVMMeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCVV-0000fM-Fc; Wed, 09 Jan 2019 11:58:49 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCVR-0000et-Hw; Wed, 09 Jan 2019 11:58:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4D823ABDC;
 Wed,  9 Jan 2019 11:58:41 +0000 (UTC)
Message-ID: <64799d4495a4cbc43c3a8f61afda17a0ae70c2fc.camel@suse.de>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Stefan Wahren <stefan.wahren@i2se.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.org>, Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 09 Jan 2019 12:58:39 +0100
In-Reply-To: <537778454.382280.1547022816273@email.ionos.de>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <CAAoAYcNJdzJW9X=hr5+5oAFWcVUexwY9zGQ_-T9X-M89jpnipQ@mail.gmail.com>
 <537778454.382280.1547022816273@email.ionos.de>
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_035845_737677_6845AF74 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>, tiwai@suse.de,
 Greg KH <gregkh@linuxfoundation.org>, mikebrady@eircom.net,
 Eric Anholt <eric@anholt.net>, "moderated list:BROADCOM BCM2835 ARM
 ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0873753435857482417=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0873753435857482417==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Tl3YcpFtQvfgVSoy1OVI"


--=-Tl3YcpFtQvfgVSoy1OVI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, 2019-01-09 at 09:33 +0100, Stefan Wahren wrote:
>=20
> But i noticed a regression introduced in 5.0-rc1, which might be
> related. I
> tried to run "vchiq_test -f 1" and it never completes. After
> reverting commit
> 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
> vchiq_test [1]
> works as expected again.

I had a look at that one, it seems that it's due to the fact that vchiq
relies on completions only sleeping whenever their internal count
reaches 0 (it's incremented on every complete()). As opposed to
wait_queues, which will wait until an event is triggered regardless of
previous state.

Regards,
Nicolas

--=-Tl3YcpFtQvfgVSoy1OVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlw14e8ACgkQlfZmHno8
x/63Qgf7BMUVlAerDE9bM0mOVzDcOhe6Sh1T/4gVngHLqlwhpKytJBZIe3/pCk8Q
08h25nh8uxxj5AjoxbrsPFgHiptVzsU8VV0z+5CvO0qxaSRN3T2AfloeiCSQJ+8C
NxG4TwR+OO9iBteydbB/rW4Q23hBVjCCHYMeEpra6jVPttqyXm2RUpi+jl8qx0su
1AudOBnna1q3K7Qeza33PEvJHox7SFJIG8NmvN7OrjtQYHJMtk10g0zzrT1MaxXq
QytabylVAZs6eYFh95ias+GzM5VxKVFvsr7loBelb+ISpSxO278qElNGaWH8dFU6
ReQD9FJWAyZMzXekSAKskO5PYUyx/g==
=6Hsv
-----END PGP SIGNATURE-----

--=-Tl3YcpFtQvfgVSoy1OVI--



--===============0873753435857482417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0873753435857482417==--


