Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:52:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C902921741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KLeOLRgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C902921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pLycoVtNzCcnkG+D7uIMouEF40EO1Za8FsFv6baLZ5M=; b=KLeOLRgk5Yyx7xM2EG4CWoUHo
	iS0GeZ0Xeri02Mn3T+DjHW6XdNZG0kmARaxd9p89/L1nGK+kQ1qIRk3UZmLC0xa2I0vRWeUqY6SWc
	R5z4RJpVs9Xv6XylRrb6+Xstnmm2+Um4Jpp8eac3FB89vi2TZwZpqi1bwzFv6MKRnpyPohTobi72A
	A58ALXEU+HWb2hsTRIxR4Y37NHf09l061Ncw47TMtanmPpgphUKL0jtgjYI0bmnqmGDim3VtI9Wk6
	MF9tfWPyAVw3yAD3Yg7tIHOiXbtorL/C0dAfbNDBzp8i3SAmWrG/Fn/h3Rx/vvyLk5rW9tNSmG9Tg
	H4HopCbZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcgNs-0002q2-MM; Fri, 28 Dec 2018 00:52:16 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcgNo-0002pQ-V1; Fri, 28 Dec 2018 00:52:14 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 93F8E10A2767;
 Thu, 27 Dec 2018 16:51:57 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id JHQeTyy0c9y5; Thu, 27 Dec 2018 16:51:56 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 3CB9F10A0EA3;
 Thu, 27 Dec 2018 16:51:56 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id C99AF2FE36F3; Thu, 27 Dec 2018 16:51:55 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH V4 2/3] ARM: dts: add Raspberry Pi 3 A+
In-Reply-To: <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
 <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Thu, 27 Dec 2018 16:51:54 -0800
Message-ID: <87wonulbh1.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_165213_041869_D7B42C52 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5664278743474050857=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============5664278743474050857==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The Raspberry Pi 3 A+ is similar to the Pi 3 B+ but has only 512 MB RAM,
> 1 USB 2.0 port and no Ethernet.
>
> Compared to the Raspberry Pi 3 B it isn't possible to control BT_ON and
> WL_ON separately.

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwlc6oACgkQtdYpNtH8
nujEpw/+OSvYCHuNDF4JtRArp9tmrKbu0q/srr/KksmBLsVDr9VUhY6TBgv2CkFP
2l7ONPb9fnP746Y6MUxvw+9s+lyS8gYLcymxYSBcYiaaQQp2w/g6CBBwcMLUyzX3
JvWoslX9DxHAbi7ISwWi3GJERnIzZ/rchU9vCYRuyk9FyhwUymVG+I+ExhFDOxBU
MRm11nRVr2cGBRbB4WSylQF14agNYZHuF1BUtHIizosZF05SNqdqYAAtgWofhb+7
dWOPkSM7Nis3PQ6g8r9pkZtB9UNEokKX08PdF4jfEGtOH528SIOIDcUVK8Bi45jW
CQBOMHHdNsp6oCaTuf01I17hkjdHYCx10BluvOkYy4cWuqL9+Q35wbYLcefTr583
Ni7QrJtOJPVJyPpqCrSvLo4qV1X43bp3mfLYUwZPDvftW2AoQLaITSDRG5ewaHDY
/tjhP7jj15W3mtzRf2wI/iHU46aLltiLICLUgfM+At1DG1iCWsT0O6zkoPnMO8Cf
NgS8ChS221vTVu4Xa0nuk9WoIAeGClp7fwqiU3r8zo6o9Rkm5eBTY7gwqk1jgv3z
PzaPpIRmciOjlwlTTvEucJ7QAMxnHKIjNrEex6CARwXAgdx6DQM6rErGWthDgg2n
7Q+CnNZp4By+IB+o7vWF+PPOszsyrZXne1e27Gnvwuf8b6zbYk0=
=6Pd0
-----END PGP SIGNATURE-----
--=-=-=--


--===============5664278743474050857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5664278743474050857==--

