Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F52DC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D02B20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TQsa07Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D02B20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CofDUqnCvmS6cNwmxuVBICD+lmh90uMFxdRLgiITqf8=; b=TQsa07CsH2s6Qa
	ZcvS+9F4pnH41Iv9EYb0C/6sgHeuD5xIRIv2S7J1MwK71diKUlKx7+wX0kNi5FJr0Zth3ncJNF8GE
	tWd/VyePt1QZiyaWdqEo3UmLqknk8ZQkVEsh6mlMq4FAos3J/9I5b0duc2mPiWa+txgCqVXailyhh
	oh4mO1GLEvHO5QFaY5DHqXxZimIQyzqJJguLkNqY+l7h/iGq11Oby7fkS8OF6uWEnlrIJ/aTo1lH+
	zamsBDt32el9Yxq+cw2EU0n3QL1HpE/v9aSkR7x3RleJk5ljnE9uWpAxG72jMQ8WwVTlp4b9Eg+18
	jWkJZpdwIfBkmjv+rTXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqvwC-00012S-Cs; Tue, 05 Feb 2019 08:18:36 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqvw8-000129-5r
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:18:34 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gqvw3-00016J-2l; Tue, 05 Feb 2019 09:18:27 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gqvw1-0005bz-UQ; Tue, 05 Feb 2019 09:18:25 +0100
Date: Tue, 5 Feb 2019 09:18:25 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: Add devicetree for Eckelmann CI4x10
Message-ID: <20190205081825.rcoi2wx2bvxsyfjz@pengutronix.de>
References: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
 <20190114013909.GE15371@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114013909.GE15371@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_001832_375933_7187498D 
X-CRM114-Status: GOOD (  12.58  )
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

Hello,

On Mon, Jan 14, 2019 at 09:39:11AM +0800, Shawn Guo wrote:
> On Fri, Jan 11, 2019 at 05:49:35PM +0100, Uwe Kleine-K=F6nig wrote:
> > +	model =3D "Freescale i.MX6 DualLite Eckelmann CI 4X10 Board";
> =

> It's not a board produced by Freescale, right?

Right, it's only the CPU that is produced by Freescale. So the implicit
associativity is: (Freescale i.MX6 DualLite) Eckelmann CI 4X10 Board :-)
I will make this "Eckelmann CI 4X10 Board".

> > +	compatible =3D "eckelmann,imx6dl-ci4x10", "fsl,imx6dl";
> =

> Document the compatible.

Where is this supposed to be documented? I found
Documentation/devicetree/bindings/arm/fsl.txt but that only seems to
list Freescale reference boards and e.g. wand,imx6q-wandboard isn't
there (or anywhere else).
 =

> > +	mram: mr25h256@0 {
> > +		compatible =3D "everspin,mr25h256";
> =

> Undocumented compatible.

Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt documents:

	compatible : May include a device-specific string consisting of the
	             manufacturer and name of the chip. A list of supported chip
		     names follows.

"everspin" is a documented manufacturer and "mr25h256" is included in
the referenced list. So it's unclear to me what is missing here.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
