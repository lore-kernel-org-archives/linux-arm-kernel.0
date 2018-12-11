Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA40FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:29:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69CF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cIj4T2wJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69CF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=chrfZtLTVuK4/FzFwpB2AUddYsUZ3qkNjLbpq0rmvNU=; b=cIj4T2wJMhpz3bI7LdzVZWVgh
	UyLugegwO9i1Wx5ZoQs+/tLm1RvDritARtNGQQFqHisbvmeLUeRtp0M+XPkKm7t71b/q76ppogvIV
	C0zxkJS+LSjfnoYX7l8UIKd8euP6O7FO+IDrmoLidII9rd4l8r1xJQ0G+EwHXPxJqkZd0cxqLIeX0
	0L1gRJzo5kf+VfNo5mWBAx3yUxGBcwScP4VqY0zAotBBeRimwtrT6MVAcXgSHqWid1XstYZj0fqdr
	JYHos8TPldIsECl7Qhs2V8P701ObOstui/LYH2+NT66TrfxxcA8n33H89txcIdAam1jFhdn+QkE6v
	QaKtgfnkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWof4-0007f7-Mq; Tue, 11 Dec 2018 20:29:46 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWof1-0007eC-B0; Tue, 11 Dec 2018 20:29:44 +0000
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
 by pokefinder.org (Postfix) with ESMTPSA id 290384C0E90;
 Tue, 11 Dec 2018 21:29:32 +0100 (CET)
Date: Tue, 11 Dec 2018 21:29:31 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: qii.wang@mediatek.com
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20181211202931.xav4gzi7rzh2scgx@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_122943_536743_057976DD 
X-CRM114-Status: UNSURE (   4.38  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5651188857522279982=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5651188857522279982==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qookkrqmaew3bmbg"
Content-Disposition: inline


--qookkrqmaew3bmbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +  - ch-offset: base reg offset for multi-user.

What is "multi-user"? Why can't you add this offset to the reg-property
directly?

> +  - mediatek,share-i3c: i3c controller can share i2c function.

Please explain in more detail? Is this an I3C controller?


--qookkrqmaew3bmbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQHisACgkQFA3kzBSg
Kba9lA//XQcp5LIyZqRaesg1uwwq1/DUnhfyqYK9Hyq5mqOGd+wXFZbvCUWicwwk
/N7FXIICvbEgzyhzItu4d2m5blloyJiA4rVxPAYo8MihORADU0Eu9qJLwI6XUGUH
kLe8/GrqWqg8DkGw4xNx7q+QpO52y/Fx7Lit6K2FmCAuMUTU8hkI05Mmm+eFaYGd
/Wxq2KZTaeDQsT0qLpRXRDi6hVMWamhgfNHO5WPcy32rHAMJ17e6iFOQaOv5FaaZ
dQmTrp5Wn1mRaKrLKuTACkz5XUqIPNxV/w5ZHWRFyTbEr5zKXdcdcYIPYjNd/bzg
vkEJR5Ith3YlmjU7YfVPyUBm0y7VGjeDXr+KL4LoVcUD/kbZUT+/GGTmAL5PZvP1
qatQcUvPiR62LTEi2nZaMjNFwg+9k9BC5WjARRzSi3Ev/2gHA7gwcCgnJEBmwp89
TaysiINGGxzRzfYnn+wL2ja3lYyJr7iYie9JAqzLHM8Q120KgavZEHyHJCWdOvX8
sMVcLh6ld03+J8iFtiNJemPiRl4jFMkg0rQs11YeAZJu/H0rVdU2Bvbk1yJ2QaaK
a22CduYq10DwPPwCrPh4GMGK3Ohi+md5XcUgDTnnc/JVD+hOHSOBtYOHkNp/nYBN
fnM1q9BoJlE+irfzbAqx64BX+a6rrg5KeAWy+f21+Z7xwCW6gII=
=ZORW
-----END PGP SIGNATURE-----

--qookkrqmaew3bmbg--


--===============5651188857522279982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5651188857522279982==--

