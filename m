Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C111C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA3D2063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TzzWHvRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA3D2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7rGj9743kNnfZgVovrBacidGeG19rqhZsW9HDwHJ4Nk=; b=TzzWHvRl9fOZ8OotFhWtOa1EQ
	D1RN72NZOn2IVr2Pf3XyGm5OSCU6pLxkGHh6NYuD8xJ4dXodQmbl4X/hizoo6WasNNzGVGrGkSatB
	Rc1K8XUwyO9A46YvDz8SrZ4dS+K6n4BfNyB3KsLaralYtmmqA9Ziw2MKlO3kd8i3nu7NBowNy8ovW
	4BVANLZW2/rZxP9/CmVp1K8CaMajyTRmhkKQTEuCcreH2FAn+htgS+Iwo42RXat/Ei7U/ER+spxSq
	r7464nRQnH3aTMjSPuNgg2tnXm0FFCu0aZX3s2wQrM6D+TNShs/5C0Ti7oih/XdgccBtK9NYFyjjK
	MjvTEtdQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBYe-0001Os-PB; Wed, 09 Jan 2019 10:58:00 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBYb-0001Nr-UF
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:57:59 +0000
Received: from localhost (p54B337E0.dip0.t-ipconnect.de [84.179.55.224])
 by pokefinder.org (Postfix) with ESMTPSA id 630A33E4151;
 Wed,  9 Jan 2019 11:57:55 +0100 (CET)
Date: Wed, 9 Jan 2019 11:57:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
Message-ID: <20190109105754.vvqx6uvsktvxeq7a@ninjato>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20190109104922.z6g772vgncdqqbqt@verge.net.au>
MIME-Version: 1.0
In-Reply-To: <20190109104922.z6g772vgncdqqbqt@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_025758_132143_3937A003 
X-CRM114-Status: UNSURE (   6.03  )
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
Cc: devicetree@vger.kernel.org, Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: multipart/mixed; boundary="===============3617666679457328161=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3617666679457328161==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phwlhbwhrxbkakdi"
Content-Disposition: inline


--phwlhbwhrxbkakdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> [    3.373714] renesas_sdhi_internal_dmac ee100000.sd: mmc0 base at 0xee100000 max clock rate 200 MHz
> [    3.456829] renesas_sdhi_internal_dmac ee120000.sd: mmc1 base at 0xee120000 max clock rate 200 MHz

No mmc2 initialized. That should work regardless of eMMC. Probably
something wrong in the DT somewhere.


--phwlhbwhrxbkakdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw107IACgkQFA3kzBSg
KbZUJA//YTnAX1C+RWIs26zxjrhGtZVQqNchtRQVPrtAgcDh9swKWcOpLbIcEH1W
cb9Ly2QqkKMNMh271IW2SxkaocaQ7vTKl1lwGP3MqKfHc2MB8EWcmOjzRGiASD+P
/LSilcxUpxb2yweyUH/2V/DNSVU1oNgFTn6ux44LqlZEtHgXMxFQY4jXaYrBZ3Mu
2FhnFx6m7NCXYA9bTPZz1eEOsWHxEfCrCJzRqLP29zhg0RiBmOYcwy5GNyaFZfuT
kS1QqD0AwmF17WmekCOBNTKgMKnMHJxIs3yjE7FMDTUKR94eNL9eok2PiXZt8JSv
N1aMmw+5ISR0ZPDn5mlq0H52vCyTRmHu9R6Z1phJdR5MaSh8+ELP1C5GPxudMpfS
BKUzEIN2aX5BmlLhGrDMAhlv3vutKQp03/6Y4ZTXZPhyiDqA1oY4YFuTUCt+/8ny
21sBlIHd+LvU0H3exLLz1yOb3D72unvbNhNVixlmS4LY9qLAXcfTf1bsp/Dt48q3
cCKjmCGElASTJDfxL4PcN5z72eevgKHlIzeMDu/22ZAUVsOK/0mjYN102uONyaTb
nlHG1pndronLO35R1ncv9AqiCKm8bEyjvvBkDFQpE4oCPC0Xl5S3eRpB40LphHjE
17zX5/0YgUZ5hL+roYh96FQB1y8P+kh3XXx7BR6F7j/wJDppdNQ=
=6CtJ
-----END PGP SIGNATURE-----

--phwlhbwhrxbkakdi--


--===============3617666679457328161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3617666679457328161==--

