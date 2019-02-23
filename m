Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CD62070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b5KC9nPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CD62070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=16k85QRsxSCRudUxyRLksLYYUZfDw+bQ6AnTgwZUw/8=; b=b5KC9nPfs2dazXcnk1n2itAi0
	0W//+8eWU7lob2Aezb80csRbLTixpJkZd6xklXuVmcSBxbCtvkkN9oExJ4TbltPtAaGatiUEctU19
	xkRcwK4lKD99QFf52EukuOVyk2HvLNXbOg+/+ofOI25dnAV1f0lUXdCzAQcLaS5tbpV6rZ6ba54/X
	F8sCRk6SngoWNDwGGvCn3Q1MOsxRCO3hjhd4xFtwndxnuQ39rpfgjZdJAKjFt9rSvGvhvs3RS6Fxw
	0fgV58Cd3Wx09qA2KUtoj8Y7ja9p5CcEZtgVTXWjBD47zfemGpSTRwweg2c9Hw8g0jyEfeK43q7fp
	A78zR1tqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxTvQ-0003Uc-6c; Sat, 23 Feb 2019 09:48:52 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxTvM-0003U2-1i
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 09:48:50 +0000
Received: from localhost (p57BC9845.dip0.t-ipconnect.de [87.188.152.69])
 by pokefinder.org (Postfix) with ESMTPSA id 7AE942C3312;
 Sat, 23 Feb 2019 10:48:43 +0100 (CET)
Date: Sat, 23 Feb 2019 10:48:43 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Shikai Wang <sxauwsk@163.com>
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Message-ID: <20190223094842.GF1018@kunai>
References: <20190219012447.5900-1-sxauwsk@163.com>
MIME-Version: 1.0
In-Reply-To: <20190219012447.5900-1-sxauwsk@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_014848_239724_8B251135 
X-CRM114-Status: UNSURE (   7.57  )
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
Cc: linux-kernel@vger.kernel.org,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============3221561182276501595=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3221561182276501595==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 09:24:47AM +0800, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.

Just checking because resetting looks like a big hammer to me: there is
no way to gracefully recover form 'arbitration lost' interrupt?


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxFvoACgkQFA3kzBSg
KbZIOw//X4tPGtaKdCAKY08zneHiiw2dqMHmf69zg2wD7wYcSKApFyY0SdxqehEm
Zv68Ud90qMfJ+Aecvv1t5zRgwWQPNJSB6f45ujlRAdn45VKtHlMAeiyk6VYelNwX
Bx2GXX7ZedpfkmdMGEjiPRsKuHX84kug+xlAHeT5mjGJCjDIrGkZdOSuP3DTDCCM
wzLQ1U8yo9DyfNr8DerZ+co07r5Bi7JXwZdHJ1CoI59DS0gf1MnyLj1+dhv3eVU2
TVz13o0m6QO3kT1eGrDaVl4SskXBAL848Lc6r0DnkxynQs/EiosI+QwbziLZkPr2
FZBFk93NoHVJAlSYSFgpbzvWSxiHUy9pknoPTIgz0f0c1/3XmMjH2ziFALy7Uar7
T++7N8amNhDdt8GbsyEmAzIyLuZcaulLk2vS30cjTJG+Ve9crSpSDJRiMyJ/436U
WU70k9WuIVG7gwiO3PgXrxon/bu4O3bhQAIJT+Tj2lC6iOj183GJW/sxwj1Pbtb0
/iPQA38/G94zqD9lIyhfdTmsXIOJaGgaCXGlqK2TiK3idxqOuvoxVMRJFhoUb0xJ
hKHB8QVoMX0K6SCMh9Lsif6ubum0wrkP4+LFoDq1PDSDU5zlpv0fxUjrJW8p9qhm
Gp7eN5oepPgSVV51IHbbAxu8h5X8wkt2Pho8WjvZY5xwlvmty0k=
=arbP
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--


--===============3221561182276501595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3221561182276501595==--

