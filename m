Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB6C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1C620856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tRHL8bgl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DOtbJjTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1C620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+Brehux6eIc+v8jeuKbhb2juoVSh+EAgY3DewQ/K8wg=; b=tRHL8bglD6XG0tCA5X1PmmPqL
	kFn4BKkZ+XYEZKrPYRZdJ/H9NKZClUN84TkxmD4+XtvwQ7uNxzCi1mFMQSRpYfYfwBLfOU8APrkuz
	9h3DxyKUUCtQ23pcK9BJfN/KkGzGF8Kn6lE6UHrvTORduR4QQZ1AUMYTLcKB8HLYOeTaYij9XMXmE
	ySVLsFyQ380hJWO5Q+gSMfjdrAqBEYwg2CHpu53F2TNXIa2F2leKkpYUtfAJ5ZApotJa4En0eCNUa
	D2ClRQtcObYr0qja/pLzhszQ1wnmupbQzdn/Ou2Xf+BQRPvo2qG+NJwZYO1LMJQ+a3sJL7Z7kZqd/
	d1On5uhEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZ2l-0007CQ-7j; Tue, 29 Jan 2019 19:27:35 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZ2i-0007C4-4L
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H3lOA73jmcUih9DdRcPfV0vs0lvHairXcpRhF+X3H/I=; b=DOtbJjTVYO4AuutIbNapqxR+2
 82NBOsJHz9WSFcpQxY6jVkTmrWCwMCb1CosQ6XRKQa8hn+8/jbhfqpxG2GcAQ3cIO1z9cR8blwBIW
 4K2BbV1GlM1bd71vxyJn5Xm7dNog9rEQycio7Flumj9Ax7pA2TA/vq4fvHMWjtN7x7q/0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1goZ2e-0001Hf-R9; Tue, 29 Jan 2019 19:27:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 342DF1127D50; Tue, 29 Jan 2019 19:27:28 +0000 (GMT)
Date: Tue, 29 Jan 2019 19:27:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Chen <Peter.Chen@nxp.com>
Subject: Re: next-20190129 build: 2 failures 14 warnings (next-20190129)
Message-ID: <20190129192728.GL10524@sirena.org.uk>
References: <E1goXtl-0000g3-1h@optimist>
MIME-Version: 1.0
In-Reply-To: <E1goXtl-0000g3-1h@optimist>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_112732_314519_4BB55710 
X-CRM114-Status: UNSURE (   8.78  )
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
Cc: linux-usb@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============7900468397243466736=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7900468397243466736==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline


--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 06:14:13PM +0000, Build bot for Mark Brown wrote:

-next has been failing to build allmodconfig for a few days on arm and
arm64

> Failed defconfigs:
> 	arm64-allmodconfig
> 	arm-allmodconfig

due to:

drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_ioctl':
phy-fsl-usb.c:(.text+0x5e4): undefined reference to `otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_start_srp':
phy-fsl-usb.c:(.text+0x680): undefined reference to `otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_set_host':
phy-fsl-usb.c:(.text+0x800): undefined reference to `otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_start_hnp':
phy-fsl-usb.c:(.text+0x88c): undefined reference to `otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `show_fsl_usb2_otg_state':
phy-fsl-usb.c:(.text+0xa44): undefined reference to `usb_otg_state_string'
drivers/usb/phy/phy-fsl-usb.o: In function `a_wait_enum':
phy-fsl-usb.c:(.text+0x1718): undefined reference to `otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_set_peripheral':
phy-fsl-usb.c:(.text+0x1f20): undefined reference to `usb_gadget_vbus_disconnect'
phy-fsl-usb.c:(.text+0x1f40): undefined reference to `otg_statemachine'

The issue is that USB_OTG_FSM is tristate but FSL_USB2_OTG is a bool so
we end up with a built in driver depending on a module.  Unfortunately I
can't see why this triggered now.  Neither file nor their Kconfig has
changed for quite some time so I guess we lost some other config that
was forcing USB_OTG_FSM to be built in.

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQqR8ACgkQJNaLcl1U
h9B2gAf/aF5XluCGY6x5ZE0x2s6s5ekDl8lGXbuHJ//7q9Nu0Asb6R04QZMsiZ0E
pKxuaqa3TIqslr3k9cnNAR0SkHAn1k5YYg3KsE/pNScO0CAP7h2zT11vpip83mps
uZDNRtmz6tJc5pqT39lrqxHDao+JezhyuPxwzTRd/XxeUtcUlZ4++UG69dIiRTq2
KLbUoek4hSvcaJ3EiDhNPVjddW56zfcTbrJoZn2Upfpi5OO70gIGjCnmiwHTB3RW
Sc5OELD2nP3ll8R+BaF+BKbV5h5vV5b3kv2Ebz4W4Hk3r7QKSa3KmbUkx35QeGVe
H2ZMQRNwt3qf9hHTHzKMuYxUhQhB/w==
=V/4V
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--


--===============7900468397243466736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7900468397243466736==--

