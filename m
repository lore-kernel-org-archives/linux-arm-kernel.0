Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:53:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECDC2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0npnvUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECDC2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rtNkG6n51mqxmtj/vs+j+7hbiYVJoLwqyGLaj3ykZcg=; b=I0npnvUA1hX/XPeLz6AFA9vpX
	2bv645juy6DMNjfoR9EigFZnOnABJDEJf0xC500BTYniJC3Y8iire5V6Fqxaye8lJfuUjzkBv0xQe
	0aNjhCqjgYihvBN6QzlDdNJ+290eCqX1Q66H/XbWSqYxIMiezvO+6Ke7r0pWkNqGLOgAqjUwshYQb
	/v58Nr3QeT2AuuVKuSMw09rT2zxRhlOd7+J3NMdu5slC5wri96jD2+ytEJg3Ug1j4oiMYCbSQwDMU
	alWJTH/IiW1lmFxvuh04nRpxvIzcr3S1hK2J++hYFb7HzSGDlBTeIx0OdY5hSowCXMhtwOh6SAtgT
	9VXHEHkQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNJC-0003sG-BC; Tue, 18 Dec 2018 21:53:46 +0000
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNJ8-0003dT-50
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:53:43 +0000
Received: from [192.168.4.242] (helo=deadeye)
 by shadbolt.decadent.org.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1gZNIl-0001cm-92; Tue, 18 Dec 2018 21:53:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
 (envelope-from <ben@decadent.org.uk>)
 id 1gZNIl-0007b3-3T; Tue, 18 Dec 2018 21:53:19 +0000
Message-ID: <99adb77f832374d66fa6796b481fe5abe79d48d9.camel@decadent.org.uk>
Subject: Re: ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko]
 undefined!
From: Ben Hutchings <ben@decadent.org.uk>
To: Helmut Grohne <helmut.grohne@intenta.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, 
 linux-arm-kernel@lists.infradead.org, Paul Durrant
 <paul.durrant@citrix.com>,  Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>
Date: Tue, 18 Dec 2018 21:53:14 +0000
In-Reply-To: <20181218093630.io6p4ovl36hnxalk@laureti-dev>
References: <20181218093630.io6p4ovl36hnxalk@laureti-dev>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk);
 SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_135342_343188_7BB0959B 
X-CRM114-Status: UNSURE (   8.73  )
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
Content-Type: multipart/mixed; boundary="===============0075614244755177058=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0075614244755177058==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TKZkZrbWvHoVTVonDV6g"


--=-TKZkZrbWvHoVTVonDV6g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-12-18 at 10:36 +0100, Helmut Grohne wrote:
> Hi,
>=20
> During a compile test of v4.20-rc7 for armhf (cross build), I
> encountered:
>=20
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
>=20
> Some searching brought up c5157101e77 ("arm64: mm: Export
> __sync_icache_dcache() for xen-privcmd"), which fixes a very similar
> problem for arm64. Is that commit maybe also needed for arm?

Yes, I submitted the corresponding patch some months ago:
<https://marc.info/?l=3Dlinux-arm-kernel&m=3D153134944429241>

Ben.

> Helmut
--=20
Ben Hutchings
Anthony's Law of Force: Don't force it, get a larger hammer.


--=-TKZkZrbWvHoVTVonDV6g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwZbEsACgkQ57/I7JWG
EQla+g//SlB0GDx/M6RmoouaufuIbwDzn13i60NYF3LsjcHSc1UPOF81nXUs+uRX
rh/Op4cx9fk9qCDoujBc7QB8/f2WUYcppqmJg3hae7iMrwQfHTfsMX6DNvWW8ohL
2wKPWQoYC9fFkuBgoOkidBMFTEn5FDQXQCH+R2wZosx7vjSplWfGZ3920YSILQmf
tXWtGcE/XDAboppLr3yGGkSZoKTf6YTPIOGRA7Mca5D/pCepiTUJS5P3cVgQWJsB
HP12ctOZQFDHI7azCzdaSbFIuv0bV2c5yQC+RApn3aXf2ti0Ndqcd8o8MGzIRmWS
U9oG3+uxHVzT204VWPoAVMbeGlojdytSZoBTWShfxpFNv4iS4eiY2cOXZSPF5A+w
Oqwcl827iFfiq6htsdtry8fQwx4UmHDoJ34kQjHRjbmwZfzcOyrGE4SioIUF/okY
0py5GKOSoBN2jn0Bzqibb+oDxW3UbEUghzhEnSqBIHAEj8hs83S6CWS3gNhBGnDM
jMWvfWR0uzlvMXfCMl3+hVSU3gBpnVRPVIrpd0N4WKLyzdsPtBOw39/YTgh4KQ70
mCqpWs1DJajkikZ0plfz+J8vM4q2ufD1aqAfS8b0f9ho52h3nt+vvOe/y+kGpvUL
jEM6yoSzCYbn5wFuw1F3Q5AjlM7RWOAAfrznLDQAqu8iI0vZtCg=
=DKaO
-----END PGP SIGNATURE-----

--=-TKZkZrbWvHoVTVonDV6g--


--===============0075614244755177058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0075614244755177058==--

