Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EADC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:58:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1B62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJgy7fqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1B62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QSxaVbUh//zBA2PXNm2YZoCVr6/v3yQamxkGAnHk9yI=; b=SJgy7fqpupfqJBLfgn3ZcVpKn
	7ZbR3yOlhDPO1vCodBM+9VdBq/h4QpqetwUjL4l8BvyR/8X5IdmrvBKacBNWvgqR7WA5JF6o7/mee
	wTNlqcM13Ml424KPGcbfFOVRFse/jn2lkSFA/RlqhBZ26ocQGfZjFdKe8dx/ARLKJlfuxs5G/1Quf
	mYujw4zcbOZWf/NySpoULB/Z4MNY60xXDEzUHvYW7VmKUx37im8RDW/JbOSLjxveYkbJUiFUAJgqc
	7RERqwK7rhVVceAfAzT7OU+yayG5ngowDW9zIDV6vhj9+8/cKIOyO9DMOPN/1656cmm7Jbep/ILRo
	gpbDuHedw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHOx-0003HK-HR; Mon, 10 Dec 2018 08:58:55 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHOt-0003Gm-D7
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:58:52 +0000
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
 by pokefinder.org (Postfix) with ESMTPSA id DF0364C0ECB;
 Mon, 10 Dec 2018 09:58:39 +0100 (CET)
Date: Mon, 10 Dec 2018 09:58:39 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RESEND] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
Message-ID: <20181210085839.GA1087@kunai>
References: <20181015105517.28032-1-wsa+renesas@sang-engineering.com>
 <20181209215154.GB5856@kunai>
 <CAMuHMdVpRYSCyho4n2R8p2s4WV1bXv8MM4VbMA9NVJjwT_rHzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVpRYSCyho4n2R8p2s4WV1bXv8MM4VbMA9NVJjwT_rHzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005851_601797_207FD600 
X-CRM114-Status: UNSURE (   8.22  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5983276946482920163=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5983276946482920163==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> Probably you should contact Russell's patch system, instead of Russell's
> human email instance, cfr. Documentation/arm/README

I didn't do this so far because rmk's patch tracker says "please submit
all patches to the linux-arm-kernel mailing list for community review
prior to submission here."

But hey, you reviewed it, maybe this will do :)

Thanks,

   Wolfram


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwOKroACgkQFA3kzBSg
KbZhIg//U8D/6eZansCo8ThWXiqp8T4e50lcEamX74ldFvAXP0GRW0+tE5L64JcR
BetFEQXY2gpfSGWLXunupNbJiAeX6PET46aa3p46NDqHbcTLF7asP8s0xLAOLQmh
qIaAB6DROsnf8HYS40SSYvNkA7dZhXcfG/SS/BK/B21M3B3apvUpsz8Jv9+poDiQ
OJirDHdN+93xCjkP0fFvA+f7tRXTzlfThzZpOfkxk/g8B34nB8DEVcKjE0LejRu8
cJDPxMLSBPnoXH/7Jmy85RtMArDu52K7l8MMUgYeAEATIqG6v39MeF/55asED/MU
KFbHYKDBVe7XiAP27eXOkFCWavP1SIfMZehN+vEPD+yLA7CxSskWkfJ1leIZIQIX
Qy/Ld+2ryBiWPXB8H5MFSeiqSMY99sb6c/zX2RsDBQisnYGGY/mqFIWgos0/Cdxy
t1jEsNPbLbgY9GV5zTuXLb7jTAX8G7YERa47N30z91hlvwvftcfxmjFqPMyO/to2
dGr6dChChOq7pw+A1TnjtrrQ9fu9ytuvdQDryXqovOp0K1IJqsJjfcapZY6JTIgj
23hsuGSiVa4jPlYRbv83T3d2JAoCTNM3plQLjhsy5YR1o8WffdfZHFCvd+cdaXUR
MOIPxPAKQ2tbaciWB5Q6msSiY0ZbGj6sgRgDxwDoC0FEfCaSc28=
=Sthe
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


--===============5983276946482920163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5983276946482920163==--

