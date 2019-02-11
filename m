Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179CFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:38:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82EF2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxEjlQu+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eML/imn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82EF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xzoxYppOQq0YBxFYhNHHcw4mA1MJcBYZZK/1PFEcyus=; b=kxEjlQu+J4WE1j
	qkyKBOG1Rn5vEiHaYCTMf8EjXCCdibCsBxUTV9jCQ0dX1cPubaLfZFooK/mpbH0AuFfILWnvm5G+6
	qlkRuEzcHHECwlvEnF/VQatZYbH9GkMbjYdG3RxId0bhg994vNMDKkycYMA6HCLtYWii2LCvzvlux
	pXzpClU+BDqht776LP34EwpVm6jufYbjWcAo/EWExcX3nEvyM3UnYT9HJCA3R0pwEdLn7wt/hwVop
	ZBCj/MeLdtg3s+h4GLdYxxCZP2voaezEqOdMCqOnPi+3Gdzm5m/GK+MB8C3YQt+g4/UYZ0PD/bnzR
	HpBSyXKXcUWh9POntoLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt0YB-0001m9-5Z; Mon, 11 Feb 2019 01:38:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt0Y7-0001ln-Mq
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 01:38:21 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E640F2146F;
 Mon, 11 Feb 2019 01:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549849099;
 bh=W1I0Wbx5JYKJm9YeYwIouF9572/RNuAhwVtq4qXTt9Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eML/imn1TiO+WCYXngq7bujBtu4tlOFrzT6dD9k8JLC3aa/EEDVOyLGxCX0G7c+a1
 pjBeHu7KQi+bkYlhMuuhF4zTmMkCkUZPMgthFJrr+uSQ8Vt8qxJoUfiuWMGjnd9ewP
 RA74yrCjMdQxaIwPB1hBmpkB4KcZ5rLaYt2zELxI=
Date: Mon, 11 Feb 2019 09:38:10 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: Add devicetree for Eckelmann CI4x10
Message-ID: <20190211013808.GC21496@dragon>
References: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
 <20190114013909.GE15371@dragon>
 <20190205081825.rcoi2wx2bvxsyfjz@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205081825.rcoi2wx2bvxsyfjz@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_173819_761686_08DF170C 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Gavin Schenk <g.schenk@eckelmann.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 09:18:25AM +0100, Uwe Kleine-K=F6nig wrote:
> > > +	compatible =3D "eckelmann,imx6dl-ci4x10", "fsl,imx6dl";
> > =

> > Document the compatible.
> =

> Where is this supposed to be documented? I found
> Documentation/devicetree/bindings/arm/fsl.txt but that only seems to
> list Freescale reference boards and e.g. wand,imx6q-wandboard isn't
> there (or anywhere else).

You need to patch Documentation/devicetree/bindings/arm/fsl.yaml on my
imx/bindings (merged into for-next) branch.  Reminder - please keep
bindings change as a separate patch.

>  =

> > > +	mram: mr25h256@0 {

Just spot it - please use a generic node name.

> > > +		compatible =3D "everspin,mr25h256";
> > =

> > Undocumented compatible.
> =

> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt documents:
> =

> 	compatible : May include a device-specific string consisting of the
> 	             manufacturer and name of the chip. A list of supported chip
> 		     names follows.
> =

> "everspin" is a documented manufacturer and "mr25h256" is included in
> the referenced list. So it's unclear to me what is missing here.

Ah, okay.  It will make my searching of compatible much harder then.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
