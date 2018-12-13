Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD93CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:00:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A42C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4w+uxnQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AKt2sLab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A42C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EZPcoUEK2/u0UeQztrCZn3e/wXJbwds6q9LzO886U6I=; b=m4w+uxnQ/K4/+/nNsI9tu1wSp
	AX2ddTfmUrs2qpJrzxn9N+djdPJgA1t5+EqdHP4vL8PrBZ0OSEETtvaRN22UETLGHnehTZPmjskEy
	pXevP1UVNxhe6npeCL5K/i1ER8No/SWvjIqpmLIbu/JAVC28bZNVsILowRJPHa6ko/l7r9K6M54LH
	cDL9amegjA3rIwS5o5Wbtixi/c4hTWoNU1SBDLgSn4FktworfVudwUag6lPgyg9kjjj0j+A7alBIr
	wHqwE3cCUjLedfczH8bvNFJxJc47t54qJ3rxFawT78r2IUuJWr4vV2N+sZdlYINakFjisZcFmD7mF
	mfIPa4qZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOjY-0001Vo-60; Thu, 13 Dec 2018 11:00:48 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOjH-0001Fm-Iw
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R7t/a0l9pYtVhFO4YWRg31SYlHx2hjV+7ED37DZGW04=; b=AKt2sLabKhwGFMxUa5DfNEDiU
 O31GysQtnFn5+Y+lC32GkfribauuQGMOTfgHgaTA+wiNsB3voMgbOkuZ47UZ+ZBA+YH0WnWKIgjVX
 4F1MWIZHqZASAw/kD/l70IvLKzKqhXZe6pFVVk3+FTl5ioelWfrxGKSzuNgDt6yRu6bso=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXOj1-0000ju-Vq; Thu, 13 Dec 2018 11:00:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A236111254C5; Thu, 13 Dec 2018 11:00:15 +0000 (GMT)
Date: Thu, 13 Dec 2018 11:00:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Message-ID: <20181213110015.GA10669@sirena.org.uk>
References: <1544647253-3806-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1544647253-3806-1-git-send-email-festevam@gmail.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_030031_841366_456155D9 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: alsa-devel@alsa-project.org, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-imx@nxp.com
Content-Type: multipart/mixed; boundary="===============0737697408378059355=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0737697408378059355==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 06:40:53PM -0200, Fabio Estevam wrote:
> eukrea-tlv320.c machine driver runs on non-DT platforms
> and include <asm/mach-types.h> header file in order to be able
> to use some machine_is_eukrea_xxx() macros.

Oh, I actually just did this myself as a -next build report was earlier
on in my inbox.  I'll drop it and apply your v2 patch instead since I
didn't push out my change yet.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSO74ACgkQJNaLcl1U
h9DzVwf/dJaB3XWFAyc6SOb2d0EMkLrkqtQv+pCT6G1WOy/4lhvXGZcypdv2H+O4
UyISUWACrkIAzxcGhS6yg06UjYO0vUk7fV8E3BCHC8oJmt0o1iyA+I0hZBuxwZ5F
+//Ri+qi/jpqWann4fP+3DqSnjeDvgOSyT9JI3iTNX/69tY2/FYjRSLIJValjA9d
/C2KuQ00mgdTTpXC+qb5VTzadE6wc4NbwIEDdxK6wQF+8QEKiSATOiMzkVxmpcZb
Qo3VR/93ymkQLoGBS1XZA6y+0lICaUs8ol1BA5WzCCENZ56GJqQWgP6En0HLv2hA
4recRwkIIvESySLpz3v2FvIVRg/qlw==
=TUDJ
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


--===============0737697408378059355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0737697408378059355==--

