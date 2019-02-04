Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F87F2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hPK+Km6w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jSHmfMpC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Czei7OQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J6QSzRYJkBrPVu0rObDNEhVr9L1zGwjEOHA8/2wvmYs=; b=hPK+Km6wD8zaV8TrCaqmkN/A7
	C9TP5zjOptWnSmK+wEpxyDrv3vLF6pT71bgalCGhHyhuvID2OMW2C/po1SLofXphMqmLPeHFj+27f
	xl1u0hWr9RHeqn2IxQMKH//Jkz5TyFBbjlEwhB+3MNSpQ+bKulDG1K/q3aW1DY7OO6uDCN7j+xUw+
	VdzKPRbVpiW5st76IQ0gMb/pqAUMRGmiWHktjbNG1ZzOeALPqahcSH3i/v0BQRACfshzSYzFD8ct+
	TNks7eriMacqkG4C+3fUCpJIVuXeSurL9Ayq6rg6Rk0JsdW8KmwGZwq5AhF+/zBqQarVEO9O0s6er
	wCYAgKtyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjdw-0001Mu-FC; Mon, 04 Feb 2019 19:10:56 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjdl-0001Cg-B5
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 19:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NGO7Ic5XZkItH3LF0+bIv+Wx3vHk3m8cWCn1TQooGOg=; b=jSHmfMpCPTk5mHIDh4Hmr9JTI
 miNBL4ESka0YxTHYj01cnCcXSk/DdAFYUIooP7z6jmugMTDNxpob8YkC0LSG7JVR3iTOL/+Fp383c
 Eky9WWNS3DGe2bV+44vC0BZbzZVAkimlPM6bkXoyL+GydTmSruSJ/75PA70MDnIeSK7kcc/LatiSV
 I4oNdz9yG1NccCtJ+tnuaYu9WxIwljfhrv1Ie3v2Ftnt3JFcVz2+k3RTsdoV3FMq5FpmVtfazGxJK
 5FKGAaoHO8HxbD1gpvNiql/hTDgXAH4d5lt8ayqxQPPeKwxtEUfzC26frXAAZluA1/YrVMrR/IpF1
 rkc5KAfaQ==;
Received: from mail.andi.de1.cc ([2a01:238:43f3:0:615b:ee97:1f81:cbf2]
 helo=h2641619.stratoserver.net)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjG2-0005Yd-R8
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 18:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NGO7Ic5XZkItH3LF0+bIv+Wx3vHk3m8cWCn1TQooGOg=; b=Czei7OQVfTM4QpPuefeIDbCL4
 W/sEL8v3ap8UPFvwMWHiQ33x1SBJzx/rS6UvNBYNmoJs0u6Y4k+FzqZv7J/dyspLLW5LYvgCj1zRd
 Kn6YlXupfo3EdWKVo0aZJYS6RNvI0sGMnDC8iZlE58ELNLbk1pC4uzu0922hY686GizCM=;
Received: from p200300ccfbce42007ee9d3fffe1fa246.dip0.t-ipconnect.de
 ([2003:cc:fbce:4200:7ee9:d3ff:fe1f:a246] helo=eeepc.fritz.box)
 by h2641619.stratoserver.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gqj3Y-0004E9-II; Mon, 04 Feb 2019 19:33:20 +0100
Received: from [::1] (helo=localhost) by localhost with esmtp (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gqj3W-0007Ts-VX; Mon, 04 Feb 2019 19:33:19 +0100
Date: Mon, 4 Feb 2019 19:33:11 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190204193311.102a60e6@kemnade.info>
In-Reply-To: <20190204155604.GH5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
 <20190204155604.GH5720@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_134615_032163_D667CD7D 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: linux-omap@vger.kernel.org, khilman@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 letux-kernel@openphoenux.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6545266541839154052=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============6545266541839154052==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cZTCPF4_0JCD8_K5dVyf4=+"; protocol="application/pgp-signature"

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Feb 2019 07:56:04 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> > Enabling off mode was only reachable deeply hidden
> > in the debugfs. As powersaving is an important feature,
> > move the option out of its shady place. =20
>=20
> How about let's enable always if we have the twl4030
> configured to allow it? You can just check if the dts has
> "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> properties set.
>=20
> In order to enable deeper idle states, the user space still
> needs to idle the UARTs and possibly other hardware blocking
> idle. So we should be safe there.
>=20
Let us not mix up runtime pm and system pm. The uarts need
to be idled for runtime suspend, but they are off/ret for
system suspend without userspace intervention, so allowing off mode
will have an influence even without uart runtime suspend,
and also probably for other powerdomains (non-core/per).
So we still need to be sure to handle at least some erratas and
context save/restore correctly.

Your Idea seems to be in pseudocode
if (powersaving_wanted)
	enable_off_mode()

I had something in mind like
if (system_is_trusted_to_handle_offmode()
	enable_off_mode()

Regards,
Andreas

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxYhWcACgkQl4jFM1s/
ye+kpxAAtyNv7KqReXE73tqndnZZKlspBriMnP2PreLqcpI8myQPpBCb+aCtP+AS
q1HAXiiMZVF41tdQ8cDXpEQPi537pGz7bmLxh+QLdAMrh6gVweUtBPX3dLIdn8+B
lC+3awFj4B9d4jNCveHh8OeAb7mDYZN9XZDzSBaJztcXGNsY9P4sr57Ird4NzoFc
A2zGUSofbgVKN2JPZT7FaSnv8sgd4khFwAV5FbIVK1R5gFWyj8ZCsnpdVSHYQIEd
yUM9qTtYshGLs/0W19h6SFxlLk+2qCiLKdslXUytkpdcHZ/0zL6rJtHSIhlua+Gc
UH6DoPhRO5Qo9Y63fy60lyRFm5cMeAosghDfzhvEBt58doLJVPwi06coRY/Tdmxn
gK8/YSMTt+S1Sj3FvDODxsOACg1MxzdBwcG/sGQDBzV/8iyiiyA28WWcHFcNiQJ7
wzPPk8FMHRP2oipVIj7gQVz2Q+HvD+stuJhS8SPIiNKmNeZSdF0qh1s7kCrOfK+6
RQUNl2goH2+8ldkWhCdcswfGQyhpr00cdhxoxrKSaat/roLpbyTalGx/cm9lgoPH
UkXzWKVTaqdjrN7/VxWjzamgjy4VMnq99BuF91UaOz0a63KPO6ob6cW+jVdtJ/I9
m/TeKon7/F+zxpuDxk5QWyZlA7YTFhzhCCMGXybBl9nX7m+bovA=
=sAHi
-----END PGP SIGNATURE-----

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+--


--===============6545266541839154052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6545266541839154052==--

