Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5B220C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CpGGHCdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5B220C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=90w069RUZVw6s/mO8XXs6LX6+LuaB8h7ak3kpIPa8D8=; b=CpGGHCdy1tF+z00eRT3KgBiyM
	drn5Br7Xg7aOJc1YVkZxf4V41tGe7/qgvrUONjC0H6d+9X/wArsIVvkqZscQYy61fvX8SO1W+H3Hy
	NSnOuX+wRDwj8OtdYhoNC839xNUYaKfwWrswpGu0GGSSGDCAv9FTVs2fCwSlvXTeKpctgfhqXQqPW
	VPuItXes5m0UVeNSYtPKrcgqyKUsRr5LE/4LL/49mfqQrkzLd8mDP54mhSDOvRGKCq/3AgVq0B9wd
	1LIFFo4WyupElv+eqqDc4VpIK6fOjWPh1BE49tx4Swsc75L6lkskJhiTwUp11oEbAwzB4Q8BZGxvP
	ZnFhiVn1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmNs-0008Vo-7o; Mon, 18 Feb 2019 17:07:12 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmMv-0007bR-6m
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:06:23 +0000
Received: from localhost (p54B3327C.dip0.t-ipconnect.de [84.179.50.124])
 by pokefinder.org (Postfix) with ESMTPSA id A98BD2C7BF4;
 Mon, 18 Feb 2019 18:06:09 +0100 (CET)
Date: Mon, 18 Feb 2019 18:06:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Shikai Wang <sxauwsk@163.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
Message-ID: <20190218170606.qt35ciis4zpqo7d2@katana>
References: <20190218094132.5226-1-sxauwsk@163.com>
MIME-Version: 1.0
In-Reply-To: <20190218094132.5226-1-sxauwsk@163.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090613_429535_595A7CD2 
X-CRM114-Status: UNSURE (   9.75  )
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
Content-Type: multipart/mixed; boundary="===============0114809618699268799=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0114809618699268799==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="55tyi4ztso44igmw"
Content-Disposition: inline


--55tyi4ztso44igmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 05:41:32PM +0800, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.

Thanks for working on this issue.

> Signed-off-by: Shikai Wang <sxauwsk@163.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Reading the previous thread, isn't this more of an acked-by or
reviewed-by than a Signed-off?

Also, is there a suitable Fixes tag?


--55tyi4ztso44igmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxq5fgACgkQFA3kzBSg
KbZszRAAljXV2RneaUpe4jL8KnONqVWgRXYtj/MG7rxBhl6B2jg5TH1HqH0MRZIO
hhTB21+VhdzjEyg9/Dai52L1BbndZKkTGTeL/jjIBI740iC4Nn6+3qerN3UmNkYR
tHKCw1LLmDj0gph9Gez9PXZwBYBJAdnCugvbE88iNiJ1E8TrVxGV4mGkdXjGJDqV
gYOV3cvlQoznHiq3iaoSrF05iCMJCvoPuHAWPoRGXNk2wuHkWr+H2RK7jBzZE4GQ
Q+JJQe0AgXIgE5ivAkTanKcmu/6vZpEnUKu2Q1jS2fESt1nd00tgT0zhi3Mr1oB2
EhjAxdq46q74gKAJGm0GgHnhzwjBTBi5rHuglxR/Z5yCdHc7WgM7bASsKKpVmcQt
vBO0geyHGL5rsyIgKIBzQXpJeB0fCdpUEO/CNmQqTRJEbHM2Ra8X/BRYWFwof1Ae
9G1LnECNAQOoXVV3bmq+CpzXCJZOQVh+LnMb1sBiltKLSdMVgIx35Q7fL5hiJF/I
FjEEH4MUjvjwocer9fLOArAUWggPdKKSbcQAOE9jKi1BBIzwIEdL39eM/Mq2Ih96
bR2C72CHEqSAsbCNcxNrYSCy54pL9tW/QZJb/DousDgbpJGwPbZJWXUr12bfml9G
+s+/LU37XtbG262QCd0CKbSb8Nz4gbzz0ZQWQ2Dh+jVUi7EJ1Ns=
=WSqx
-----END PGP SIGNATURE-----

--55tyi4ztso44igmw--


--===============0114809618699268799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0114809618699268799==--

