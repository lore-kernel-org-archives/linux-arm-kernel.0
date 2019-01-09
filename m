Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1BEC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D9C20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oL++rlcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D9C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qLOxrFAsY5EJ4YaPRhxYWzN3+cj7CxW/Pe2Te4K7aV4=; b=oL++rlcIyWW2gi
	GimtKHeMTIL0AQ3yz349sq5umSKi1sAXUBGr5gH+k1WoQVDhYjlePuVl/4l5xxg8eLHp57lAL3e+w
	Jc691wovNfOYXGDfm9EkcZRZH636uuNddPiYjhXeB3Tk6e4UpY39l5h3RHDApHdoduvL3dw6FBN77
	eTSpKhqvALeigpEdkJVLtT/dSWapYJqXt8vibwj/8n53dfW/iJbeZVgYAWa/E1/3ZruA3kb4OJuJx
	it1+7hNipv7g8pSct+1gdbTI3zGvyFlL4OhQ4jZXaeTH3wECMpi90tB+IOQxnC2TDveeGXY08ztbW
	jD675QFnwmbavyRcv86g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghA26-0001ra-KA; Wed, 09 Jan 2019 09:20:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghA1y-0001ds-8u
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:20:16 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghA1u-0006Tx-LA; Wed, 09 Jan 2019 10:20:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghA1u-00063W-4u; Wed, 09 Jan 2019 10:20:06 +0100
Date: Wed, 9 Jan 2019 10:20:06 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
 Arthur LAMBERT <lambertarthur22@gmail.com>
Subject: Re: Handle pwm with sysfs with recent kernel
Message-ID: <20190109092006.35364dwcfiindd7c@pengutronix.de>
References: <20190108100739.GA9046@arthur-bzh>
 <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
 <20190109092531.71cf52c8@karo-electronics.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109092531.71cf52c8@karo-electronics.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_012010_468171_F52C15B2 
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
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Wed, Jan 09, 2019 at 09:25:31AM +0100, Lothar Wa=DFmann wrote:
> Hi,
> =

> On Tue, 8 Jan 2019 23:21:02 +0100 Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 08, 2019 at 11:07:39AM +0100, Arthur LAMBERT wrote:
> > > Then I have another issue when I try to enable my pwm :
> > > =

> > > # ls /sys/class/pwm/
> > > pwmchip0  pwmchip2  pwmchip4  pwmchip6
> > > pwmchip1  pwmchip3  pwmchip5  pwmchip7
> > > # echo 0 > /sys/class/pwm/pwmchip0/export
> > > # echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> > > -sh: write error: Invalid argument  =

> > =

> > Just a guess: did you check that /sys/class/pwm/pwmchip0/pwm0/enable
> > actually exists?
> > =

> If not, the error message would be 'No such file or directory' rather
> than "Invalid argument".

Then "Invalid argument" means that either the "1" couldn't be parsed as
an integer 1 or 0 (no) or that pwm_apply_state returned -EINVAL. What
type of pwm are we talking about (i.e. which driver is responsible for
pwmchip0)? Hmm, that machine is an imx6ul, looking at the pwm-imx driver
there doesn't seem to be a path through the .apply callback that returns
-EINVAL. Would you care to add a few printk in
drivers/pwm/sysfs.c:enable_store() that show where the -EINVAL comes
from?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
