Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4879B2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIiRFfbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4879B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NKYsrvKytjHuiSQwxG+d/T4VnXDZU33eSiyAE80gWoY=; b=pIiRFfbUltBL+x
	Llbg1lANHa9TXf7HJYrAMMDGRJMEpGAeFsLHPnkHi/yuP+/3cH0vDAxM8rHqII5Cc4S4PFukfn9Hv
	AHOzl/7vTm3Js6ztS5sJfr28VXUsjWAhySQh9ryhQRGvQ25XdJNJEbm3TO9ynig+oQr26fCsKiRIJ
	BgpyQhlu8YJ3Vq4JjjkRHCdk1ERWQUhPInJyJGHQ9opWOk3lNG4PTiSdTxR0/5LiRT6lCk3FeLqmB
	G36ZYFwSPjJc6y6/zXYfYeLgeCL2PdBhKCHQMIqntuoAdFhpCvr+ERtPUTfshdwRJy5SEZLcQfEmX
	ZCbzJRVd/GxJGnC4Wr2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5x8-0003cu-Er; Tue, 04 Dec 2018 08:21:10 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5x2-0003Sy-Bh
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:21:07 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gU5wn-0003qj-1L; Tue, 04 Dec 2018 09:20:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gU5wl-0006VK-Nr; Tue, 04 Dec 2018 09:20:47 +0100
Date: Tue, 4 Dec 2018 09:20:47 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: PETER CHEN <peter.chen@nxp.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: Warn if oc polarity isn't
 specified
Message-ID: <20181204082047.ciht5czh6dfvedrk@pengutronix.de>
References: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
 <20181202213325.26017-2-u.kleine-koenig@pengutronix.de>
 <AM0PR04MB53148CE406ED8DBFABA5A79B8BAF0@AM0PR04MB5314.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB53148CE406ED8DBFABA5A79B8BAF0@AM0PR04MB5314.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_002104_569645_26DAE2B3 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "mstarr@hedonline.com" <mstarr@hedonline.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Peter,

On Tue, Dec 04, 2018 at 06:19:11AM +0000, PETER CHEN wrote:
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/=
ci_hdrc_imx.c
> > index 80b4e4ef9b68..3dcfd0d97f94 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -141,6 +141,8 @@ static struct imx_usbmisc_data
> > *usbmisc_get_init_data(struct device *dev)
> >  	} else if (of_find_property(np, "over-current-active-low", NULL)) {
> >  		data->oc_pol_active_low =3D 1;
> >  		data->oc_pol_configured =3D 1;
> > +	} else {
> > +		dev_warn(dev, "No over current polarity defined\n");
> >  	}
> =

> If the platform doesn't support OC, the polarity setting is not needed. Y=
ou could consider
> getting polarity property only "disable-over-current" is not found at pat=
ch 1.

Right, just fixed that up and will send out v3 in a moment.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
