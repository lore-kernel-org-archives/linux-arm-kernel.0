Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB10021916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TPz+7XkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB10021916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tAU30z2WZmD0BCGGvAg5lAHi2hvrywb+JOmYKWCJVhM=; b=TPz+7XkM9qxVRy
	bGM9Ab4UvyALfqJxeSKOraKdhPpj9L4doVNzg4xExDhXTxrZMY2/m6Eq9ozAH94hE6U9DPLKtyF30
	wIQIH7yQGj0QFyvoUp+azq8Ge5ddA+xXtAD7Xs5tvGe4ONk6V66hbd1eXinHIF6nw6mm/hB2mBkyq
	vVZdMCehsfKdf/e6YVIbuB4lEzD0XsiCPo0CkzrNzwyPT0KAOXKAPof+UekENPKdQpfeXi0M3SzGM
	HoH7gaUCGzg4/Xnal7mY6q7O9wNS0cXPLVV704cWtYc8/5CgvhYw+RtKD+bnBsgHr9oZmexwaCYAM
	Q5yp3xNbx4qTjiv/kC1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv6fG-0003V9-Hg; Sat, 16 Feb 2019 20:34:22 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6fD-0003Tu-R7; Sat, 16 Feb 2019 20:34:21 +0000
Received: from p57b77d08.dip0.t-ipconnect.de ([87.183.125.8]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gv6fB-0007eD-3L; Sat, 16 Feb 2019 21:34:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rock960: Enable tsadc device
Date: Sat, 16 Feb 2019 21:34:16 +0100
Message-ID: <3185590.aYss3V9hle@phil>
In-Reply-To: <aa2f376897ffb4fef02bd3e64812c8e1dbe4987a.camel@collabora.com>
References: <20190215152539.16606-1-ezequiel@collabora.com>
 <4625663.tZDl4lH1EQ@diego>
 <aa2f376897ffb4fef02bd3e64812c8e1dbe4987a.camel@collabora.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_123420_028712_2DA0F276 
X-CRM114-Status: GOOD (  16.14  )
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 16. Februar 2019, 03:55:01 CET schrieb Ezequiel Garcia:
> On Sat, 2019-02-16 at 00:14 +0100, Heiko St=FCbner wrote:
> > Hi Ezequiel,
> > =

> > Am Freitag, 15. Februar 2019, 16:25:39 CET schrieb Ezequiel Garcia:
> > > Enable the thermal sensor. This device also provides
> > > temperature shutdown protection. The shutdown value is
> > > set at 110C, as tested by the vendor.
> > > =

> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > =

> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi index
> > > d64d5ac0804a..599c9752ed4d 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > @@ -634,3 +634,10 @@
> > >          mali-supply =3D <&vdd_gpu>;
> > >          status =3D "okay";
> > >  };
> > =

> > doesn't apply against my 5.1/dts64 branch and our rock960.dtsi
> > also does not have a mali node yet (especially also not one with
> > space-indentation ;-) ).
> > =

> > =

> =

> Sorry about that, it was based on your for-next branch,
> but a mali patch slipped through.

I've fixed that up now and applied the fixed version for 5.1.
I've also moved the &tsadc to the correct position - alphabetically
between sdmmc and uart0. Please keep sorting in mind for future
additions ;-) .


Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
