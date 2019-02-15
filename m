Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D777021925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="je/8/wEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D777021925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tUAdApeRkvtE4xlPXAH8WQ5cG7kSHAOgnLQfJ9P2CkI=; b=je/8/wEpmNwUoUSiwnw8HIMZw
	d+RMh4i11LIjBKoHcQOuQkfuKymtfp+zPuIw/LR5lIetL3uItmBEt4ulrtbHWQNlg5ZQxHt3HQynE
	b6PK50nGJnLksfmXQM9JvBPC30ZEVKzkHDenvZVc8rcShIEFSE7aJ9/m++ra+zxsgW2i+eh8H5cN2
	NhPlGPeU1MSaWELhlokJOi1bEChGtuLViU9os6g9Q9t8dOm0ld4iPIrPvQXPdDObQCAWipVrvec2V
	uymZErZhuQvZ1HNeU6Q7E/xHhLi0YiD33Nd6l7F35wd7I471hYb6su4AigvpI4xhxQ+fmJeHono3Q
	6bJLKJs9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugUE-0006dL-5U; Fri, 15 Feb 2019 16:37:14 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugTz-0006LF-Qk; Fri, 15 Feb 2019 16:37:01 +0000
Received: from localhost (unknown [195.52.228.164])
 by pokefinder.org (Postfix) with ESMTPSA id 2D6B22E3551;
 Fri, 15 Feb 2019 17:36:58 +0100 (CET)
Date: Fri, 15 Feb 2019 17:36:57 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190215163657.fs6t7p3vqez53su3@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato>
MIME-Version: 1.0
In-Reply-To: <20190215092500.6q3hqnoufyowiqaz@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_083700_009826_07D30CEB 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Jun Gao <jun.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3827589182559958547=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3827589182559958547==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fynakfv4m43e4662"
Content-Disposition: inline


--fynakfv4m43e4662
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>> > Ok, I can add a check in another patch. Should we return NULL pointer
>> > if msg->len is 0 or print out some warnings? Thanks.
>>=20
>> No warning, msg->len =3D=3D 0 is a valid setting. But interesting questi=
on:
>> I was about to say NULL, but your driver would assume ENOMEM there and
>> discard the message which is also not correct since msg->len =3D=3D 0 is=
 a
>> valid setting. So, should we just return msg->buf then? Will this work
>> with your driver? Can it handle zero-length transfers?
>=20
> dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> kernel if msgs->len is 0, so I think it doesn't handle zero-length transf=
er.

Please don't drop the lists.

Then, the correct solution is to forbid those transfer with this
controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).


--fynakfv4m43e4662
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxm6qUACgkQFA3kzBSg
KbbsQw//TKz2pCmEj99gaTnI4oak75P3IW10Xow7DY8Bhv4KTJ6irOVHclR2WoL/
/o3ASwvfasg2jvE7JBhdZyMXtAs0GhlISv/02ZG3oJ6/i6gmPGlgAlgftFH2YWVg
xRWLmRaPJCUfEsN1RddKYGBLsdYrELNJLHNqCvKDvnxiM2eUH1o4KVPn908AlzQf
6XHzsGew3EW/2G470f0qimDDRPcFN00r7FdUnvM8+fGazP39VPCGb7BFk/cm8iss
RWitHJTHQehSLLN+yKkLS697feeiV83Qi+tj7tkVOL4HJvs4hrLssAndK4eaaoVu
TIzXgASGfmO5EC/srp3KqZFNaVHe8sGE8B2uAlS1cmArLfUCG0PirLdAzp6mmG9t
ExfPZOw7pUsaNRdPyiGLu2xD8u//d2WA6WDvPYiD5/2azHKE3Klv+YDvQZlexkpm
TqhD56l1ohbQmmEpNzC/a5giCZbOujXMrUgz/2C+JtNEIgcq71VBOPtsUOwaTLxP
npBZxZ4+Lmu0VdvgLa30VmpaFf9s24rhADLuJs9DWQrECIo5c/8CV19x3jupM3e1
+UkRz2Vt/J7RqeXhOY2lv4pPz9RTx3MJNgUZErVsGsqYhIkzqjVv5Kh2vmoPt2GV
fnYlXaiiWYoUX2JZ14OBvaHPJA7GqP3T2yJqEOeoLdIVmKYYcng=
=lS99
-----END PGP SIGNATURE-----

--fynakfv4m43e4662--


--===============3827589182559958547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3827589182559958547==--

