Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E45C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:18:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C30020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r4zyHyIl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HTlTPhiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C30020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8IB++kyQT8rbKhFryrY599GKOSinybXe6LzzlBOrkro=; b=r4zyHyIlvYr3qAwlz3HrRLsO7
	GAmLYRKWgOQVzpUc1y635zIQrO55tSlEyC2lo5dsgJB2xraRs/9bmyv9kPJGGqGA78QV//T2ipJii
	ywTNK5EyLHC0Dt/Hfx7/Hv9zpqW7zsB3K7tmcPysOIk81v6LcWcm25ljZNPMXLj2k2OzoGBb9z/ga
	3aoe64XDOGsxq/xz4ZcijvXsw6s8+qN9XTAIeb7b80o/nFQaTCb11U1C6Z+WMe8OIG5ggVDsraoGl
	RcRzEIFr8oiErZ/2Fm8YjSQNfDa0ht1IGlLxyNrklMxyy1Dcrn6evqvl8J7TYc1GBiIfmXDrAndLw
	FaA7CJzJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpodW-0006XB-Gs; Sat, 02 Feb 2019 06:18:42 +0000
Received: from mail.andi.de1.cc ([2a01:238:43f3:0:615b:ee97:1f81:cbf2]
 helo=h2641619.stratoserver.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpodT-0006Wt-B9
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 06:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K4d/74SfSGpowEs1tW9V6SK3qE76OJNqK+WcVbDexCk=; b=HTlTPhiVN+QQ0V8mMhQQ8YQVl
 QC/LZICoq51omWnOXBdkl+7V7pEDeWpEBgzHJVXMocKwwNeXesgyrutofQmMBAFN+YDHpC7JhvIiT
 DPm2rp7VV/UGy4Pgq43yobF2kbprkspDAQYxHFAA9E8Qo16liREz7LCksx2lWz63XTlTI=;
Received: from x2f7f150.dyn.telefonica.de ([2.247.241.80] helo=localhost)
 by h2641619.stratoserver.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gpodJ-0004UG-Lw; Sat, 02 Feb 2019 07:18:29 +0100
Received: from localhost ([::1]) by localhost with esmtp (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gpodG-0003Un-Sh; Sat, 02 Feb 2019 07:18:26 +0100
Date: Sat, 2 Feb 2019 07:18:13 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: tony@atomide.com, linux@armlinux.org.uk, khilman@kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190202071813.6234d8a6@kemnade.info>
In-Reply-To: <20190202055827.12956-1-andreas@kemnade.info>
References: <20190202055827.12956-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_221839_533772_5187051C 
X-CRM114-Status: UNSURE (   7.24  )
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
Content-Type: multipart/mixed; boundary="===============1433797329975995673=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============1433797329975995673==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/brBhm643RtDYZ=JIaq78N0f"; protocol="application/pgp-signature"

--Sig_/brBhm643RtDYZ=JIaq78N0f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat,  2 Feb 2019 06:58:27 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Enabling off mode was only reachable deeply hidden
> in the debugfs. As powersaving is an important feature,
> move the option out of its shady place.
> The debugfs file can still be used to override the default.

oops, this should be an rfc. So take it a bit with care.

Regards,
Andreas

--Sig_/brBhm643RtDYZ=JIaq78N0f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxVNiUACgkQl4jFM1s/
ye8pEw/+L6fsxsK4dvYlZo/y0VgLNEYvdJs2w2yZEVoWmygXS2stsavD/y6Ap3my
hSUIbVNJ438d5CFjQjgeSYhdhYHofuRDbZNuPv1JxKeIPvLlRanfL0OCmolOZJhA
VO2ptqAM571hmbrfuT5ejB/uAO/jFEMX3DJWskHJbW3aaUm1OfLplw7GKa+zK5+A
kc+vss0BHhFDJoSOI00qr9v1h57QHV6xsSqnBkWozbnPM5Cyqvzq2Kqx3Vjw/RkG
CAB+dbIrS3YUISMAbglnSSgoJQCHA3u+Kx3zoXxP/0MV6pYHqtn8knjW+lxRAqlr
u1SuN4zvWs60hb6vh6E9kmUrYzGm0ewLlbbNq3ICZC8EBxvPXPVZNoM+phgLIF9U
ixTLjN/5oDmJmCEblLXKsMhtzAwCj5iip1yxaMMmER9PNERSR9YLoAWOfDt/aycu
VqJK8FA4pmruclyHD6tgGaVVQ/WiGV5snp/IkvlD9iRQ5EPXxaF5pz+LVOIywyp/
Hxvs8d76qUhBgqqPxVQJy1gMO2uOUA2jOzeAWVWQe/FRJSt+wcdQbEHegiBO8E6a
A1SMOsFGiI06myc4US2YtfkN5UiKDUnNoZKNwgjNjzXaqI64O0H+MZDyI7IEBDSU
h6c9cgLJKuY9TNWo4X0tfGBiOhx2pqSS+94/IdXgPffEDORBB9c=
=USJC
-----END PGP SIGNATURE-----

--Sig_/brBhm643RtDYZ=JIaq78N0f--


--===============1433797329975995673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1433797329975995673==--

