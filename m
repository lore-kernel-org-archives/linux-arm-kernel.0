Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:50:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B81D20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nZfkgfgF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KEWpR6Dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B81D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5y3GpDcZFCWeI+Ujlz5y8RS2Whl8qajv5sToyslf5iI=; b=nZfkgfgF+Cn4NYCgKVaoJwFEx
	ilDRuR3ShzB7RfY02LEVqJjdbONu+qjOE4QmPRKFtCGOQjitxSpxA/XmqIV+Usi5kFBi1bWVze29t
	Pi56Zb3dtPuUDij6CdqiEFDhAgj5E+GdyMYh+cgDRamd5aI6ik0ZqbzbMhZUfiJNUMl7hBvl5je0D
	bdf4EhXEZ/EvqTWIYgGnwxG5H7wCbPicANY7o/819QM7NgOhk1vJjPTEpv/vVGOemgiXYQuZ9XUuk
	Xq9UGJ2JU9rAejGc6SiGxxISlGepOwBH0F8riUAyHgsKpa6cLXIKO2OfvR0nVSnz6qHi1uwm8p7u9
	I+VWXj7fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlFF-0000Nn-3J; Tue, 11 Dec 2018 16:50:53 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlFC-0000Mr-GF
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=isMWD15qQr87vTtkiF3zofCCoSNNZ1+wQb6NKvF2/oM=; b=KEWpR6Dp9aAOjpslkDoRGInQl
 2+EVhrG3SDpcGHMAuQFvefqw6PF2xSJ+SoDPPeKmqBo5RMMdEGDIsjUk+fsRxvDl+4EL49RW7Liel
 X6N40R8JanXVPcS5IFWHDlsjR6HD7wSKXenxfNCPlJGAMwa5DQ9fDusZxGSLbkb55l34o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWlEu-0001HM-1X; Tue, 11 Dec 2018 16:50:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A3833112540E; Tue, 11 Dec 2018 16:50:31 +0000 (GMT)
Date: Tue, 11 Dec 2018 16:50:31 +0000
From: Mark Brown <broonie@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
Message-ID: <20181211165031.GN6686@sirena.org.uk>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
 <20181211152311.GK6686@sirena.org.uk>
 <e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com>
MIME-Version: 1.0
In-Reply-To: <e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_085050_684652_90FA854F 
X-CRM114-Status: UNSURE (   9.02  )
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
Cc: kernel-build-reports@lists.linaro.org, catalin.marinas@arm.com,
 will.deacon@arm.com, Wei Xu <xuwei5@hisilicon.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0424068436455635510=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0424068436455635510==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 04:24:10PM +0000, John Garry wrote:
> On 11/12/2018 15:23, Mark Brown wrote:
> > On Tue, Dec 11, 2018 at 05:10:16AM -0800, kernelci.org bot wrote:

> > >     defconfig:
> > >         hip07-d05:
> > >             lab-collabora: new failure (last pass: next-20181210)

> > It takes an oops during IPMI initialization:

> I have seen this issue previously. It would be specific to D05. I think that
> there is an issue with the FW in this board, in that DMI reports IPMI
> support incorrectly.

> Could we add a kernel command-line to avoid IPMI detection from DMI,
> ipmi_si.trydmi=0

Copying in Guillaume who can hopefully help with that (and who I
should've copied in originally, sorry).

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwP6tYACgkQJNaLcl1U
h9BprQf/Qhm1TpJxB9lRKYhwXBO+6f9OPGpMCt1VLwDGXoaImKkBTS19lfRQfQ3X
x125wur7lfjJvIrqmCW8DOQ9hIphk86uCicxfxJlWPAoKTB9nsk2CyIQ1YFFN9rM
2YfpaypLSUSJbA3UBkzAJqNNkibWIYta96BW8BJUkN4BB5VkEXWwgckkO4Xwt8UV
evoX28nc/9uQanvoG3EhM8X6J/8aJFbeFJsOhpUv/8eEwG56ExTmtLWy8gyCb6OZ
OO9sjRs6ElCTG9b9c/Xcv71WzfYOAVAVuBfa10WjS8Tcw/Fsch5XQj6PtEnQ6RJP
2o067xD27ebjw+B88objkcbZZapz3Q==
=aplj
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--


--===============0424068436455635510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0424068436455635510==--

