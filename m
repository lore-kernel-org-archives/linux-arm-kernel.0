Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C7C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:14:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764E02085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tEZzVa+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764E02085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L3JThhfXDastVReZNM1mRci/joaw0xzqLBjLQfF4nOs=; b=tEZzVa+iR9KKGq
	gev+ODN+nBovanmTJP0k2TbcGyLpjtU/6g/tzOUGlo2il68eXQpmpjykjsZ2nA+J07IKw8hzeCZ1V
	RJzX4/eUJdZ0MacSTdfmKOn6iDA8o3cCrbL240ss3BfeabcTHyI2fzTofL7jTqrq0h/jz17t0bFNG
	3ZBOyAZnnIsE3DZrVvJ6gmnM956WlLCu1WOqqljn5UB4Xt68Gvu/piJxg8IuqNJFNznuVsm8rsGF+
	mlZ4+1IeOUjWBz0RRVeBcCEM9bWLjMBTrqrwv1oDapYUUqnSpm1/o+VxtUVDAukwLYETrVOd9Z4MT
	fYQP+J5BgGdaeswU1FCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwujJ-0000Tz-DD; Thu, 21 Feb 2019 20:14:01 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwujG-0000TT-DJ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:14:00 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gwuj5-0004mt-Lv; Thu, 21 Feb 2019 21:13:47 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gwuj4-0003sh-Dw; Thu, 21 Feb 2019 21:13:46 +0100
Date: Thu, 21 Feb 2019 21:13:46 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 1/4] pwm: atmel: add struct atmel_pwm_data
Message-ID: <20190221201346.wbyfhmtmgyoii3wt@pengutronix.de>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550570914-26391-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_121358_606156_DF9680A3 
X-CRM114-Status: UNSURE (   8.40  )
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
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 10:08:53AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> =

> Add struct atmel_pwm_data to embed different per controller information. =
At
> this stage, embed a member of type struct atmel_pwm_registers in it.

I'd write:

	Introduce a new structure to describe per controller
	information. For now it contains only a struct
	atmel_pwm_registers member which up to now is enough to describe
	the relevant differences and was used directly as driver data
	before.
	This prepares adding support for another similar controller that
	needs additional information.

Other than that

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
