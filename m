Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418ACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBD42086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e4qsvOqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBD42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FW73451sTDrBP79OBtpANkdbAv/pQxIx65XK3LkiRyU=; b=e4qsvOqTSIh39e
	pysbd5Hv7F3C4r0SyERn/4zELC/NAOxCPYCw7HrfChBNPrdsrZ9gM5s36RBNOCkVA/rbWVlCeCXZ7
	1DrJTN1ttG9IWQdLJJtIP4g4koEt9DhVQtttbKIoDphtHtOfvKfVpIwgAZsNRpY3m8xb9v+aHp5vs
	9I45JEPdtEaq+WaZXPLStj8v1jnjBzZaHEmJK7s5/qneAm9Wdv7lXuyhM8f0fTKl8eUS3Rp0Nk21Z
	Jl7yUIBRU8g8lJenItwsnCqLbjkwtdWj7a/Ef7ntxhnDa1HuzJ02AMryCNI8Tiw7qEpGaYIzx9eGR
	pYPeaOG776hv74bZ9hSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkDXW-0006CI-0P; Thu, 17 Jan 2019 19:41:22 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkDXS-0006BD-3Q
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:41:19 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gkDXI-0006Bl-5w; Thu, 17 Jan 2019 20:41:08 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gkDXH-0003j5-4o; Thu, 17 Jan 2019 20:41:07 +0100
Date: Thu, 17 Jan 2019 20:41:07 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: mt7622: add a property
 "mediatek,num-pwms" for PWM
Message-ID: <20190117194107.wrafykdre5tugv4q@pengutronix.de>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
 <b5ed4626a553acb5e3107c6c96e82b674439128f.1547453586.git.ryder.lee@mediatek.com>
 <20190115200231.drn2rbxu4jxr22yz@pengutronix.de>
 <2edcc5fd-ce60-b585-e0fd-226897a7a34c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2edcc5fd-ce60-b585-e0fd-226897a7a34c@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_114118_301590_41ACBF3B 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 linux-pwm@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Thu, Jan 17, 2019 at 02:00:43PM +0100, Matthias Brugger wrote:
> On 15/01/2019 21:02, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 14, 2019 at 04:21:22PM +0800, Ryder Lee wrote:
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boo=
t/dts/mediatek/mt7622.dtsi
> >> index 8fc4aa7..ab016cf 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> >> @@ -436,6 +436,7 @@
> >>  			 <&pericfg CLK_PERI_PWM6_PD>;
> >>  		clock-names =3D "top", "main", "pwm1", "pwm2", "pwm3", "pwm4",
> >>  			      "pwm5", "pwm6";
> >> +		mediatek,num-pwms =3D <6>;
> >>  		status =3D "disabled";
> > =

> > Conceptually this patch must go in before the change to the driver.
> > Otherwise the pwms are not usable with only patch 1 applied which breaks
> > bisectability.
> > =

> =

> The driver should have backwards compatibility to older DTs. So that woul=
d need
> to be fixed in the driver not in the patch order of the series.

Right you are. Bisectability is a reason to not apply the patches in the
order as is, but given that you already requested backwards
compatibility the bisectability will be fixed en passant.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
