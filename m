Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9143C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB44D21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dQQn7Q/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB44D21B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z0T8sg2qZ/7/z1kYOO6jqL1DOzj78uprYmOfsUd+RIE=; b=dQQn7Q/BAA7QcoachHiDSmC8R
	qVJfX2PLaQdiBYWWokENMXsEOd+tTcsxNl1eWAq0kA0W+VyZyk6kUTh2+UhisqlRrQA6iprMPdjPX
	+ySQZNbCzgsVLs0UnLjuxtl0fkOo71ktTp/4qLIGu2Qima2u5hU31GNY35u0n9rNjih33C+rFl10o
	Uh8S7BsEu1rYPBYGVLnHO9mU5a7Ov9haLZ/itOS0YiP1CaF49VZdPN6Ij9sCRuKa3f4ueFGDIUBjl
	eC11H188IH9RpcJXe4FOM9Sf0pHhrrJxtG5u/osDX+UBvPGPDBbvfU8xJtqnVJwLck0Zlkt+FtKfR
	mC7I0V+RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZk3-0004b8-9w; Fri, 15 Feb 2019 09:25:07 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZjy-0004C1-5z; Fri, 15 Feb 2019 09:25:04 +0000
Received: from localhost (unknown [83.221.228.209])
 by pokefinder.org (Postfix) with ESMTPSA id 36CCC2E3551;
 Fri, 15 Feb 2019 10:25:01 +0100 (CET)
Date: Fri, 15 Feb 2019 10:25:00 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190215092500.6q3hqnoufyowiqaz@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_012503_084460_B17563DC 
X-CRM114-Status: GOOD (  13.19  )
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
Content-Type: multipart/mixed; boundary="===============4367792970178759942=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4367792970178759942==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2t44ovekq3k3td5"
Content-Disposition: inline


--y2t44ovekq3k3td5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 05:17:27PM +0800, Hsin-Yi Wang wrote:
> Ok, I can add a check in another patch. Should we return NULL pointer
> if msg->len is 0 or print out some warnings? Thanks.

No warning, msg->len == 0 is a valid setting. But interesting question:
I was about to say NULL, but your driver would assume ENOMEM there and
discard the message which is also not correct since msg->len == 0 is a
valid setting. So, should we just return msg->buf then? Will this work
with your driver? Can it handle zero-length transfers?

> On Fri, Feb 15, 2019 at 5:10 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> > > i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
> > > 0 and msg->len is also 0, function makes zero-length allocation, which returns
> > > a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
> > > code to fail. Modify the threshold to > 0 so the function returns NULL pointer.
> > >
> > > Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
> > handled for all callers. Do you want to add a check if msg->len is 0 or
> > shall I? Both fine for me.
> >

--y2t44ovekq3k3td5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmhWwACgkQFA3kzBSg
KbaFFQ//fuSyJ7pBnGx4oHNrTC5YHyX1SDtwZyZqo5kDgB7MNJ5yOR3Gd2jTCx8j
IzJEQlO6bVPUCJSgdZTvWjfOdbbkLyakIhbMYoDOTPl+JV73M1GU0bppG7oggqTV
T/DbHUvQ5YlshB/eENAJtbVJjGu7rjmd2Ttbm4PSUl5Y1zyiT0JLAMEEvDfW8UxY
cOMY8u8bHZtbDxkMRQ73L2h7C0XFb7TdoxmdYmbNvFBmczHAzznvgrHtxGmTg2R2
ThO7WNRTzABSeudmLeZhKTIum4hvwp3ghyBsRos8kiBpSmDz/0vRcBvqG+4ZThuO
GbqQTyK+Lln4Q7zkPdCSb1GWO6IGGFysXUAIewTRmr2yWgP5zkAtaZkbDkDdz1aW
6EUlgfWg//3BXQimXWpMwZ/sOij8IJ2XBsIytssuO6pJon+q3/sspY+QBnOWFsiJ
UhcW12LdEXZW7Nvi+BxRYfRlSy3TxOb5Z2sGYsOMZ0P8SGyQxFFiUQ6ks99hr0hf
Clv3SBpRv7Kua4LmziFL/PtNnNkr/9Z9j/sdk8hfh2Zzlx0D1+k8sWvWN2KjYxa1
ZKDVf3RzdKWPbw0nloni4/6aQ9/+sohzz6Ov09l0Gvu6exQIF5XAmCw/Gh6WjyiV
UzARwXWjLRkPuGDRFEIe7WgmwlcaF0NMC8zwttf8FavI4eNdOxQ=
=eOq9
-----END PGP SIGNATURE-----

--y2t44ovekq3k3td5--


--===============4367792970178759942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4367792970178759942==--

