Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0F5C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:28:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C17220856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q5CuHJwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C17220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YCABGrOBt+lG3Q87QecL32LeQJg6XOAMk9re6oTxcXk=; b=Q5CuHJwFHXM4JQTw95NOwPUR4
	3HJXu0MZOGry2wftVUsrJT1gV1HTdKP/0ixuAgZxhqU3n52KKRihWhI8a8TobyvElm6vItMWL17gl
	9sD2BzpMrp51MhkM2wUto2RqlU5BXWQTWC/RNwcId5tTdEICw65/HK1sbsjr0qiPaItINp9/LVpxx
	oRfF2LNNBINvPKj9WoVtalmvDTcq3tbIL6rBOUzqxo7XNNVT0yoKKqycSiDoiuRUFBHPu9tDXBeTD
	SenX4oHzv651a8+q/SGsNUsn/svPNXBXoBIp89RURWfrxfghrJuIMDJw7ozAUrmtzkrH4s/m1sXzV
	1L0b65/ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5qH-0002mb-LD; Thu, 17 Jan 2019 11:28:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5qE-0002le-6p
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:28:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E9B52207B2; Thu, 17 Jan 2019 12:28:08 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id C03E42074E;
 Thu, 17 Jan 2019 12:28:08 +0100 (CET)
Date: Thu, 17 Jan 2019 12:21:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: ayaka <ayaka@soulik.info>
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190117112150.qfzqjdmrqpcjqvnh@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
 <20190108095228.GA5161@misaki.sumomo.pri>
 <2149617a-6a36-4c0b-26c9-7fdfee9da9c9@soulik.info>
 <2e734dd6-d459-9990-61fe-27301df35ff7@soulik.info>
MIME-Version: 1.0
In-Reply-To: <2e734dd6-d459-9990-61fe-27301df35ff7@soulik.info>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_032810_392035_06D15062 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: linux-arm-kernel@lists.infradead.org, nicolas.dufresne@collabora.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-sunxi@googlegroups.com, hans.verkuil@cisco.com, jenskuske@gmail.com,
 sakari.ailus@linux.intel.com, Guenter Roeck <groeck@chromium.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 posciak@chromium.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: multipart/mixed; boundary="===============6333865322741854800=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6333865322741854800==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oqkbl2a7clijvahv"
Content-Disposition: inline


--oqkbl2a7clijvahv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 09:33:01PM +0800, ayaka wrote:
> I forget a important thing, for the rkvdec and rk hevc decoder, it would
> requests cabac table, scaling list, picture parameter set and reference
> picture storing in one or various of DMA buffers. I am not talking about =
the
> data been parsed, the decoder would requests a raw data.
>=20
> For the pps and rps, it is possible to reuse the slice header, just let t=
he
> decoder know the offset from the bitstream bufer, I would suggest to add
> three properties(with sps) for them. But I think we need a method to mark=
 a
> OUTPUT side buffer for those aux data.

I'm not sure this is something we actually want. The whole design
decision was that we wouldn't have a bitstream parser in the kernel,
and doing as you suggest goes against that design.

And either if it is something that turns out to be useful, this is
really out of scope for this series.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oqkbl2a7clijvahv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEBlTgAKCRDj7w1vZxhR
xRcgAP0dWriJx8+o1omXhfWzZxnYLft+14hPq2CjUX6JxflfLQEAmPrSaLuuzNxR
APurR6hH+cGQ0z90Wdyrw41F9LbmnAg=
=fkam
-----END PGP SIGNATURE-----

--oqkbl2a7clijvahv--


--===============6333865322741854800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6333865322741854800==--

