Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86173C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5767A21B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CgYwiWeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5767A21B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1EYKWrlaNQ87wmftkfDNI4l22xqJfTFTFy5kCzge36w=; b=CgYwiWeS9zC9TL4Bmh984Wkuk
	J5Va/OujuO7BNWh3zH16M5nb5blqMyxKyD56d63lzJElSN8cs5pcgen49NzqTc5YiQeKlrG6doUWz
	kfVTONyDtKQjC4Z4YEvfVyOdin6PL9SG8G2NZU6x0qCQucsudmo7PmRug40zKg7B+T47pn9ILSy/C
	5CbhnLaLRn0EtsZ3JW0RABsJxm1ogwKZGeWa4XW+4O8CPHp2q1CuZxDmCJULQEnIudCfadRivvHAO
	ObQwt0kRSlbJRwiVnCzg4uKMytHX7WCYh5fLmCqedOsfbVSaaPA6BMTCN1f1NQIWv+pDmQR853Ii0
	hYvau+fzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtG8t-00085a-Ic; Mon, 11 Feb 2019 18:17:19 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtG8c-0007ol-MR
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:17:06 +0000
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
 by pokefinder.org (Postfix) with ESMTPSA id 2CCBA2E3542;
 Mon, 11 Feb 2019 19:16:59 +0100 (CET)
Date: Mon, 11 Feb 2019 19:16:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
Message-ID: <20190211181658.u55ggc2xi4nsxxvy@katana>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
 <20190208214849.GH12451@kunai>
 <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_101703_449318_7B0DA581 
X-CRM114-Status: UNSURE (   5.97  )
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
Cc: linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============1360690467662630948=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1360690467662630948==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b7kjvamtr6un2ngr"
Content-Disposition: inline


--b7kjvamtr6un2ngr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Can you please apply above changes on top of this patch? Or I can submit
> v2 with it.

Please send v2.


--b7kjvamtr6un2ngr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhvBYACgkQFA3kzBSg
KbZ58hAAmNRU6mM70EOa6sDNBXGmzcZENP6uaJPIZhmXqGs2hZGLkU6mSJic0Q+m
GfvX9fFAYCSagyUe/TIjgdxW0zsYPvo+791TQkB7L+d4ttcMRWVymCBoiGVsQj8q
I1toNkiWc6cMUKpdTifAAjjuK5x5CVnyYEdlCkaH96CejSh++DzdCxqtoKBu+YZH
sIfcpclSkuyXJB1Auzc36FVmcYMxUZbsHhE1pAQUGOgV+6RqmreNctPC7OvDYeJx
Xi2z5GmlB2J/CWE7nxD6vWIz17O6hzmLHf5/xsgP0YewwqYkib/jiKIwxmdzAO7c
5e8R3mO/ivmnj+/0+ez0gENLneu9hu0NnkqcuC1VJ0BddNLsNIOYmjnpu2x8NHhB
HNxmop4N0jaFkloCGq6o9HfMuwLWIR7/AkK9LOfrw2ZGS1zwJZqb5aesysT9yy0F
uzw+srgi+bnYOfGD2+rZxmMHCYv/cW9QT2bA4/15KAo39yXfNup1+XZr/94QRej+
3Bo0NDqTQLIk1Gvd0NjsK7Ohdr+XPA3amgfPnUqZ+cTH4sEwU6ezaV5DvCXj9plx
kxFgWksLgBpaCGIzd6A7ui7lsSfpuFZgo6zlQFTtGNtYNNakhoKz3gvIVXMSNwMn
Y6S9MM25vev0yn/qX2APLeN6fWVL0ixI6ZlI0qAVBs5xmoIHQo8=
=SJHw
-----END PGP SIGNATURE-----

--b7kjvamtr6un2ngr--


--===============1360690467662630948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1360690467662630948==--

