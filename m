Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1334EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C6A20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lrfukKG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C6A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=miPxFgP9lnuWiboz32ZuJvEIEmjkF7vC8txJjyMkOmU=; b=lrfukKG00+AeraoLX5ZaP59VT
	3HwAGP/2lmQxnIB27dvstEl7mz45b6qoNszUrDprjfJRdQwcjEx3QQbJYXRV9jTCA+YdN6ziI58M5
	LuvOdeaHGml0Vy01RePlXnNhDBkFXtyqZD7lurUfzj4ESKMznrjtnSzpjIAwhdndPMcg3zEOTsD1f
	3Jkp+CcFo4XzqiE3qWKaQUXmS/R0wsqWKPPZML4IO45E5ukRrta5d4F6JScdJp5cEHfpIQGyRqIgZ
	K7Uu0mLL+PJchN8fgKSjC+ZMxTJ+5hmqYPJJfW4hvCmcuikF1j9ZFtnwPvtGZXXC2+QI3vWnrC7Dc
	Ce9QEQLPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtOx-0003vl-AP; Thu, 06 Dec 2018 13:09:11 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtOo-0003up-2H
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:09:09 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 439bX117TLz1r8W4;
 Thu,  6 Dec 2018 14:08:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 439bX05zPYz1qst5;
 Thu,  6 Dec 2018 14:08:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id xDE9ppMOprPV; Thu,  6 Dec 2018 14:08:47 +0100 (CET)
X-Auth-Info: NojaainKu6o2YUrIUvBLiPLKL4pPpo1gPXk7DbiLVlY=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Thu,  6 Dec 2018 14:08:47 +0100 (CET)
Date: Thu, 6 Dec 2018 14:08:40 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181206140840.53d49cd6@jawa>
In-Reply-To: <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
 <20181206092255.2359f7e6@jawa>
 <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_050902_261041_9E894443 
X-CRM114-Status: GOOD (  13.60  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============4290533773628228719=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============4290533773628228719==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ"; protocol="application/pgp-signature"

--Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> On Thu, Dec 6, 2018 at 6:23 AM Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > At the time of development - I've checked my NXP related patches
> > with W=3D1 passed to make. No warnings observed then. =20
>=20
> In linux-next the warning happens without W=3D1.

I will check this latter this week...


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwJH1gACgkQAR8vZIA0
zr2bcgf/ZQO9ux6TS1P3o6t1LwXRUeqAlF2ZiRhx85OpxJ2V2UyBgX/QYFTcFCOU
1PfoE3JHZiHWlenl5Nk92994ryNWuaqrPkQN1UfEausOzdiSpjZ8GAFAPlPWz8C8
41f7StzyUj1a5/UPK6uCc0BeLT3Zj2SaI0fz6VWuuTwzdlETlCFyHze/lDjkuKI/
ZzA0B5dPZENo/n4IkFT5j19TRv4ToOU3AV9cHdoFNslEd4dk5+erUJ8BwaScuZO7
Bgrf7TRKJmJiLXmt3otChel+1+J2+J1ZST4PC14+aTE8MKPJN78jJEPRAMVzV4Ts
jsUkz5qdGCAEkCdLg0g9bpzkr2DJiQ==
=D1rb
-----END PGP SIGNATURE-----

--Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ--


--===============4290533773628228719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4290533773628228719==--

