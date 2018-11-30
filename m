Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:50:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FEE2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AWfnHkqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FEE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3rZ9AC/MtCpQCh1nypLjbpJGfm6L3wOUlcxQN0Y0lxs=; b=AWfnHkquSIkSGT
	RZcpS2L2zyVZ8uxnQq+bMgyAZLsBtYaLL/mJC4zITECjZeRnlH8UZDTHwtCDGT/gkLvgBa/NVBFJ/
	EBntZ7Fq6dTOKeT9MSzO2NwdF4XH6G6gD+wx9l9YHScJj/diRqI/ZulMAMepUVAbuc891YDiTmAPf
	+BzUrY/QpG4kq+qW1hasaERAh/YpZ0B1QADP28Y/pDr0Auq3dTOLS7sDtCzWx7lipfgARTjTMKJjf
	86eYax6rQ/2SG4r4Q/qm3gooi9cPTsIJ53ocyjLdJ4SFKH63z+9lfeQf+QrL5QZ02NoSLISS+sHcd
	iHL8seQYDvcGNGTIl8hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmvq-0007z2-2y; Fri, 30 Nov 2018 17:50:26 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmvm-0007Fg-P9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:50:24 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gSmvW-0003XQ-3c; Fri, 30 Nov 2018 18:50:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gSmvU-000379-Rv; Fri, 30 Nov 2018 18:50:04 +0100
Date: Fri, 30 Nov 2018 18:50:04 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from
 driver data struct
Message-ID: <20181130175004.iiduvgzwwij3fvof@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
 <1543598496.18519.101.camel@impinj.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543598496.18519.101.camel@impinj.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095022_989630_51455DBD 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: "marex@denx.de" <marex@denx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Trent,

On Fri, Nov 30, 2018 at 05:21:40PM +0000, Trent Piepho wrote:
> On Fri, 2018-11-30 at 07:47 +0100, Uwe Kleine-K=F6nig wrote:
> > The driver data's member variable just caches the transfer's speed_hz
> > member. All users of the former now have access directly to the latter.
> > So fix them to use the uncached value and remove the cache.
> =

> What should have been done with this is to compare the next transfer's
> speed_hz to this cached value, and not preprogram the clock if it has
> not changed.  Since usually it doesn't change between transfers.

Hmm, yes, this could be done, but I'm not sure the additional effort
brings a performance advantage. If you have the energy to do test that,
feel free to implement it, preferably on top of my cleanup commit.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
