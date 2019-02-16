Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:29:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A775B21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PKW6D7YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A775B21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4GwytPVmo8eiVQ2byRtQ9QmLpRH770z3ao22R4ZFFVw=; b=PKW6D7YI12RyTg2jshTOs7+IL
	g/TDVmaWYUKwV/dNbN43F6aAw0G8B9cb7S0vWHj1hHFLROpCOFRSsuc50UXqysNTJCtXT19E3l4OB
	FU6spAn/RBNNOXxvCGfojDTTppLUH5Kik8jAbx3Az74KL5oRigK9jiiJn33rjpR1T510OZuCYi8hO
	JSwkXAyI5XUhFiY7MIqxpAY3KszCR3Ki2ttgArQTUyJLYZkWOfcMbPJQEg+aByYJpLEYpgmYDrzvt
	V5NGlDv16igdhs94bxMyUDgrR7fwog4JlevFg0h623JuX0fpFE41a2Zxz0smoADybstiYBKeT98hS
	1iEkBtyyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guz5x-0003i0-OU; Sat, 16 Feb 2019 12:29:25 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guz5u-0003hS-Q0; Sat, 16 Feb 2019 12:29:24 +0000
Received: from localhost (unknown [195.52.228.164])
 by pokefinder.org (Postfix) with ESMTPSA id 9483F2C0509;
 Sat, 16 Feb 2019 13:29:16 +0100 (CET)
Date: Sat, 16 Feb 2019 13:29:15 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190216122915.hchghozcn7ntdkbm@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
 <1550316723.30065.44.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1550316723.30065.44.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_042922_994325_C0EC2881 
X-CRM114-Status: UNSURE (   7.25  )
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
 srv_heupstream@mediatek.com, Rob Herring <robh@kernel.org>,
 leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7180055415413143207=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7180055415413143207==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvl5pgprc2c6iamr"
Content-Disposition: inline


--uvl5pgprc2c6iamr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
> there are I2C and I3C controllers on MT8183 SoC. We will remove
> "mediatek,share-i3c" for I2C controller driver, so these patches are
> just to support the I2C controllers on MT8183 SoC. For the I3C
> controller we will send some new patches which are based on i3c
> framework directories(kernel/drivers/i3c), not based on
> i2c-mt65xx.c.

Sounds perfect to me. If it turns out that the I3C driver can share
things with the I2C driver, we can discuss it then. But unless we have
an I3C driver and know for sure, the above strategy seems good to me.


--uvl5pgprc2c6iamr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxoAhcACgkQFA3kzBSg
KbZX6Q//fbtn+bsK5KVjERP9EokrSE8Pn/Q8MsFHFKLxQm2ZQsc2yMzOu0YUYvnF
X531Roh9TkDU3SkJL/xnERFtamDianlugO11qGRxvJnSGCjrUDogHdw8awM6BE1e
G01y8agD7lRVmrZb3AidW9HAfgCBalucvrKovIQSkvvhvnCglVnZHBpwmQwFEZ/E
NlB20w8KdvAKNXeT8GgxsjFBfanSHAHOTJKUcnkeO4Lg10TDlnh85c1FGcuOmbcE
j0yvYzcFIUJ5Xdw1f0BVG12RDuN0pOSN/FuVDZRBb/FkOJx+CIb62jJiieCYVTMl
/jwL6gkGbyZyo2YJJ/P6twDzxXE3JtjP1gtnN9FPBVFOeaWN3qoabOM/aO1iWlZM
K2hsLVorxvdHedrDEqwNFawEFSF0Y2sdPCndwlgKRqRcdJRh4f5VzPNXTxDmPeQI
5zubdYEA1dE8NfX3xM4/05/vBNK9JDwj+U5EczvGL7PI+q8n5X/QoQqu7x6tWMq8
D9VMUWRpM6usbQ52gt/hQi08taNuaxP4BQJkDduDVZ/x09aAdKrKDStwtwhIABH1
gnLt/3qJqEo6o2LM6fpK/hvhUgjiZ5KlTJ/RylosAcAbRkho4lFwI6AyzEGRFGHe
lntFJiamVASorn7fg4GVdNNJAzVsNTIdVcSJfxij5TjtbqVjiBg=
=2hOh
-----END PGP SIGNATURE-----

--uvl5pgprc2c6iamr--


--===============7180055415413143207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7180055415413143207==--

