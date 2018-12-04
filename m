Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C53BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD59206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAaJKKzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD59206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dzg2iaoBbGCzYVO8Tla3+pzBUJd7QsnvyH/9y3Fgh/Q=; b=LAaJKKzch1zKEa
	jGJQJP7UkNnajSC3cyMRj6g2NbB36CN7Hb9GLyuRmZXDA7ngaRHzv56pr/O5b8EonGZpNIiGiXvnd
	oTcSHjRZe57i5WQW52UYpNLYbrimIRkZEvlcdbAuJdqYa5D44UEm9mCF7IH1PqR84NqYVt5N3RTlJ
	Aw8CHz2lvy/hWjC8T/vqdE3PebnRMLVlLVZ41A2QFI2l/YhhIpXnH11Pk5ZPlaSQ/5HrNgaeh0h/B
	UAE4/jqw11ird3c/W41a9t2H5mJyQHCWzs63X8guhzIBw3XPNXd2kDTU7F8P+LZCCfvf/XabYLoXq
	Id/v7xX+Z6SfW7IxYZQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAvu-0004aE-BW; Tue, 04 Dec 2018 13:40:14 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAvr-00039E-Hp
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:40:13 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gUAvd-00018g-IM; Tue, 04 Dec 2018 14:39:57 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gUAvc-0007QI-97; Tue, 04 Dec 2018 14:39:56 +0100
Date: Tue, 4 Dec 2018 14:39:56 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v3 1/3] usb: chipidea: imx: support configuring for
 active low oc signal
Message-ID: <20181204133956.54qe44fwcbfw46s3@pengutronix.de>
References: <20181204083131.12524-1-u.kleine-koenig@pengutronix.de>
 <20181204083131.12524-2-u.kleine-koenig@pengutronix.de>
 <ce751026-d61f-400e-cb5d-abd9d45dc05f@i2se.com>
 <20181204085250.o4vaviz7ta43zpfo@pengutronix.de>
 <05dbcf6d-1551-31b4-4c9b-fb713fc71362@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05dbcf6d-1551-31b4-4c9b-fb713fc71362@i2se.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_054011_748133_83AE7211 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Peter Chen <Peter.Chen@nxp.com>, devicetree@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, linux-usb@vger.kernel.org,
 Matthew Starr <mstarr@hedonline.com>, Rob Herring <robh+dt@kernel.org>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Tue, Dec 04, 2018 at 12:43:21PM +0100, Stefan Wahren wrote:
> Am 04.12.18 um 09:52 schrieb Uwe Kleine-K=F6nig:
> > But for the review you are right, I added the dt people to Cc for them
> > to comment. In v2 Matthew also noted that he would prefer to handle the
> > situation when both over-current-active-low and over-current-active-high
> > were given differently. I think we don't need that as this is a case of
> > "broken dt" and it doesn't matter much what is done then. (With my patch
> > we're configuring for active high in that case.) A feedback here would
> > be great, too.
> =

> AFAIR such invalid settings should be catched with a proper error
> message and abort of the probing.

I remember a review commend from Rob[1]: "It is not really the kernel's
job to validate crap in bindings. If you put [strange things] in your
DT, then the kernel may or may not handle that."

If this applies here, too, the current patches are fine.

Best regards
Uwe

[1] https://patchwork.kernel.org/patch/8776441/

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
