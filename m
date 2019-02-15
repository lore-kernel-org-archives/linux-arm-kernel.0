Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0787B21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SabhJ7cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0787B21B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fUqka22s432VfG20oYjoXn6ySaK3KvaW/w9EQqaot2I=; b=SabhJ7cKa2lRva9eBagcxm9aI
	wy00WzTeaFAp3rUTxoQyxNMgQbPXdnw2+47GQWaHmS3TmSILxhMVvrFXLbijBmZal+1x/rz3dRwRu
	0nAcD+hoDUrOJniK1I36xAewLooiqoKaFCKgnSiR1kU/3vXPGJwiQ8Rrugw8MpMfIFbJFvXnWNE/D
	bpnMGB+fti1Ax34qo/uL8U7EpgJyvwN2uDJLAn6JXC8lFLhntvrrqN6yEx8q46uXxf9ICHnx61nzu
	KHjbmg1GxhwBsuHUk1NMr9hBcIVUobpboRc7Gypyif6EVvD3LfDNBFz/VSk7ughtd6mRtCNjiFi5L
	88yY2Sm7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZVU-0005sH-V6; Fri, 15 Feb 2019 09:10:04 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZVQ-0005W3-Vp; Fri, 15 Feb 2019 09:10:02 +0000
Received: from localhost (unknown [83.221.228.209])
 by pokefinder.org (Postfix) with ESMTPSA id 310A02E3551;
 Fri, 15 Feb 2019 10:10:00 +0100 (CET)
Date: Fri, 15 Feb 2019 10:09:59 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190215090959.soxkf3ho3or2geme@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20190215090202.157100-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_011001_169433_994059D6 
X-CRM114-Status: UNSURE (   8.51  )
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
Content-Type: multipart/mixed; boundary="===============5826440666001856318=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5826440666001856318==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7e24ofik27zxdzz"
Content-Disposition: inline


--z7e24ofik27zxdzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshol=
d is
> 0 and msg->len is also 0, function makes zero-length allocation, which re=
turns
> a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause la=
ter
> code to fail. Modify the threshold to > 0 so the function returns NULL po=
inter.
>=20
> Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transac=
tions")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
handled for all callers. Do you want to add a check if msg->len is 0 or
shall I? Both fine for me.


--z7e24ofik27zxdzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmgecACgkQFA3kzBSg
KbbmfBAAqYW+JvwMtjirjdXC3UPcneALX9Iw2pOiZ2zmKVFJp27osp1IkQyxPDgW
WvJ1+0O2l2+YLM1HMxhQKZVSsULwUD8CaltGxlKypNQZa/ka8kWOffsOUODldueC
bqddzNomrk5OCmkywbbcAq4iVcxfLRffnrjqtP+CXHqxi5OIG5cNclI5u5zjnuOY
rEg7fu2p9p0wXS6fSfEW0iK84XKfbAkcyxJLryEx8o5QDAvow99wmFjJ3x9deKFf
UNcoRYUgyZK+DXQF0SUr1EuEOStuXC8yoKncyuYD7rfRIMQBU0Q/YDy3TnWj5Fa3
AI07nksJ+Swqzu3hn158vKvqMRkX9n+C6BSBgajGE/mAMffIHXuDTfxpNOkDDqri
FaVtITfGcp/s3aLCu8vFoyuyK05LV0xt7RGqMt4mglFU/dMXvRkKEyDmLx3ASdIl
7S2fO8ldd5DPTAKnpBJnEhxD1x2YdPqn0o8lMYMXPkIk1+6tFakXB7ACBJ4b5oJf
CBUzj/2aYGJ9RH5AEW+BVXnTrKwBTs885zmZkgHM/FxgusV6t1srPXImocRVvyQC
KtGiVLYW34c3x72ONu/09kPocbRJubyWUsCntSDWfIBuRkcQXmfbroNRq2SEFlGA
hy18Oc7VKRxSqrRs8V4ibmcpEY7BcMydmFC4aelBei3mCz1nHms=
=Jioo
-----END PGP SIGNATURE-----

--z7e24ofik27zxdzz--


--===============5826440666001856318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5826440666001856318==--

